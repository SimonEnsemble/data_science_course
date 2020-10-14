### A Pluto.jl notebook ###
# v0.12.3

using Markdown
using InteractiveUtils

# ╔═╡ 96a40376-0e39-11eb-1898-2dc6106f6b8b
using DataFrames, CSV, PyPlot, Random

# ╔═╡ c0680ed8-0e36-11eb-11fb-f18d31acff70
my_name = "Oslo 🐶"

# ╔═╡ 8dd3c444-0e36-11eb-1ea4-557fcf1612ff
md"
# hw3: A/B testing (permutation tests)

background reading:
* [A/B tests](https://www.inferentialthinking.com/chapters/12/1/AB_Testing.html)
* [causality](https://www.inferentialthinking.com/chapters/12/3/Causality.html)

learning objectives:
* formulate competing hypotheses
* conduct A/B tests via simulation (resampling / permutation tests)
* explain and interpret p-values

_name_: $my_name
"

# ╔═╡ a32ca600-0e39-11eb-32c3-710b5ac87a02
PyPlot.matplotlib.style.use("seaborn-bright")

# ╔═╡ 5b6651ce-0e37-11eb-2b5a-c3f876485e83
md"

**modifying the Cavendish banana to make it more resistant to Panama disease**

the Cavendish [banana is threatened](https://www.theguardian.com/science/2018/aug/05/science-search-for-a-super-banana-panama-disease-gm-gene-editing) by Panama disease, which is caused by a fungus. if you are really interested in this problem, see [this YouTube video](https://www.youtube.com/watch?v=YkI3zkQ4WBo&t). 
an active area of research is to genetically modify the Cavendish banana plant to make it resistant to Panama disease.
"

# ╔═╡ 8bba3142-0e37-11eb-38ce-65b83ee32067
html"<img src=https://upload.wikimedia.org/wikipedia/commons/thumb/9/9b/Cavendish_Banana_DS.jpg/1920px-Cavendish_Banana_DS.jpg width=200>"

# ╔═╡ 94a9d69a-0e37-11eb-1828-adf49aa45893
md"
**an experimental setup to determine if gene editing provides resistence to Panama disease**

we have identified a gene in the banana plant, gene X, that is thought to be associated with resistance to fungal infection. using modern gene editing tools such as CRISPR, we are able to make a precise, single-nucleotide edit to gene X that appears in the wild. the hope is that this single nucleotide polymorphism will confer protection against fungal infection. 

we perform a randomized, controlled experiment to test whether this mutation of gene X confers greater resistance to Panama disease, or not.
* control group: 30 randomly selected banana plants (gene X wild type)
* treatment group: 30 randomly selected banana plants with gene X genetically modified.
none of these banana plants have been exposed to the fungus that causes Panama disease.

we then expose each plant in the experiment to the fungus that causes Panama disease. the plants are all contained in a single greenhouse. after one year, we record whether or not each grown banana plant is infected with Panama disease. the study is \"blind\" because the caretakers of the plants were never told which plants are genetically modified and which are not. this minimizes the chances that the caretakers (advertently or inadvertently) treat the two different variants of plants differently and thereby bias the outcome of the experiment.

🐸 the results of our randomized experiment are in `banana_study.csv`. each row represents a banana plant. the `:gene_x` attribute indicates whether gene X in the banana plant is the wild type or mutant. the `:outcome` attribute indicates the outcome of the experiment (infected or not infected). read in `banana_study.csv` as a `DataFrame`, `df`.
"

# ╔═╡ 7c557912-0e39-11eb-1fb9-a70ddb2de7b4


# ╔═╡ 11f17eb2-0e3a-11eb-0f12-9fbbcb70332b
md"
🐸 use the `by` command to group the banana plants in `df` by genetic variant and create a new `DataFrame`, `df_outcome`, with a new column, named `p_infected`, that contains the proportion of plants of that variant that are infected by the fungus.

i.e. create a dataframe, `df_outcome`:
```
     gene_x      p_infected
    wild type       ...
     mutant         ...
```
"

# ╔═╡ 2b4e1258-0e3a-11eb-3d68-554a7486c259


# ╔═╡ 4814fe24-0e3a-11eb-0ce5-8793afbab239
md"
🐸 create a data visualization of `df_outcome` above. 

particularly, make a bar plot with two bars, one corresponding to wild type, the other to mutant. make the bar heights equal to the respective proportion of banana plants of that genetic variant that were infected by the fungus. with a different color, stack a bar *on top* of these bars to represent the proportion that were not infected. the total height of each bar (sum of the two bars of different colors, stacked on top of each other) should be 1.0 to represent the entire set of bananas falling in that group. properly label your x-axis, y-axis, and x-ticks, and place a legend to denote the colors.


!!! hint
    see matplotlib docs [here](https://matplotlib.org/3.1.1/gallery/lines_bars_and_markers/bar_stacked.html). pay attn to the `bottom` kwarg.
"

# ╔═╡ c3c5c224-0e3a-11eb-0150-d96fbd4db956


# ╔═╡ e742d58e-0e53-11eb-38c9-7956a9f123d1
md"
🐸 which genetic variant (wild type vs. mutated) has the smallest proportion of infected plants? 

why, then can't we conclude that this genetic variant is **certainly** more resistant to Panama disease than the other?
"

# ╔═╡ e6f6f89e-0e53-11eb-3e61-3b8ab3e61a20
md"

b/c...

"

# ╔═╡ 1f7f9ff4-0e54-11eb-0f1e-7909d4d9461c
md"🐸 formulate a null hypothesis and an alternative hypothesis that pertains to this experiment. state it below.

among the population of banana plants exposed to the fungus that causes Panama disease:
"

# ╔═╡ 5a362726-0e54-11eb-32c0-cf0e21babba0
md"
_null hypothesis_: ...

_alternative hypothesis_: ...
"

# ╔═╡ 66504e7e-0e54-11eb-2f1e-dd6b1841e2d3
md"
🐸 define a test statistic that would differ depending on whether the null or alternative hypothesis were true. write your definition of the test statistic below.

!!! hint
    a difference in proportions
"

# ╔═╡ b247bd58-0e54-11eb-1388-eb9db4242ab2
md"
_test statistic_:= ...

"

# ╔═╡ bd0e1900-0e54-11eb-36b7-1f30224eaf0f
md"🐸 write a function `proportion_infected` that takes in three arguments:
* `df_banana::DataFrame`: each row represents a 🍌 plant. has a column indicating which variant of gene X (\"wild type\" or \"mutant\") that plant harbors. also has an `:outcome` column (\"infected\" or \"not infected\"). your `df` will be passed in as this argument.
* `gene_x_col_name::Symbol`: the name of the column in `df_banana` that indicates which gene X variant the plants harbor (\"wild type\" or \"mutant\"). so `df_banana[1, gene_x_col_name]` gives us the gene X variant of banana 1.
* `gene_x::String`: either \"wild type\" or \"mutant\"
and returns the proportion of banana plants harboring `gene_x` (`=\"wild type\"` or `=\"mutant\"`) gene X that were infected by the fungus.
"

# ╔═╡ f38c766e-0e56-11eb-3d94-95d4607bb78f


# ╔═╡ f4124710-0e56-11eb-1e43-215ae7cf4b15
md"🐸 test your function `proportion_infected` on the two different groups of plants."

# ╔═╡ 186fdb18-0e57-11eb-193f-fbb753faa244


# ╔═╡ 18fd84e0-0e57-11eb-36a6-c72f5f1db6a6


# ╔═╡ 19e4df3e-0e57-11eb-34b1-496c40474b94
md"
🐸 write a function `difference_in_proportions_infected` that takes in two arguments:
* `df_banana::DataFrame` as above
* `gene_x_col_name::Symbol` as above
and returns the test statistic. 

!!! tip
    inside this function, call `proportion_infected` twice
"

# ╔═╡ 6523fe3a-0e57-11eb-08a7-dfc38a3df774


# ╔═╡ a13b76c8-0e57-11eb-07af-770597bed043
md"
🐸 using `difference_in_proportions_infected`, compute the actual, observed (as opposed to simulated under the null hypothesis, which we will do next) test statistic of our experimental outcome in `banana_study.csv` by passing in `df` as `df_banana` and `:gene_x` as `gene_x_col_name`. assign it to a variable to use later.
"

# ╔═╡ e55a31dc-0e57-11eb-182d-9f02479717d3


# ╔═╡ e7472eb4-0e57-11eb-228a-51705eeccbff
md"🐸 imagine we are at the beginning of the experiment where we selected 60 banana plants. at this point, we are randomly selecting which banana plants receive the genetic modification on gene X and which do not. now, simulate one repetition of the banana study, _operating under the assumption that the null hypothesis is true_, by permuting the labels in the `gene_x` column of `df`. this effectively simulates the random allocation of healthy banana plants to the two groups:
* group A: do not receive genetic modification on gene X (wild type)
* group B: receive genetic modification on gene X (mutant)

in this conceptual experiment, the outcome (infected vs. not) would be exactly the same _if the null hypothesis were true_, since then the genetic modification makes no difference in susceptibility to fungal infection. assign the permuted labels to be a new column in `df` called `:shuffled_gene_x`.
"

# ╔═╡ 0938881a-0e58-11eb-2df7-b5a2227ca1a5


# ╔═╡ f72ccbbe-0e58-11eb-143e-09c728ac7abd
md"🐸 _operating under the assumption that the null hypothesis is true_:

(a) simulate 10,000 repetitions of the randomized banana experiment. keep track of the test statistic observed from each simulation by storing each test statistic in an array.

(b) plot the distribution of the test statistic. make your bins for the histogram manually to ensure the bin that includes zero is centered at zero. draw a red, vertical line at the actual test statistic observed in the experiment. the mean value of the test statistic should be around zero. make sure you understand why.

(c) compute the p-value associated with our null hypothesis that you obtained from your _random permutation test_."

# ╔═╡ 1438de8a-0e59-11eb-2bff-effebb5c898b


# ╔═╡ 4c5d30c2-0e59-11eb-3987-3bc356bb1f66


# ╔═╡ 5b2e1530-0e59-11eb-055a-e38373f7005d


# ╔═╡ 1573d0fc-0e59-11eb-14de-0710879b5f16
md"🐸 explain what the the p-value represents."

# ╔═╡ 28b13f36-0e59-11eb-215a-6b7f4198ec0b
md"the p-value is ..."

# ╔═╡ 66ca616c-0e59-11eb-30e1-132f15afa55d
md"
🐸 if the level of significance is set at $\alpha=0.05$, you may have the tendency to make a bold conclusion, such as \"mutating gene X confers resistance to fungal infection\" or \"mutating gene X does not influence the susceptibility to fungal infection\". however, such \"dichotomization\" is a mis-interpretation of the p-value. we must embrace uncertainty! see [this recent article in Nature](https://www.nature.com/articles/d41586-019-00857-9) where, owing to the tendency to misinterpret p-values, some scientists call for abandoning the notion of statistical significance. When you've read the article, change the `Bool` below to `true`, and question (9) is complete! morever, statistical significance does not imply the effect is large!

> \"We are calling for a stop to the use of P values in the conventional, dichotomous way -- to decide whether a result refutes or supports a scientific hypothesis\" [source](https://www.nature.com/articles/d41586-019-00857-9)
"

# ╔═╡ 8e0babd4-0e59-11eb-0c9a-d9b5d4c6eab0
i_read_the_nature_article = false

# ╔═╡ b2142f74-0e59-11eb-19e9-258bedc028e6
if ! i_read_the_nature_article
    md"
!!! danger \"read the article!\"
    "
else
    md"
!!! correct \"you're done!\"
    "
end


# ╔═╡ Cell order:
# ╟─8dd3c444-0e36-11eb-1ea4-557fcf1612ff
# ╠═c0680ed8-0e36-11eb-11fb-f18d31acff70
# ╠═96a40376-0e39-11eb-1898-2dc6106f6b8b
# ╠═a32ca600-0e39-11eb-32c3-710b5ac87a02
# ╟─5b6651ce-0e37-11eb-2b5a-c3f876485e83
# ╟─8bba3142-0e37-11eb-38ce-65b83ee32067
# ╟─94a9d69a-0e37-11eb-1828-adf49aa45893
# ╠═7c557912-0e39-11eb-1fb9-a70ddb2de7b4
# ╟─11f17eb2-0e3a-11eb-0f12-9fbbcb70332b
# ╠═2b4e1258-0e3a-11eb-3d68-554a7486c259
# ╟─4814fe24-0e3a-11eb-0ce5-8793afbab239
# ╠═c3c5c224-0e3a-11eb-0150-d96fbd4db956
# ╟─e742d58e-0e53-11eb-38c9-7956a9f123d1
# ╠═e6f6f89e-0e53-11eb-3e61-3b8ab3e61a20
# ╟─1f7f9ff4-0e54-11eb-0f1e-7909d4d9461c
# ╠═5a362726-0e54-11eb-32c0-cf0e21babba0
# ╟─66504e7e-0e54-11eb-2f1e-dd6b1841e2d3
# ╠═b247bd58-0e54-11eb-1388-eb9db4242ab2
# ╟─bd0e1900-0e54-11eb-36b7-1f30224eaf0f
# ╠═f38c766e-0e56-11eb-3d94-95d4607bb78f
# ╟─f4124710-0e56-11eb-1e43-215ae7cf4b15
# ╠═186fdb18-0e57-11eb-193f-fbb753faa244
# ╠═18fd84e0-0e57-11eb-36a6-c72f5f1db6a6
# ╟─19e4df3e-0e57-11eb-34b1-496c40474b94
# ╠═6523fe3a-0e57-11eb-08a7-dfc38a3df774
# ╟─a13b76c8-0e57-11eb-07af-770597bed043
# ╠═e55a31dc-0e57-11eb-182d-9f02479717d3
# ╟─e7472eb4-0e57-11eb-228a-51705eeccbff
# ╠═0938881a-0e58-11eb-2df7-b5a2227ca1a5
# ╟─f72ccbbe-0e58-11eb-143e-09c728ac7abd
# ╠═1438de8a-0e59-11eb-2bff-effebb5c898b
# ╠═4c5d30c2-0e59-11eb-3987-3bc356bb1f66
# ╠═5b2e1530-0e59-11eb-055a-e38373f7005d
# ╟─1573d0fc-0e59-11eb-14de-0710879b5f16
# ╠═28b13f36-0e59-11eb-215a-6b7f4198ec0b
# ╟─66ca616c-0e59-11eb-30e1-132f15afa55d
# ╟─b2142f74-0e59-11eb-19e9-258bedc028e6
# ╠═8e0babd4-0e59-11eb-0c9a-d9b5d4c6eab0
