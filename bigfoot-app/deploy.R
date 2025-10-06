library(rsconnect)
app_dir <- "/FILE PATH TO YOUR APP"
deployApp(account = "YOURUSERNAMEHERE",
          appDir = app_dir,
          appName = "YOURAPPNAMEHERE",
          forceUpdate = TRUE,
          logLevel = "verbose")
unlink("/FILE PATH TO YOUR APP/rsconnect", recursive = TRUE)