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

include <bricks.scad>;

//Uncomment this for calibration
simple_brick(1,1,1);
//Uncomment for an exploded view of the arch
//arch_demo();
//Uncomment for a full set (8 bricks and a keystone)
//build_set();
//Uncomment for a single brick
//arch_brick();
//Uncomment for a single keystone
//keystone();

module arch_demo()
{
	union()
	{
		for(i=[0:3],j=[0,1]) rotate([0,i*20,j*180])translate([-peg_space*5,0,0])arch_brick();
		translate([0,0,peg_space])rotate([0,80,0])translate([-peg_space*4,0,0])keystone();
	}
	
}

module build_set()
{
	union() for(i=[-1:1],j=[-1:1])
	{
		if(i==0 && j==0)
		{
			keystone();
		}
		else translate([i*peg_space*3,j*peg_space*3,0])arch_brick();
	}
}

//To do: make this into a module to accept arch radius and brick size parameters
//Brick size for the arch is hardcoded at 2x2
//Arch inner radius is hardcoded to 3 peg spaces
module arch_brick()
{
	translate([peg_space*4,0,0])union()
	{
		difference(){shell_outer();shell_inner();}
		intersection()
		{
			shell_outer();
			arch_cylinders(filled=true);
		}
		rotate([0,20,0])translate([-peg_space*5,-peg_space,0])brick_top(2,2);
	}
}

module keystone()
{
	translate([peg_space*4,0,0])union()
	{
		difference(){shell_outer();shell_inner();}
		intersection()
		{
			shell_outer();
			arch_cylinders();
		}
	}
}

module shell_outer()
{
		hull()for(i=[0,1])rotate([0,i*20,0])translate([-peg_space*4,0,(peg_height+peg_allowance)*(0.5-i)])
			cube(size=[peg_space*2,peg_space*2,peg_height+peg_allowance],center=true);
}

module shell_inner()
{
		hull()for(i=[0,1])rotate([0,i*20,0])translate([-peg_space*4,0,(peg_height+peg_allowance)*(0.5-i)])
			cube(size=[peg_space+peg_radius*2,peg_space+peg_radius*2,peg_height+peg_allowance+1],center=true);
}

//filled: if true, the top half of the brick is filled (don't use for the keystone)
//- this ensures that there are no hollow spaces
//(since exporting to STL won't work if there are)
module arch_cylinders(filled=false)
{
	module arch_span(degrees)
	{
		rotate([0,degrees,0])translate([-peg_space*4,0,0])
			cube(size=[peg_space*2,peg_space*2,peg_height*peg_allowance],center=true);
	}
	//upright cylinders with a spanning piece at 10 degrees
	union()
	{
		arch_span(10);
		intersection()
		{
			translate([-peg_space*5,-peg_space,0]) brick_bottom_cylinders(2,2,100);
			hull()
			{
				arch_span(0);
				arch_span(10);
			}
		}
		intersection()
		{
			if(!filled) rotate([0,20,0])translate([-peg_space*5,-peg_space,-100]) brick_bottom_cylinders(2,2,100,filled);
			hull()
			{
				arch_span(10);
				arch_span(20);
			}
		}
	}
}
