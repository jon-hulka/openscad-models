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
//brick_top(pegs_x=2,pegs_y=6);
//brick_bottom(pegs_x=4,pegs_y=3);
demo(1);


module demo(n)
{
	if(n==1)
	{
//Demo 1 - a boring brick
		simple_brick(2,2,1);
	}
	else if(n==2)
	{
//Demo 2 - cookie cutter
		intersection()
		{
			simple_brick(3,3,3);
			cylinder(h=brick_height*7,r=peg_space*1.5,center=true);
		}
	}
	else if(n==2.5)
	{
//Demo 2.5 - smaller cookie cutter
		intersection()
		{
			simple_brick(2,2,3);
			cylinder(h=brick_height*7,r=peg_space,center=true);
		}
	}
	else if(n==3)
	{
//Demo 3 - cookie cutter dressed up
		intersection()
		{
			union()
			{
				simple_brick(3,3,3);
				difference()
				{
					translate([0,0,brick_height*1.5])
						cylinder(h=brick_height*3,r=peg_space*1.5,center=true);
					translate([0,0,brick_height-1])
						cylinder(h=brick_height*2,r=peg_space*1+peg_radius,center=true);
					translate([0,0,-brick_height*3])simple_brick(3,3,3);
				}
			}
			cylinder(h=brick_height*7,r=peg_space*1.5,center=true);
		}
	}
	else if(n==3.5)
	{
//Demo 3.5 - smaller cookie cutter dressed up
		intersection()
		{
			union()
			{
				simple_brick(2,2,3);
				difference()
				{
					translate([0,0,brick_height*1.5])
						cylinder(h=brick_height*3,r=peg_space,center=true);
#					translate([0,0,brick_height-1])
						cylinder(h=brick_height*2,r=peg_space*0.5+peg_radius,center=true);
#					translate([0,0,-brick_height*3])simple_brick(2,2,3);
				}
			}
			cylinder(h=brick_height*7,r=peg_space,center=true);
		}
	}
	else if(n==4)
	{
//Demo 4 - with a twist
		translate(30,30,0)union()
		{
			intersection()
			{
				union()
				{
			rotate(a=30)translate([-peg_space,-peg_space*2,brick_height*3]) brick_top(pegs_x=2,pegs_y=4);
					translate([-peg_space,-peg_space*2,0])
					{
						brick_bottom_cylinders(pegs_x=2,pegs_y=4,height=peg_height*2);
						brick_bottom_edges(pegs_x=2,pegs_y=4,height=peg_height*2);
					}
					translate([0,0,(brick_height*3+peg_allowance+peg_height)/2])
					cylinder(h=brick_height*3-peg_allowance-peg_height,r=sqrt(peg_space*peg_space*5),center=true);
				}
				union()
				{
					translate([0,0,peg_height/2-0.5+brick_height*3])
						cylinder(h=peg_height+1,r=sqrt(peg_space*peg_space*5),center=true);
					translate([0,0,brick_height*3/2])
						linear_extrude(height=brick_height*3,twist=-30,slices=75,center=true)
						polygon([
							[-peg_space,-2*peg_space],
							[-peg_space,2*peg_space],
							[peg_space,2*peg_space],
							[peg_space,-2*peg_space]]);
				}
			}
		}
	}
//Demo 5 - two sided
	else if(n==5)
	{
		union()
		{
			translate([-peg_space,-peg_space*2,0])
			union()
			{
				mirror([0,0,-1])brick_top(pegs_x=2,pegs_y=4);
				translate([0,0,brick_height*3]) brick_top(pegs_x=2,pegs_y=4);
			}
			translate([0,0,brick_height*3/2])cube(size=[peg_space*2,peg_space*4,brick_height*3],center=true);
		}
	}
}
