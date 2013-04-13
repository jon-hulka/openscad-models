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
	rotate([90,0,0])intersection()
	{
		translate([radius-width/2,0,0])cylinder(h=depth,r=radius,center=true);
		translate([width/2-radius,0,0])cylinder(h=depth,r=radius,center=true);
		translate([0,-width/2-1,0])cube(size=[width+1,width+2,depth+1],center=true);
	}
}
module round_arch(width,depth)
{
	rotate([90,0,0])intersection()
	{
		cylinder(h=depth,r=width/2,center=true);
		//This will be used to cut out of the larger piece, so it extends down 0.01mm
		translate([0,-width/2-0.99,0])cube(size=[width+1,width+2.01,depth+1],center=true);
	}
}

module solid_structure(width)
{
	difference()
	{
		union()
		{
			rotate([0,0,90])gothic_arch(width+20,width+40);
			gothic_arch(width+20,width+40);
		}
		union()
		{
			rotate([0,0,90])round_arch(width,width+50);
			round_arch(width,width+50);
		}
		intersection()
		{
			union()
			{
				rotate([0,0,90])gothic_arch(width,width+50);
				gothic_arch(width,width+50);
			}
			translate([0,0,-width-40])cube(size=width+60,center=true);
		}
	}
}

module beam(width,thickness)
{
	union()
	{
		difference()
		{
			gothic_arch(width+thickness*2,thickness);
			gothic_arch(width,thickness+1);
		}
		difference()
		{
			round_arch(width+thickness*2,thickness);
			round_arch(width,thickness+1);
		}
		intersection()
		{
			gothic_arch(width+thickness*2,thickness);
			translate([0,0,-width/2-thickness*3/2]) cube(size=[width,thickness,thickness],center=true);
		}
	}
}
module draw_beams()
{
w=400;
t=10;
union()
{
	for(i=[0:3])
	{
		rotate([0,0,90*i])
		{
			translate([0,w/2+t*3/2,0]) beam(w,t);
		}
	}
	for(i=[0:1])
	{
		rotate([0,0,45+90*i]) scale([sqrt(2),1,1]) beam(w,t);
		rotate([0,0,90*i]) translate([0,0,-w-t/2]) cube(size=[w+t*4,t,t],center=true);
	}
}
}
draw_beams();