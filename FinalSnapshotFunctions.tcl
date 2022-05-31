#load frames you want from i to i+length
proc loadframes {initial length} {
	display resize 800 800
	set dcdfile [glob ./sd*dcd]
	set ii [expr {$initial + $length }]
	mol addfile $dcdfile first $initial last $ii waitfor all
}

#change visualization state
#if not already loaded by vmdrc
proc  vstate {} {
	mol delrep 0 all
	
	mol selection {type P}
	mol addrep 0
	mol modselect 0 0 type P
	mol modstyle 0 0 VDW 1.000000 20.000000
	mol modcolor 0 0 ColorID 3
	mol modmaterial 3 0 Glossy


	mol selection {type TP X and within 1.2 of type TP}
	mol addrep 0
	mol modselect 1 0 type TP X and within 1.2 of type TP 
	mol modstyle 1 0 VDW 1.000000 20.000000
	mol modcolor 1 0 ColorID 0
	mol modmaterial 4 0 Glossy

	mol selection {type TH X and within 1.2 of type TH}
	mol addrep 0
	mol modselect 2 0 type TH X and within 1.2 of type TH 
	mol modstyle 2 0 VDW 1.000000 20.000000
	mol modcolor 2 0 ColorID 14
	mol modmaterial 2 0 Glossy
	
	mol selection {type F}
	mol addrep 0
	mol modselect 3 0 type F 
	mol modstyle 3 0 VDW 1.000000 20.000000
	mol modcolor 3 0 ColorID 1
	mol modmaterial 3 0 Glossy


	mol selection {type TP X and within 1.2 of type TP}
	mol addrep 0
	mol modselect 4 0 type TP X and within 1.2 of type TP 
	mol modstyle 4 0 VDW 1.000000 20.000000
	mol modcolor 4 0 ColorID 0
	mol modmaterial 4 0 Glossy

	mol selection {type TH X and within 1.2 of type TH}
	mol addrep 0
	mol modselect 5 0 type TH X and within 1.2 of type TH 
	mol modstyle 5 0 VDW 1.000000 20.000000
	mol modcolor 5 0 ColorID 14
	mol modmaterial 5 0 Glossy

	axes location off
	display depthcue off
	display resize 800 800
	display projection Orthographic
	color Display Background white
	set select1 [atomselect top all]
	$select1 set radius 0.5
	
}

#find CM F particles in frame j , Glob CM is twice 

proc FCM {j} {
	animate goto $j
	set selF [atomselect top "name F"]
	set CM [measure center $selF]
	set CM2 [vecscale 2 $CM]
	puts $CM
	puts $CM2	
}

#make it ready for taking snapshots with two capsids

proc CapsidCenetr2 { frame p xx yy zz xd yd zd D D2 args} {
	# go to the given frame
	set periodic [format %s $p]  
	animate goto $frame
	mol modselect 0 0 type F and ((x-$xx)^2+(y-$yy)^2+(z-$zz)^2>($D+5)^2 or (x-$xd)^2+(y-$yd)^2+(z-$zd)^2>($D+5)^2)  
	mol modstyle 0 0 VDW 1.000000 20.000000
	mol modcolor 0 0 ColorID 1
	mol modmaterial 0 0 Glass1
	mol modselect 1 0 type TP X and within 1.2 of type TP and ((x-$xx)^2+(y-$yy)^2+(z-$zz)^2>($D+5)^2 or (x-$xd)^2+(y-$yd)^2+(z-$zd)^2>($D+5)^2) 
	mol modstyle 1 0 VDW 1.000000 20.000000
	mol modcolor 1 0 ColorID 0
	mol modmaterial 1 0 Glossy
	mol modselect 2 0 type TH X and within 1.2 of type TH and ((x-$xx)^2+(y-$yy)^2+(z-$zz)^2>($D+5)^2 or (x-$xd)^2+(y-$yd)^2+(z-$zd)^2>($D+5)^2) 
	mol modstyle 2 0 VDW 1.000000 20.000000
	mol modcolor 2 0 ColorID 14
	mol modmaterial 2 0 Glossy
	mol modselect 3 0 type F and ((x-$xx)^2+(y-$yy)^2+(z-$zz)^2<$D^2 or (x-$xd)^2+(y-$yd)^2+(z-$zd)^2<($D2)^2)  
	mol modstyle 3 0 VDW 1.000000 20.000000
	mol modcolor 3 0 ColorID 1
	mol modmaterial 3 0 Glossy
	mol modselect 4 0 type TP X and within 1.2 of type TP and ((x-$xx)^2+(y-$yy)^2+(z-$zz)^2<$D^2 or (x-$xd)^2+(y-$yd)^2+(z-$zd)^2<($D2)^2) 
	mol modstyle 4 0 VDW 1.000000 20.000000
	mol modcolor 4 0 ColorID 2
	mol modmaterial 4 0 Glossy
	mol modselect 5 0 type TH X and within 1.2 of type TH and ((x-$xx)^2+(y-$yy)^2+(z-$zz)^2<$D^2 or (x-$xd)^2+(y-$yd)^2+(z-$zd)^2<($D2)^2) 
	mol modstyle 5 0 VDW 1.000000 20.000000
	mol modcolor 5 0 ColorID 2
	mol modmaterial 5 0 Glossy 
	
}
#only selecting by index
proc CapsidIndex { I D args} {
	for {set k 0} {$k < 6} {incr k} {
        	mol delrep 0 all
        }
	
	mol selection {type TP X and within 1.1 of type TP}
        mol addrep 0
	mol modselect 0 0 type TP X and within 1.1 of type TP and not within $D of index $I 
	mol modstyle 0 0 VDW 1.000000 20.000000
	mol modcolor 0 0 ColorID 0
	mol modmaterial 0 0 Glass1
	#mol showperiodic top 0 y

	mol selection {type TH X and within 1.2 of type TH}
        mol addrep 0
	mol modselect 1 0 type TH X and within 1.2 of type TH and not within $D of index $I 
	mol modstyle 1 0 VDW 1.000000 20.000000
	mol modcolor 1 0 ColorID 14
	mol modmaterial 1 0 Glass1
	#mol showperiodic top 0 y

	mol selection {type TP X and within 1.1 of type TP}
        mol addrep 0
	mol modselect 2 0 type TP X and within 1.1 of type TP and within $D of index $I 
	mol modstyle 2 0 VDW 1.000000 20.000000
	mol modcolor 2 0 ColorID 0
	mol modmaterial 2 0 Glossy

	mol selection {type TH X and within 1.2 of type TH}
        mol addrep 0
	mol modselect 3 0 type TH X and within 1.2 of type TH and within $D of index $I 
	mol modstyle 3 0 VDW 1.000000 20.000000
	mol modcolor 3 0 ColorID 14
	mol modmaterial 3 0 Glossy

	mol selection {type F}
	mol addrep 0
	mol modselect 4 0 type F and not within $D of index $I 
	mol modstyle 4 0 VDW 1.000000 20.000000
	mol modcolor 4 0 ColorID 1
	mol modmaterial 4 0 Glass1
	#mol showperiodic top 0 y
	mol selection {type F}
        mol addrep 0
	mol modselect 5 0 type F and within $D of index $I 
	mol modstyle 5 0 VDW 1.000000 20.000000
	mol modcolor 5 0 ColorID 1
	mol modmaterial 5 0 Glossy 
}
proc CapsidIndex2 { I J D args} {
	for {set k 0} {$k < 6} {incr k} {
        	mol delrep 0 all
        }
	
	mol selection {type TP X and within 1.1 of type TP}
        mol addrep 0
	mol modselect 0 0 type TP X and within 1.1 of type TP and not within $D of index $I $J
	mol modstyle 0 0 VDW 1.000000 20.000000
	mol modcolor 0 0 ColorID 0
	mol modmaterial 0 0 Glass1

	mol selection {type TH X and within 1.2 of type TH}
        mol addrep 0
	mol modselect 1 0 type TH X and within 1.2 of type TH and not within $D of index $I $J
	mol modstyle 1 0 VDW 1.000000 20.000000
	mol modcolor 1 0 ColorID 14
	mol modmaterial 1 0 Glass1

	mol selection {type TP X and within 1.1 of type TP}
        mol addrep 0
	mol modselect 2 0 type TP X and within 1.1 of type TP and within $D of index $I $J
	mol modstyle 2 0 VDW 1.000000 20.000000
	mol modcolor 2 0 ColorID 0
	mol modmaterial 2 0 Glossy

	
	mol selection {type TH X and within 1.2 of type TH}
        mol addrep 0
	mol modselect 3 0 type TH X and within 1.2 of type TH and within $D of index $I $J
	mol modstyle 3 0 VDW 1.000000 20.000000
	mol modcolor 3 0 ColorID 14
	mol modmaterial 3 0 Glossy
	
	mol selection {type F}
	mol addrep 0
	mol modselect 4 0 type F and not within $D of index $I $J
	mol modstyle 4 0 VDW 1.000000 20.000000
	mol modcolor 4 0 ColorID 1
	mol modmaterial 4 0 Glass1

	mol selection {type F}
        mol addrep 0
	mol modselect 5 0 type F and within $D of index $I  $J
	mol modstyle 5 0 VDW 1.000000 20.000000
	mol modcolor 5 0 ColorID 1
	mol modmaterial 5 0 Glossy 
}
proc CapsidIndex4 { I J K L D args} {
	for {set k 0} {$k < 6} {incr k} {
        	mol delrep 0 all
        }
	
	mol selection {type TP X and within 1.1 of type TP}
        mol addrep 0
	mol modselect 0 0 type TP X and within 1.1 of type TP and not within $D of index $I $J $K $L
	mol modstyle 0 0 VDW 1.000000 20.000000
	mol modcolor 0 0 ColorID 0
	mol modmaterial 0 0 Glass1
	mol showperiodic top 0 XYZ 
	

	mol selection {type TH X and within 1.2 of type TH}
        mol addrep 0
	mol modselect 1 0 type TH X and within 1.2 of type TH and not within $D of index $I $J $K $L
	mol modstyle 1 0 VDW 1.000000 20.000000
	mol modcolor 1 0 ColorID 14
	mol modmaterial 1 0 Glass1
	mol showperiodic top 1 XYZ 
	

	mol selection {type TP X and within 1.1 of type TP}
        mol addrep 0
	mol modselect 2 0 type TP X and within 1.1 of type TP and within $D of index $I $J $K $L
	mol modstyle 2 0 VDW 1.000000 20.000000
	mol modcolor 2 0 ColorID 0
	mol modmaterial 2 0 Glossy
	#mol showperiodic top 2 XYZ 
	

	mol selection {type TH X and within 1.2 of type TH}
        mol addrep 0
	mol modselect 3 0 type TH X and within 1.2 of type TH and within $D of index $I $J $K $L
	mol modstyle 3 0 VDW 1.000000 20.000000
	mol modcolor 3 0 ColorID 14
	mol modmaterial 3 0 Glossy
	#mol showperiodic top 3 XYZ  
	

	mol selection {type F}
	mol addrep 0
	mol modselect 4 0 type F and not within $D of index $I $J $K $L
	mol modstyle 4 0 VDW 1.000000 20.000000
	mol modcolor 4 0 ColorID 1
	mol modmaterial 4 0 Glass1
	mol showperiodic top 4 XYZ 
	

	mol selection {type F}
        mol addrep 0
	mol modselect 5 0 type F and within $D of index $I $J $K $L
	mol modstyle 5 0 VDW 1.000000 20.000000
	mol modcolor 5 0 ColorID 1
	mol modmaterial 5 0 Glossy
	#mol showperiodic top 5 XYZ 
	
}

proc CapsidIndex8 { I J K L I1 J1 K1 L1 D args} {
	for {set k 0} {$k < 6} {incr k} {
        	mol delrep 0 all
        }
	
	mol selection {type TP X and within 1.1 of type TP}
        mol addrep 0
	mol modselect 0 0 type TP X and within 1.1 of type TP and not within $D of index $I $J $K $L  $I1 $J1 $K1 $L1
	mol modstyle 0 0 VDW 1.000000 20.000000
	mol modcolor 0 0 ColorID 0
	mol modmaterial 0 0 Glass1
	mol showperiodic top 0 XYZ 
	

	mol selection {type TH X and within 1.2 of type TH}
        mol addrep 0
	mol modselect 1 0 type TH X and within 1.2 of type TH and not within $D of index $I $J $K $L  $I1 $J1 $K1 $L1
	mol modstyle 1 0 VDW 1.000000 20.000000
	mol modcolor 1 0 ColorID 14
	mol modmaterial 1 0 Glass1
	mol showperiodic top 1 XYZ 
	

	mol selection {type TP X and within 1.1 of type TP}
        mol addrep 0
	mol modselect 2 0 type TP X and within 1.1 of type TP and within $D of index $I $J $K $L $I1 $J1 $K1 $L1
	mol modstyle 2 0 VDW 1.000000 20.000000
	mol modcolor 2 0 ColorID 0
	mol modmaterial 2 0 Glossy
	mol showperiodic top 2 XYZ 
	

	mol selection {type TH X and within 1.2 of type TH}
        mol addrep 0
	mol modselect 3 0 type TH X and within 1.2 of type TH and within $D of index $I $J $K $L $I1 $J1 $K1 $L1
	mol modstyle 3 0 VDW 1.000000 20.000000
	mol modcolor 3 0 ColorID 14
	mol modmaterial 3 0 Glossy
	mol showperiodic top 3 XYZ  
	

	mol selection {type F}
	mol addrep 0
	mol modselect 4 0 type F and not within $D of index $I $J $K $L $I1 $J1 $K1 $L1
	mol modstyle 4 0 VDW 1.000000 20.000000
	mol modcolor 4 0 ColorID 1
	mol modmaterial 4 0 Glass1
	mol showperiodic top 4 XYZ 
	

	mol selection {type F}
        mol addrep 0
	mol modselect 5 0 type F and within $D of index $I $J $K $L $I1 $J1 $K1 $L1
	mol modstyle 5 0 VDW 1.000000 20.000000
	mol modcolor 5 0 ColorID 1
	mol modmaterial 5 0 Glossy
	mol showperiodic top 5 XYZ 
	
}

proc PolyIndex { I D args} {
    axes location off
	display depthcue off
	display resize 800 800
	display projection Orthographic
	color Display Background white
	for {set k 0} {$k < 6} {incr k} {
        	mol delrep 0 all
        }
	
	mol selection {type HT HX}
    mol addrep 0
	mol modselect 0 0 type HT HX and within $D of index $I 
	mol modstyle 0 0 VDW 1.000000 20.000000
	mol modcolor 0 0 ColorID 14
	mol modmaterial 0 0 Glossy
	#mol showperiodic top 0 y

	mol selection {type PT PX}
    mol addrep 0
	mol modselect 1 0 type PT PX and within $D of index $I 
	mol modstyle 1 0 VDW 1.000000 20.000000
	mol modcolor 1 0 ColorID 0
	mol modmaterial 1 0 Glossy
	#mol showperiodic top 0 y

	mol selection {type C}
        mol addrep 0
	mol modselect 2 0 type C and within $D of index $I 
	mol modstyle 2 0 VDW 1.000000 20.000000
	mol modcolor 2 0 ColorID 1
	mol modmaterial 2 0 Glossy

	mol selection {type PS}
        mol addrep 0
	mol modselect 3 0 type PS and within $D of index $I 
	mol modstyle 3 0 VDW 1.000000 20.000000
	mol modcolor 3 0 ColorID 4
	mol modmaterial 3 0 Glossy

	mol selection {type PN}
	mol addrep 0
	mol modselect 4 0 type PN and  within $D of index $I 
	mol modstyle 4 0 VDW 1.000000 20.000000
	mol modcolor 4 0 ColorID 11
	mol modmaterial 4 0 Glossy
	#mol showperiodic top 0 y
	mol selection {type PC}
    mol addrep 0
	mol modselect 5 0 type PC and within $D of index $I 
	mol modstyle 5 0 VDW 1.000000 20.000000
	mol modcolor 5 0 ColorID 7
	mol modmaterial 5 0 Glossy 
}
	
#only selecting 
proc CapsidCenter { xx yy zz D args} {
	for {set k 0} {$k < 3} {incr k} {
        	mol delrep 0 all
        }
	 
	mol selection {type F}
        mol addrep 0
	mol modselect 0 0 type F and (x-$xx)^2+(y-($yy))^2+(z-($zz))^2<($D)^2 
	mol modstyle 0 0 VDW 1.000000 20.000000
	mol modcolor 0 0 ColorID 6
	mol modmaterial 0 0 Glossy

	mol selection {type TP X and within 1.1 of type TP}
        mol addrep 0
	mol modselect 1 0 type TP X and within 1.1 of type TP and (x-$xx)^2+(y-($yy))^2+(z-($zz))^2<$D^2 
	mol modstyle 1 0 VDW 1.000000 20.000000
	mol modcolor 1 0 ColorID 0
	mol modmaterial 1 0 Glossy

	mol selection {type TH X and within 1.2 of type TH}
        mol addrep 0
	mol modselect 2 0 type TH X and within 1.2 of type TH and (x-$xx)^2+(y-($yy))^2+(z-($zz))^2<$D^2 
	mol modstyle 2 0 VDW 1.000000 20.000000
	mol modcolor 2 0 ColorID 3
	mol modmaterial 2 0 Glossy 
}



proc CapsidCenterTrans { xx yy zz D args} {
	for {set k 0} {$k < 6} {incr k} {
        	mol delrep 0 all
        }
	mol selection {type F}
        mol addrep 0
	mol modselect 0 0 type F and (x-$xx)^2+(y-$yy)^2+(z-($zz))^2>($D+4)^2 
	mol modstyle 0 0 VDW 1.000000 20.000000
	mol showperiodic top 0 Z
	#mol numperiodic top 0 1 
	mol modcolor 0 0 ColorID 6
	mol modmaterial 0 0 Glass1
	mol selection {type TP X and within 1.2 of type TP}
        mol addrep 0
	mol modselect 1 0 type TP X and within 1.2 of type TP and (x-$xx)^2+(y-$yy)^2+(z-($zz))^2>($D+2)^2 
	mol modstyle 1 0 VDW 1.000000 20.000000
	mol modcolor 1 0 ColorID 0
	mol showperiodic top 1 Z
	#mol numperiodic top 1 1 
	mol modmaterial 1 0 Glass1
	mol selection {type TH X and within 1.2 of type TH}
        mol addrep 0
	mol modselect 2 0 type TH X and within 1.1 of type TH and (x-$xx)^2+(y-$yy)^2+(z-($zz))^2>($D+2)^2 
	mol modstyle 2 0 VDW 1.000000 20.000000
	mol modcolor 2 0 ColorID 3
	mol showperiodic top 2 Z
	#mol numperiodic top 2 1
	mol modmaterial 2 0 Glass1
	mol selection {type F}
        mol addrep 0
	mol modselect 3 0 type F and (x-$xx)^2+(y-($yy))^2+(z-($zz))^2<($D)^2 
	mol modstyle 3 0 VDW 1.000000 20.000000
	mol modcolor 3 0 ColorID 1
	mol modmaterial 3 0 Glossy
	mol selection {type TP X and within 1.1 of type TP}
        mol addrep 0
	mol modselect 4 0 type TP X and within 1.1 of type TP and (x-$xx)^2+(y-($yy))^2+(z-($zz))^2<$D^2 
	mol modstyle 4 0 VDW 1.000000 20.000000
	mol modcolor 4 0 ColorID 0
	mol modmaterial 4 0 Glossy
	mol selection {type TH X and within 1.2 of type TH}
        mol addrep 0
	mol modselect 5 0 type TH X and within 1.2 of type TH and (x-$xx)^2+(y-($yy))^2+(z-($zz))^2<$D^2 
	mol modstyle 5 0 VDW 1.000000 20.000000
	mol modcolor 5 0 ColorID 14
	mol modmaterial 5 0 Glossy 
}







proc CapsidPolymerCenter { xx yy zz D args} {
	for {set k 0} {$k < 6} {incr k} {
        	mol delrep 0 all
        }
    set i 0 
    set j 0  
    
    #cargo
	mol selection {type C}
    mol addrep 0
	mol modselect $j 0 type C and (x-$xx)^2+(y-($yy))^2+(z-($zz))^2<($D)^2 
	mol modstyle $j 0 VDW 1.000000 20.000000
	mol modcolor $j 0 ColorID 1
	mol modmaterial $j 0 Glossy
    incr j
    
    mol selection {type C}
    mol addrep 0
	mol modselect $j 0 type C and (x-$xx)^2+(y-$yy)^2+(z-($zz))^2>($D+4)^2 
	mol modstyle $j 0 VDW 1.000000 20.000000
	mol modcolor $j 0 ColorID 1
	mol modmaterial $j 0 Glass1
	incr j
	
	#hexamer
	mol selection {type HT HX}
    mol addrep 0
	mol modselect $j 0 type HT HX and (x-$xx)^2+(y-($yy))^2+(z-($zz))^2<$D^2 
	mol modstyle $j 0 VDW 1.000000 20.000000
	mol modcolor $j 0 ColorID 14
	mol modmaterial $j 0 Glossy
	incr j
	
	mol selection {type HT HX}
    mol addrep 0
	mol modselect $j 0 type HT HX and (x-$xx)^2+(y-$yy)^2+(z-($zz))^2>($D+4)^2 
	mol modstyle $j 0 VDW 1.000000 20.000000
	mol modcolor $j 0 ColorID 14
	mol modmaterial $j 0 Glass1
	incr j
	
	#POLYMER PN
	mol selection {type PN}
	mol addrep $i
    mol modselect $j $i type PN and (x-$xx)^2+(y-($yy))^2+(z-($zz))^2<($D)^2
    mol modstyle $j $i VDW 1.000000 20.000000
    mol modcolor $j $i ColorID 7
    mol modmaterial $j $i Glossy
    incr j
    
    mol selection {type PN}
    mol addrep 0
	mol modselect $j 0 type PN and (x-$xx)^2+(y-$yy)^2+(z-($zz))^2>($D+4)^2 
	mol modstyle $j 0 VDW 1.000000 20.000000
	mol modcolor $j 0 ColorID 7
	mol modmaterial $j 0 Glass1
	incr j
    
    
    
    #POLYMER PC
	mol addrep $i
    mol modselect $j $i type PC and (x-$xx)^2+(y-($yy))^2+(z-($zz))^2<($D)^2
    mol modstyle $j $i VDW 1.000000 20.000000
    mol modcolor $j $i ColorID 11
    mol modmaterial $j $i Glossy
	incr j

	mol selection {type PC}
    mol addrep 0
	mol modselect $j 0 type PC and (x-$xx)^2+(y-$yy)^2+(z-($zz))^2>($D+4)^2 
	mol modstyle $j 0 VDW 1.000000 20.000000
	mol modcolor $j 0 ColorID 11
	mol modmaterial $j 0 Glass1
	incr j
	
    #POLYMER PS
    mol selection {type PS}
	mol addrep $i
	mol modselect $j $i type PS and (x-$xx)^2+(y-($yy))^2+(z-($zz))^2<($D)^2
	mol modstyle $j $i VDW 1.000000 20.000000
	mol modcolor $j $i ColorID 4
	mol modmaterial $j $i Glossy
	incr j
	
	mol selection {type PS}
    mol addrep 0
	mol modselect $j 0 type PS and (x-$xx)^2+(y-$yy)^2+(z-($zz))^2>($D+4)^2 
	mol modstyle $j 0 VDW 1.000000 20.000000
	mol modcolor $j 0 ColorID 4
	mol modmaterial $j 0 Glass1
	incr j
		 
}

#now scale and move
proc sn04 {xx yy zz args} {
	set select1 [atomselect top all]
	$select1 moveby [$xx $yy $zz]
 	#scale by 3.125
}

proc tachsnap {f} {
	set datfile1 onesnap.[format "%04d" $f].dat
	set tgafile1 onesnap.[format "%04d" $f].tga
	render Tachyon $datfile1 "/usr/local/lib/vmd/tachyon_LINUXAMD64" -trans_max_surfaces 1 $datfile1 -format TARGA -o $tgafile1
	exec rm $datfile1
}

proc sn6t {x n} {
	set f [ expr { $x + $n } ]
	set datfile1 onesnap.[format "%04d" $f].dat
	set tgafile1 onesnap.[format "%04d" $f].tga
	render Tachyon $datfile1 "/usr/local/lib/vmd/tachyon_LINUXAMD64" -trans_max_surfaces 1 $datfile1 -format TARGA -o $tgafile1
	exec rm $datfile1
	set datfile2 twosnap.[format "%04d" $f].dat
	set tgafile2 twosnap.[format "%04d" $f].tga
	render Tachyon $datfile2 "/usr/local/lib/vmd/tachyon_LINUXAMD64" -trans_max_surfaces 2 $datfile2 -format TARGA -o $tgafile2
	exec rm $datfile2
} 

proc onesnap {x n} {
	set f [ expr { $x + $n } ]
	set datfile1 onesnap.[format "%04d" $f].dat
	set tgafile1 onesnap.[format "%04d" $f].tga
	render Tachyon $datfile1 "/usr/local/lib/vmd/tachyon_LINUXAMD64" -trans_max_surfaces 1 $datfile1 -format TARGA -o $tgafile1
	exec rm $datfile1
}

proc onesnaps {x n} {
	set f [ expr { $x + $n } ]
	set datfile1 onesnap.[format "%04d" $f].dat
	set tgafile1 onesnap.[format "%04d" $f].tga
	render Tachyon $datfile1 "/usr/local/lib/vmd/tachyon_LINUXAMD64" -trans_max_surfaces 1 $datfile1 -format TARGA -o $tgafile1
	exec rm $datfile1
}

proc snaprotate {frame angle1 angle2 } {
	for {set k $angle1} {$k < $angle2} {incr k} {
        	set f [ expr { $frame + $k } ] 
		set datfile1 onesnap.[format "%04d" $f].dat
		set tgafile1 onesnap.[format "%04d" $f].tga
		render Tachyon $datfile1 "/usr/local/lib/vmd/tachyon_LINUXAMD64" -trans_max_surfaces 1 $datfile1 -format TARGA -o $tgafile1
		exec rm $datfile1
		#rotate_center {1 0 0} {-20 -20 20} 2 
		rotate y by 1
	}	
}


proc rotate_axis {vec center deg {index top}} {
    # get the current matrix
    lassign [molinfo $index get rotate_matrix] curr
    # the transformation matrix
    set r [trans axis $vec $deg]
    # get the new matrix
    set m [transmult $r $curr]
    # and apply it to the molecule
    molinfo $index set rotate_matrix "{ $m }"
}

proc rotate_center {vec  center deg } {
    # get the current matrix
    lassign [molinfo $index get rotate_matrix] curr
    # the transformation matrix
    set r [trans axis $vec $deg]
    # get the new matrix
    set m [transoffset $r $center ]
    # and apply it to the molecule
    set rotate_center "{ $m }"
}

proc snapcenter { XX YY ZZ D actual initial final args} {
	for { set i $initial } { $i<= $final } { incr i } {
		animate goto $i
		CapsidCenter $XX $YY $ZZ $D 
		onesnap $i $actual
	}
}

proc snapPolymercenter { XX YY ZZ D actual initial final args} {
	for { set i $initial } { $i<= $final } { incr i } {
		animate goto $i
		CapsidPolymerCenter $XX $YY $ZZ $D 
		onesnap $i $actual
	}
}
proc snapindex { II D actual initial final args} {
	for { set i $initial } { $i<= $final } { incr i } {
		animate goto $i
		CapsidIndex $II $D 
		onesnap $i $actual
	}
}

proc snapindex4 { II JJ KK LL D actual initial final args} {
	for { set i $initial } { $i<= $final } { incr i } {
		animate goto $i
		CapsidIndex4 $II $JJ $KK $LL $D 
		onesnap $i $actual
	}
}

proc snapindex8 { II JJ KK LL I1 J1 K1 L1 D actual initial final args} {
	for { set i $initial } { $i<= $final } { incr i } {
		animate goto $i
		CapsidIndex8 $II $JJ $KK $LL $I1 $J1 $K1 $L1 $D 
		onesnap $i $actual
	}
}

proc snaps {xx yy zz D frame actualframe length args} {
	#animate delete all
	#sn0 $actualframe $length
	set j [ expr { $frame + $length }]
	puts $j
	for { set i $frame } { $i< $j } { incr i } {
		animate goto $i
		sn5 $xx $yy $zz $D 
		sn6t $i $actualframe
	}
}

proc justsnaps {frame actualframe length args} {
	#animate delete all
	#sn0 $actualframe $length
	set j [ expr { $frame + $length }]
	puts $j
	for { set i $frame } { $i< $j } { incr i } {
		animate goto $i
		#sn5 $xx $yy $zz $D 
		onesnap $i $actualframe
	}
}
		
proc snaps2 {xx yy zz xd yd zd D D2 frame actualframe length args} {
	#animate delete all
	#sn0 $actualframe $length
	set j [ expr { $frame + $length }]
	puts $j
	for { set i $frame } { $i< $j } { incr i } {
		animate goto $i
		sn8 $xx $yy $zz $xd $yd $zd $D $D2 
		sn6t $i $actualframe
	}
}

proc snaps4 {xx yy zz xd yd zd xx1 yy1 zz1 xd1 yd1 zd1 D D2 D1 D21 frame actualframe length args} {
	#animate delete all
	#sn0 $actualframe $length
	set j [ expr { $frame + $length }]
	puts $j
	for { set i $frame } { $i< $j } { incr i } {
		animate goto $i
		sn9 $xx $yy $zz $xd $yd $zd $xx1 $yy1 $zz1 $xd1 $yd1 $zd1 $D $D2 $D1 $D21 
		sn6t $i $actualframe
	}
}


proc sn6 {f} {
	set filename snap.[format "%04d" $f].tga
        render snapshot $filename
}


proc sn7 { num1 num2 frame xx yy zz xd yd zd D D2 args} {
	for {set i $num1} {$i < $num2} {incr i} {
		# go to the given frame
		animate goto $i
		set j [expr { $i + $frame}]
		mol modselect 0 0 type F and ((x-$xx)^2+(y-$yy)^2+(z-$zz)^2>($D)^2 or (x-$xd)^2+(y-$yd)^2+(z-$zd)^2>($D)^2) 
		mol modstyle 0 0 VDW 1.000000 20.000000
		mol modcolor 0 0 ColorID 1
		mol modmaterial 0 0 Glass1
		mol modselect 1 0 type TP X and within 1.2 of type TP and ((x-$xx)^2+(y-$yy)^2+(z-$zz)^2>($D)^2 or (x-$xd)^2+(y-$yd)^2+(z-$zd)^2>($D)^2) 
		mol modstyle 1 0 VDW 1.000000 20.000000
		mol modcolor 1 0 ColorID 0
		mol modmaterial 1 0 Glass1
		mol modselect 2 0 type TH X and within 1.2 of type TH and ((x-$xx)^2+(y-$yy)^2+(z-$zz)^2>($D)^2 or (x-$xd)^2+(y-$yd)^2+(z-$zd)^2>($D)^2) 
		mol modstyle 2 0 VDW 1.000000 20.000000
		mol modcolor 2 0 ColorID 14
		mol modmaterial 2 0 Glass1
		mol modselect 3 0 type F and ((x-$xx)^2+(y-$yy)^2+(z-$zz)^2<$D^2 or (x-$xd)^2+(y-$yd)^2+(z-$zd)^2<($D2)^2) 
		mol modstyle 3 0 VDW 1.000000 20.000000
		mol modcolor 3 0 ColorID 1
		mol modmaterial 3 0 Glossy
		mol modselect 4 0 type TP X and within 1.2 of type TP and ((x-$xx)^2+(y-$yy)^2+(z-$zz)^2<$D^2 or (x-$xd)^2+(y-$yd)^2+(z-$zd)^2<($D2)^2) 
		mol modstyle 4 0 VDW 1.000000 20.000000
		mol modcolor 4 0 ColorID 0
		mol modmaterial 4 0 Glossy
		mol modselect 5 0 type TH X and within 1.2 of type TH and ((x-$xx)^2+(y-$yy)^2+(z-$zz)^2<$D^2 or (x-$xd)^2+(y-$yd)^2+(z-$zd)^2<($D2)^2) 
		mol modstyle 5 0 VDW 1.000000 20.000000
		mol modcolor 5 0 ColorID 14
		mol modmaterial 5 0 Glossy 
		# take the picture
		set filename snap.[format "%04d" $j].tga
		render snapshot $filename
	}
}

#good one
proc sn8 {  xx yy zz xd yd zd D D2 args} {
	for {set k 0} {$k < 6} {incr k} {
        	mol delrep 0 all
        }
	mol selection {type F}
        mol addrep 0
	mol modselect 0 0 type F and ((x-$xx)^2+(y-$yy)^2+(z-$zz)^2>($D+18)^2 ) 
	mol modstyle 0 0 VDW 1.000000 20.000000
	mol modcolor 0 0 ColorID 1
	mol modmaterial 0 0 Glass1
	mol selection {type TP X and within 1.1 of type TP}
        mol addrep 0
	mol modselect 1 0 type TP X and within 1.1 of type TP and ((x-$xx)^2+(y-$yy)^2+(z-$zz)^2>($D+20)^2 )
	mol modstyle 1 0 VDW 1.000000 20.000000
	mol modcolor 1 0 ColorID 0
	mol modmaterial 1 0 Glass1
	mol selection {type TH X and within 1.2 of type TH}
        mol addrep 0
	mol modselect 2 0 type TH X and within 1.2 of type TH and ((x-$xx)^2+(y-$yy)^2+(z-$zz)^2>($D+20)^2 )
	mol modstyle 2 0 VDW 1.000000 20.000000
	mol modcolor 2 0 ColorID 14
	mol modmaterial 2 0 Glass1
	mol selection {type F}
        mol addrep 0
	mol modselect 3 0 type F and ((x-$xx)^2+(y-$yy)^2+(z-$zz)^2<$D^2 or (x-$xd)^2+(y-$yd)^2+(z-$zd)^2<($D2)^2) 
	mol modstyle 3 0 VDW 1.000000 20.000000
	mol modcolor 3 0 ColorID 1
	mol modmaterial 3 0 Glossy
	mol selection {type TP X and within 1.1 of type TP}
        mol addrep 0
	mol modselect 4 0 type TP X and within 1.1 of type TP and ((x-$xx)^2+(y-$yy)^2+(z-$zz)^2<$D^2 or (x-$xd)^2+(y-$yd)^2+(z-$zd)^2<($D2)^2) 
	mol modstyle 4 0 VDW 1.000000 20.000000
	mol modcolor 4 0 ColorID 0
	mol modmaterial 4 0 Glossy
	mol selection {type TH X and within 1.2 of type TH}
        mol addrep 0
	mol modselect 5 0 type TH X and within 1.2 of type TH and ((x-$xx)^2+(y-$yy)^2+(z-$zz)^2<$D^2 or (x-$xd)^2+(y-$yd)^2+(z-$zd)^2<($D2)^2) 
	mol modstyle 5 0 VDW 1.000000 20.000000
	mol modcolor 5 0 ColorID 14
	mol modmaterial 5 0 Glossy 
}

proc sn88 {  xx yy zz xd yd zd D D2 args} {
	mol modselect 0 0 type F and within 5 of index 
	mol modstyle 0 0 VDW 1.000000 20.000000
	mol modcolor 0 0 ColorID 1
	mol modmaterial 0 0 Glass1
	mol selection {type TP X and within 1.1 of type TP}
        mol addrep 0
	mol modselect 1 0 type TP X and within 1.1 of type TP and ((x-$xx)^2+(y-$yy)^2+(z-$zz)^2>($D)^2 or (x-$xd)^2+(y-$yd)^2+(z-$zd)^2>($D)^2) 
	mol modstyle 1 0 VDW 1.000000 20.000000
	mol modcolor 1 0 ColorID 0
	mol modmaterial 1 0 Glass1
	mol modselect 2 0 type TH X and within 1.2 of type TH and ((x-$xx)^2+(y-$yy)^2+(z-$zz)^2>($D)^2 or (x-$xd)^2+(y-$yd)^2+(z-$zd)^2>($D)^2) 
	mol modstyle 2 0 VDW 1.000000 20.000000
	mol modcolor 2 0 ColorID 14
	mol modmaterial 2 0 Glass1
	mol modselect 3 0 type F and ((x-$xx)^2+(y-$yy)^2+(z-$zz)^2<$D^2 or (x-$xd)^2+(y-$yd)^2+(z-$zd)^2<($D2)^2) 
	mol modstyle 3 0 VDW 1.000000 20.000000
	mol modcolor 3 0 ColorID 1
	mol modmaterial 3 0 Glossy
	mol selection {type TP X and within 1.1 of type TP}
        mol addrep 0
	mol modselect 4 0 type TP X and within 1.1 of type TP and ((x-$xx)^2+(y-$yy)^2+(z-$zz)^2<$D^2 or (x-$xd)^2+(y-$yd)^2+(z-$zd)^2<($D2)^2) 
	mol modstyle 4 0 VDW 1.000000 20.000000
	mol modcolor 4 0 ColorID 0
	mol modmaterial 4 0 Glossy
	mol modselect 5 0 type TH X and within 1.2 of type TH and ((x-$xx)^2+(y-$yy)^2+(z-$zz)^2<$D^2 or (x-$xd)^2+(y-$yd)^2+(z-$zd)^2<($D2)^2) 
	mol modstyle 5 0 VDW 1.000000 20.000000
	mol modcolor 5 0 ColorID 14
	mol modmaterial 5 0 Glossy 
	# take the picture
	#set filename snap.[format "%04d" $j].tga
	#render snapshot $filename
}

#4 capsids
proc sn9  {  xx yy zz xd yd zd xx1 yy1 zz1 xd1 yd1 zd1 D D2 D1 D21 args} {
	for {set k 0} {$k < 6} {incr k} {
        	mol delrep 0 all
        }
	mol selection {type F}
        mol addrep 0
	mol modselect 0 0 type F and ((x-$xx)^2+(y-$yy)^2+(z-$zz)^2>($D+2)^2 and (x-$xd)^2+(y-$yd)^2+(z-$zd)^2>($D+2)^2 and (x-$xx1)^2+(y-$yy1)^2+(z-$zz1)^2>($D1+2)^2 and (x-$xd1)^2+(y-$yd1)^2+(z-$zd1)^2>($D21+10)^2) 
	mol modstyle 0 0 VDW 1.000000 20.000000
	mol modcolor 0 0 ColorID 1
	mol modmaterial 0 0 Glass1
	mol selection {type TP X and within 1.1 of type TP}
        mol addrep 0
	mol modselect 1 0 type TP X and within 1.1 of type TP and ((x-$xx)^2+(y-$yy)^2+(z-$zz)^2>($D+2)^2 and (x-$xd)^2+(y-$yd)^2+(z-$zd)^2>($D+2)^2 and (x-$xx1)^2+(y-$yy1)^2+(z-$zz1)^2>($D1+2)^2 and (x-$xd1)^2+(y-$yd1)^2+(z-$zd1)^2>($D21+2)^2) 
	mol modstyle 1 0 VDW 1.000000 20.000000
	mol modcolor 1 0 ColorID 0
	mol modmaterial 1 0 Glass1
	mol selection {type TH X and within 1.2 of type TH}
        mol addrep 0
	mol modselect 2 0 type TH X and within 1.2 of type TH and ((x-$xx)^2+(y-$yy)^2+(z-$zz)^2>($D+2)^2 and (x-$xd)^2+(y-$yd)^2+(z-$zd)^2>($D+2)^2 and (x-$xx1)^2+(y-$yy1)^2+(z-$zz1)^2>($D1+2)^2 and (x-$xd1)^2+(y-$yd1)^2+(z-$zd1)^2>($D21+2)^2) 
	mol modstyle 2 0 VDW 1.000000 20.000000
	mol modcolor 2 0 ColorID 14
	mol modmaterial 2 0 Glass1
	mol selection {type F}
        mol addrep 0
	mol modselect 3 0 type F and ((x-$xx)^2+(y-$yy)^2+(z-$zz)^2<$D^2 or (x-$xd)^2+(y-$yd)^2+(z-$zd)^2<($D2)^2 or (x-$xx1)^2+(y-$yy1)^2+(z-$zz1)^2<$D1^2 or (x-$xd1)^2+(y-$yd1)^2+(z-$zd1)^2<($D21)^2)
	mol modstyle 3 0 VDW 1.000000 20.000000
	mol modcolor 3 0 ColorID 1
	mol modmaterial 3 0 Glossy
	mol selection {type TP X and within 1.1 of type TP}
        mol addrep 0
	mol modselect 4 0 type TP X and within 1.1 of type TP and ((x-$xx)^2+(y-$yy)^2+(z-$zz)^2<$D^2 or (x-$xd)^2+(y-$yd)^2+(z-$zd)^2<($D2)^2 or (x-$xx1)^2+(y-$yy1)^2+(z-$zz1)^2<$D1^2 or (x-$xd1)^2+(y-$yd1)^2+(z-$zd1)^2<($D21)^2) 
	mol modstyle 4 0 VDW 1.000000 20.000000
	mol modcolor 4 0 ColorID 0
	mol modmaterial 4 0 Glossy
	mol selection {type TH X and within 1.2 of type TH}
        mol addrep 0
	mol modselect 5 0 type TH X and within 1.2 of type TH and ((x-$xx)^2+(y-$yy)^2+(z-$zz)^2<$D^2 or (x-$xd)^2+(y-$yd)^2+(z-$zd)^2<($D2)^2 or (x-$xx1)^2+(y-$yy1)^2+(z-$zz1)^2<$D1^2 or (x-$xd1)^2+(y-$yd1)^2+(z-$zd1)^2<($D21)^2)
	mol modstyle 5 0 VDW 1.000000 20.000000
	mol modcolor 5 0 ColorID 14
	mol modmaterial 5 0 Glossy 
}

#material add MyGlass1 copy Glass1
	#material change opacity MyGlass1 0.1
proc newsn1 {} {
	mol delrep 0 all
	
	mol selection {type F}
	mol addrep 0
	mol modselect 0 0 type F
	mol modstyle 0 0 VDW 1.000000 20.000000
	mol modcolor 0 0 ColorID 1
	mol modmaterial 3 0 Glossy


	mol selection {type TP X and within 1.2 of type TP}
	mol addrep 0
	mol modselect 1 0 type TP X and within 1.2 of type TP 
	mol modstyle 1 0 VDW 1.000000 20.000000
	mol modcolor 1 0 ColorID 0
	mol modmaterial 4 0 Glossy

	mol selection {type TH X and within 1.2 of type TH}
	mol addrep 0
	mol modselect 2 0 type TH X and within 1.2 of type TH 
	mol modstyle 2 0 VDW 1.000000 20.000000
	mol modcolor 2 0 ColorID 14
	mol modmaterial 2 0 Glossy
	
	mol selection {type G}
	mol addrep 0
	mol modselect 3 0 type G
	mol modstyle 3 0 VDW 1.000000 20.000000
	mol modcolor 3 0 ColorID 3
	mol modmaterial 3 0 Glossy


	mol selection {type TP X and within 1.2 of type TP}
	mol addrep 0
	mol modselect 4 0 type TP X and within 1.2 of type TP 
	mol modstyle 4 0 VDW 1.000000 20.000000
	mol modcolor 4 0 ColorID 0
	mol modmaterial 4 0 Glossy

	mol selection {type TH X and within 1.2 of type TH}
	mol addrep 0
	mol modselect 5 0 type TH X and within 1.2 of type TH 
	mol modstyle 5 0 VDW 1.000000 20.000000
	mol modcolor 5 0 ColorID 14
	mol modmaterial 5 0 Glossy

	axes location off
	display depthcue off
	display resize 800 800
	display projection Orthographic
	color Display Background white
	set select1 [atomselect top all]
	$select1 set radius 0.5
	
}



proc p1 {} {
	mol delrep 0 all
	
	mol selection {type F}
	mol addrep 0
	mol modselect 0 0 type F
	mol modstyle 0 0 VDW 1.000000 20.000000
	mol modcolor 0 0 ColorID 1
	mol modmaterial 0 0 Glossy


	mol selection {type P}
	mol addrep 0
	mol modselect 1 0 type P
	mol modstyle 1 0 VDW 1.000000 20.000000
	mol modcolor 1 0 ColorID 0
	mol modmaterial 1 0 Glossy

	axes location off
	display depthcue off
	display resize 800 800
	display projection Orthographic
	color Display Background white
	set select1 [atomselect top all]
	$select1 set radius 1 
	
}

