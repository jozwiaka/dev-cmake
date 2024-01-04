prepare:
	rm -rf build
	mkdir build

configure:
	cd build && cmake .. || exit

build:
	cd build && cmake --build . || exit

run:
	./build/app/exe

all: prepare configure build run

gitsubmodule:
	git submodule deinit -f -- /mnt/c/dev/cmake_learning/Other/Gitsubmodule/external/json || echo "Error"
	git submodule deinit -f -- external/json || echo "Error"

	git rm -rf -f --cached /mnt/c/dev/cmake_learning/Other/Gitsubmodule/external/json || echo "Error"
	git rm -rf -f --cached external/json || echo "Error"
	
	rm -rf external/json || echo "Error"
	git config -f ../../.gitmodules --remove-section submodule.Other/Gitsubmodule/external/json || echo "Error"
	git config -f ../../.git/config --remove-section submodule.Other/Gitsubmodule/external/json || echo "Error"
	rm -rf external || echo "Error"
	mkdir -p external || echo "Error"
	touch external/CMakeLists.txt || echo "Error"
	git submodule add https://github.com/nlohmann/json external/json || echo "Error"

dependency:
	# apt install graphviz
	cd build && cmake .. --graphviz=graph.dot && dot -Tpng graph.dot -o graphImage.png

.PHONY: all prepare configure build run gitsubmodule
