// Test scene for camera development and testing
CameraTestScene = class extends SceneBase
  
//// constructor creates new instance of CameraTest scene  
  constructor = function()
    super()
    
    this.Name = "CameraTest"
    
    DEBUG_MakeEntity(0, 0)
    DEBUG_MakeEntity(20, 30)
    DEBUG_MakeEntity(-30, -20)
    DEBUG_MakeEntity(-15, 25)
    DEBUG_MakeEntity(40, -20)
  end
  
  DEBUG_MakeEntity = function(x, y)
    entityId = this.AddEntity("MyEntity")
    this.AddComponent(entityId, TransformComponent)
    transform = this.Components.GetTransform(entityId)
    transform.Position.X = x
    transform.Position.Y = y
  end
  
end