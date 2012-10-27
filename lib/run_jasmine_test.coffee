#!/usr/local/bin/phantomjs

# Runs a Jasmine Suite from an html page
# @page is a PhantomJs page object
# @exit_func is the function to call in order to exit the script

class PhantomJasmineRunner
  constructor: (@page, @exit_func = phantom.exit) ->
    @tries = 0
    @max_tries = 10

  get_status: -> @page.evaluate(-> console_reporter.status)

  terminate: ->
    switch @get_status()
      when "success" then @exit_func 0
      when "fail"    then @exit_func 1
      else                @exit_func 2

# Script Begin
if phantom.args.length == 0
  console.log "Need a spec directory as the argument"
  phantom.exit 1

page = new WebPage()

runner = new PhantomJasmineRunner(page)

# Don't supress console output
page.onConsoleMessage = (msg) ->
  console.log msg

  # Terminate when the reporter singals that testing is over.
  # We cannot use a callback function for this (because page.evaluate is sandboxed),
  # so we have to *observe* the website.
  if msg == "ConsoleReporter finished"
    runner.terminate()

# my coffee script sucks :) /yanush

fs = require('fs')

specDir = "#{fs.workingDirectory}#{fs.separator}#{phantom.args[0]}"

console.log("running specs from #{specDir}")

tempSpecs = fs.list(specDir)
specs = []

suffix = '_spec.js'

for spec in tempSpecs
  if (spec.substr(suffix.length * -1) == suffix)    
    specs.push(encodeURIComponent("../#{phantom.args[0]}/#{spec.replace('.js', '')}"))

url = "lib/TestRunner.html\##{specs}"

console.log("launching runner at #{url}")

page.open url, (status) ->
  if status != "success"
    console.log "can't find lib/TestRunner.html"
    phantom.exit 1

  # Now we wait until onConsoleMessage reads the termination signal from the log.
