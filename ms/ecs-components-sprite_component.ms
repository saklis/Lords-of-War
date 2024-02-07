// Component that hold info about sprite to be rendered
SpriteComponent = class extends ComponentBase
  
//// constructor creates new instance of Sprite Component
  constructor = function()
    super()
    
    // Name of the sprite file to display
    this.Name = ""
    
    // Type of sprite. Will impact drawing
    this.Type = SpriteType.Ground
  end
end