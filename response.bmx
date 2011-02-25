Rem
	Copyright (c) 2010-2011 Christiaan Kras
	
	Permission is hereby granted, free of charge, to any person obtaining a copy
	of this software and associated documentation files (the "Software"), to deal
	in the Software without restriction, including without limitation the rights
	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
	copies of the Software, and to permit persons to whom the Software is
	furnished to do so, subject to the following conditions:
	
	The above copyright notice and this permission notice shall be included in
	all copies or substantial portions of the Software.
	
	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
	THE SOFTWARE.
End Rem

Rem
	bbdoc: A REST Response object
	about: A TRESTResponse object is what will be returned by TRESTRequest.Call()
End Rem
Type TRESTResponse
	Rem
		bbdoc: Headers returned by REST server
	End Rem
	Field headers:TMap = New TMap
	Rem
		bbdoc: Content returned by REST server
	End Rem
	Field content:String
	Rem
		bbdoc: Content returned by REST server in a stream
		about: If a stream has been passed to TRESTRequest
		this field will point to the same stream. Note that
		the @content field won't be set if a stream is being used.
	End Rem
	Field stream:TStream
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
	
	Rem
		bbdoc: responseCode is in the 1xx range
		returns: Byte
		about:
		Return True if responseCode is an Informational status code (1xx). This class of status code indicates a provisional response which can't have any content.
	End Rem
	Method IsInfo:Byte()
		Return Self.responseCode >= 100 And Self.responseCode < 200
	End Method
	
	Rem
		bbdoc: responseCode is in the 2xx range
		returns: Byte
		about:
		Return True if responseCode is a Successful status code (2xx).
	End Rem
	Method IsSuccess:Byte()
		Return Self.responseCode >= 200 And Self.responseCode < 300
	End Method
	
	Rem
		bbdoc: responseCode is in the 3xx range
		returns: Byte
		about:
		Return True if responseCode is a Redirection status code (3xx). This class of status code indicates that further action needs to be taken by the user agent in order to fulfill the request.
	End Rem
	Method IsRedirect:Byte()
		Return Self.responseCode >= 300 And Self.responseCode < 400
	End Method
	
	Rem
		bbdoc: responseCode is in the 4xx or 5xx range
		returns: Byte
		about:
		Return TRUE if responseCode is an Error status code (4xx or 5xx). The function return True for both client error or a server error status codes.
	End Rem
	Method IsError:Byte()
		Return Self.responseCode >= 400 And Self.responseCode < 600
	End Method
	
	Rem
		bbdoc: responseCode is in the 4xx range
		returns: Byte
		about:
		Return True if responseCode is an Client Error status code (4xx). This class of status code is intended for cases in which the client seems to have erred.
	End Rem
	Method IsClientError:Byte()
		Return Self.responseCode >= 400 And Self.responseCode < 500
	End Method
	
	Rem
		bbdoc: responseCode is in the 5xx range
		returns: Byte
		about:
		Return True if responseCode is an Server Error status code (5xx). This class of status codes is intended for cases in which the server is aware that it has erred or is incapable of performing the request.
	End Rem
	Method IsServerError:Byte()
		Return Self.responseCode >= 500 And Self.responseCode < 600
	End Method

End Type
