// Test scene for camera development and testing
CameraTestScene = class extends SceneBase
  
//// constructor creates new instance of CameraTest scene  
  constructor = function()
    super()
    
    this.Name = "CameraTest"
    
    DEBUG_MakeMap()
    DEBUG_MakeUnit(0, 0, "unit1")
    DEBUG_MakeUnit(16, 32, "unit2")
    DEBUG_MakeUnit(-48, -48, "unit3")
    DEBUG_MakeUnit(32, -32, "unit4")
    // DEBUG_MakeUnit(40, -20)
    
    this.AddUIDesign(new TestUiDesign())
  end
  
  DEBUG_MakeUnit = function(x, y, spriteName)
    local entityId = this.AddEntity("MyEntity")
    
    this.AddComponent(entityId, TransformComponent)
    local transform = this.Components.GetTransform(entityId)
    transform.Position.X = x
    transform.Position.Y = y
    
    this.AddComponent(entityId, SpriteComponent)
    local sprite = this.Components.GetSprite(entityId)
    
    sprite.InitAsUnit(spriteName)
    
    this.AddComponent(entityId, ControllerComponent)
  end
  
  DEBUG_MakeMap = function()
    local entityId = this.AddEntity("MyEntity")
    
    // Map Entity don't need Transform Component - it won't move and is always rendered at (0,0)
    
    // this.AddComponent(entityId, TransformComponent)
    // local transform = this.Components.GetTransform(entityId)
    // transform.Position.X = x
    // transform.Position.Y = y
    
    this.AddComponent(entityId, SpriteComponent)
    local sprite = this.Components.GetSprite(entityId)
    
    sprite.InitAsMap("myfirstmap")
    this.Navigator.GenerateNavData("myfirstmap")
  end
  
end