build:
	clang client.m -o client
	clang server.m -o server
	
	# "Must replace the path in tech.macoder.xpcdemo.plist '{{PATH}}' with your own path, and then run "make test"."
test:
	sudo cp tech.macoder.xpcdemo.plist /Library/LaunchDaemons
	sudo launchctl load /Library/LaunchDaemons/tech.macoder.xpcdemo.plist
	./client
clean:
	rm client & rm server
	sudo launchctl unload /Library/LaunchDaemons/tech.macoder.xpcdemo.plist & sudo launchctl remove /Library/LaunchDaemons/tech.macoder.xpcdemo.plist & sudo rm /Library/LaunchDaemons/tech.macoder.xpcdemo.plist