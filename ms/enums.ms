// Types of sprites
SpriteType = object
  Default = "default"
  Unit = "unit"
  Map = "map"
end

// Types of render tasks
RenderTaskType = object
  Ground = "ground"
  Terrain = "terrain"
  Location = "location"
  City = "city"
  Unit = "unit"
  Canopy = "canopy"
end

// Types of things that can be clicked on - used by Hit Info in User interface
HitInfoType = object
  None = "none"
  Ground = "ground"
  Terrain = "terrain"
  Unit = "unit"
end