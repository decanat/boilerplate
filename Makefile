BINS = node_modules/.bin

# List of scripts
LIB = $(wildcard lib/*.js)

# Duo binary
D=$(BINS)/duo
M=$(BINS)/mocha

#
REPORTER ?= dot


# Compile
build: node_modules build/index.js

# Run build if changes were made
build/index.js: index.js $(LIB)
	@$(D) $<


# Run Mocha tests
test: node_modules
	@$(M) -R $(REPORTER)


# Install npm modules
node_modules: package.json
	@npm install

# Clean non-checked-in files
clean:
	rm -rf components build node_modules


.PHONY: build test clean
