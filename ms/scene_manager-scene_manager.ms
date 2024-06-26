//// Scene Manager is a class that handles asset loading, scene transitions and alike

SceneManager = class
  
//// constructor creating new instance of scene manager  
  constructor = function()
    // reference to current scene
    this.Current = 0
    
    Debug.Info("Scene Manager created")
  end
  
//// LoadDefaultScene load scene set as default one in game config
  LoadDefaultScene = function()
    Debug.Info("Creating default scene...")
    this.LoadScene(Config.DefaultSceneClass)
  end
  
//// LoadScene loads all assets required by the scene and is a stargin point for scene's logic
  // @sceneName:string - name of the scene to load
  LoadScene = function(sceneName)
    Debug.Info("Loading scene: " + sceneName)
    if this.Current == 0 then
      this.Current = this.CreateSceneObject(sceneName)
      if this.Current == 0 then Debug.Error("While loading scene!")
      else 
        Debug.Info("Scene loaded! Current scene: '"+this.Current.Name+"' / UI Design: '"+this.Current.UI.Name+"'")
        Debug.Info("Entities count: " + this.Current.EntitiesCount() + "/" + Config.EntitiesMaxCount)
        Debug.Info("Components count: " + this.Current.Components.CountAll())
      end
    end
  end
  
//// CreateSceneObject creates a object from class that is assigned to the supplied name
  // @sceneName:string - name of the scene to load
  // @returns instance of the scene class. Returns 0 in case of error
  CreateSceneObject = function(sceneName)
    if sceneName == "Blank" then return new BlankScene() end
    if sceneName == "CameraTest" then return new CameraTestScene() end
    Debug.Error("Unable to create scene object. Scene name '"+ sceneName +"' not recognised.")
    return 0
  end

//// Update calls update method for current scene  
  Update = function()
    if this.Current != 0 then
      this.Current.Update()
    end
  end
  
end