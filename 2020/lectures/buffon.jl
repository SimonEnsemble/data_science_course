### A Pluto.jl notebook ###
# v0.11.14

using Markdown
using InteractiveUtils

# ╔═╡ f4c4e3c2-0134-11eb-3801-9b34e38a05d4
using PyPlot, PlutoUI, StatsBase # load all packages we need at the top of the file

# ╔═╡ 84bbb724-ff52-11ea-10f2-6113eee6b3ae
md"
## Monte Carlo simulation of Buffon's needle
"

# ╔═╡ f3ca3250-039c-11eb-0c7c-d7d56fcc2ca6
begin
	PyPlot.matplotlib.style.use("seaborn-colorblind")
	
	rcParams = PyPlot.PyDict(PyPlot.matplotlib."rcParams")
	rcParams["font.size"] = 16
end

# ╔═╡ 0c9005be-0136-11eb-1ce4-4b7b26c374b6
md"
### defining helpful data structures

define a data structure to represent a needle of length $L$ at position $x$ and with orientation $\theta$.
"

# ╔═╡ b5dec972-ff52-11ea-01a3-dfcaeade188d
struct Needle
	x::Float64
	θ::Float64 # \theta, then hit Tab
	L::Float64
end

# ╔═╡ 37258de2-0136-11eb-00b1-f186cf54efbb
md"
here's how to construct a needle, then query its attributes
"

# ╔═╡ f8965616-ff52-11ea-3794-af97cc4cc12d
needle = Needle(0.1, π / 3, 1.0)

# ╔═╡ 1254dad4-ff53-11ea-2c97-3daf9b031a0c
needle.x

# ╔═╡ 1695775c-ff53-11ea-2860-d3d83a4885fa
needle.θ

# ╔═╡ 9d939266-ff53-11ea-14fe-07b2a69b033e
needle.L

# ╔═╡ aee30d1c-ff53-11ea-2dc2-a73f3695cb07
md"define a data structure to represent the floor, with $\ell$ the distance between the lines. (perhaps not necessary but conceptually helpful)
"

# ╔═╡ 3262b86e-ff53-11ea-3c84-d18d0b8830c7
struct Floor
	ℓ::Float64 # \ell, then Tab
end

# ╔═╡ 8a17d8f4-0134-11eb-390a-a3e46f107d84
md"
### simulation of needle tosses
"

# ╔═╡ bd3f7a8a-ff53-11ea-144d-35aa5c354ac8
"""
	needle = toss_needle(L, floor)

toss a needle of length `L` onto a `floor`.
the needle lands at a uniform random position with a uniform random orientation.

# arguments
* `L::Float64`: the length of the needle
* `floor::Floor`: the floor on which the needle is tossed
"""
function toss_needle(L::Float64, floor::Floor)
	x = rand() * floor.ℓ
	θ = rand() * π
	return Needle(x, θ, L)
end

# ╔═╡ 64993800-ff54-11ea-17ec-6b6861be1dfe
md"
### did the needle cross a line?"

# ╔═╡ 6e976e8c-ff54-11ea-266a-0d592a884b97
function cross_line(needle::Needle, floor::Floor)
	x_right_tip = needle.x + needle.L / 2 * sin(needle.θ)
	x_left_tip  = needle.x - needle.L / 2 * sin(needle.θ)
	return x_right_tip > floor.ℓ || x_left_tip < 0.0
end

# ╔═╡ f3b6a7d0-02cf-11eb-3942-71ade026fcb2
md"
### estimate the probability that a needle crosses a line

which is the fraction of simulated needle tosses that result in a needle crossing a line.
"

# ╔═╡ f1785d6c-02cf-11eb-12dc-3d27e3d4c15d
function estimate_prob_needle_crosses_line(nb_tosses::Int, floor::Floor, L::Float64)
	nb_crosses = 0
	for t = 1:nb_tosses
		needle = toss_needle(L, floor)
		if cross_line(needle, floor)
			nb_crosses += 1
		end
	end
	return nb_crosses / nb_tosses # fraction of needles that cross a line
end

# ╔═╡ 2fece28c-02d0-11eb-1427-b7c56e640a76
estimate_prob_needle_crosses_line(25, Floor(1.2), 2.0)

# ╔═╡ 4b9088f4-02d0-11eb-27da-87dcda0ae70c
md"
### visualize an outcome

first, let's toss a bunch of needles and keep track of them in an array.
"

# ╔═╡ d1e261fc-02d0-11eb-00e6-1594f53ab643
begin
	floor = Floor(2.0)
	L = floor.ℓ / 2
	nb_tosses = 125
end

# ╔═╡ 25e90a00-033f-11eb-3b33-678f9cfb5e6a
needles = [toss_needle(L, floor) for 🌳 in 1:nb_tosses] # list comprehension

# ╔═╡ a8701318-033f-11eb-2731-8798e51fb4c9
# begin
# 	needles = Needle[]
# 	for t = 1:nb_tosses
# 		push!(needles, toss_needle(L, floor))
# 	end
# 	needles
# end

# ╔═╡ c46bbb80-033f-11eb-1919-f10ad3e77a5a
length(needles)

# ╔═╡ d427544c-02d0-11eb-0a24-95e0cdcdef49
md"
#### visualize the needles
"

# ╔═╡ 0cd6cfe6-02d1-11eb-2f6a-3ff63622e586
begin
	# if you wish to color the needles by whether or not they
	#   cross a line
	color_by_crossing = false
	
	figure()
	xlabel(L"$x$")
	ylabel(L"$y$")
	# plot the lines on the floor
	nb_lines = 6
	for l = 1:nb_lines
		axvline(x=(l-1) * floor.ℓ, color="k")
	end
	# plot the needles
	dy = (nb_lines - 1) * floor.ℓ
	for needle in needles
		xs = [needle.x - needle.L / 2 * sin(needle.θ), 
			  needle.x + needle.L / 2 * sin(needle.θ)]
		ys = [needle.L / 2 * cos(needle.θ), 
			  -needle.L / 2 * cos(needle.θ)] 
		# add random offset for viz purposes
		xs = xs .+ floor.ℓ * rand(0:nb_lines-2)
		ys = ys .+ rand() * dy
		if ! color_by_crossing || cross_line(needle, floor)
			plot(xs, ys, color="C1")
		else
			plot(xs, ys, color="C2")
		end
	end
	xlim([-L/2, (nb_lines - 1) * floor.ℓ + L/2])
	ylim([-L/2, dy + L/2])
	axis("off")
	gca().set_aspect("equal")
	savefig("needles.png", format="png", dpi=300)
# 	title("Buffon's needle")
	gcf()
end

# ╔═╡ 6a9c9648-02d0-11eb-15a3-571fee067d61
md"
#### visualize the state space of needles $(x, \theta)$
"

# ╔═╡ 60c473a6-042c-11eb-31e6-6dedb602e8f9
begin
	figure()
	xlabel(L"$\theta$")
	ylabel(L"$x$")
	θ_range = range(0.0, π, length=100)
	
	# plot boundaries as lines
	plot(θ_range, L/2 * sin.(θ_range), color="k")
	plot(θ_range, floor.ℓ .- L/2 * sin.(θ_range), color="k")
	hlines(0.0, 0.0, π, color="k", clip_on=false)
	hlines(floor.ℓ, 0.0, π, color="k", clip_on=false)
	vlines(0.0, 0.0, floor.ℓ, color="k", clip_on=false)
	vlines(π, 0.0, floor.ℓ, color="k", clip_on=false)
	
	# fill regions with color
	fill_between(θ_range, zeros(100), L/2 * sin.(θ_range), 
		alpha=0.5, color="C0")
	fill_between(θ_range, L/2 * sin.(θ_range), floor.ℓ .- L/2 * sin.(θ_range), 
		alpha=0.5, color="C1")
	fill_between(θ_range, floor.ℓ .- L/2 * sin.(θ_range), [floor.ℓ for i = 1:100], 
		alpha=0.5, color="C0")
	
	# plot needles in state space
	xs = [needle.x for needle in needles]
	θs = [needle.θ for needle in needles]
	colors = [cross_line(needle, floor) ? "C0" : "C1" for needle in needles]
	scatter(θs, xs, color=colors, marker="x")
	
	xlim([0, π])
	xticks([0, π/2, π], [L"$0$", L"$\pi/2$", L"$\pi$"])
	ylim([0, floor.ℓ])
	yticks([0, floor.ℓ], [L"$0$", L"$\ell$"])
	gcf()
end

# ╔═╡ 4217183e-02d1-11eb-0da6-61fa776418c9
md"
### compare to the exact solution

see [here](https://en.wikipedia.org/wiki/Buffon%27s_needle_problem).

$p = \frac{2L}{\pi \ell}$

if $L=\ell/2\implies$ this is a cool way to compute $\pi$ (well, $\pi^{-1}$) 😎
"

# ╔═╡ e654733c-02d0-11eb-16b2-092f5bae0883
md"
### how many tosses do we need for a reliable estimate?
"

# ╔═╡ c43ba85e-043a-11eb-1b3c-63e6aa51fdd4


# ╔═╡ 59c92812-045f-11eb-315f-796411822194


# ╔═╡ d28f1324-02d1-11eb-3224-751c95995830


# ╔═╡ 60c53630-045f-11eb-3597-77c55aa98bca
begin
	x = [1, 2, 3]
	y = x .^ 2
	
	yerr = rand(2, 3)
end

# ╔═╡ e92b6076-045a-11eb-232d-5d09ad2f5b76
begin
	# https://matplotlib.org/3.1.1/api/_as_gen/matplotlib.pyplot.errorbar.html#matplotlib.pyplot.errorbar
	figure()
	errorbar(x, y, fmt="o", yerr=yerr, capsize=5)
	gcf()
end

# ╔═╡ 5ca13928-045f-11eb-2af6-914d599250e6


# ╔═╡ 3b01794e-045b-11eb-3ee5-cdebb0f4d285


# ╔═╡ 5e8a632c-045f-11eb-1d15-9567e04999fa


# ╔═╡ Cell order:
# ╟─84bbb724-ff52-11ea-10f2-6113eee6b3ae
# ╠═f4c4e3c2-0134-11eb-3801-9b34e38a05d4
# ╠═f3ca3250-039c-11eb-0c7c-d7d56fcc2ca6
# ╟─0c9005be-0136-11eb-1ce4-4b7b26c374b6
# ╠═b5dec972-ff52-11ea-01a3-dfcaeade188d
# ╟─37258de2-0136-11eb-00b1-f186cf54efbb
# ╠═f8965616-ff52-11ea-3794-af97cc4cc12d
# ╠═1254dad4-ff53-11ea-2c97-3daf9b031a0c
# ╠═1695775c-ff53-11ea-2860-d3d83a4885fa
# ╠═9d939266-ff53-11ea-14fe-07b2a69b033e
# ╟─aee30d1c-ff53-11ea-2dc2-a73f3695cb07
# ╠═3262b86e-ff53-11ea-3c84-d18d0b8830c7
# ╟─8a17d8f4-0134-11eb-390a-a3e46f107d84
# ╠═bd3f7a8a-ff53-11ea-144d-35aa5c354ac8
# ╟─64993800-ff54-11ea-17ec-6b6861be1dfe
# ╠═6e976e8c-ff54-11ea-266a-0d592a884b97
# ╟─f3b6a7d0-02cf-11eb-3942-71ade026fcb2
# ╠═f1785d6c-02cf-11eb-12dc-3d27e3d4c15d
# ╠═2fece28c-02d0-11eb-1427-b7c56e640a76
# ╟─4b9088f4-02d0-11eb-27da-87dcda0ae70c
# ╠═d1e261fc-02d0-11eb-00e6-1594f53ab643
# ╠═25e90a00-033f-11eb-3b33-678f9cfb5e6a
# ╠═a8701318-033f-11eb-2731-8798e51fb4c9
# ╠═c46bbb80-033f-11eb-1919-f10ad3e77a5a
# ╟─d427544c-02d0-11eb-0a24-95e0cdcdef49
# ╠═0cd6cfe6-02d1-11eb-2f6a-3ff63622e586
# ╟─6a9c9648-02d0-11eb-15a3-571fee067d61
# ╠═60c473a6-042c-11eb-31e6-6dedb602e8f9
# ╟─4217183e-02d1-11eb-0da6-61fa776418c9
# ╟─e654733c-02d0-11eb-16b2-092f5bae0883
# ╠═c43ba85e-043a-11eb-1b3c-63e6aa51fdd4
# ╠═59c92812-045f-11eb-315f-796411822194
# ╠═d28f1324-02d1-11eb-3224-751c95995830
# ╠═60c53630-045f-11eb-3597-77c55aa98bca
# ╠═e92b6076-045a-11eb-232d-5d09ad2f5b76
# ╠═5ca13928-045f-11eb-2af6-914d599250e6
# ╠═3b01794e-045b-11eb-3ee5-cdebb0f4d285
# ╠═5e8a632c-045f-11eb-1d15-9567e04999fa
