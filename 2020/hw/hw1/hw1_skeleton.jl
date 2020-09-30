### A Pluto.jl notebook ###
# v0.11.14

using Markdown
using InteractiveUtils

# ╔═╡ cb380112-0290-11eb-2d54-1d2ebbf2db02
using PyPlot

# ╔═╡ dfac0f06-0283-11eb-1e61-bdcfebc698d2
student_name = "xxx" # write your name here and run the cell

# ╔═╡ ecc0cb6c-027e-11eb-224b-81b62dbdd22a
md"
# CHE 599 hw 1
_version 1_

Fall 2020

_name_: $student_name.

**learning outcomes**:
* understand the idea behind stochastic simulation
* equip yourself with Julia programming skills
* reinforce concepts in computational thinking
"

# ╔═╡ 47eaa4a4-0290-11eb-2f7e-8b0039ce49a1
md"

!!! note
	for fun, feel free to make use of the unicode 🌳 in this assignment instead of typing `tree`. type `\:deciduous_tree:`, then hit tab to get this emoji.
"

# ╔═╡ 51be6bf2-0284-11eb-211b-8133496d70ce
md"
## excerise 1: planting trees

![image of trees](https://raw.githubusercontent.com/SimonEnsemble/data_science_course/master/2020/hw/hw1/trees.png)

we aim to use a computer simulation to decide where to plant trees on a rectangular plot of land (width $W$, length $L$). our goal is to plant each tree at a uniform random position, but under the constrant that it is not within a distance $2R$ of another tree. we want to plant the trees at random positions to give the plot of land the feeling of a natural forest, as opposed to planting the trees in a regular grid. the constraint that no two trees are a distance $<2R$ from each other is because trees planted too close together will not grow.

this exercise has a strong connection with molecular simulation, since the trees can be thought of as [hard spheres](https://en.wikipedia.org/wiki/Hard_spheres) (well, hard circles, since we are in two dimensions for this exercise). in fact, a simulation result from this exercise resembles a random snapshot of a hard sphere fluid when the number of particles, energy, and volume are fixed.

![image of trees](https://raw.githubusercontent.com/SimonEnsemble/data_science_course/master/2020/hw/hw1/tree_problem.png)
"

# ╔═╡ 48075776-028f-11eb-0fd4-370dff3b0f8d
md"1. define `R` as a variable that we will use in this problem, given that all pairs of trees must be further than a distance `R=5.0` apart."

# ╔═╡ 67f43268-028f-11eb-2e5e-8faa100a99c9


# ╔═╡ f1d75708-0288-11eb-263f-294cad147db5
md"2. construct a custom data structure for the plot of land, `Land`, that contains its length $L$ and width $W$."

# ╔═╡ ff9e1b92-0288-11eb-06d8-11c6e60c595d


# ╔═╡ 13ea3328-028f-11eb-2122-2f326ee27fbb
md"go ahead and construct the plot of land to use for this problem, `land` which has `L=100.0` and `W=50.0`."

# ╔═╡ 2e45f658-028f-11eb-2d6d-07c170bea82a


# ╔═╡ 0d52d028-0286-11eb-1d4e-9789e55c9671
md"3. construct a custom data structure for a tree, `Tree`, that contains its $x$- and $y$-position on the plot of land, with the origin in the lower left corner."

# ╔═╡ 0f3e6d9a-0289-11eb-3738-0373c20d7dff


# ╔═╡ 5deac108-028b-11eb-3aa1-65843c219c3c
md"
4. we'll need to determine whether any two trees are within a distance $2R$. 

* write a function `too_close(tree_i::Tree, tree_j::Tree, R::Float64)` that returns `true` if `tree_i` and `tree_j` are closer than `2R` and `false` otherwise.
* write a function `too_close(proposed_tree::Tree, planted_trees::Array{Tree, 1}, R::Float64)` that returns `true` if a proposed tree, `proposed_tree::Tree`, is too close to any of the previously planted trees, `planted_trees::Array{Tree, 1}` and `false` otherwise. it should call the function `too_close(tree_i::Tree, tree_j::Tree, R::Float64)` inside of it.

two functions with the same name that take in different types is a capability of Julia called _multiple dispatch_.

both of these function definitions must be within the same `begin ... end` block.
"

# ╔═╡ 070b7a98-028c-11eb-36bd-8d482e75cc5e
md"""
!!! hint
    test your function `too_close` by passing in two trees that are obviously too close, and passing in two trees that are obviously not close. e.g. the following code should return `true`: `too_close(Tree(0.0, 0.0), Tree(0.01, 0.02), 1.0)`. so should `too_close(Tree(0.0, 0.0), [Tree(0.01, 0.02)], 1.0)`.
"""

# ╔═╡ 88f0d3e2-028b-11eb-34b0-df315c0165dd


# ╔═╡ 414c3df0-028c-11eb-221b-bd990973bce7


# ╔═╡ 0447ff50-0289-11eb-232f-2b299e601c68
md"
5. write a function `plant_trees(R::Float64, nb_trees::Int, land::Land)` that returns an array of trees, `trees`, an `Array{Tree, 1}`, of length `nb_trees`.
* the position of each tree belongs to the plot of land, i.e. $0<x<L$ and $0<y<W$.
* the coordinate of the first tree is uniformly distributed over the land. the coordinate of tree $i$ is uniformly distributed over the subset of the land that is further than distance $2R$ from any of the other preceding $i-1$ trees that have been planted.

i.e., this is the function that we use to determine the coordinates of the trees for the plot of land that (i) appear natural (are random) and (ii) restrict any two trees from being too close.

of course, use your function `too_close` inside of `plant_trees`!
"

# ╔═╡ eadc244c-028a-11eb-3ecb-b377658b0adb
md"""
!!! hint
    use rejection sampling, where you insert each (proposed) tree at a uniform random position, but then reject that sampled position iff the tree is within a distance $2R$ of any of the other trees that have already been planted (accepted).
"""

# ╔═╡ e231e3d4-028a-11eb-33fb-4f67ab3ca129


# ╔═╡ 04db259e-0290-11eb-0e32-3137eec26e5d
md"
6. 🌳🌳🌳 let's plant trees! 🌳🌳🌳

call your function `plant_trees` to plant `nb_trees=30` trees on the land. assign the output to be `trees`.
"

# ╔═╡ 3e33a5be-0290-11eb-0f18-7758e3320559


# ╔═╡ 43d64aea-028f-11eb-1190-538f0c737bb9
md"
6. write a function `viz_trees(trees::Array{Tree, 1}, land::Land)` that:
* plots each tree as a green `x` marker
* shows the boundary of the `land` as a rectangle
* has a circle with dashed lines drawn around each tree

the aim of this function is to vizualize the proposed positions of the planted trees.

below is the output of my `viz_tree` function that you should aim to recreate.

![image of trees](https://raw.githubusercontent.com/SimonEnsemble/data_science_course/master/2020/hw/hw1/sim_tree_distn.png)
"

# ╔═╡ e0f82058-028f-11eb-1a5c-f9ce95100746
md"""
!!! hint
    matplotlib functions `scatter`, `plot`, `hlines`, and `vlines` will be useful. also, use `axis("equal")` to make sure the scales are the same on the x- and y-axis.
"""

# ╔═╡ e5ba19e8-0291-11eb-006d-8bea92ab126c
md"
you might find it helpful to first write a function `draw_circle(x::Float64, y::Float64, R::Float64)` to draw a circle of radius `R` around a point `(x,y)`."

# ╔═╡ ff021374-028c-11eb-0780-1d68f0728618


# ╔═╡ 29f5a24e-0292-11eb-188d-8faf65431df9
md"
🎈
now for the rewarding part:
call the function `viz_trees(trees, land)` and visualize your distribution of trees. if the distribution does not \"look\" random and any two circles are overlapping, then you must have done something wrong! call `gcf()` to get the current figure and display it in Pluto. 
"

# ╔═╡ 2f472bc6-0294-11eb-270f-f369ce3eb7ac


# ╔═╡ e10ab1d8-0290-11eb-2a9d-bf9a9e85762b
md"
7. now try to plant `100` trees on this `land`. don't wait too long, I think this function could go on forever! why doesn't the function ever stop running? trying to find the maximal amount of trees you can pack into the land is known as a [circle packing problem](https://en.wikipedia.org/wiki/Circle_packing)."

# ╔═╡ cf806762-0292-11eb-00be-5b0d3d106d30


# ╔═╡ 3f5b5dde-0294-11eb-244c-1de2093c6f46
md"A: "

# ╔═╡ Cell order:
# ╟─ecc0cb6c-027e-11eb-224b-81b62dbdd22a
# ╠═dfac0f06-0283-11eb-1e61-bdcfebc698d2
# ╠═cb380112-0290-11eb-2d54-1d2ebbf2db02
# ╟─47eaa4a4-0290-11eb-2f7e-8b0039ce49a1
# ╟─51be6bf2-0284-11eb-211b-8133496d70ce
# ╟─48075776-028f-11eb-0fd4-370dff3b0f8d
# ╠═67f43268-028f-11eb-2e5e-8faa100a99c9
# ╟─f1d75708-0288-11eb-263f-294cad147db5
# ╠═ff9e1b92-0288-11eb-06d8-11c6e60c595d
# ╟─13ea3328-028f-11eb-2122-2f326ee27fbb
# ╠═2e45f658-028f-11eb-2d6d-07c170bea82a
# ╟─0d52d028-0286-11eb-1d4e-9789e55c9671
# ╠═0f3e6d9a-0289-11eb-3738-0373c20d7dff
# ╟─5deac108-028b-11eb-3aa1-65843c219c3c
# ╟─070b7a98-028c-11eb-36bd-8d482e75cc5e
# ╠═88f0d3e2-028b-11eb-34b0-df315c0165dd
# ╠═414c3df0-028c-11eb-221b-bd990973bce7
# ╟─0447ff50-0289-11eb-232f-2b299e601c68
# ╟─eadc244c-028a-11eb-3ecb-b377658b0adb
# ╠═e231e3d4-028a-11eb-33fb-4f67ab3ca129
# ╟─04db259e-0290-11eb-0e32-3137eec26e5d
# ╠═3e33a5be-0290-11eb-0f18-7758e3320559
# ╟─43d64aea-028f-11eb-1190-538f0c737bb9
# ╟─e0f82058-028f-11eb-1a5c-f9ce95100746
# ╟─e5ba19e8-0291-11eb-006d-8bea92ab126c
# ╠═ff021374-028c-11eb-0780-1d68f0728618
# ╟─29f5a24e-0292-11eb-188d-8faf65431df9
# ╠═2f472bc6-0294-11eb-270f-f369ce3eb7ac
# ╟─e10ab1d8-0290-11eb-2a9d-bf9a9e85762b
# ╠═cf806762-0292-11eb-00be-5b0d3d106d30
# ╠═3f5b5dde-0294-11eb-244c-1de2093c6f46
