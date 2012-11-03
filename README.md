tdd-js-template
=================

A template for a javascript test driven development project. Uses requireJS, jasmine and phantomJS. This project is built to automatically detect all the specs in a directory and run them, see the command below

* to run the tests you'll need to install [phantomJS](http://phantomjs.org/download.html) on your machine 
* add the phantomjs.exe location to your path (or replace to a fully qualified path in the next instruction code)
* run `phantomjs lib/run_jasmine_test.coffee specs`

Given the following class file `src/X.js`:

	define(function() {
		function X() {
		}

		return X;
	});

The spec file `specs/X_spec.js` will look like this:


	define(['X'], function(X) {
		describe('X', function() {
			it('is an X', function() {
				expect(true).toBe(true);
			});
		});
	});


**the _spec suffix is mandatory for the script to automatically identify the spec files**\n
**at the moment the test command can only be run from the project root**

