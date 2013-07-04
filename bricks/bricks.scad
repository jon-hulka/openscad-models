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
peg_allowance=0.4; //Extra space for pegs in bottom of a brick of height 1
brick_height=3.2; //This is the flat brick
peg_diagonal_space=peg_space*sqrt(2);
//rod_radius=2;
$fn=20;
//left edge: x=0;
//top edge: y=0;
//peg bottom: z=0;
//The platform sits below the z axis
module brick_top(pegs_x,pegs_y)
{
//	difference()
//	{
		union()
		{
			//Pegs extend 0.2mm down into the platform to ensure connection
			for(i=[0:pegs_x-1], j=[0:pegs_y-1])
				translate([(0.5 + i)*peg_space, (0.5 + j)*peg_space,peg_height/2-0.1])
					cylinder(h=peg_height+0.2,r=peg_radius,center=true);
			//The platform sits just under the z-axis
			translate([pegs_x*peg_space/2,pegs_y*peg_space/2,-(brick_height-peg_height-peg_allowance)/2])
				cube(size=[pegs_x*peg_space,pegs_y*peg_space,brick_height-peg_height-peg_allowance],center=true);
		}
//		for(i=[0:pegs_x-1], j=[0:pegs_y-1])
//			translate([(0.5 + i)*peg_space, (0.5 + j)*peg_space,0])
//				cylinder(h=10,r=rod_radius,center=true);
//	}
}

module brick_bottom_cylinders(pegs_x,pegs_y,height,filled=false)
{
	intersection()
	{
		for(i=[0:pegs_x], j=[0:pegs_y])
		{
			translate([i*peg_space,j*peg_space,height/2])
			
			if(filled)
			{
				cylinder(h=height,r=(peg_diagonal_space-peg_radius*2)/2,center=true);
			}
			else
			{
				difference()
				{
					cylinder(h=height,r=(peg_diagonal_space-peg_radius*2)/2,center=true);
					cylinder(h=height+1,r=peg_radius,center=true);
				}
			}
		}
		translate([pegs_x/2*peg_space,pegs_y/2*peg_space,height/2])
		cube(size=[pegs_x*peg_space,pegs_y*peg_space,height+1],center=true);
	}	
}

module brick_bottom_edges(pegs_x,pegs_y,height)
{
	translate([peg_space*pegs_x/2,peg_space*pegs_y/2,height/2]) difference()
	{
		cube(size=[peg_space*pegs_x,peg_space*pegs_y,height],center=true);
		cube(size=[peg_space*(pegs_x-1)+peg_radius*2,peg_space*(pegs_y-1)+peg_radius*2,height+1],center=true);
	}
}

module simple_brick(pegs_x,pegs_y,bricks_z)
{
	union()
	{
		translate([-peg_space*pegs_x/2,-peg_space*pegs_y/2,0])
		{
			brick_bottom_cylinders(pegs_x,pegs_y,brick_height*bricks_z);
			brick_bottom_edges(pegs_x,pegs_y,brick_height*bricks_z);
		}
		translate([-peg_space*pegs_x/2,-peg_space*pegs_y/2,brick_height*bricks_z]) brick_top(pegs_x,pegs_y);
	}
}
