using .Geometry
using Test

import Base.:(==)



    @testset "Point2D" begin
        @test isa(Point2D(1,4),Point2D)
        @test isa(Point2D(-1,2),Point2D)    
        @test isa(Point2D(-3.14,4.13),Point2D)
        @test isa(Point2D(1.1,2.2),Point2D)
        @test isa(Point2D(1.2,0),Point2D)
    end

    @testset "Point2D default constructor" begin
        @test Point2D("(-1, -2)") == Point2D(-1, -2)
        @test Point2D("(-2,4.5)") == Point2D(-2,4.5)
        @test Point2D("(1.3, 2)") == Point2D(1.3, 2)
    end

    @testset "Point3D" begin
        @test isa(Point3D(1,4, 7),Point3D)
        @test isa(Point3D(-1,2,3),Point3D)    
        @test isa(Point3D(-3.14,4.13,0.01),Point3D)
        @test isa(Point3D(1.1,2.2,3.3),Point3D)
        @test isa(Point3D(1.2,4.76,0),Point3D)
    end

    tri = [1,3,4,1,1,1]
    @testset "Triangle" begin
        @test isa(Polygon([Point2D(1,3),Point2D(4,1),Point2D(1,1)]),Polygon)
        @test isa(Polygon(1,3,4,1,1,1),Polygon) 
        @test isa(Polygon(tri),Polygon) 
    end

    rec = [1,3,5,3,5,1,1,1]
    @testset " Rectangle" begin
        @test isa(Polygon([Point2D(1,3),Point2D(5,3),Point2D(5,1),Point2D(1,1)]),Polygon) 
        @test isa(Polygon(1,3,5,3,5,1,1,1),Polygon) 
        @test isa(Polygon(rec),Polygon) 
    end

    par = [2,3,5,3,4,1,1,1]
    @testset " Parallelogram" begin
        @test isa(Polygon([Point2D(2,3),Point2D(5,3),Point2D(4,1),Point2D(1,1)]),Polygon) 
        @test isa(Polygon(2,3,5,3,4,1,1,1),Polygon) 
        @test isa(Polygon(par),Polygon)
    end

    @testset "Polygon default constructor" begin
        @test Polygon([Point2D(2,3),Point2D(5,3),Point2D(4,1),Point2D(1,1)]) == Polygon(2,3,5,3,4,1,1,1) == Polygon(par)
    end

    par2 = [2,3,5,3,4,1,1,1,3]
    @testset "Polygon Error" begin
        @test_throws ArgumentError Polygon(2,3,5,3) # <3 points
        @test_throws ArgumentError Polygon(par2)# Odd
    end;


    p1 = Point2D(1, 4)
    p2 = Point2D(4, 1)
    #4.242640687119285
    p3 = Point2D(0, 1)
    p4 = Point2D(3, 4)
    #4.242640687119285

    p5 = Point2D(1, 6)
    p6 = Point2D(1, 4)
    #2
    p7 = Point2D(4, 1)
    p8 = Point2D(6, 1)
    #2

    p9 = Point2D(1, 1)
    p10 = Point2D(4, 5)
    #5
    p11 = Point2D(-2, 0)
    p12 = Point2D(-6, -3)
    #5

    @testset "Distance" begin
        @test isapprox(distance2D(p1,p2),distance2D(p3,p4)) 
        @test isapprox(distance2D(p5,p6), distance2D(p7,p8)) 
        @test isapprox(distance2D(p9,p10),distance2D(p11,p12)) 
    end

    triangle = Polygon([Point2D(1,3),Point2D(4,1),Point2D(1,1)]) # 8.6055512755
    rectangle = Polygon([Point2D(1,3),Point2D(5,3),Point2D(5,1),Point2D(1,1)]) # 12
    parallelogram = Polygon([Point2D(2,3),Point2D(5,3),Point2D(4,1),Point2D(1,1)]) # 10.4721359550

    @testset "Perimeter" begin
        @test isapprox(perimeter(triangle), 8.6055512755)
        @test isapprox(perimeter(rectangle), 12) 
        @test isapprox(perimeter(parallelogram), 10.4721359550) 
    end

