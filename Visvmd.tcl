# VMD visualization for Dodecahedron model particels 
# FM 2021-12-23
#run it after loading a gsd file with "play Visvmd.tcl" or copy it to ~/.vmdrc to config the default seeting.

#The first two lines edit the vmd default color to the new colors.  
#color change rgb 1(vmd color number) .4 .6 .4  (rgb percent)
#color change rgb 1+32(vmd color number of transparent version of color 1) .4 .6 .4  (rgb percent)
#so it can be repeated for all visible particles with desired colors. 

#color change rgb 1 .4 .6 .4
#color change rgb 33 .4 .6 .4
after idle {
set j 0
animate goto end
mol delrep 0 0
mol addrep 0
	mol modselect 0 0 type M
 mol modstyle 0 0 VDW 1.000000 20.000000
 mol modcolor 0 0 ColorID 0
 mol modmaterial 0 0 Glossy
 mol addrep 0
	mol modselect 1 0 type C and within 2 of type P PS
 mol modstyle 1 0 VDW 1.000000 20.000000
 mol modcolor 1 0 ColorID 4
 mol modmaterial 1 0 Glossy
 mol selection {type C and within 2 of type P PS}
 mol addrep 0
	mol modselect 2 0 type A
 mol modstyle 2 0 VDW 1.000000 20.000000
 mol modcolor 2 0 ColorID 0
 mol modmaterial 2 0 Glossy
 mol addrep 0
	mol modselect 3 0 type B
 mol modstyle 3 0 VDW 1.000000 20.000000
 mol modcolor 3 0 ColorID 1
 mol modmaterial 3 0 Glossy
 mol addrep 0
	mol modselect 4 0 type T
 mol modstyle 4 0 VDW 1.000000 20.000000
 mol modcolor 4 0 ColorID 4
 mol modmaterial 4 0 Glossy
 mol addrep 0
	mol modselect 5 0 type X and within 1.2 of type T and within 2 of type P PS
 mol modstyle 5 0 VDW 1.000000 20.000000
 mol modcolor 5 0 ColorID 0
 mol modmaterial 5 0 Glossy
 mol selection {type X and within 1.2 of type T and within 2 of type P PS}
 mol addrep 0
	mol modselect 6 0 type P
 mol modstyle 6 0 VDW 1.000000 20.000000
 mol modcolor 6 0 ColorID 1
 mol modmaterial 6 0 Glossy
 mol addrep 0
	mol modselect 7 0 type PS
 mol modstyle 7 0 VDW 1.000000 20.000000
 mol modcolor 7 0 ColorID 1
 mol modmaterial 7 0 Glossy
 mol addrep 0
	mol modselect 8 0 type R and within 2 of type P PS
 mol modstyle 8 0 VDW 1.000000 20.000000
 mol modcolor 8 0 ColorID 4
 mol modmaterial 8 0 Glossy
 mol selection {type R and within 2 of type P PS}
 mol addrep 0
	mol modselect 9 0 type RA and within 2 of type P PS
 mol modstyle 9 0 VDW 1.000000 20.000000
 mol modcolor 9 0 ColorID 4
 mol modmaterial 9 0 Glossy
 mol selection {type RA and within 2 of type P PS}
 mol addrep 0
	mol modselect 10 0 type N
 mol modstyle 10 0 VDW 1.000000 20.000000
 mol modcolor 10 0 ColorID 3
 mol modmaterial 10 0 Glossy
 mol addrep 0
	mol modselect 11 0 type Q
 mol modstyle 11 0 VDW 1.000000 20.000000
 mol modcolor 11 0 ColorID 1
 mol modmaterial 11 0 Glossy
 mol addrep 0
	mol modselect 12 0 type X3
 mol modstyle 12 0 VDW 1.000000 20.000000
 mol modcolor 12 0 ColorID 3
 mol modmaterial 12 0 Glossy
 set sel0 [atomselect top "name M"] 
 $sel0 set radius 0
set sel1 [atomselect top "name C"] 
 $sel1 set radius 0.1
set sel2 [atomselect top "name A"] 
 $sel2 set radius 0
set sel3 [atomselect top "name B"] 
 $sel3 set radius 0
set sel4 [atomselect top "name T"] 
 $sel4 set radius 0
set sel5 [atomselect top "name X"] 
 $sel5 set radius 0.35
set sel6 [atomselect top "name P"] 
 $sel6 set radius .15
set sel7 [atomselect top "name PS"] 
 $sel7 set radius .15
set sel8 [atomselect top "name R"] 
 $sel8 set radius .1
set sel9 [atomselect top "name RA"] 
 $sel9 set radius .1
set sel10 [atomselect top "name N"] 
 $sel10 set radius 0
set sel11 [atomselect top "name Q"] 
 $sel11 set radius 0
set sel12 [atomselect top "name X3"] 
 $sel12 set radius 0
display projection Orthographic
 display depthcue off
 display resize 800 800
 color Display Background white
 menu main on
 animate goto end
 }
