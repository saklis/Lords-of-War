// Test scene for camera development and testing
CameraTestScene = class extends SceneBase
  
//// constructor creates new instance of CameraTest scene  
  constructor = function()
    super()
    
    this.Name = "CameraTest"
    
    entityId = this.AddEntity("MyFirstEntity")
    this.AddComponent(entityId, TransformComponent)
  end
  
end