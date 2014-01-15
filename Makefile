#VERSION=1.2.8

default:
	@echo usage:
	@echo \# checkout specified version, fetch file, update component.json, commit and create a tag:
	@echo make prepare VERSION=x.x.x
	@echo \# then push it to gh:
	@echo make push

src:
	git clone https://github.com/angular/bower-angular.git src

fetch: src
	cd src && git fetch

checkout: fetch
	cd src && git checkout v$(VERSION)

angular.js: checkout
	cp src/angular.js .

component:
	sed --in-place "s/\"version\": \".*\"/\"version\": \"$(VERSION)\"/" component.json

commit:
	git commit --all --message "version $(VERSION)"

tag:
	git tag $(VERSION)

prepare: angular.js component commit tag

push:
	git push origin master --tags

clean:
	rm -rf src

.PHONY: default fetch checkout component commit tag prepare push clean
