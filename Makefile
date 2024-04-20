checkdotter:
	ifeq (, $(shell which dotter))
		@echo 'error: dotter is not installed, please install it`'
		@exit 1
	endif

deploy:
	dotter -v
