/* [Cap features] */
cap_diameter     = 26;  // [26:normal, 29:large]
fragments_number  = 21;

/* [Magnet features] */
magnet_diameter   =  15.85;
magnet_height     =  3.05;

/* [Piece specs] */
cap_top_diameter = 18;
cap_height       =  7;
diaphragm_thickness= 0.3;
material_thickness = 0.6;
snap_height       =  2;
tolerance         =  0.3;

tol = tolerance;
c_D = cap_diameter;
c_d = ((cap_top_diameter) > (magnet_diameter))
    ? cap_top_diameter
	 : magnet_diameter;
c_h = cap_height;
d_t = diaphragm_thickness;
m_d = magnet_diameter;
m_h = magnet_height;
m_t = material_thickness;
s_h = snap_height;

$fn=fragments_number;

module snap_profile ()
{
  polygon([
	 [0, -m_t],
	 [c_D/2-tol, -m_t],
	 [c_D/2, s_h+tol],
	 [c_D/2+2*tol, s_h+tol+m_t/2],
	 [c_D/2+tol, s_h+2*tol+m_t],
	 [c_D/2-m_t, s_h+2*tol+m_t],
	 [c_D/2-m_t-tol, 0],
	 [m_d/2+tol+m_t, 0],
	 [m_d/2+tol+m_t, c_h-tol],
	 [m_d/2+tol, c_h-tol],
	 [m_d/2, -m_t+m_h+tol],
	 [m_d/2+tol, -m_t+m_h],
	 [m_d/2+tol, -m_t+d_t],
	 [0, -m_t+d_t]
  ]);
}

difference ()
{
  rotate_extrude() snap_profile();
      for (r=[0,120,240])
	 rotate([0,0,r])
  translate([-c_D/2-2*tol,0-0.5,-m_t]) cube([2*m_t+1.5*tol,1,c_h]);
  for (r=[30,150,270])
	 rotate([0,0,r])
		translate([-1,0,0])
		  cube([2,m_d/2+m_t+tol,c_h]);
}

/* Old design */

module encasing_profile ()
{
  polygon([
	 [m_d/2+tol, 0],
	 [c_D/2-tol/2, 0],
	 [c_D/2-0.5, 1],
	 [c_d/2, 1],
	 [c_d/2-tol,c_h],
	 [c_d/2-1,c_h],
	 [c_d/2-1,1],
	 [m_d/2+tol,1]
  ]);
}

module support_profile ()
{
  polygon([
	 [2, m_h],
	 [m_d/2-1, m_h],
	 [c_d/2-1-tol, m_h],
	 [c_d/2-1-tol, m_h+1],
	 [m_d/2, m_h+1],
	 [m_d/2, c_h],
	 [m_d/2-1,c_h],
	 [m_d/2-1, m_h+1],
	 [2, m_h+1]
  ]);
}

*rotate_extrude() encasing_profile();
*rotate_extrude() support_profile();

