Rem
	bbdoc:
	about:
End Rem
Type TRESTResponse
	Field headers:TMap = New TMap
	Rem
		bbdoc: Content returned by REST server
	End Rem
	Field content:String
	Rem
		bbdoc: HTTP Status code returned by REST server
	End Rem
	Field responseCode:Int
	
	Rem
		bbdoc: Retrieve header from response
		returns: Value of header
		about:
		Retrieve a header by the name of @headerName<br>
		When @throwOnError is @True a TRESTResponseException will be thrown when the header doesn't exist.
	End Rem
	Method GetHeader:String(headerName:String, throwOnError:Byte = False)
		If throwOnError And Not Self.headers.Contains(headerName) Then Throw New TRESTResponseException.SetMessage("Header " + headerName + " doesn't exist")
		Return String(Self.headers.ValueForKey(headerName))
	End Method	
End Type
