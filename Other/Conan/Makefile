conan_setup:
	pip install conan

	# Let Conan try to guess the profile, based on the current operating system and installed tools, please run:
	conan profile detect --force
	cat /root/.conan2/profiles/default || echo "Wrong profile path"

prepare:
	rm -rf build
	mkdir build
	conan install . --output-folder=build --build=missing

configure:
	cd build && cmake .. || exit

build:
	cd build && cmake --build . || exit

run:
	./build/exe

all: conan_setup prepare configure build run


.PHONY: all prepare configure build run conan_setup
