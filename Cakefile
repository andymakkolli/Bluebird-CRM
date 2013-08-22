# This is the build file required for managing the SCSS/Coffeescript files
# You're able to manually update the SCSS files through Sass command line
# but the .coffee files Are concatenated by folder, and outputed as
# single files in order to maintain some semblence of includes/requires. 
# Dependencies are: Coffeescript 1.6.3 and Sass 3.2.10

# It's generally not advisable to directly modify the .js and .css 
# files that are generated by coffeescript & sass because they're
# automatically generated. 

# requires: file system access module, file system path module,
# and the exec module for executing system processes
fs     = require 'fs'
{exec} = require 'child_process'
fspath = require 'path'

# coffeescript files are listed as path, output name, as an array of objects
# the path is the folder the contains all of the individual scripts
# that will be concatenated into a single script. it does not load
# said scripts at runtime (a la require.js), but it does allow
# you to break up monolithic .js files into conceptual branches.

# todo: allow for non-runtime required js files from other folders
# this could be a header at the top that looks for "bbjsrequire 'path'"
# and read the path, and drop it into the array.
coffeeFiles  = [
  {path: 'themes/Bluebird/scripts/tree', outputName: "JSTree"}
  {path: 'themes/Bluebird/scripts/jquery.taggingAutocomplete', outputName: "jquery.taggingAutocomplete"}
  {path: 'themes/Bluebird/scripts/jquery.infiniScroll', outputName: "jquery.infiniScroll"}
  {path: 'themes/Bluebird/scripts/bbUtils', outputName: "bbUtils"}
  {path: 'themes/Bluebird/scripts/bbJSsettings', outputName: "bbhg"}
]

# sassFiles outputs a single css file named "outputName"
sassFiles = [
  {path: 'themes/Bluebird/nyss_skin/tags', outputName: "tags"}
]

# for sublime users, in your CoffeeScript.sublime-build file,
# this is what you refer to after cake. cake 'sbuild','sassbuild',
# or whatever tasks you're writing. hypothetically you can remove
# the content of sbuild and make it 2 different non-blocking processes
# so that you're compiling multiple sets simultaniously

task 'sbuild', 'Build all Coffee files', ->
  # read all of the paths in coffeeFiles in order to read what's in
  # the dir's of them
  pathContents = new Array remaining = Object.keys(coffeeFiles).length
  for obj, index in coffeeFiles then do (obj, index) ->
    outputName = obj.outputName
    tempName = "#{outputName}_temp"
    path  = obj.path
    filesToRead = []
    # using fs.existsSync is unfortunate and should be adjusted
    fs.readdir "#{path}", (err, files) ->
      fs.exists "#{path}/#{tempName}.coffee", (exists) ->
        if exists
          fs.unlink "#{path}/#{tempName}.coffee", (err) ->
            throw err if err
            console.log 'Removed Residual app.coffee file.'
      fs.existsSync "#{path}/#{tempName}.coffee", (exists) ->
        if exists then console.log('still exists')            
      for file, index in files then do (files, index) ->
        if fspath.extname(file) is ".coffee"
          filesToRead.push(file)
      appContents = new Array aremaining = filesToRead.length
      for file, index in filesToRead then do (files, index) ->
        fs.readFile "#{path}/#{file}", 'utf8', (err, fileContents) ->
          throw err if err
          appContents[index] = fileContents
          process(path) if --aremaining <= 0
      process = () ->
        fs.writeFile "#{path}/#{tempName}.coffee", appContents.join('\n\n'), 'utf8', (err) ->
          throw except if err
          # where you write coffee
          exec "coffee --compile #{path}/#{tempName}.coffee", (err, stdout, stderr) ->
            fs.unlink "#{path}/#{tempName}.coffee", (err) ->
              throw err if err
            if err
              console.log "errored?"
            fs.rename "#{path}/#{tempName}.js", "#{path}/#{outputName}.js" 
            # console.log stdout + stderr
            console.log "wrote #{path}/#{outputName}.js"
            time = new Date()
            currentTime = "#{time.getHours()}:#{time.getMinutes()}:#{time.getSeconds()}"
            console.log(currentTime)

task 'sassbuild', 'Build all Sass Files', ->
  # we're not worried about concatinating because sass already does that
  # with @import rules
  pathContents = new Array remaining = Object.keys(sassFiles).length
  for obj, index in sassFiles then do (obj, index) ->
    outputName = obj.outputName
    path  = obj.path
    filesToProcess = []
    fs.readdir  "#{path}", (err, files) ->
      for file, index in files then do (files, index) ->
        if fspath.extname(file) is (".scss" or ".sass")
          ext = fspath.extname(file)
          process("#{path}/#{file}", path, ext)
    process = (filepath, path, ext) ->
      exec "sass #{filepath} #{path}/#{outputName}.css", (err, stdout, stderr) ->
        if err
          console.log "errored?"
          console.log err
        else
          console.log "wrote #{path}/#{outputName}#{ext}"
          time = new Date()
          currentTime = "#{time.getHours()}:#{time.getMinutes()}:#{time.getSeconds()}"
