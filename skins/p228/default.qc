// Start of QC script.

$modelname "v_p228.mdl"
$cd ".\"
$cdtexture ".\"
$scale 1.0
$cliptotextures

$bbox 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$cbox 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$eyeposition 0.000000 0.000000 0.000000

//reference mesh(es)
$body "studio" "hands1"
$body "studio" "hands2"
$body "studio" "hands3"
$body "studio" "hands4"
$body "clip" "clip"

$bodygroup "skins"
{
studio "template"
// end
}

// 2 attachment(s)
$attachment 0 "v_weapon.p250_parent" 0.000000 2.000000 5.000000
$attachment 1 "v_weapon.p250_parent" 0.000000 2.400000 2.300000

// 37 hit box(es)
$hbox 0 "v_weapon.Bip01_R_Hand" -7.288399 -1.299175 -1.870311 0.345192 36.061729 3.433919
$hbox 0 "v_weapon.Bip01_L_Hand" -3.527230 -1.296037 -1.565914 0.527202 0.941431 1.848344
$hbox 0 "v_weapon.Bip01_L_Finger0" -1.427838 -0.728040 -0.831598 0.869255 1.126580 0.652726
$hbox 0 "v_weapon.Bip01_L_ForeTwist" -8.080620 -2.447722 -1.729096 8.297151 2.180983 2.105669
$hbox 0 "v_weapon.Bip01_R_Finger0" -1.446667 -0.753145 -0.659002 0.878669 1.139132 0.853565
$hbox 0 "v_weapon.Bip01_R_ForeTwist" -8.074344 -2.444584 -2.105669 8.297151 2.180983 1.729096
$hbox 0 "v_weapon.Bip01_L_Finger01" -1.114027 -0.558583 -0.586826 0.000000 0.351468 0.423644
$hbox 0 "v_weapon.Bip01_L_Finger02" -1.060680 -0.524064 -0.470716 0.000000 0.276153 0.392263
$hbox 0 "v_weapon.Bip01_L_Finger1" -1.239552 -0.511511 -0.627621 0.000000 0.467578 0.379711
$hbox 0 "v_weapon.Bip01_L_Finger2" -1.459219 -0.561721 -0.467578 0.000000 0.498959 0.445611
$hbox 0 "v_weapon.Bip01_L_Finger3" -1.289761 -0.546030 -0.379711 0.000000 0.486406 0.476992
$hbox 0 "v_weapon.Bip01_L_Finger4" -0.935155 -0.423644 -0.316949 0.000000 0.542892 0.546030
$hbox 0 "v_weapon.Bip01_L_Finger41" -0.784526 -0.335777 -0.257325 0.000000 0.288706 0.404816
$hbox 0 "v_weapon.Bip01_R_Finger01" -1.126580 -0.580549 -0.448749 0.000000 0.376573 0.608792
$hbox 0 "v_weapon.Bip01_R_Finger02" -1.085784 -0.530340 -0.414230 0.000000 0.304396 0.495821
$hbox 0 "v_weapon.Bip01_R_Finger1" -1.245828 -0.533478 -0.398539 0.000000 0.489544 0.655864
$hbox 0 "v_weapon.Bip01_R_Finger2" -1.456081 -0.586826 -0.426782 0.000000 0.524064 0.489544
$hbox 0 "v_weapon.Bip01_R_Finger3" -1.289761 -0.571135 -0.498959 0.000000 0.502097 0.354606
$hbox 0 "v_weapon.Bip01_R_Finger4" -0.941431 -0.445611 -0.567997 0.000000 0.558583 0.301258
$hbox 0 "v_weapon.Bip01_R_Finger41" -0.790802 -0.354606 -0.426782 0.000000 0.307534 0.282429
$hbox 0 "v_weapon.Bip01_L_Finger11" -0.928879 -0.323225 -0.426782 0.000000 0.392263 0.348330
$hbox 0 "v_weapon.Bip01_L_Finger21" -0.878669 -0.445611 -0.360882 0.000000 0.338915 0.354606
$hbox 0 "v_weapon.Bip01_L_Finger31" -0.781388 -0.423644 -0.332639 0.000000 0.294982 0.357744
$hbox 0 "v_weapon.Bip01_L_Finger32" -1.041851 -0.351468 -0.338915 0.034519 0.288706 0.329501
$hbox 0 "v_weapon.Bip01_L_Finger42" -0.922603 -0.219667 -0.288706 0.000000 0.291844 0.298120
$hbox 0 "v_weapon.Bip01_R_Finger11" -0.925741 -0.342053 -0.373435 0.000000 0.414230 0.451887
$hbox 0 "v_weapon.Bip01_R_Finger21" -0.881807 -0.470716 -0.379711 0.000000 0.360882 0.382849
$hbox 0 "v_weapon.Bip01_R_Finger31" -0.778250 -0.448749 -0.382849 0.000000 0.316949 0.357744
$hbox 0 "v_weapon.Bip01_R_Finger32" -1.060680 -0.376573 -0.348330 0.034519 0.307534 0.360882
$hbox 0 "v_weapon.Bip01_R_Finger42" -0.944570 -0.241634 -0.323225 0.000000 0.323225 0.310672
$hbox 0 "v_weapon.Bip01_L_Finger12" -1.023022 -0.294982 -0.342053 0.000000 0.294982 0.335777
$hbox 0 "v_weapon.Bip01_L_Finger22" -0.875531 -0.338915 -0.348330 0.015691 0.323225 0.348330
$hbox 0 "v_weapon.Bip01_R_Finger12" -1.044989 -0.316949 -0.351468 0.000000 0.316949 0.364020
$hbox 0 "v_weapon.Bip01_R_Finger22" -0.894360 -0.354606 -0.373435 0.025105 0.342053 0.364020
$hbox 0 "v_weapon.p250_parent" -0.489544 -1.806072 -1.365076 0.480130 2.341026 4.876615
$hbox 0 "v_weapon.p250_slide" -0.373435 -0.903774 -0.059624 0.370296 0.420506 5.551309
$hbox 0 "v_weapon.p250_magazine" -0.401677 -0.131800 -0.671555 0.401677 3.338943 0.731178

// 8 animation sequence(s)
$sequence "idle" "idle" fps 30
$sequence "shoot1" "shoot1" fps 35 { event 5001 0 "11" }
$sequence "shoot2" "shoot2" fps 35 { event 5001 0 "11" }
$sequence "shoot3" "shoot3" fps 35 { event 5001 0 "11" }
$sequence "shoot_empty" "shoot_empty" fps 35 { event 5001 0 "11" }
$sequence "reload" "reload" fps 20 {
  { event 5004 8 "weapons/p228_clipout.wav" }
  { event 5004 20 "weapons/p228_clipin.wav" }
  { event 5004 34 "weapons/p228_sliderelease.wav" }
  { event 5004 38 "weapons/p228_sliderelease2.wav" }
 }
$sequence "draw" "draw" fps 22 {
  { event 5004 0 "weapons/de_deploy.wav" }
  { event 5004 8 "weapons/p228_slidepull.wav" }
  { event 5004 12 "weapons/p228_slidepull2.wav" }
 }
$sequence "inspect" "inspect" fps 30

// End of QC script.
