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
height = 4; // Height of tent pole
length = 8; // Length of tent
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
            translate( v = [ -0.1, 0, -layer ] ) {
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
