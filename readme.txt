#load the trajectory sd*
vmd sd*.mol2 sd*.dcd

#in TKconsole:
>play take_snap.tcl

#go to last frame
>CapsidPolymer

#then go to desired frame
#zoom in and meke the view as desired

#then 
>display resize 1000 10000
>Capsidpolymer
# choose a frmaenumber as fpart of the filename
>onesnap framenumber


#to convert tga files to jpg:
#close vmd
#in the folder that you have tga files run 
>bash convert.sh


