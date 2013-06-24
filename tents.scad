// tents.scad
// OpenSCAD Template
// 
// Copyright (C) 2013 Christopher Roberts
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
// 
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
// 
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.


// Global Parameters
height = 2; // Height of tent pole
length = 4; // Length of tent
layer  = 0.3; // Layer height

module tent_shape( l, h) {

    difference() {

        // Things that exist
        union() {
            translate( v = [ 0, 0, -height ] ) {
                rotate( a = [ 45, 0, 0 ] ) {
                    cube( size = [l, sqrt(0.5 * pow(h*2,2)), sqrt(0.5 * pow(h*2,2)) ] );
                }
            }
        }

        // Things to be cut out
        union() {
            translate( v = [ -0.1, -h, -h] ) {
                cube( size = [ length + 0.2, 2* height, height ] );
            }
        }
    }

}

module tent() {

    difference() {

        // Things that exist
        union() {
            tent_shape(length, height);
        }

        // Things that don't exist
        union() {
            translate( v = [ -0.1, 0, -sqrt( 0.5 * pow(layer,2)) ] ) {
                tent_shape(length -layer, height);
            }
        }
    
    }

}

module tent_complete() {

    difference() {

        // Things that exist
        union() {
            tent();
            cylinder( r = layer/2, h = height );
            translate( v = [ length, 0, 0 ] ) {
                cylinder( r = layer/2, h = height );
            }
            translate( v = [0, -height +layer, 0] ) {
                cube( size = [length, 2 * (height - layer), layer ] );
            }
            translate( v = [0, -height + layer/2, 0] ) {
                cube( size = [length, 2 * height - layer, layer/2 ] );
            }

        }

        // Things that don't exist
        union() {

        }
    
    }

}

tent_complete();

// -------------------------------------------------------------------------------------------
// Commands
// -------------------------------------------------------------------------------------------

// http://en.wikibooks.org/wiki/OpenSCAD_User_Manual

// primitives
// cube(size = [1,2,3], center = true);
// sphere( r = 10, $fn=100 );
// circle( r = 10 );
// cylinder( h = 10, r = 20, $fs = 6, center = true );
// cylinder( h = 10, r1 = 10, r2 = 20, $fs = 6, center = false );
// polyhedron(points = [ [x, y, z], ... ], triangles = [ [p1, p2, p3..], ... ], convexity = N);
// polygon(points = [ [x, y], ... ], paths = [ [p1, p2, p3..], ... ], convexity = N);

// transormations
// scale(v = [x, y, z]) { ... }
// rotate(a=[0,180,0]) { ... }
// translate(v = [x, y, z]) { ... }
// mirror([ 0, 1, 0 ]) { ... }

// rounded box by combining a cube and single cylinder
// $fn=50;
// minkowski() {
//   cube([10,10,1]);
//   cylinder(r=2,h=1);
// }

// hull() {
//   translate([15,10,0]) circle(10);
//   circle(10);
// }

// linear_extrude(height=1, convexity = 1) import("tridentlogo.dxf");
// deprecated - dxf_linear_extrude(file="tridentlogo.dxf", height = 1, center = false, convexity = 10);
// deprecated - import_dxf(file="design.dxf", layer="layername", origin = [100,100], scale = 0.5);
// linear_extrude(height = 10, center = true, convexity = 10, twist = 0, $fn = 100)
// rotate_extrude(convexity = 10, $fn = 100)
// import_stl("example012.stl", convexity = 5);

// for (z = [-1, 1] ) { ... } // two iterations, z = -1, z = 1
// for (z = [ 0 : 5 ] ) { ... } // range of interations step 1
// for (z = [ 0 : 2 : 5 ] ) { ... } // range of interations step 2

// for (i = [ [ 0, 0, 0 ], [...] ] ) { ... } // range of rotations or vectors
// usage say rotate($i) or translate($i)
// if ( x > y ) { ... } else { ... }
// assign (angle = i*360/20, distance = i*10, r = i*2)

// text http://www.thingiverse.com/thing:25036
// inkscape / select all items
// objects to path
// select the object to export
// extensions / generate from path / paths to openscad

