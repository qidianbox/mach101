build:
	gcc -Xlinker -sectcreate -Xlinker __TEXT -Xlinker __info_plist -Xlinker Info.plist main.c -o sandboxed
	codesign -s zznQ --entitlements sandboxent.xml sandboxed