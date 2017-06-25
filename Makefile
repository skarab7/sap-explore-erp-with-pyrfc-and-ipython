DOCKER_IMAGE_TAG=pysaprfc

clean:
	rm -r nwrfcsdk

unpack:
	unzip nwrfcsdk_x64_linux.zip

docker_build:
	docker build -t $(DOCKER_IMAGE_TAG) $(CURDIR)

docker_run: docker_rm docker_build
	docker run -it \
	   -v $$(pwd)/nwrfcsdk:/usr/sap/nwrfcsdk/ \
	   --name $(DOCKER_IMAGE_TAG)-cli \
	    $(DOCKER_IMAGE_TAG):latest \
	   /bin/bash

docker_rm:
	docker rm $(DOCKER_IMAGE_TAG)-cli