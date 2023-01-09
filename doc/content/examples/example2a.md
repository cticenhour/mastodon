# Example 2a: Direct shear test using the GQ/H backbone curve formulation

This example demonstrates a single element direct simple shear test that utilizes I-soil with GQ/H
backbone generation method [!citep](groholski2016simplified). For this particular example, the units
defining the parameters are N, kg, and meter (m), and the material definition is created using
following input:

!listing examples/ex02a/HYS_GQH.i start=Materials end=Preconditioning

where

`theta_1 through theta_2` ; are curve fitting parameters obtained from DEEPSOIL
[!citep](hashash2016deepsoil).

`taumax = 7500` ; specifies maximum shear strength achieved at large shear strains.

Other parameters are the same as in [Example 1](examples/index.md exact=True). Once the same boundary
conditions are applied as in [Example 1](examples/index.md exact=True), the following response is obtained

!media media/examples/example2stressstrain.png
       style=width:60%;margin-left:150px;float:center;
       id=fig:example2stressstrain
       caption=Hysteretic response under 0.02 cyclic strian amplitude.

!alert note
Observe that in Example 2a, the shear stress mobilized at shear strain of 0.02 is 6 kPa whereas in
Example 1a, the mobilized shear stress is ~ 4 kPa. This is because in Example 1a, the backbone
asymptotically approaches to 4 kPa which is implied by [!citet](darendeli2001development) at large
strains whereas in Example 2a, the shear stress asymptotically approaches to 7.5 kPa at large strains
(0.1)

!bibtex bibliography
