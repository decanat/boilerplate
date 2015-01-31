BINS = node_modules/.bin

# List of scripts
LIB = $(wildcard lib/*.js)
# Assets directory for tests
ASSETS = test/assets
PID = $(ASSETS)/pid

# Duo binary
D=$(BINS)/duo
M=$(BINS)/mocha
S=$(BINS)/serve

#
REPORTER ?= dot
PORT ?= 8000


# Compile
build: node_modules build/index.js

# Run build if changes were made
build/index.js: index.js $(LIB)
	@$(D) $<


# Run Mocha tests
test: node_modules
	@$(M) -R $(REPORTER)

# Run Mocha in browser
test-browser: test/assets test/assets/index.js serve

# Mocha assets needed for browser
test/assets: node_modules
	@mkdir $(ASSETS)
	@cd $(ASSETS) && \
		ln -s ../../node_modules/mocha/mocha.css && \
		ln -s ../../node_modules/mocha/mocha.js

# Browser compatible tests
test/assets/%.js: test/%.js $(LIB)
	@$(D) $< \
		--development \
		--stdout > $@


# Serve test/ directory
serve: kill
	@$(S) test --port $(PORT) & echo $$! > $(PID)
	@sleep 1

# Kill 'serve' process with given PID or given PORT
kill:
	@kill -9 `cat $(PID)` 2> /dev/null || true
	@rm -f $(PID)


# Install npm modules
node_modules: package.json
	@npm install

# Clean non-checked-in files
clean: kill
	rm -rf components build node_modules $(ASSETS)


.PHONY: build test clean
