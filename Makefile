################################################################################
#   Bookcase                                                                   #
################################################################################

############################################################
# Variables                                                #
############################################################

ROOT = $(realpath $(dir $(lastword $(MAKEFILE_LIST))))


############################################################
# Build Targets                                            #
############################################################

.PHONY: all clean build build-test test install-deps

all: build

clean:
	@rm -rf ${ROOT}/_build   \
                ${ROOT}/*.native \
                ${ROOT}/*.byte   \
                ${ROOT}/index.html

build:
	@ocamlbuild -use-ocamlfind             \
         -pkgs cohttp,yojson                   \
         src/dynamoDB.cmxa

build-test:
	@ocamlbuild -Is src,tst -use-ocamlfind \
         -pkgs ounit,yojson                    \
         tst/testmain.native

test: build-test
	@./testmain.native

install-deps:
	@brew update
	@brew install opam pkg-config pcre
	@opam update
	opam install ounit yojson cohttp

readme:
	markdown ${ROOT}/README.md > ${ROOT}/index.html
	open ${ROOT}/index.html
