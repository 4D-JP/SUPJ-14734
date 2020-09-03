//%attributes = {}
$path:=Get 4D folder:C485(Current resources folder:K5:16)+"dino.4wp"

  //$form:=New object
  //$form.wpDoc:=WP Import document($path)

FORM LOAD:C1103("preview")

$wpDoc:=OBJECT Get pointer:C1124(Object named:K67:5;"wpDoc")
$wpDoc->:=WP Import document:C1318($path)

$countPages:=WP Get page count:C1412($wpDoc->)

C_REAL:C285($pageHeight;$pageWidth)
WP SET ATTRIBUTES:C1342($wpDoc->;wk layout unit:K81:78;wk unit pt:K81:136)


WP GET ATTRIBUTES:C1345($wpDoc->;\
wk page height:K81:263;$pageHeight;\
wk page width:K81:262;$pageWidth;\
wk page orientation:K81:264;$pageOrientation)

If ($pageOrientation=wk landscape:K81:275)
	OBJECT SET COORDINATES:C1248(*;"wpDoc";0;0;$pageHeight;$pageWidth*$countPages)
Else 
	OBJECT SET COORDINATES:C1248(*;"wpDoc";0;0;$pageWidth;$pageHeight*$countPages)
End if 

C_PICTURE:C286($image)
FORM SCREENSHOT:C940($image)
FORM UNLOAD:C1299

$path:=Temporary folder:C486+Generate UUID:C1066+".png"
WRITE PICTURE FILE:C680($path;$image)
OPEN URL:C673($path)