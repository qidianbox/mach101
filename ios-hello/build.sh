# build for ios

## 111
# clang -target arm64-apple-darwin \
#       -arch arm64 \
#       -o hello \
#       -isysroot `xcrun --sdk iphoneos --show-sdk-path` \
#       -miphoneos-version-min=9.0 \
#       hello.m

`xcrun --sdk iphoneos -f clang` -arch arm64 \
      -isysroot `xcrun --sdk iphoneos --show-sdk-path` \
      -miphoneos-version-min=8.0 \
      -o hello \
      hello.m

`xcrun --sdk iphoneos -f strip` -Sx hello

`xcrun --sdk iphoneos -f codesign` -f -s "iPhone Developer" --entitlements entitlements.xml hello