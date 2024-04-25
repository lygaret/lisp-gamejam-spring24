local fennel = require("lib.fennel")
  .install({ correlate = true, moduleName = "lib.fennel" })

debug.traceback = fennel.traceback

require("game.main")
