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


peg_space=8;
peg_radius=2.5;
peg_height=2;
peg_allowance=0.75; //Extra space for pegs in 'bottoms'
brick_height=3.2; //This is the flat brick
$fn=20;
//left edge: x=0;
//top edge: y=0;
//peg bottom: z=0;
//The platform sits below the z axis and is 0.25mm thick
module brick_top(pegs_x,pegs_y)
{
	union()
	{
		//Pegs extend 0.2mm down into the platform
		for(i=[0:pegs_x-1], j=[0:pegs_y-1])
			translate([(0.5 + i)*peg_space, (0.5 + j)*peg_space,peg_height/2-0.1])
			cylinder(h=peg_height+0.2,r=peg_radius,center=true);
		//The platform sits just under the z-axis
		translate([pegs_x*peg_space/2,pegs_y*peg_space/2,-0.125])
			cube(size=[pegs_x*peg_space,pegs_y*peg_space,0.25],center=true);
	}
}

//left edge: x=0;
//top edge: y=0;
//bottom: z=0;
//There is an extra 1mm on top - holes extend 0.75mm into it to give extra space for pegs
module brick_bottom(pegs_x,pegs_y)
{
	difference()
	{
		//The piece is carved out of one cube
		translate([(pegs_x)*peg_space/2,(pegs_y)*peg_space/2,peg_height/2+0.5])
			cube(size=[(pegs_x)*peg_space,(pegs_y)*peg_space,peg_height+1],center=true);
		translate([0,0,(peg_height+peg_allowance)/2-0.125])union()
		{
			//Pegs - 'normal' position
			for(i=[0:pegs_x-1], j=[0:pegs_y-1])
				translate([(0.5 + i)*peg_space,(0.5 + j)*peg_space,0])
				cylinder(h=peg_height+peg_allowance+0.25,r=peg_radius,center=true);
			for(i=[0:pegs_x], j=[0:pegs_y])
				translate([i*peg_space, j*peg_space,0])
				cylinder(h=peg_height+peg_allowance+0.25,r=peg_radius,center=true);
			for(i=[0:pegs_x-1])
			{
				translate([(0.5+i)*peg_space,pegs_y*peg_space/2,0])
				cube(size=[peg_radius,pegs_y*peg_space,peg_height+1],center=true);
			}
			for(j=[0:pegs_y-1])
			{
				translate([pegs_x*peg_space/2,(0.5+j)*peg_space,0])
				cube(size=[pegs_x*peg_space,peg_radius,peg_height+1],center=true);
			}
		}
	}
}

module simple_brick(pegs_x,pegs_y,bricks_z)
{
	union()
	{
		translate([-peg_space*pegs_x/2,-peg_space*pegs_y/2,0])
			brick_bottom(pegs_x,pegs_y);
		translate([-peg_space*pegs_x/2,-peg_space*pegs_y/2,brick_height*bricks_z])
			brick_top(pegs_x,pegs_y);
		translate([0,0,(brick_height*bricks_z+peg_allowance+peg_height)/2])
			cube(size=[peg_space*pegs_x,peg_space*pegs_y,brick_height*bricks_z-peg_allowance-peg_height],center=true);
	}
}

//brick_top(pegs_x=2,pegs_y=6);
//brick_bottom(pegs_x=4,pegs_y=3);
demo(3.5);


module demo(n)
{
	if(n==1)
	{
//Demo 1 - a boring brick
		simple_brick(2,4,3);
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
					translate([0,0,brick_height/2])
						cylinder(h=brick_height,r=peg_space*1.5,center=true);
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
					translate([0,0,brick_height/2])
						cylinder(h=brick_height,r=peg_space,center=true);
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
			rotate(a=30)translate([-peg_space,-peg_space*2,brick_height*3]) brick_top(pegs_x=2,pegs_y=4);
			intersection()
			{
				union()
				{
			translate([-peg_space,-peg_space*2,0])brick_bottom(pegs_x=2,pegs_y=4);
			translate([0,0,(brick_height*3+peg_allowance+peg_height)/2])
				cylinder(h=brick_height*3-peg_allowance-peg_height,r=sqrt(peg_space*peg_space*5),center=true);
				}
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
