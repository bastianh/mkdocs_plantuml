
	docker build -t mkdocs .
	docker run --rm -it -v ${PWD}:/docs -p 8000:8000 mkdocs
