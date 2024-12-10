all: lint build

lint:
	go vet ./...

format:
	go fmt ./...

libw2v/lib/libw2v.a:
	mkdir -p _build
	rm -rf _build/*
	cd _build && cmake -DCMAKE_BUILD_TYPE=Release ../libw2v
	cd _build && make

build: libw2v/lib/libw2v.a
	go build .
	go build -o w2v/w2v ./w2v/main.go

upgrade:
	go get -u ./...
	go mod tidy

clean:
	go clean
	rm -rf _build libw2v/lib w2v/w2v w2v/w2v.exe
