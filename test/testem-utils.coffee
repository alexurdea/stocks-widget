module.exports =
  testemRunnerPath: (bin = true) ->
    fs = require "fs"
    testemPath = if bin then "node_modules/.bin/testem" else "node_modules/testem/testem.js"
    extension = if bin && require("os").platform() == "win32" then ".cmd" else ""
    localPath = "#{process.cwd()}/#{testemPath}#{extension}"
    if fs.existsSync(localPath)
      localPath
    else
      throw "Testem runner wasn't found! Make sure it is installed locally to your project or under `node_modules/lineman`"