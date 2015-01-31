BINS = node_modules/.bin

# List of scripts
LIB = $(wildcard lib/*.js)

# Binaries
D=$(BINS)/duo
M=$(BINS)/mocha
P=$(BINS)/mocha-phantomjs
S=$(BINS)/serve

#
REPORTER ?= dot
PORT ?= 8000

# Assets directory for tests
ASSETS = test/assets
PIDFILE = $(ASSETS)/pid
# PID from file
FPID = `cat $(PIDFILE)`
# PID from lsof
NPID = `lsof -t -i:$(PORT)`

# URL for tests
URL = http://localhost:$(PORT)

# Compile
build: node_modules build/index.js

# Run build if changes were made
build/index.js: index.js $(LIB)
	@$(D) $<

# Run Mocha tests
test: node_modules
	@$(M) -R $(REPORTER)

# Run Mocha tests in headless browser
test-phantom: test-browser
	@$(P) $(URL)

# Build to run Mocha in browser
test-browser: node_modules test/assets test/assets/index.js serve

# Mocha assets needed for browser
test/assets:
	@mkdir test/assets
	@cd $(ASSETS) && \
		ln -s ../../node_modules/mocha/mocha.css && \
		ln -s ../../node_modules/mocha/mocha.js

# Browser compatible tests
test/assets/%.js: test/%.js $(LIB)
	@$(D) $< \
		--development \
		--stdout > $@


# Serve test/ directory
serve:
ifeq (,$(wildcard $(PIDFILE)))
	@$(S) test \
		--port $(PORT) \
		--exec "make test/assets/index.js" \
		--no-logs & echo $$! > $(PIDFILE)
	@sleep 1
endif

# Kill 'serve' process with given PID or given PORT
kill:
ifneq (,$(wildcard $(PIDFILE)))
	@kill -9 $(FPID) 2> /dev/null || true
	@rm -f $(PIDFILE)
endif

# Install npm modules
node_modules: package.json
	@npm install

# Clean non-checked-in files
clean: kill
	rm -rf components build node_modules $(ASSETS)


.PHONY: build test clean
