color lightpink, chain R

select ldlr_roi, chain R and resi 213+219+223

# color them
color purple, ldlr_roi
show sticks, ldlr_roi
show spheres, ldlr_roi

set dash_gap, 0, undefined-vdw
set dash_gap, 0, hbond-vdw
set dash_gap, 0, polar-vdw
set dash_gap, 0, weakpolar-vdw
set dash_gap, 0, ionic-vdw
set dash_gap, 0, hbond-proximal
set dash_gap, 0, polar-proximal
set dash_gap, 0, ionic-proximal
set dash_gap, 0, weakpolar-proximal
set dash_gap, 0, weakhbond-vdw
set dash_gap, 0, weakhbond-proximal
set dash_gap, 0, hydrophobic-proximal
set dash_gap, 0, ring_centers
set dash_gap, 0, CARBONPI
set dash_gap, 0, CATIONPI
set dash_gap, 0, DONORPI
set dash_gap, 0, ring-ET
set dash_gap, 0, ring-OT
set dash_gap, 0, ring-FT

set dash_radius, 0.05, undefined-vdw
set dash_radius, 0.05, hbond-vdw
set dash_radius, 0.05, polar-vdw
set dash_radius, 0.05, weakpolar-vdw
set dash_radius, 0.05, ionic-vdw
set dash_radius, 0.05, hbond-proximal
set dash_radius, 0.05, polar-proximal
set dash_radius, 0.05, ionic-proximal
set dash_radius, 0.05, weakpolar-vdwclash
set dash_radius, 0.05, weakpolar-proximal
set dash_radius, 0.05, weakhbond-vdw
set dash_radius, 0.05, weakhbond-proximal
set dash_radius, 0.05, hydrophobic-proximal
set dash_radius, 0.05, ring_centers
set dash_radius, 0.05, CARBONPI
set dash_radius, 0.05, CATIONPI
set dash_radius, 0.05, DONORPI
set dash_radius, 0.05, ring-ET
set dash_radius, 0.05, ring-OT
set dash_radius, 0.05, ring-FT

# --- palette (matches your legend) ---

# --- hide categories
disable polar-proximal*
disable weakpolar-proximal*
disable hbond-proximal*
disable weakhbond-proximal*
disable ionic-proximal*
disable ring_centers*

# --- Hydrophobic (forest) —
set dash_color, forest, hydrophobic-proximal

# --- Polar (orange) ---
set dash_color, orange, polar-vdw
set dash_color, orange, polar-vdwclash
set dash_color, orange, weakpolar-vdw
set dash_color, orange, weakpolar-vdwclash

# --- H-bonds (red) ---
set dash_color, red, hbond-vdw
set dash_color, red, hbond-vdwclash
set dash_color, red, weakhbond-vdw
set dash_color, red, weakhbond-vdwclash

# --- Ionic (yellow) ---
set dash_color, yellow, ionic-vdw
set dash_color, yellow, ionic-vdwclash

# --- Undefined (cyan) ---
set dash_color, cyan, undefined-vdw
set dash_color, cyan, undefined-vdwclash

# --- Aromatic / π interactions (pale green) ---
set dash_color, palegreen, CARBONPI
set dash_color, palegreen, CATIONPI
set dash_color, palegreen, DONORPI
set dash_color, palegreen, ring-OF

# --- Optional: Carbonyl (blue) — only if such objects exist in your session
# color blue, obj carbonyl*

# --- Optional: Coordinate covalent (purple) — only if present (e.g., metal coordination)
# color purple, obj coordinate*
# color purple, elem ZN and not name NZ+NE+ND1+ND2  # (example for metals if you created objects)

set dash_as_cylinders, on 
set dash_width, 1.0        
set dash_radius, 0.03      

color green, elem Ca
color red, elem O
color blue, elem N

# select all calcium ions (element CA, not alpha carbons)
select ca_ions, elem CA

# make sure they’re spheres (not tiny nonbonded dots)
hide nonbonded, ca_ions
show spheres, ca_ions

# set their display scale to exactly 1.0000 (so display radius = vdw)
set sphere_scale, 1.0000, ca_ions

set_view (\
     0.594052017,    0.568623722,    0.569005191,\
    -0.118867084,   -0.637520432,    0.761199832,\
     0.795590043,   -0.519827425,   -0.311132252,\
    -0.002365442,    0.003163364,  -71.630058289,\
   354.617004395,  233.186508179,  209.521545410,\
    34.483932495,  108.901977539,  -20.000000000 )

set bg_rgb, white
set ray_trace_mode, 1
ray 1500
