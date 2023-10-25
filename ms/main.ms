// MAIN - Game entry point

// Scene Manager instance
Scene = 0

// MicroStudio.init function
init = function()
  // init global objects
  Scene = new SceneManager()
  
  // start default scene
  Scene.LoadDefaultScene()
end

// MicroStudio.update function
update = function()
  Scene.Update()
end

// MicroStudio.draw function
draw = function()
end