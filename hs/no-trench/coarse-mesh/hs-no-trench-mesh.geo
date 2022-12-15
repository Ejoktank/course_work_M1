//SetFactory("OpenCASCADE");
TrenchWidth = 1.0;
TrenchHeight = 12;
TrenchDepth = 2;
SoilSurfaceRadius = 35;
HalfSpaceRadius = 300;
Cos1 = 0.5;
Sin1 = Sqrt(3.0)/2.0;
Cos2 = Cos(7.0*Pi/18.0);
Sin2 = Sin(7.0*Pi/18.0);

Point(1) = {-TrenchHeight/4.0,0.0,0.0};
Point(2) = {0.0,0.0,0.0};
Point(3) = {TrenchHeight/4.0 - TrenchWidth,0.0,0.0};
Point(4) = {TrenchHeight/4.0,0.0,0.0};
Point(5) = {TrenchHeight/4.0,TrenchHeight/2.0,0.0};
Point(6) = {TrenchHeight/4.0 - TrenchWidth,TrenchHeight/2.0,0.0};
Point(7) = {0.0,TrenchHeight/2.0,0.0};
Point(8) = {-TrenchHeight/4.0,TrenchHeight/2.0,0.0};
Point(9) = {SoilSurfaceRadius,0.0,0.0};
Point(10) = {SoilSurfaceRadius*Cos1,SoilSurfaceRadius*Sin1,0.0};
Point(11) = {SoilSurfaceRadius*Cos2,SoilSurfaceRadius*Sin2,0.0};
Point(12) = {0.0,SoilSurfaceRadius,0.0};
Point(13) = {-SoilSurfaceRadius*Cos1,SoilSurfaceRadius*Sin1,0.0};
Point(14) = {-SoilSurfaceRadius,0.0,0.0}; 
Point(15) = {HalfSpaceRadius,0.0,0.0};
Point(16) = {HalfSpaceRadius,HalfSpaceRadius,0.0};
Point(17) = {-HalfSpaceRadius,HalfSpaceRadius,0.0};
Point(18) = {-HalfSpaceRadius,0.0,0.0};
Point(19) = {HalfSpaceRadius,0.0,-HalfSpaceRadius};
Point(20) = {HalfSpaceRadius,HalfSpaceRadius,-HalfSpaceRadius};
Point(21) = {-HalfSpaceRadius,HalfSpaceRadius,-HalfSpaceRadius};
Point(22) = {-HalfSpaceRadius,0.0,-HalfSpaceRadius};

Line(1) = {1,2};
Line(2) = {2,7};
Line(3) = {7,8};
Line(4) = {8,1};
Line(5) = {2,3};
Line(6) = {3,6};
Line(7) = {6,7};
Line(8) = {3,4};
Line(9) = {4,5};
Line(10) = {5,6};
Line(11) = {4,9};
Circle(12) = {9,2,10};
Line(13) = {10,5};
Circle(14) = {10,2,11};
Line(15) = {11,6};
Circle(16) = {11,2,12};
Line(17) = {12,7};
Circle(18) = {12,2,13};
Line(19) = {13,8};
Circle(20) = {13,2,14};
Line(21) = {14,1};

Line(22) = {15,16};
Line(23) = {16,17};
Line(24) = {17,18};
Line(25) = {19,20};
Line(26) = {20,21};
Line(27) = {21,22};
Line(28) = {15,19};
Line(29) = {16,20};
Line(30) = {17,21};
Line(31) = {18,22};
Line(32) = {22,19};


Line Loop(1) = {1,2,3,4};
Line Loop(2) = {5,6,7,-2};
Line Loop(3) = {8,9,10,-6};
Line Loop(4) = {11,12,13,-9};
Line Loop(5) = {-13,14,15,-10};
Line Loop(6) = {-15,16,17,-7};
Line Loop(7) = {-17,18,19,-3};
Line Loop(8) = {-19,20,21,-4};
Line Loop(9) = {28,25,-29,-22};
Line Loop(10) = {29,26,-30,-23};
Line Loop(11) = {30,27,-31,-24};
Line Loop(12) = {-25,-32,-27,-26};

Plane Surface(1) = {1};
Plane Surface(2) = {2};
Plane Surface(3) = {3};
Plane Surface(4) = {4};
Plane Surface(5) = {5};
Plane Surface(6) = {6};
Plane Surface(7) = {7};
Plane Surface(8) = {8};
Plane Surface(9) = {9};
Plane Surface(10) = {10};
Plane Surface(11) = {11};
Plane Surface(12) = {12};

Physical Surface ("FreeSoilSurface",1) = {1:8};
Physical Surface ("HalfSpaceBound",2) = {9:12};

Transfinite Curve {4,2,6,9,12,20} = 7;
Transfinite Curve {1,3,18} = 4;
Transfinite Curve {5,7,16} = 3;
Transfinite Curve {8,10,14} = 2;
Transfinite Curve {22:32} = 2;

MinElementLength = 1.0; 
MaxElementLength = SoilSurfaceRadius*Pi/38.0/2.0*4.0;
LineLength = SoilSurfaceRadius - TrenchHeight/4.0;
Bump = (LineLength - MinElementLength)/(LineLength - MaxElementLength); 
NumOfNodes = Fabs(Round(Log(MinElementLength/MaxElementLength)/Log(Bump)));

Transfinite Curve {11,-13,-15,-17,-19,-21} = NumOfNodes Using Progression Bump;

// x1 = TrenchHeight/4.0;
// y1 = TrenchHeight/2.0;
// x2 = SoilSurfaceRadius*Cos1
// y2 = SoilSurfaceRadius*Sin1
// LineLength = Sqrt((x1-x2)*(x1-x2)+(y1-y2)*(y1-y2))
// Bump = (LineLength - MinElementLength)/(LineLength - MaxElementLength);
// Transfinite Curve {-13,-19} = NumOfNodes Using Progression Bump;

// x1 = TrenchHeight/4.0 -TrenchWidth;
// y1 = TrenchHeight/2.0;
// x2 = SoilSurfaceRadius*Cos1
// y2 = SoilSurfaceRadius*Sin1
// LineLength = Sqrt((x1-x2)*(x1-x2)+(y1-y2)*(y1-y2))
// Bump = (LineLength - MinElementLength)/(LineLength - MaxElementLength);
// Transfinite Curve {-15} = NumOfNodes Using Progression Bump;

// LineLength = SoilSurfaceRadius - TrenchHeight/2.0;
// Bump = (LineLength - MinElementLength)/(LineLength - MaxElementLength); 
// Transfinite Curve {-17} = NumOfNodes Using Progression Bump;

Transfinite Surface {:};
Mesh 2;
Recombine Surface {:};
Mesh 2;

Mesh.SaveElementTagType = 2;
