// Component that hold info about position rotation and scale in the scene
TransformComponent = class extends Component
  
//// constructor creates new instance of Transform Component
  constructor = function()
    super()
    
    // Position in the scene
    this.Position = new Vector(0, 0)
    
    // Rotation in angles
    this.Rotation = 0
    
    // Scale
    this.Scale = new Vector(1, 1)
  end
end