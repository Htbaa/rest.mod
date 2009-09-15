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
		about:
	End Rem
	Method GetHeader:String(headerName:String)
		'If Not Self.headers.Contains(headerName) Then Throw New TRESTResponseException.SetMessage("Header " + headerName + " doesn't exist")
		Return String(Self.headers.ValueForKey(headerName))
	End Method
	
End Type
