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


# ╔═╡ d427544c-02d0-11eb-0a24-95e0cdcdef49
md"
#### visualize the needles
"

# ╔═╡ 0cd6cfe6-02d1-11eb-2f6a-3ff63622e586


# ╔═╡ 6a9c9648-02d0-11eb-15a3-571fee067d61
md"
#### visualize the state space of needles $(x, \theta)$
"

# ╔═╡ 0dde4f40-02d1-11eb-1522-859a2eda2762


# ╔═╡ 4217183e-02d1-11eb-0da6-61fa776418c9
md"
### compare to the exact solution

see [here](https://en.wikipedia.org/wiki/Buffon%27s_needle_problem).

$p = \frac{2L}{\pi \ell}$

this is a cool way to compute $\pi$ 😎
"

# ╔═╡ e654733c-02d0-11eb-16b2-092f5bae0883
md"
### how many tosses do we need for a reliable estimate?
"

# ╔═╡ 0f2f6ea6-02d1-11eb-2464-c3d12a81a15a


# ╔═╡ d28f1324-02d1-11eb-3224-751c95995830


# ╔═╡ Cell order:
# ╟─84bbb724-ff52-11ea-10f2-6113eee6b3ae
# ╠═f4c4e3c2-0134-11eb-3801-9b34e38a05d4
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
# ╟─d427544c-02d0-11eb-0a24-95e0cdcdef49
# ╠═0cd6cfe6-02d1-11eb-2f6a-3ff63622e586
# ╟─6a9c9648-02d0-11eb-15a3-571fee067d61
# ╠═0dde4f40-02d1-11eb-1522-859a2eda2762
# ╟─4217183e-02d1-11eb-0da6-61fa776418c9
# ╟─e654733c-02d0-11eb-16b2-092f5bae0883
# ╠═0f2f6ea6-02d1-11eb-2464-c3d12a81a15a
# ╠═d28f1324-02d1-11eb-3224-751c95995830
