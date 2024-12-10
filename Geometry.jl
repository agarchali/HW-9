module Geometry

using Test

import Base.show, Base.(==)

export Point2D, Point3D, distance2D, distance3D, perimeter, Polygon


"""
    Point2D(x::Real, y::Real)


Creates a Point2D object with dimensions x and y
Can take either two Numbers or a string similat to "(1, 2)"

# Example
```julia-repl
julia> Point2D(1,2)
(1, 2)

strng = "(1, -2.4)"
Point2D(strng)
(1.0, -2.4)

Point2D(("1, 2"))
(1, 2)
```
"""
struct Point2D
    x::Real
    y::Real
    str::String
    Point2D(x::Real, y::Real) = new(x, y)
    function Point2D(str::String)
        idk = match(r"^\(([+-]?\d*\.?\d+?),\s?([+-]?\d*\.?\d+?)\)$", str )
        x = parse(Float64, idk[1])
        y = parse(Float64, idk[2])
        new(x,y)
    end
end
Base.show(io::IO,p::Point2D) = print(io, string((p.x,p.y)))
Base.:(==)(p1::Point2D, p2::Point2D)= p1.x == p2.x && p1.y == p2.y 



"""
    Point3D(x::Real, y::Real, z::Real)


Creates a Point3D object with dimensions x, y, and z

# Example
```julia-repl
julia> Point3D(1,2,3)
(1, 2, 3)
```
"""
struct Point3D
    x::Real
    y::Real
    z::Real
end

Base.show(io::IO,p::Point3D) = print(io, string((p.x,p.y,p.z)))
Base.:(==)(p1::Point3D, p2::Point3D)= p1.x == p2.x && p1.y == p2.y && p1.z == p2.z


"""
    Polygon(x::vector{Point2D})
    Polygon(x::Vector{Real})
    Polygon(::Real...)

Creates a Polygon object with at least ```3``` points.
The points can be entered as a vector of Point2D, a Vector of reals, or vararg of reals.
If Using the vector of reals or the varag call, you must must know that every two reals are
converted into a Point2D object, therefore this struct will throw an error if the number of reals is odd.

#Important!
The points must be entered in either clockwise or counterclockwise orderfor compatibility with
other structures, such as perimeter

# Examples

```julia-repl
julia> Polygon([Point2D(1,2),Point2D(3,4),Point2D(5,6),Point2D(7,8)])
[(1, 2),(3, 4),(5, 6),(7, 8)]

x = [1, 2, 3, 4, 5, 6]
Polygon(x)
[(1, 2),(3, 4),(5, 6)]

Polygon(1,2,3,4,5,6)
[(1, 2),(3, 4),(5, 6)]
```

# Error examples
```julia-repl
julia> x = [1, 2, 3, 4, 5 ,6 ,7 ]
Polygon(x)

Polygon([Point2D(1,2),Point2D(3,4)])

Polygon(1,2,3,4,5)

```
"""
struct Polygon
    points::Vector{Point2D}

    # Inner constructor with Vector{Point2D}
    function Polygon(points::Vector{Point2D})
        if length(points) < 3
            throw(ArgumentError("A polygon must have at least three points."))
        end
        new(points)
    end
    function Polygon(coords::Vector{Int64})
        if length(coords) % 2 != 0
            throw(ArgumentError("The number of coordinates must be even to form (x, y) pairs."))
        end
        points = [Point2D(coords[i], coords[i+1]) for i in 1:2:length(coords)]
        return Polygon(points)
    end

    # Outer constructor with Varargs of Real, calls the inner constructor with Vector{Real}
    Polygon(coords::Real...) = Polygon(collect(coords))

  
end

function Base.:(==)(p1::Polygon,p2::Polygon)
    all(p1.points[i] == p2.points[i] for i in 1:length(p1.points))
end
function Base.show(io::IO, p::Polygon)
    print(io, reduce((str ,n) -> str * (n==1 ?  "[" : ",") * "$(p.points[n])",collect(1:length(p.points)),init=""),"]")
end

  """
    Polygon(p1::Point2D, p2::Point2D)
Takes two 2D points of type Point2D and returns the distance between them

# Example

```julia-repl
julia>p1 = Point2D(1,2)
p2 = Point2D(9,8)
distance2D(p1,p2)

10.0
```
"""
function distance2D(point1::Point2D, point2::Point2D)
    x = point1.x-point2.x
    y = point1.y-point2.y

    return sqrt(x^2+y^2)
end

"""
Polygon(p1::Point3D, p2::Point3D)
Takes two 3D points of type Point3D and returns the distance between them

# Example

```julia-repl
julia>pn1 = Point3D(1,2,3)
pn2 = Point3D(9,8,7)
distance3D(p1,p2)

10.770329614269007
```
"""
function distance3D(point1::Point3D, point2::Point3D)
    x = point1.x-point2.x
    y = point1.y-point2.y
    z = point1.z-point2.z
    return sqrt(x^2+y^2+z^2)
end


"""
perimeter(x::Polygon)

Takes a Polygon object and returns its perimeter

# Example

```julia-repl
julia>square = Polygon([Point2D(1,3),Point2D(3,3),Point2D(3,1),Point2D(1,1)])
perimeter(square)

8.0
```
"""
function perimeter(idk::Polygon)
    tot = 0
  for i = 1:length(idk.points)
    if i == length(idk.points)
    tot += distance2D(idk.points[i],idk.points[1])
  else
    tot += distance2D(idk.points[i],idk.points[i+1])
  end
  end
    return tot
  end

  function isRectangular(idk::Polygon)
    if length(idk.points)!=4
        return false
    else
        return isapprox(distance2D(idk.points[1],idk.points[3]),distance2D(idk.points[2],idk.points[4]))
    end
end


end # Geometry module