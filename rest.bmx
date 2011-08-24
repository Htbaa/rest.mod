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

SuperStrict

Rem
	bbdoc: htbaapub.rest
EndRem
Module htbaapub.rest
ModuleInfo "Name: htbaapub.rest"
ModuleInfo "Version: 1.09"
ModuleInfo "License: MIT"
ModuleInfo "Author: Christiaan Kras"
ModuleInfo "Special thanks to: Bruce A Henderson, Kris Kelly"
ModuleInfo "Git repository: <a href='http://github.com/Htbaa/rest.mod/'>http://github.com/Htbaa/rest.mod/</a>"
ModuleInfo "History: 1.09"
ModuleInfo "History: Made TRESTRequest.Call() more efficient when merging preset and per-request supplied headers"
ModuleInfo "History: 1.08"
ModuleInfo "History: Made TRESTRequest.proxy private (now _proxy). Use the SetProxyServer() method instead"
ModuleInfo "History: 1.07"
ModuleInfo "History: Added support for setting a proxy server"
ModuleInfo "History: 1.06"
ModuleInfo "History: Updated OpenSSL dll's to 1.0.0.4"
ModuleInfo "History: 1.05"
ModuleInfo "History: Ignore libcurl partial file error when doing a HEAD request because HEAD requests shouldn't contain a body at all"

Import bah.libcurlssl
Import brl.retro

Include "exceptions.bmx"
Include "url.bmx"
Include "response.bmx"
Include "request.bmx"
