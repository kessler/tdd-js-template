tdd-js-template
=================

A template for a javascript test driven development project. Uses requireJS, jasmine and phantomJS

* to run the tests you'll need to install [phantomJS](http://phantomjs.org/download.html) on your machine 
* add the phantomjs.exe location to your path (or replace to a fully qualified path in the next instruction code)
* run `phantomjs lib/run_jasmine_test.coffee specs`

Given the following "class" in `src/X.js`:

`
define(function() {
	function X() {
	}

	return X;
});
`

The spec will look like this:

`
define(['X'], function(X) {
	describe('X', function() {
		it('is an X', function() {
			expect(true).toBe(true);
		});
	});
});

`


