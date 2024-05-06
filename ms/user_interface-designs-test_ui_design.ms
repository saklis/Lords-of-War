// Test UI Design for development and testing
TestUiDesign = class extends UIDesignBase

//// Constructor create new instance of this UI Design  
  constructor = function()
    super()
    
    this.Name = "Test UI Design"
    
    this.UiWidth = 75
  end
  
//// Draw draws UI
  Draw = function()
    super()
    
    if this.SelectedUnitId != -1 then
      local spriteComponent = Scene.Components.GetSprite(this.SelectedUnitId)
      screen.drawSprite(spriteComponent.Name, 180-40, 0, 48)
    end
  end
  
end