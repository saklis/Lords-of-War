// represents a 2D vector along with handful of functions to manipulate them
Vector = class
//// constructor creates new instance of Vector class
  // @x:float - Value of the Vector on X axis
  // @y:float - Value of the Vector on Y axis
  constructor = function(x, y)
    this.X = x
    this.Y = y
  end
  
//// Add adds supplied argument values to respective axis
  // @x:float - value to add to X axis
  // @y:float - value to add to Y axis
  Add = function(x, y)
    this.X += x
    this.Y += y
  end
  
//// + operator creates new Vector which is a sum of two provided Vectors
  // @a:Vector - first Vector
  // @b:Vector - second Vector
  // @returns new Vector which is a sum of two
  "+" = function(a, b)
    return new Vector(a.X + b.X, a.Y + b.Y)
  end
  
//// - operator creates new Vector which is a difference of two provided Vectors
  // @a:Vector - first Vector
  // @b:Vector - second Vector
  // @returns new Vector which is a diference of two
  "-" = function(a, b)
    return new Vector(a.X - b.X, a.Y - b.Y)
  end
  
//// ManhattanDistance calculates distance between two vectors using Manhattan method
  // @other:Vector - other Vector to calculate distance to
  // @returns calculated distance
  ManhattanDistance = function(other)
    return abs(other.X - this.X) + abs(other.Y - this.Y)
  end
  
//// ChebyshevDistance calculates distance between two vectors using Chebyshev method
  // @other:Vector - other Vector to calculate distance to
  // @returns calculated distance
  ChebyshevDistance = function(other)
    return max(abs(other.X - this.X), abs(other.Y - this.Y))
  end
  
//// ToString returns a string representation of the Vector
  // @returns string representing the Vector
  ToString = function()
    return "X: " + this.X + "; Y: " + this.Y
  end
end