// Copyright 2013 Jonathan Hulka
// This program is free software; you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation; either version 2 of the License, or
// (at your option) any later version.
// 
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
// 
// You should have received a copy of the GNU General Public License
// along with this program; if not, write to the Free Software
// Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
// MA 02110-1301, USA.
phi=(1+sqrt(5))/2;
edge_length=2/phi*15;
//radius=edge_length;
radius=7.5;
//Points of the cube
for(i=[-15,15],j=[-15,15],k=[-15,15])
	translate([i,j,k])sphere(r=radius,center=true);
//And the rest
for(i=[-1/phi*15,1/phi*15],j=[-phi*15,phi*15])
{
	translate([0,i,j])sphere(r=radius,center=true);
	translate([i,j,0])sphere(r=radius,center=true);
	translate([j,0,i])sphere(r=radius,center=true);
}	
