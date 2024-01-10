// MAIN - Game entry point

// Scene Manager instance
Scene = 0

// Viewport Renderer instance
Camera = 0

// MicroStudio.init function
init = function()
  Debug.Info("*** Lords of War vAlpha ***")
  
  // init global objects
  Scene = new SceneManager()
  Camera = new ViewportRenderer()
  
  // start default scene
  Scene.LoadDefaultScene()
end

// MicroStudio.update function
update = function()
  Camera.Update()
  Scene.Update()
end

// MicroStudio.draw function
draw = function()
  screen.clear()
  
  Scene.Draw()
  Camera.Draw()
end