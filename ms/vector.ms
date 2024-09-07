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
  
//// Normalize - normalize this vector to length of 1
  // @returns:number - normalized form of vector. If length is equal 0 then returns vector (0,0)
  Normalize = function()
    local length = GetLength()
    if length != 0 then
      this.X = X / length
      this.Y = Y / length
    end
  end
  
//// GetLength -  returns vector's magnitude
  // @returns:number - magnitude (length) of the vector
  GetLength = function()
    return sqrt(X*X + Y*Y)
  end
  
//// GetLengthSquared -  returns vector's squared magnitude (version to speed up calculations)
  // @returns:number - magnitude (length) of the vector
  GetLengthSquared = function()
    return X*X + Y*Y
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
    return "{" + this.X + "; " + this.Y + "}"
  end
end