//// ControlBase is a base class for controls (elements of UI Design)

ControlBase = class
  
//// Construct new instance of class
  constructor = function()
    
    // position of this control on the screen
    this.Position = new Vector(0,0)
    
    // size of this control
    this.Size = new Vector(0,0)
  end
  
//// Click is executed whenever this control is interacted with
  Click = function()
  end
  
//// Draw draws this Control on the screen
  Draw = function()
    if Config.DebugUI then
      screen.drawRect(this.Position.X, this.Position.Y, this.Size.X, this.Size.Y, "rgb(255,75,75)")
    end
  end
end