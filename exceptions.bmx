Rem
	bbdoc: Exception for TREST
End Rem
Type TRESTBaseException Abstract
	Field message:String
	
	Rem
		bbdoc: Sets message
		returns: TRESTBaseException
	End Rem
	Method SetMessage:TRESTBaseException(message:String)
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
Type TRESTRequestException Extends TRESTBaseException
End Type

Rem
	bbdoc: Exception for TRESTResponse
End Rem
Type TRESTResponseException Extends TRESTBaseException
End Type
