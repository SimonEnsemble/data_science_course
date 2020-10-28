### A Pluto.jl notebook ###
# v0.12.4

using Markdown
using InteractiveUtils

# ╔═╡ d1d038ec-171b-11eb-3b0b-696b15e1098f
using CSV, DataFrames, PyPlot, Statistics, StatsBase

# ╔═╡ a01c3e64-1715-11eb-3079-fd1d7aaa093c
md"
# counting
"

# ╔═╡ f83e1662-1715-11eb-2b0b-47661759ae8b
md"
🐸 explain why the answer to the below problem is incorrect, and provide the correct answer. without doing any calculations, does the incorrect answer over- or under-estimate the true number of possible allocations?

_problem statement_: (allocating resources) the state has seven ongoing forest fires (distinguishable, of course), but only five (indstinguishable) firefighting helicopters. how many distinct ways can the helicopters be allocated to fight the list of fires? it is possible for any given fire to receive 0, 1, 2, ... 5 helicopters.

_[incorrect] solution_: this is sampling with replacement. the first helicopter samples a forest fire with replacment. there are seven possible fires it can be assigned to. the second helicopter then selects seven possible fires, and so on. therefore, there are $7\cdot 7 \cdots 7=7^5$ distinct allocations of helicopters to the fires.
"

# ╔═╡ 3428342e-171d-11eb-01a9-ddf8a3405c78
md"
[your answer here...]
"

# ╔═╡ e2ae5e56-1715-11eb-2673-ed35c4f0effd
md"
# bootstrap confidence intervals

👀 read the [data8 textbook](https://www.inferentialthinking.com/chapters/13/3/Confidence_Intervals.html) for more on bootstrapping and its limitations.
"

# ╔═╡ 3cd29d8c-1725-11eb-2686-790cdd7df4ab
plt.style.use("https://github.com/dhaitz/matplotlib-stylesheets/raw/master/pitayasmoothie-light.mplstyle")

# ╔═╡ dd70fcf0-1718-11eb-3c0f-ad070d725934
md"
our goal is to compute bootstrap confidence intervals of the proportion of poisonous mushrooms in the woods with different odors.

!!! tip
    bootstrapping on proportions works the same way as for bootstrapping on means, just that you compute the proportion after resampling instead of the mean. see [here](https://www.inferentialthinking.com/chapters/13/3/Confidence_Intervals.html).

the file `mushrooms.csv` has data on a random sample of mushrooms. each row represents a different mushroom that was sampled. the three columns are the attributes of the mushrooms:
* `:class` column: edible=e, poisonous=p
* `:odor` column: almond=a, anise=l, creosote=c, fishy=y, foul=f, musty=m, none=n, pungent=p, spicy=s
* `:habitat` column: grasses=g, leaves=l, meadows=m, paths=p, urban=u, waste=w, woods=d

🍄 read in `mushrooms.csv` as a data frame.
"

# ╔═╡ d71b95a8-171b-11eb-370d-c558237e8589


# ╔═╡ 44530ae6-171e-11eb-1a08-cdefe3a713a7
md"
🍄 remove all mushrooms from the data frame, except those that (i) are poisonous and (ii) are from the woods.
"

# ╔═╡ 083d835c-171d-11eb-33ef-cf6eece36471


# ╔═╡ adcad06e-171e-11eb-08a3-531a2e7c9608
md"
🍄 how many mushrooms remain?
"

# ╔═╡ b6aad652-171e-11eb-1e2d-0dfb5aa0a3bf


# ╔═╡ 7296bdbe-171c-11eb-24df-197e7757fa25
md"
🍄 create a function `proportion_odor(df::DataFrame, odor::String)` that takes as input the mushroom data frame and returns the proportion of these mushrooms that are odor `odor`. an example use is:

`proportion_odor(df, \"m\") # 0.028` 
"

# ╔═╡ 1745c352-1720-11eb-1588-b1b996f10863


# ╔═╡ 026d94b0-171f-11eb-276b-93816fc182a0
md"🍄 test your function by computing the proportion of poisonous mushrooms in the woods that are musty odor."

# ╔═╡ 4ac4644a-1720-11eb-26f0-9b13e69a3ebb


# ╔═╡ 74bcc1be-171f-11eb-3d10-15dcefc8f968
md"
🍄 create a function `bootstrap_sample(df::DataFrame)` that returns a bootstrap sample of the mushrooms (in the form of a `DataFrame`). essentially, this function mimics going out into the woods, randomly selecting poisonous mushrooms, and smelling them.

!!! hint
    there are two essential components that a _bootstrap sample_ must satisfy:
    * same size as original sample
    * sample with replacement
"

# ╔═╡ baf98df4-171f-11eb-085b-3723963a7895


# ╔═╡ a6b6c342-1720-11eb-1217-4548ce622fac
md"
🍄 test your function by taking a bootstrap sample, and computing the proportion that are musty. unless you got really unlucky, the proportion should be different in your bootstrap sample. also, the proportion should generally change each time you run it, since you would then be selecting a different bootstrap sample. 
"

# ╔═╡ fcb907be-1720-11eb-0c0c-2530521d5da3


# ╔═╡ 141299f2-1721-11eb-0b45-971fd21ded29
md"
🍄 use 10,000 bootstrap samples to compute the bootstrap empirical distribution of the proportion of poisonous mushrooms in the woods that are of odor creosote=c, fishy=y, foul=f, musty=m, none=n, or spicy=s.

I recommend a box plot with six boxes, one for each odor.

!!! hint
    `for` loop over odors, `for` loop over bootstrap samples. store results in an array of arrays that you can feed to `boxplot`.
"

# ╔═╡ 11d529cc-1722-11eb-3756-8d2b04d1d64f


# ╔═╡ e00681b0-1722-11eb-2edd-cd656b4a5d78


# ╔═╡ f6e0f202-171b-11eb-2c47-536616d5f3ab
md"
🍄 compute the 95% bootstrap confidence interval for the proportion of poisonous mushrooms in the woods that are of each odor.

present your results as a bar plot, where each bar is the proportion of mushrooms, with an error bar that indicates the confidence interval. this is your final product.

you've quantified the uncertainty in the proportion of poisonous mushrooms in the woods that are of different odors, where the uncertainy comes from the random sampling of the mushrooms, as opposed to smelling all the mushrooms out there!
"

# ╔═╡ f3aec840-1723-11eb-0356-495db17679e1


# ╔═╡ 8893931e-1724-11eb-13bf-51fcec4dc9ed


# ╔═╡ 200ca70e-1724-11eb-2f5c-aff60ab4e675


# ╔═╡ Cell order:
# ╟─a01c3e64-1715-11eb-3079-fd1d7aaa093c
# ╟─f83e1662-1715-11eb-2b0b-47661759ae8b
# ╠═3428342e-171d-11eb-01a9-ddf8a3405c78
# ╟─e2ae5e56-1715-11eb-2673-ed35c4f0effd
# ╠═d1d038ec-171b-11eb-3b0b-696b15e1098f
# ╠═3cd29d8c-1725-11eb-2686-790cdd7df4ab
# ╟─dd70fcf0-1718-11eb-3c0f-ad070d725934
# ╠═d71b95a8-171b-11eb-370d-c558237e8589
# ╟─44530ae6-171e-11eb-1a08-cdefe3a713a7
# ╠═083d835c-171d-11eb-33ef-cf6eece36471
# ╟─adcad06e-171e-11eb-08a3-531a2e7c9608
# ╠═b6aad652-171e-11eb-1e2d-0dfb5aa0a3bf
# ╟─7296bdbe-171c-11eb-24df-197e7757fa25
# ╠═1745c352-1720-11eb-1588-b1b996f10863
# ╟─026d94b0-171f-11eb-276b-93816fc182a0
# ╠═4ac4644a-1720-11eb-26f0-9b13e69a3ebb
# ╟─74bcc1be-171f-11eb-3d10-15dcefc8f968
# ╠═baf98df4-171f-11eb-085b-3723963a7895
# ╟─a6b6c342-1720-11eb-1217-4548ce622fac
# ╠═fcb907be-1720-11eb-0c0c-2530521d5da3
# ╟─141299f2-1721-11eb-0b45-971fd21ded29
# ╠═11d529cc-1722-11eb-3756-8d2b04d1d64f
# ╠═e00681b0-1722-11eb-2edd-cd656b4a5d78
# ╟─f6e0f202-171b-11eb-2c47-536616d5f3ab
# ╠═f3aec840-1723-11eb-0356-495db17679e1
# ╠═8893931e-1724-11eb-13bf-51fcec4dc9ed
# ╠═200ca70e-1724-11eb-2f5c-aff60ab4e675
