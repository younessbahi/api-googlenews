# default build target
all::

all:: build

.PHONY: all build run test

build:
	docker build --tag api-googlenews:latest .

run:
	docker run -it --rm -p "8080:8080" api-googlenews:latest

test:
	@curl -v "localhost:8080/topic?category=world&country=US"
	@curl -v "localhost:8080/search?q=eurodollar&country=gb"