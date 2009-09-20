Rem
	bbdoc: Exception for TREST
End Rem
Type TRESTException Abstract
	Field message:String
	
	Rem
		bbdoc: Sets message
		returns: TRESTException
	End Rem
	Method SetMessage:TRESTException(message:String)
		Self.message = message
		Return Self
	End Method
	
	Rem
		bbdoc: Return message
	End Rem
	Method ToString:String()
		Return Self.message
	End Method
End Type

Rem
	bbdoc: Exception for TRESTRequest
End Rem
Type TRESTRequestException Extends TRESTException
End Type

Rem
	bbdoc: Exception for TRESTResponse
End Rem
Type TRESTResponseException Extends TRESTException
End Type
