### A Pluto.jl notebook ###
# v0.12.3

using Markdown
using InteractiveUtils

# ╔═╡ 8e448b2c-0c2c-11eb-132e-352f88a62b9f
using CSV, DataFrames, PyPlot, Statistics, Random

# ╔═╡ b3896c22-0c2c-11eb-1973-8fcadcdd18c2
PyPlot.matplotlib.style.use("beavs.mplstyle")

# ╔═╡ ae5fdbf4-0c2d-11eb-32b8-15c794321a8c
md"
here is a [funny video](https://fivethirtyeight.com/features/not-even-scientists-can-easily-explain-p-values/) where scientists are asked to explain the p-value in one sentence. challenge yourself to explain a p-value in one sentence after going through this notebook!
"

# ╔═╡ 7b3a585c-0c2e-11eb-314f-33c382e53c1b
md"
# A/B testing

> In modern data analytics, deciding whether two numerical samples come from the same underlying distribution is called A/B testing. The name refers to the labels of the two samples, A and B. [source](https://www.inferentialthinking.com/chapters/12/1/AB_Testing.html)

background reading: [Computational and Inferential Thinking](https://www.inferentialthinking.com/chapters/12/1/AB_Testing.html), on which this notebook is heavily inspired.

consider a large population of cauliflower plants on a farm, all planted at the same time. 
"

# ╔═╡ a41432c0-0c2e-11eb-1ad1-a52d42aceed4
html"<img src=\"https://upload.wikimedia.org/wikipedia/commons/2/25/Cauliflower.JPG\" width=100><img src=\"https://upload.wikimedia.org/wikipedia/commons/2/25/Cauliflower.JPG\" width=100><img src=\"https://upload.wikimedia.org/wikipedia/commons/2/25/Cauliflower.JPG\" width=100><img src=\"https://upload.wikimedia.org/wikipedia/commons/2/25/Cauliflower.JPG\" width=100>
<img src=\"https://upload.wikimedia.org/wikipedia/commons/2/25/Cauliflower.JPG\" width=100>
<img src=\"https://upload.wikimedia.org/wikipedia/commons/2/25/Cauliflower.JPG\" width=100>"

# ╔═╡ bbde9436-0c2e-11eb-298c-ddd2b3cf4b5d
md"
_the two groups of cauli plants in this experiment_:
* in the _treatment group_, cauli plants on the farm were randomly selected to receive fertilizer
* in the _control group_, cauli plants were randomly selected to _not_ receive fertilizer

_the observation_:
at harvest, we measure the mass (in grams) of each cauliflower head in the two groups. 

_the goal_: determine if the distribution of masses of cauliflower heads in the treatment group differs from the distribution of masses in the control group.

_remark on causality_: the cauli's were randomly assigned to the control and treatment groups. thus, a different distribution of masses between the two groups is evidence that the fertilizer *caused* the mass distribution to be different in the treatment group than in the control group. 
in contrast, if this were an observational study, where we simply measured the mass of cauliflowers in multiple farms, some treated with fertilizer, some not, there could be confouding variables that explain differences in the distribution of masses. can you think of such a scenario?

!!! hint
    e.g. if farmers who used fertilizer tended to have less nutrients in the soil.
"

# ╔═╡ 533ba390-0c30-11eb-245e-1bf14fa54b91
md"
🐸 read in the data from this randomized controlled cauliflower study, `cauliflower.csv`. 

each row corresponds to a cauliflower plant. 

the `group` column indicates whether the cauliflower was in the control or treatment group, and the `mass` column indicates its mass in grams on harvest day.
"

# ╔═╡ f531ad34-0c30-11eb-0a02-8387fae3bfe9
begin
	df = CSV.read("cauliflower.csv", copycols=true)
	first(df, 6)
end

# ╔═╡ 3704e316-0c31-11eb-14ab-d3f2fe5d1a84
md"
🐸 how many cauliflowers are allocated to each group?

!!! tip
    use `by`.
"

# ╔═╡ 90b997d2-0c31-11eb-1451-05ee41e55d37
by(df, :group, nb_plants=:group=>length)

# ╔═╡ b2881d96-0c31-11eb-08ae-71f566a6dc9b
md"🐸 compare the distribution of masses among the two groups (control, treatment) by drawing a box plot (two boxes, one for cauli masses in the treatment group, one for in the control group)."

# ╔═╡ 7afff85c-0c32-11eb-2412-1d0e3268a75a
begin
	figure()
	boxplot([gp[:, :mass] for gp in groupby(df, :group)])
	ylabel("mass [g]")
	xticks([1, 2], [gp[1, :group] for gp in groupby(df, :group)])
	gcf()
end

# ╔═╡ 7ba24210-0c32-11eb-1f0e-5fef1ea16ade
md"
the mass of a cauli head in the fertilizer group tends (as measured by the median in the box plot) to be greater than those in the control group.

🐸 create a new `DataFrame` with the `mean` mass of cauli plants within each group using the `by` function. name the column `mean_mass`.

```
    group	mean_mass
	String	Float64
1	control	827.462
2	fertilizer	859.655
```
"

# ╔═╡ 835ee2aa-0c33-11eb-3aea-3da4b923ac9e
by(df, :group, mean_mass=:mass=>mean)

# ╔═╡ bafffaf0-0c33-11eb-1aca-8f40e2f26125
md"
🐸 which group has the highest mass of cauli heads?

discuss among your group: what can you conclude from this? be cautious!
"

# ╔═╡ fd601eb6-0c33-11eb-2615-19c27eab605d
md"

✏ _this difference in means could be due to chance, owing to the random process of allocating the cauliflowers to the control and treatment groups!_

!!! explanation
    we only have 20 cauliflowers in each group, a tiny subset of the entire population of cauliflowers on the farm. it could have happened by chance that e.g., the cauliflower seeds harboring genes for a greater mass happened to fall in the fertilizier group, or that more cauliflowers in the control group happened to be attacked by pests, etc. How confident are we that the difference in the distribution of masses between the control and treatment groups is not due to chance?

✏ to formalize, we have two possible hypotheses:

**null hypothesis**: in the population of cauliflower plants, the distribution of masses of the cauliflower heads is the same for cauliflower plants that receive fertilizer treatment as those that do not. the difference in the distributions we see above is due to chance.

**alternative hypothesis**: in the population of cauliflower plants, fertilized cauli heads tend to be heavier than unfertilized cauli heads. the difference in the means (a measure of central tendency) we see above is not due to chance.

✏ we now design a **test statistic**, which maps our data set to a single number, that would differ under the null and alternative hypothesis. 

let us choose the test statistic as the difference in means among the two groups:

*test statistic* := (mean mass of cauli heads in the fertilizer treatment group) - (mean mass of cauli heads in the control group)

✏ _the test statistic is a random variable_.

!!! explanation
    where does the randomness come from? if we could repeat the cauliflower experiment over and over, there would be different allocations of the cauliflower plants to the control and treatment groups and, consequently, different differences in the means from experiment to experiment. i.e. the test statistic varies from experiment to experiment because of the randomness of allocating the cauliflower plants (which harbor variation in genes, soil they are planted in, proximity to a tree, etc.) to the different groups.

through simulation, we will answer the question: if we were to repeat this randomized experiment, what is the probability that we would observe a test statistic as or more extreme than we did, given that the null hypothesis is true? 
Our approach is:
* compute the test statistic for our sample of data. conceptually, this observed test statistic is one of many possible values we could see if we were to repeat the same experiment over and over, each time randomly allocating cauliflowers to the treatment and control groups.
* simulate the repetition of this experiment (randomly re-allocating cauliflowers to treatment and control groups) assuming that the null hypothesis is true to obtain the distribution of the test statistic under the null hypothesis
* from this distribution of the test statistic under the null hypothesis, compute the probability that we would observe a test statistic equal to or more extreme than the test statistic we actually observed in the data, assuming that the null hypothesis is true. this is the **p-value**.

so if the *p-value* is 0.05, this tells us, if we could repeat this experiment many times, each time randomly allocating cauliflowers to the control and treatment groups, *and* if fertilizer treatment has *no* effect whatsover on the mass of the cauliflower, then in 5% of the experiments, we would see the difference in means of the masses as large as it is or larger.

so if the *p-value* is small, that means that it is unlikely that the difference in means we see is due only to the random allocation of the cauliflowers to the two groups. thus it must be likely that the difference in means is due to a different underlying distribution of masses among cauliflowers treated with fertilizier and those that are not.

> Null hypothesis testing is a reductio ad absurdum argument adapted to statistics. In essence, a claim is assumed valid if its counter-claim is improbable. - [Wikipedia](https://en.wikipedia.org/wiki/P-value)

🐸 write a function `μ_mass` that takes in as arguments:
* `df_cauli::DataFrame`: the cauli `DataFrame` from the experiment
* `group_col_name::Symbol`: the name of the column in `df_cauli` that contains the group names for `filter`ing (we will need capability this later)
* `which_group::String` the group (\"control\" or \"treatment\")
and returns the mean mass of cauliflowers falling in the group `which_group`.
"

# ╔═╡ f25fd298-0c35-11eb-3faf-57ff0c3e90f0
function μ_mass(df_cauli::DataFrame, group_col_name::Symbol, which_group::String)
	return mean(filter(row -> row[group_col_name] == which_group, df_cauli)[:, :mass])
end

# ╔═╡ 55af6ea2-0c37-11eb-040d-2fe6713d8c4b
md"
🐸 test your function and check it with your `by` output above.
"

# ╔═╡ 659e5044-0c37-11eb-3ebc-8f5280b1691c
μ_mass(df, :group, "control")

# ╔═╡ 770258c6-0c37-11eb-228f-1765cfb0e0d3
μ_mass(df, :group, "fertilizer")

# ╔═╡ 88681c1e-0c36-11eb-3d3b-11c3232afb22
md"
🐸 write a function `μ_treat_minus_μ_control` that takes in as arguments:
* `df_cauli::DataFrame`: the cauli `DataFrame` from the experiment
* `group_col_name::Symbol`: the name of the column in `df_cauli` that contains the group names for `filter`ing (we will need capability this later)
and returns the test statistic.

!!! tip
    inside, `μ_treat_minus_μ_control` should call your function `μ_mass` above.

again, test the function to ensure it works.
"

# ╔═╡ 25a0b568-0c37-11eb-2c82-7529f204b77e
function μ_treat_minus_μ_control(df_cauli::DataFrame, group_col_name::Symbol)
	return μ_mass(df_cauli, group_col_name, "fertilizer") - μ_mass(df_cauli, group_col_name, "control")
end

# ╔═╡ 26b295d4-0c37-11eb-24b7-431cdfa1cd72
μ_treat_minus_μ_control(df, :group)

# ╔═╡ deb31352-0c37-11eb-0f41-2f26aade9aa5
md"
**permuatation test**

*idea*: randomly permute the group labels to simulate the test statistic under the null hypothesis

how do we simulate a repetition of this random experiment and obtain its test statistic (= difference in mean masses between fertilized and control cauli's) under the null hypothesis?

*key insight*: under the null hypothesis, the mass of the cauliflower head is not affected by the treatment. so, during repititions of this random experiment, the masses of all 40 cauliflowers in our data set would be the same as we see in the current data, regardless of the group to which each cauliflower was (randomly) allocated. so, the group to which the cauliflower is allocated is totally inconsequential! therefore, _under the null hypothesis_, we can simulate a repitition of our random experiment by maintaining a list of 40 cauliflowers whose masses are the same as in the data, but with their group labels (control/fertilizer) randomly *permuted*.

🐸 simulate the repeated random experiment under the null hypothesis by making a new column `:shuffled_group` in your cauli data frame that denotes the group to which the cauliflower plant (with the same mass) is allocated in the _simulated_ repetition of the experiment. 

the `:mass` column remains the same since, under the null hypothesis, the mass of the cauliflower is not affected by fertilizer. the `:shuffled_group` should be a random permutation of the `:group` column in the original experiment.

!!! tip
    use the `shuffle` function (see [docs](https://docs.julialang.org/en/v1/stdlib/Random/#Random.shuffle))
"

# ╔═╡ 83209cb6-0c38-11eb-02cb-69362bd01773
df[:, :shuffled_group] = df[shuffle(1:nrow(df)), :group]

# ╔═╡ f80a19e2-0c38-11eb-10cb-ff18f4342b13
md"take a look at your data frame to compare the `:group` to `:shuffled_group` columns."

# ╔═╡ ef88516e-0c38-11eb-29a4-531cf1c6f67b
head(df)

# ╔═╡ 83a18108-0c38-11eb-32a9-57323e1332e7
md"
🐸 check that the test statistic is different in your simulation (unless we happen to assing the cauliflowers to the same group, which is very unlikely), using `μ_treat_minus_μ_control` you wrote above and your new group column name `:shuffled_group`.

!!! note
    this is why we included `group_col_name::Symbol` as an argument to `μ_mass`. it can compute the mean mass in the actual and shuffled groups.
"

# ╔═╡ ddea8210-0c38-11eb-0dbb-75c3617a5238
μ_treat_minus_μ_control(df, :shuffled_group)

# ╔═╡ 403a4694-0c39-11eb-08de-7137b36af24e
md"
**obtaining the distribution of the test statistic under the null hypothesis**

🐸 simulate repetitions of the random experiment under the null hypothesis 10000 times. in an array, store the test statistic (difference in means among the two groups) for each simulation. plot the distribution of the test statistic as a histogram. 

draw a vertical line via `axvline` to indicate where the *actual*, observed test statistic falls compared to the distribution of test statistics under the null hypothesis.

!!! hint
    just overwrite the `:shuffled_group` column in your cauli data frame inside a loop over simulations.
"

# ╔═╡ c619d874-0c39-11eb-25c3-f5ef94861962
begin
	nb_sims = 10000
	test_stats = zeros(nb_sims)
	for s = 1:nb_sims
		df[:, :shuffled_group] = df[shuffle(1:nrow(df)), :group]
		test_stats[s] = μ_treat_minus_μ_control(df, :shuffled_group)
	end
	test_stats
end

# ╔═╡ ca4adf74-0c39-11eb-0c21-47a437ad903b
actual_test_stat = μ_treat_minus_μ_control(df, :group)

# ╔═╡ ccab4484-0c39-11eb-12ef-b10f58408c6d
begin
	figure()
	xlabel("μ_fert - μ_cont")
	ylabel("# sims")
	hist(test_stats)
	axvline(x=actual_test_stat, color="C2", linestyle="--")
	gcf()
end

# ╔═╡ ce2e71aa-0c39-11eb-0dce-b1e265fee2a6
md"
🐸 is it a coincidence that the simulated distribution of the test statistic is centered around zero?

!!! tip
    no! explain why.

🐸 the **p-value** is the proportion of simulated experiments under the null hypothesis where the test statistic (difference in means) was equal to or greater than what we observed in the actual experiment. compute the p-value from your simulation. let this be a one-sided hypothesis test, where our alternative hypothesis is that the fertilized caulis tend to be heavier than unfertilized caulis.
"

# ╔═╡ 28011f70-0c3a-11eb-265f-533bb4e70edb
sum(test_stats .>= actual_test_stat) / nb_sims # the equal to is not important here, but it is when testing proportions (e.g. your hw) think about why.

# ╔═╡ 3fafe840-0c3a-11eb-1442-077b29f06e52
md"
you have used a powerful computational technique (a simulation!) to test a hypothesis called a **random permutation test**. in contrast to other _parametric_ methods for hypothesis testing, the random permutation test is _empirical_ and does not impose strict assumptions about the shape of the underlying distributions (e.g. Gaussian-ness).

the **level of statistical significance** $\alpha$ is a [subjective] quantity set by researchers before the study for how small the p-value has to be to reject their null hypothesis and declare the result *statistically significant*. often $\alpha := 0.05$. in other words, $\alpha$ is the probability that we would reject the null hypothesis, given that it is true. in this context, $\alpha$ is the probability that, from our data analysis, we would conclude that fertilizer treatment tends to increase the mass of cauliflower heads, yet the truth is that fertilizer has no effect on the mass of the cauliflower head.
"

# ╔═╡ 94e6fe20-0c3a-11eb-3de4-b13b24ab15b1
html"
<blockquote class=\"twitter-tweet\"><p lang=\"en\" dir=\"ltr\">FOUR CARDINAL RULES OF STATISTICS 📈📊📉<br><br>A thread <br><br>1/🧵</p>&mdash; Daniela Witten (@daniela_witten) <a href=\"https://twitter.com/daniela_witten/status/1312180955801505794?ref_src=twsrc%5Etfw\">October 3, 2020</a></blockquote> <script async src=\"https://platform.twitter.com/widgets.js\" charset=\"utf-8\"></script> 
"

# ╔═╡ Cell order:
# ╠═8e448b2c-0c2c-11eb-132e-352f88a62b9f
# ╠═b3896c22-0c2c-11eb-1973-8fcadcdd18c2
# ╟─ae5fdbf4-0c2d-11eb-32b8-15c794321a8c
# ╟─7b3a585c-0c2e-11eb-314f-33c382e53c1b
# ╟─a41432c0-0c2e-11eb-1ad1-a52d42aceed4
# ╟─bbde9436-0c2e-11eb-298c-ddd2b3cf4b5d
# ╟─533ba390-0c30-11eb-245e-1bf14fa54b91
# ╠═f531ad34-0c30-11eb-0a02-8387fae3bfe9
# ╟─3704e316-0c31-11eb-14ab-d3f2fe5d1a84
# ╠═90b997d2-0c31-11eb-1451-05ee41e55d37
# ╟─b2881d96-0c31-11eb-08ae-71f566a6dc9b
# ╠═7afff85c-0c32-11eb-2412-1d0e3268a75a
# ╟─7ba24210-0c32-11eb-1f0e-5fef1ea16ade
# ╠═835ee2aa-0c33-11eb-3aea-3da4b923ac9e
# ╟─bafffaf0-0c33-11eb-1aca-8f40e2f26125
# ╟─fd601eb6-0c33-11eb-2615-19c27eab605d
# ╠═f25fd298-0c35-11eb-3faf-57ff0c3e90f0
# ╟─55af6ea2-0c37-11eb-040d-2fe6713d8c4b
# ╠═659e5044-0c37-11eb-3ebc-8f5280b1691c
# ╠═770258c6-0c37-11eb-228f-1765cfb0e0d3
# ╟─88681c1e-0c36-11eb-3d3b-11c3232afb22
# ╠═25a0b568-0c37-11eb-2c82-7529f204b77e
# ╠═26b295d4-0c37-11eb-24b7-431cdfa1cd72
# ╟─deb31352-0c37-11eb-0f41-2f26aade9aa5
# ╠═83209cb6-0c38-11eb-02cb-69362bd01773
# ╟─f80a19e2-0c38-11eb-10cb-ff18f4342b13
# ╠═ef88516e-0c38-11eb-29a4-531cf1c6f67b
# ╟─83a18108-0c38-11eb-32a9-57323e1332e7
# ╠═ddea8210-0c38-11eb-0dbb-75c3617a5238
# ╟─403a4694-0c39-11eb-08de-7137b36af24e
# ╠═c619d874-0c39-11eb-25c3-f5ef94861962
# ╠═ca4adf74-0c39-11eb-0c21-47a437ad903b
# ╠═ccab4484-0c39-11eb-12ef-b10f58408c6d
# ╟─ce2e71aa-0c39-11eb-0dce-b1e265fee2a6
# ╠═28011f70-0c3a-11eb-265f-533bb4e70edb
# ╟─3fafe840-0c3a-11eb-1442-077b29f06e52
# ╟─94e6fe20-0c3a-11eb-3de4-b13b24ab15b1
