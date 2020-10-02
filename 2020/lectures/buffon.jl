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
	# change matplotlib style. choose one here:
	#   https://matplotlib.org/3.1.1/gallery/style_sheets/style_sheets_reference.html
	PyPlot.matplotlib.style.use("seaborn-colorblind")
	
	# make the font bigger
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

# ╔═╡ 00b77514-04d2-11eb-1372-036aeab58188
"""
	p = exact_p(floor, L)

compute the exact probability that a needle of length `L` crosses a `floor`.
[yes, we can derive an analytical solution to the Buffon's needle problem!]

# arguments
* `floor::Floor`: a floor with parallel lines
* `L::Float64`: the length of the needle.
"""
function exact_p(floor::Floor, L::Float64)
	return 2 * L / (π * floor.ℓ)
end

# ╔═╡ 26a99aa4-04d2-11eb-1ab0-313436c05652
exact_p(floor, L)

# ╔═╡ 2442d8ac-04d2-11eb-2c27-17c926f22e4a
estimate_prob_needle_crosses_line(10000000, floor, L)

# ╔═╡ 5f088f6e-04f4-11eb-0d9f-fb83831fab66
md"check that our simulation recovers the exact probability.

if not, we have a 🐛!
"

# ╔═╡ 8b85e13a-04d2-11eb-3105-cd3ecabd1a10
isapprox(exact_p(floor, L), 
		 estimate_prob_needle_crosses_line(100000000, floor, L),
		 atol=1e-3)

# ╔═╡ e654733c-02d0-11eb-16b2-092f5bae0883
md"
### how does the estimate of the probability of a needle cross depend on the number of tosses?
"

# ╔═╡ a72dbd00-04f4-11eb-117d-35b47f75b1cf
nb_tosses_range = [10, 50, 100, 500, 1000, 5000, 10000, 50000, 100000]

# ╔═╡ e221a23c-04f4-11eb-118e-2d6bf6a135d7
md"first, a warm-up problem.
plot the estimate of the probability against the number of tosses used to estimate it.
this is going to be noisy and change significantly each time we run, when the number of tosses is small. (not ideal, but a good warm-up problem)."

# ╔═╡ 7daafaea-04f4-11eb-194b-17706203fb09
begin
	p_ests = zeros(length(nb_tosses_range))
	for (i, nb_tosses) in enumerate(nb_tosses_range)
		p_ests[i] = estimate_prob_needle_crosses_line(nb_tosses, floor, L)
	end
end

# ╔═╡ b24b2042-04f4-11eb-1292-3918f46dd9d1
begin
	figure()
	scatter(nb_tosses_range, p_ests, color="C5")
	xlabel("# tosses")
	ylabel(L"estimate of $p$")
	axhline(y=exact_p(floor, L), linestyle="--", color="gray")
	xscale("log")
	gcf()
end

# ╔═╡ 0ff169d6-04f5-11eb-07b4-2535ab742442
md"
now, for a fixed # of tosses, let's run `nb_sims=1000` simulations of needle tossing to see how the estimate varies with the number of tosses.
* plot the average among the simulations as a dot.
* plot the middle 90% of the estimates within error bars.
"

# ╔═╡ c43ba85e-043a-11eb-1b3c-63e6aa51fdd4
begin
	nb_sims = 5000
	# store average estimates here
	avg_p_ests = zeros(length(nb_tosses_range))
	# store length of error bars here.
	yerr = zeros(2, length(nb_tosses_range))
	# loop over different # tosses
	for (i, nb_tosses) in enumerate(nb_tosses_range)
		# run nb_sims simulations of needle tossing
		p_ests = zeros(nb_sims)
		for s = 1:nb_sims
			p_ests[s] = estimate_prob_needle_crosses_line(nb_tosses, floor, L)
		end
		# compute average estimate among the simulations
		avg_p_ests[i] = mean(p_ests)
		# get 5th, 95th percentiles and compute length of error bars
		yerr[1, i] = percentile(p_ests, 95.0) - avg_p_ests[i]
		yerr[2, i] = avg_p_ests[i] - percentile(p_ests, 5.0)
	end
end

# ╔═╡ d44b7674-04f4-11eb-0089-0feabade739c
begin
	figure()
	errorbar(nb_tosses_range, avg_p_ests, 
		yerr=yerr, color="C5", lw=2, fmt="o", capsize=5)
	xlabel("# tosses")
	ylabel(L"estimate of $p$")
	axhline(y=exact_p(floor, L), linestyle="--", color="gray")
	xscale("log")
	gcf()
end

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
# ╠═00b77514-04d2-11eb-1372-036aeab58188
# ╠═26a99aa4-04d2-11eb-1ab0-313436c05652
# ╠═2442d8ac-04d2-11eb-2c27-17c926f22e4a
# ╟─5f088f6e-04f4-11eb-0d9f-fb83831fab66
# ╠═8b85e13a-04d2-11eb-3105-cd3ecabd1a10
# ╟─e654733c-02d0-11eb-16b2-092f5bae0883
# ╠═a72dbd00-04f4-11eb-117d-35b47f75b1cf
# ╟─e221a23c-04f4-11eb-118e-2d6bf6a135d7
# ╠═7daafaea-04f4-11eb-194b-17706203fb09
# ╠═b24b2042-04f4-11eb-1292-3918f46dd9d1
# ╟─0ff169d6-04f5-11eb-07b4-2535ab742442
# ╠═c43ba85e-043a-11eb-1b3c-63e6aa51fdd4
# ╠═d44b7674-04f4-11eb-0089-0feabade739c
