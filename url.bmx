'Code below taken from the public domain
'http://www.blitzmax.com/codearcs/codearcs.php?code=1581
'Original author is Perturbatio/Kris Kelly
'Wrapped by Htbaa/Christiaan Kras to fit in the module
Rem
	bbdoc:
	about:
End Rem
Type TURLFunc
	Rem
		bbdoc:
		about:
	End Rem
	Function EncodeString:String(value:String, EncodeUnreserved:Int = False, UsePlusForSpace:Int = True)
		Local ReservedChars:String = "!*'();:@&=+$,/?%#[]~r~n"
		Local s:Int
		Local result:String
	
		For s = 0 To value.length - 1
			If ReservedChars.Find(value[s..s + 1]) > -1 Then
				result:+ "%"+ TURLFunc.IntToHexString(Asc(value[s..s + 1]))
				Continue
			ElseIf value[s..s+1] = " " Then
				If UsePlusForSpace Then result:+"+" Else result:+"%20"
				Continue
			ElseIf EncodeUnreserved Then
					result:+ "%" + TURLFunc.IntToHexString(Asc(value[s..s + 1]))
				Continue
			EndIf
			result:+ value[s..s + 1]
		Next
	
		Return result
	End Function
	
	Rem
		bbdoc:
		about:
	End Rem
	Function DecodeString:String(EncStr:String)
		Local Pos:Int = 0
		Local HexVal:String
		Local Result:String
	
		While Pos<Len(EncStr)
			If EncStr[Pos..Pos+1] = "%" Then
				HexVal = EncStr[Pos+1..Pos+3]
				Result:+Chr(HexToInt(HexVal))
				Pos:+3
			ElseIf EncStr[Pos..Pos+1] = "+" Then
				Result:+" "
				Pos:+1
			Else
				Result:+EncStr[Pos..Pos + 1]
				Pos:+1	
			EndIf
		Wend
		
		Return Result
	End Function
	
	Rem
		bbdoc:
		about:
	End Rem
	Function HexToInt:Int( HexStr:String )
		If HexStr.Find("$") <> 0 Then HexStr = "$" + HexStr
		Return Int(HexStr)
	End Function
	
	Rem
		bbdoc:
		about:
	End Rem
	Function IntToHexString:String(val:Int, chars:Int = 2)
		Local Result:String = Hex(val)
		Return result[result.length-chars..]
	End Function

	Rem
		bbdoc: Create a query string from the given values
		about: Expects an array with strings. Each entry should be something like var=value
	End Rem
	Function CreateQueryString:String(params:String[])
		Local qs:String = "&".Join(params)
		If qs.Length > 0
			Return "?" + qs
		End If
		Return Null
	End Function
End Type