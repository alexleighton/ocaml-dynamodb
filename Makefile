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

.PHONY: all clean build build-test test install-deps doc view-doc

all: build

clean:
	@rm -rf ${ROOT}/_build           \
                ${ROOT}/*.native         \
                ${ROOT}/*.byte           \
                ${ROOT}/dynamoDB.docdir

build:
	@ocamlbuild -use-ocamlfind    \
         -pkgs yojson,uri,cohttp.lwt  \
         src/dynamoDB.native

doc:
	@ocamlbuild -use-ocamlfind      \
         -pkgs yojson,uri,cohttp.lwt    \
         src/dynamoDB.docdir/index.html

view-doc: doc
	@open ${ROOT}/dynamoDB.docdir/index.html

build-test:
	@ocamlbuild -Is src,tst -use-ocamlfind \
         -pkgs ounit,yojson,uri,cohttp.lwt     \
         tst/testmain.native

test: build-test
	@./testmain.native

install-deps:
	@brew update
	@brew install opam pkg-config pcre
	@opam update
	opam install ounit yojson cohttp.lwt uri ISO8601

readme:
	markdown ${ROOT}/README.md > ${ROOT}/index.html
	open ${ROOT}/index.html
