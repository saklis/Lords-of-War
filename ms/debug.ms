// Global debug object to handle all printout to console
Debug = object
  
//// Info prints out the message.
  Info = function(message)
    print(message)
  end
  
//// Log prints out debug logs, if they are enabled in Config.
  Log = function(message)
    if Config.Debug then
      print(" > " + message)
    end
  end
  
//// Error prints out error message with extra markings.
  Error = function(message)
    print("ERROR!!! " + message)
  end
end