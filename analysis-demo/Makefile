toolsdemo:
	# "签名&权限"
	clang -framework Foundation toolsdemo.m -o toolsdemo
	codesign -s "zznQ" toolsdemo
	codesign -dvv toolsdemo
	codesign -d --entitlements - toolsdemo
	
	# "Object file"
	clang toolsdemo.m -c