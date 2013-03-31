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

module gothic_arch(width,depth)
{
	radius=width*5/4;
	intersection()
	{
		translate([radius-width/2,0,0])cylinder(h=depth,r=radius,center=true);
		translate([width/2-radius,0,0])cylinder(h=depth,r=radius,center=true);
		translate([0,-width/2-1,0])cube(size=[width+1,width+2,depth+1],center=true);
	}
}
module round_arch(width,depth)
{
	intersection()
	{
		cylinder(h=depth,r=width/2,center=true);
		translate([0,-width/2-1,0])cube(size=[width+1,width+2,depth+1],center=true);
	}
}

rotate([0,30,0])difference()
{
	union()
	{
		rotate([0,90,0])gothic_arch(400,420);
		gothic_arch(400,420);
	}
	union()
	{
		rotate([0,90,0])round_arch(380,430);
		round_arch(380,430);
	}
	intersection()
	{
		union()
		{
			rotate([0,90,0])gothic_arch(380,430);
			gothic_arch(380,420);
		}
		translate([0,-415,0])cube(size=430,center=true);
	}
}
