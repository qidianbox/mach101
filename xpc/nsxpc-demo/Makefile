build:
	clang -framework Foundation client.m -o client
	clang -framework Foundation server.m -o nsxpcserver
	
	# "Must replace the path in tech.macoder.nsxpc.plist '{{PATH}}' with your own path, and then run "make test"."
test:
	sudo cp tech.macoder.nsxpc.plist /Library/LaunchDaemons
	sudo launchctl load /Library/LaunchDaemons/tech.macoder.nsxpc.plist
	./client
clean:
	rm client & rm nsxpcserver
	sudo launchctl unload /Library/LaunchDaemons/tech.macoder.nsxpc.plist & sudo launchctl remove /Library/LaunchDaemons/tech.macoder.nsxpc.plist & sudo rm /Library/LaunchDaemons/tech.macoder.nsxpc.plist