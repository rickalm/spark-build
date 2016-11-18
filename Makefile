manifest.json:
	bin/make-manifest.sh

docker: manifest.json
	bin/make-docker.sh

package: manifest.json
	bin/make-package.py

universe: manifest.json
	bin/make-universe.sh

test: manifest.json
	bin/test.sh

clean:
	-rm -rf build/ manifest.json

all_docker:
  make MANIFEST=manifest-1.6.2-2.7.2-2.10-jre7.json docker
  make MANIFEST=manifest-1.6.2-2.7.2-2.11-jre7.json docker
  make MANIFEST=manifest-2.0.0-2.7.2-2.11-jre7.json docker

.PHONY: package docker universe test clean all_docker
