module screw(type = 2, r1 = 5, r2 = 7, n = 1, h = 100, t = 16)
{
	linear_extrude(height = h, twist = 360*t/n, convexity = t)
	difference() {
		circle(r2);
		for (i = [0:n-1]) {
			if (type == 1) rotate(i*360/n) polygon([
					[ 2*r2, 0 ],
					[ r2, 0 ],
					[ r1*cos(180/n), r1*sin(180/n) ],
					[ r2*cos(360/n), r2*sin(360/n) ],
					[ 2*r2*cos(360/n), 2*r2*sin(360/n) ],
			]);
			if (type == 2)
			{
				difference()
				{
					circle(r=r2+1,center=true);
					translate([(r2-r1)/2,0])circle(r=(r2+r1)/2,center=true);
				}
			}
		}
	}
}

module gear(h=5,r=25,teeth=30,depth=2.5)
{
	tooth_width=3.14*(r-depth/2)*2/teeth;
	pi=3.14;
	r_inner=r-depth/2;
	r_outer=r+depth/2;
	difference()
	{
		cylinder(r=r+depth/2-depth/10,h=h,center=true);
		for(i=[0:teeth])
		{
			rotate([0,0,i*360/teeth])linear_extrude(height=h+1,center=true)
				polygon([
					[-tooth_width*5/8,r_inner],
					[-tooth_width*3/8,r_inner],
					[-tooth_width*7/64,r_outer],
					[tooth_width*7/64,r_outer],
					[tooth_width*3/8,r_inner],
					[tooth_width*5/8,r_inner],
					[tooth_width*5/8,r_outer+1],
					[-tooth_width*5/8,r_outer+1]
				]);
		}
	}
}

module y_axis()
{
	translate([0,50,0])rotate([90,0,0])
	{
		for(i=[-1:1])translate([i*25,0,0])rotate([0,0,3])gear(r=12.5);
		for(i=[-1,1])translate([i*25,0,50])cylinder(r=3,h=100,center=true);
	}
}

translate([0,0,75])
{
	rotate([0,0,6])gear(r=12.5);
	for(i=[0:2])
	{
		rotate([0,0,i*360/3])translate([0,25,0])
		{
			gear(r=12.5);
			cylinder(r=3,h=100,center=true);
		}
	}
}
y_axis();
translate([0,0,10])rotate([0,0,90])y_axis();