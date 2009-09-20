Rem
	bbdoc: A REST request object
	about:
End Rem
Type TRESTRequest
	Field _progressCallback:Int(data:Object, dltotal:Double, dlnow:Double, ultotal:Double, ulnow:Double)
	Field _progressData:Object
	
	Field _headers:TMap = New TMap
	
	Rem
		bbdoc: Optionally set the path to a certification bundle to validate the SSL certificate of the REST Server
		about: If you want to validate the SSL certificate of the REST server you can set the path to your certificate bundle here.
		This needs to be set BEFORE creating a TRESTRequest object.
	End Rem
	Global CAInfo:String
	
	Rem
		bbdoc: Set a progress callback function to use when uploading or downloading data
		about: This is passed to cURL with setProgressCallback(). See bah.libcurlssl for more information
	End Rem
	Method SetProgressCallback(progressFunction:Int(data:Object, dltotal:Double, dlnow:Double, ultotal:Double, ulnow:Double), progressObject:Object = Null)
		Self._progressCallback = progressFunction
		Self._progressData = progressObject
	End Method
	
'	Rem
'		bbdoc: Callback for cURL to catch headers
'		about: Private method
'	End Rem
	Function HeaderCallback:Int(buffer:Byte Ptr, size:Int, data:Object)
		Local str:String = String.FromCString(buffer)
		
		Local parts:String[] = str.Split(":")
		If parts.Length >= 2
			TRESTResponse(data).headers.Insert(parts[0], str[parts[0].Length + 2..].Trim())
		End If
		
		Return size
	End Function
	
	Rem
		bbdoc: Add a header
		about: Preset a header which will then be used when invoking Call()
	End Rem
	Method AddHeader(name:String, value:String)
		Self._headers.Insert(name, value)
	End Method
	
	Rem
		bbdoc: Remove a single header
		about: @name is the name of the header
	End Rem
	Method RemoveHeader(name:String)
		Self._headers.Remove(name)
	End Method
	
	Rem
		bbdoc: Clear all headers
		about: Clears all headers that have been set with AddHeader()
	End Rem
	Method RemoveHeaders()
		Self._headers.Clear()
	End Method
	
	Rem
		bbdoc: Send request to REST server
		returns: TRESTResponse object
		about: Used to send requests. Sets header data and content data. Returns TRESTResponse object.<br>
		Any headers set in @headers array won't be added to the objects headers TMap.<br>
		This allows you to define a TRESTRequest object with a number of default/preset headers
		and any additional can be added here. Do note that any headers set with AddHeader() will be
		added to the request.<br>
		<br>
		If @userData is a TStream and @requestMethod has been set to PUT then libcurlssl will read
		the TStream and push it's content to the REST server. After the request has been made the
		TStream will be closed.<br>
		<br>
		If an error occurs with the request a TRESTRequestException will be thrown. 
	End Rem
	Method Call:TRESTResponse(url:String, headers:String[] = Null, requestMethod:String = "GET", userData:Object = Null)
		Local response:TRESTResponse = New TRESTResponse

		Local curl:TCurlEasy = TCurlEasy.Create()
		curl.setWriteString()
		curl.setOptInt(CURLOPT_VERBOSE, 0)
		curl.setOptInt(CURLOPT_FOLLOWLOCATION, 1)
		curl.setOptString(CURLOPT_CUSTOMREQUEST, requestMethod)
		curl.setOptString(CURLOPT_URL, url)

		'Set progress callback if set
		If Self._progressCallback <> Null
			curl.setProgressCallback(Self._progressCallback, Self._progressData)
		End If
		
		'Use certificate bundle if set
		If TRESTRequest.CAInfo
			curl.setOptString(CURLOPT_CAINFO, TRESTRequest.CAInfo)
		'Otherwise don't check if SSL certificate is valid
		Else
			curl.setOptInt(CURLOPT_SSL_VERIFYPEER, False)
		End If
		
		'Pass content
		If userData
			Select requestMethod
				Case "POST"
					curl.setOptString(CURLOPT_POSTFIELDS, String(userData))
					curl.setOptLong(CURLOPT_POSTFIELDSIZE, String(userData).Length)
				Case "PUT"
					curl.setOptInt(CURLOPT_UPLOAD, True)
					Local stream:TStream = TStream(userData)
					curl.setOptLong(CURLOPT_INFILESIZE_LARGE, stream.Size())
					curl.setReadStream(stream)
			End Select
		End If
		
		
		Local headerList:TList = New TList
		'Push any preset headers into the list
		If Not Self._headers.IsEmpty()
			For Local key:String = EachIn Self._headers.Keys()
				Local value:String = String(Self._headers.ValueForKey(key))
				headerList.AddLast(key + ": " + value)
			Next
		End If
		
		If headers <> Null
			For Local str:String = EachIn headers
				headerList.AddLast(str)
			Next
		End If
		
		Local headerArray:String[] = New String[headerList.Count()]
		For Local i:Int = 0 To headerArray.Length - 1
			headerArray[i] = String(headerList.ValueAtIndex(i))
		Next
		
		curl.httpHeader(headerArray)
		curl.setHeaderCallback(Self.HeaderCallback, response)
		
		Local res:Int = curl.perform()

		If TStream(userData)
			TStream(userData).Close()
		End If
				
		Local errorMessage:String
		If res Then
			errorMessage = CurlError(res)
		End If

		Local info:TCurlInfo = curl.getInfo()
		Local responseCode:Int = info.responseCode()

		curl.freeLists()
		curl.cleanup()
		
		response.content = curl.toString()

		'Throw exception if an error with cURL occured
		If errorMessage <> Null
			Throw New TRESTRequestException.SetMessage(errorMessage)
		End If
		
		response.responseCode = responseCode
		
		Return response
	End Method
End Type