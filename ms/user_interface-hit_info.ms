//// Hit Info is constructed by HitTrace() from UI Design and contains information about whatever it is under the provided coordinates

HitInfo = class
  
//// Construcotr creates new instance of Hit Info
  constructor = function()
    // type of element that was clicked on
    this.Type = HitInfoType.None
    
    // reference to the object that was clicked on
    // Attention! Check this.Type to know what is the type of the referenced object!
    this.Object = 0
    
    // Coordinates of the Hit in World Space
    this.HitWorldPosition = 0
    
    // Coordinates of the Hit in Map Space
    this.HitMapPosition = 0
  end
end