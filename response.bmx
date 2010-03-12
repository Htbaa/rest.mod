Rem
	Copyright (c) 2010 Christiaan Kras
	
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
End Type
