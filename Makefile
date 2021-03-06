TESTS = test/*.test.js
REPORTER = spec
TIMEOUT = 20000
PATH := ./node_modules/.bin:$(PATH)

lint:
	@eslint --fix lib index.js test

test:
	@mocha -t $(TIMEOUT) -R spec $(TESTS)

test-cov:
	@nyc --reporter=html --reporter=text mocha -t $(TIMEOUT) -R spec $(TESTS)

test-coveralls: lint
	@nyc mocha -t $(TIMEOUT) -R spec $(TESTS)
	@echo TRAVIS_JOB_ID $(TRAVIS_JOB_ID)
	@nyc report --reporter=text-lcov | coveralls

doc:
	@doxmate build

.PHONY: test doc
