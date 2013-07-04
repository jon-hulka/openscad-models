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
edge_length=15*(sqrt(5)-1)/2;
radius=edge_length;
//radius=5;
for(i=[-15,15],j=[-phi*15,phi*15])
{
	translate([0,i,j])sphere(r=radius,center=true);
	translate([i,j,0])sphere(r=radius,center=true);
	translate([j,0,i])sphere(r=radius,center=true);
}	
