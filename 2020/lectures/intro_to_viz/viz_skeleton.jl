### A Pluto.jl notebook ###
# v0.12.2

using Markdown
using InteractiveUtils

# ╔═╡ f21a4810-0841-11eb-3677-6184b9c7e722
using DataFrames, CSV, PyPlot

# ╔═╡ cc2d47ce-0841-11eb-1d5b-e5a34cd63714
md"
# data viz

we will use `matplotlib`, an open-source data visualization library written for Python (but we call it from Julia using `PyPlot`). 

* [documentation](https://matplotlib.org/) for `matplotlib`
* a `matplotlib` [gallery](https://matplotlib.org/gallery/index.html).
"

# ╔═╡ fe095ece-0841-11eb-1b4d-357b5107a0aa
md"
## bar plots

*goal*: visualize how Americans like their steak done [[source](https://fivethirtyeight.com/features/how-americans-like-their-steak/)] via a bar plot showing preference for rare, medium rare, etc.

read in `data/steak.csv` as `df_steak::DataFrame`
* first column: \"do you eat steak?\"
* second column: \"if you do like steak, how do you like your steak done?\"
"

# ╔═╡ da5e8dc8-09ac-11eb-2ccb-6be97ef46993
pwd()

# ╔═╡ e179a3fe-09ac-11eb-10be-93185e9ba4f6


# ╔═╡ 8f9d6cd8-09ab-11eb-11dc-7789357407b5


# ╔═╡ 57847d7e-0842-11eb-2d4a-f14011a761c3
md"
drop rows with missing values (folks who do not eat steak should not count in our visualization)
"

# ╔═╡ 612f687a-0842-11eb-19ed-1f4efa152e78


# ╔═╡ 6b01c47e-0842-11eb-0557-dfec71c4ef48
md"
let's make sure everyone in this data set now eats steak and thus can answer the question
"

# ╔═╡ 7623ab42-0842-11eb-2fe2-41cf30a7ec70


# ╔═╡ 77a39b58-0842-11eb-2f1c-070f6d62cc75
md"
count the number of folks who prefer rare, medium rare, etc.

store the result in `df_steak_prefs::DataFrame` to use for visualization.

!!! hint
    use `by`
"

# ╔═╡ 991b5ac2-0843-11eb-3c7a-d7cf4070b768


# ╔═╡ 9a1691ee-0843-11eb-1253-f50fd8485a57
md"
since there is an ordinality in how well the steak is cooked (which the computer cannot possibly know, without some machine learning algorithm being involved), manually permute the rows so that the ordering is natural.
"

# ╔═╡ 92d0d5f2-09ad-11eb-34cf-fdd935ea6051


# ╔═╡ bd4c54aa-0843-11eb-1027-1f250081a009
md"
draw a bar plot showing how folks like their steak cooked.
"

# ╔═╡ b00cfc66-09ad-11eb-15f6-ff5023917037


# ╔═╡ 908a52a4-09ae-11eb-27ab-6f9a75253f54


# ╔═╡ 0e9df8b8-0844-11eb-3de1-afd114b2d059
md"
to help depict how well the steak is cooked in each bar, color the bars according to how well the steak is cooked, using the `hot` colormap.

see colormaps [here](https://matplotlib.org/3.1.0/tutorials/colors/colormaps.html).
"

# ╔═╡ 5c7a4d7a-0844-11eb-1988-f7690c65f603


# ╔═╡ 778d79b6-0844-11eb-251a-836c560adc99
md"
`hot_cmap` is a function that takes in a `Float64` in $[0, 1]$ and outputs a color in the [RGBA format](https://en.wikipedia.org/wiki/RGBA_color_model).
"

# ╔═╡ 8ab05aa4-0844-11eb-3ca7-d54feeb37e4f


# ╔═╡ d4bde3fa-0844-11eb-11cd-11ac0239278e
md"
use `hot_cmap` to color the bars.
"

# ╔═╡ e4f1faa6-0844-11eb-35ae-1579b43939c5


# ╔═╡ e5bd9860-0844-11eb-292a-f1fc13b95a6a
md"
## line plots with multiple series and a legend

plot the adsorption isotherm of two different gases in a porous material, Noria. [source](http://www.cchem.berkeley.edu/co2efrc/downloads/pdfs/Patil16.pdf)

* `Xe.csv`: amount of xenon gas adsorbed at different pressures
* `Kr.csv`: amount of krypton gas adsorbed at different pressures

temperature: 298 K.

read in the data as `df_gas::Dict{String, DataFrame}` so that `df_gas[\"Xe\"]` gives the xenon adsorption data.
"

# ╔═╡ 974e72b8-0845-11eb-3bf1-c1b30517a1ae


# ╔═╡ 39870d3c-09af-11eb-1dc8-05df9642c09e


# ╔═╡ 68abf7a8-09af-11eb-31b3-8b506e1acdab


# ╔═╡ 6ea53766-09af-11eb-3993-6f2c386050d0


# ╔═╡ 17088318-0846-11eb-36f6-33b5d5bca1e8
md"
use a line plot with markers to plot the adsorption isotherm of Xe and Kr in Noria.

* x-axis: pressure
* y-axis: amount adsorbed
* use two different colors for the two different gases
* use two different markers (for color-blind folks and black & white printers)
* include a legend indicating which series is which
"

# ╔═╡ 68803182-0846-11eb-1b95-817dd52ca4e8


# ╔═╡ Cell order:
# ╟─cc2d47ce-0841-11eb-1d5b-e5a34cd63714
# ╠═f21a4810-0841-11eb-3677-6184b9c7e722
# ╟─fe095ece-0841-11eb-1b4d-357b5107a0aa
# ╠═da5e8dc8-09ac-11eb-2ccb-6be97ef46993
# ╠═e179a3fe-09ac-11eb-10be-93185e9ba4f6
# ╠═8f9d6cd8-09ab-11eb-11dc-7789357407b5
# ╟─57847d7e-0842-11eb-2d4a-f14011a761c3
# ╠═612f687a-0842-11eb-19ed-1f4efa152e78
# ╟─6b01c47e-0842-11eb-0557-dfec71c4ef48
# ╠═7623ab42-0842-11eb-2fe2-41cf30a7ec70
# ╟─77a39b58-0842-11eb-2f1c-070f6d62cc75
# ╠═991b5ac2-0843-11eb-3c7a-d7cf4070b768
# ╟─9a1691ee-0843-11eb-1253-f50fd8485a57
# ╠═92d0d5f2-09ad-11eb-34cf-fdd935ea6051
# ╟─bd4c54aa-0843-11eb-1027-1f250081a009
# ╠═b00cfc66-09ad-11eb-15f6-ff5023917037
# ╠═908a52a4-09ae-11eb-27ab-6f9a75253f54
# ╟─0e9df8b8-0844-11eb-3de1-afd114b2d059
# ╠═5c7a4d7a-0844-11eb-1988-f7690c65f603
# ╟─778d79b6-0844-11eb-251a-836c560adc99
# ╠═8ab05aa4-0844-11eb-3ca7-d54feeb37e4f
# ╟─d4bde3fa-0844-11eb-11cd-11ac0239278e
# ╠═e4f1faa6-0844-11eb-35ae-1579b43939c5
# ╟─e5bd9860-0844-11eb-292a-f1fc13b95a6a
# ╠═974e72b8-0845-11eb-3bf1-c1b30517a1ae
# ╠═39870d3c-09af-11eb-1dc8-05df9642c09e
# ╠═68abf7a8-09af-11eb-31b3-8b506e1acdab
# ╠═6ea53766-09af-11eb-3993-6f2c386050d0
# ╟─17088318-0846-11eb-36f6-33b5d5bca1e8
# ╠═68803182-0846-11eb-1b95-817dd52ca4e8
