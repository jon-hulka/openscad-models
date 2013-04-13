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
module metatron_lines(from_x,from_y,from_z)
{
	for(i=[-15,15])
	{
		if(from_x!=i || from_y !=0 || from_z != 0) hull()
		{
			translate([i,0,0])sphere(r=0.25,center=true);
			translate([from_x,from_y,from_z])sphere(r=0.25,center=true);
		}
		if(from_x!=0 || from_y !=i || from_z != 0) hull()
		{
			translate([0,i,0])sphere(r=0.25,center=true);
			translate([from_x,from_y,from_z])sphere(r=0.25,center=true);
		}
		if(from_x!=0 || from_y !=0 || from_z != i) hull()
		{
			translate([0,0,i])sphere(r=0.25,center=true);
			translate([from_x,from_y,from_z])sphere(r=0.25,center=true);
		}
		for(j=[-15,15],k=[-15,15])
		{
			if(from_x!=i || from_y!=j || from_z!=k)hull()
			{
				translate([i,j,k])sphere(r=0.25,center=true);
				translate([from_x,from_y,from_z])sphere(r=0.25,center=true);
			}
		}
	}
}
module metatron_cube(from_x=0,from_y=0,from_z=0)
{
	for(i=[-15,15])
	{
		translate([i,0,0])sphere(r=2,center=true);
		translate([0,i,0])sphere(r=2,center=true);
		translate([0,0,i])sphere(r=2,center=true);
		metatron_lines(0,0,i);
		metatron_lines(0,i,0);
		metatron_lines(i,0,0);
		for(j=[-15,15],k=[-15,15])
		{
			translate([i,j,k])sphere(r=2,center=true);
			metatron_lines(i,j,k);
		}
	}
}

metatron_cube();
