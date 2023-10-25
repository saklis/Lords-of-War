//// Scene Manager is a class that handles asset loading, scene transitions and alike

SceneManager = class
  
  constructor = function()
    CurrentScene = 0
  end
  
  LoadDefaultScene = function()
    this.LoadScene(Config.DefaultSceneClass)
  end
  
  //// LoadScene loads all assets required by the scene and is a stargin point for scene's logic
  // @sceneName:string - name of the scene to load
  LoadScene = function(sceneName)
    print("Loading scene: " + sceneName)
    if CurrentScene == 0 then
      CurrentScene = CreateSceneObject(sceneName)
      if CurrentScene == 0 then print("ERROR! while loading scene!")
      else print("Scene loaded!") end
    end
  end
  
  //// CreateSceneObject creates a object from class that is assigned to the supplied name
  // @sceneName:string - name of the scene to load
  CreateSceneObject = function(sceneName)
    if sceneName == "CameraTest" then return new CameraTest() end
    print("ERROR! Unable to create object scene of unrecognised name of '" + sceneName + "'")
    return 0
  end
  
  Update = function()
  end
  
end