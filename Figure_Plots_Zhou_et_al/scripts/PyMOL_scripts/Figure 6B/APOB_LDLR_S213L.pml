# Select the residue of interest
select residue_of_interest, chain R and resi 213

# Color chain A white
color white, chain A

# Color chain R light pink
color lightpink, chain R

# Color the residue of interest purple
color purple, residue_of_interest

# Show cartoon for everything and sticks for the residue
show cartoon
show sticks, residue_of_interest

# Set transparency for the whole object
set transparency, 0.5, chain R

# Center and zoom on the residue
zoom residue_of_interest, buffer=5

# Set background color
bg_color white

# Ray trace and save
ray 1200, 900

# Residue 3386
show sticks, chain A and resi 3386
set label_size, 20
#label chain A and resi 3386 and name CA, resi

# Residue 3394
show sticks, chain A and resi 3394
set label_size, 20
#label chain A and resi 3394 and name CA, resi

# Residue 3395
show sticks, chain A and resi 3395
set label_size, 20
#label chain A and resi 3395 and name CA, resi

# Residue 3396
show sticks, chain A and resi 3396
set label_size, 20
#label chain A and resi 3396 and name CA, resi

# Residue 3412
show sticks, chain A and resi 3412
set label_size, 20
#label chain A and resi 3412 and name CA, resi

# Residue 3413
show sticks, chain A and resi 3413
set label_size, 20
#label chain A and resi 3413 and name CA, resi

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

set dash_radius, 0.1, undefined-vdw
set dash_radius, 0.1, hbond-vdw
set dash_radius, 0.1, polar-vdw
set dash_radius, 0.1, weakpolar-vdw
set dash_radius, 0.1, ionic-vdw
set dash_radius, 0.1, hbond-proximal
set dash_radius, 0.1, polar-proximal
set dash_radius, 0.1, ionic-proximal
set dash_radius, 0.1, weakpolar-vdwclash
set dash_radius, 0.1, weakpolar-proximal
set dash_radius, 0.1, weakhbond-vdw
set dash_radius, 0.1, weakhbond-proximal
set dash_radius, 0.1, hydrophobic-proximal
set dash_radius, 0.1, ring_centers
set dash_radius, 0.1, CARBONPI
set dash_radius, 0.1, CATIONPI
set dash_radius, 0.1, DONORPI

# --- palette (matches your legend) ---
# (PyMOL already has forest/orange/blue/red/cyan/purple/yellow)

# --- hide the categories you said to remove ---
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

# select all calcium ions (element CA, not alpha carbons)
select ca_ions, elem CA

# make sure they’re spheres (not tiny nonbonded dots)
hide nonbonded, ca_ions
show spheres, ca_ions

# set their display scale to exactly 1.0000 (so display radius = vdw)
set sphere_scale, 1.0000, ca_ions

color green, elem Ca
color red, elem O
color blue, elem N

set_view (\
     0.304332227,   -0.640832424,   -0.704781353,\
    -0.427533001,    0.569275081,   -0.702232778,\
     0.851234496,    0.515024841,   -0.100724883,\
     0.003340327,   -0.001288880,  -39.289134979,\
   351.172180176,  232.427993774,  212.752090454,\
    28.415887833,   50.229724884,  -20.000000000 )

set bg_rgb, white
set ray_trace_mode, 1
ray 1500
