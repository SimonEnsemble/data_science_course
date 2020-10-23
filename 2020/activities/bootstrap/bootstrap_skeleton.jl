### A Pluto.jl notebook ###
# v0.12.4

using Markdown
using InteractiveUtils

# ╔═╡ eccd7a46-14dd-11eb-1c13-ef71de1f5f1f
using CSV, DataFrames, PyPlot, Statistics, StatsBase

# ╔═╡ 0ea33e4e-14de-11eb-2975-5d101d9c1008
md"
# estimation and confidence intervals

> An important part of data science consists of making conclusions based on the data in random samples. [source](https://www.inferentialthinking.com/chapters/10/Sampling_and_Empirical_Distributions.html)

🐸 read in the Iris data set in `iris.data` [[source](http://archive.ics.uci.edu/ml/datasets/Iris/)] as a `DataFrame`.
* each row represents an Iris flower.
* the `class` column indicates which class the Iris flower is: Setosa, Versicolour, or Virginica.
* the remaining columns give the sepal and petal lengths and widths of the flower.
"

# ╔═╡ 738474aa-14df-11eb-255f-d719c3089ed5
html"<center>
<img src=\"https://miro.medium.com/max/1216/0*rhP_m_pskOF_MUad\" width=500>
<br>
<img src=\"https://miro.medium.com/max/578/0*1lgB-Yqej6VPER00\" width=200>
</center?"

# ╔═╡ f9c0e1fc-14dd-11eb-1886-59eb872025d8


# ╔═╡ bafdfec6-14df-11eb-07ed-79856a162ab6
md"
🐸 we're only interested in the sepal length of Iris versicolors. delete all rows from your data frame except those that are versicolors.
"

# ╔═╡ 6f36364e-14de-11eb-16d4-37f19de4641c


# ╔═╡ 61df6518-14e0-11eb-10ea-a5a58833a9b4
md"
🐸 how many versicolor Irises are there in the data set?
"

# ╔═╡ 830091d8-14de-11eb-04bf-07249b2650a4


# ╔═╡ 74b165ec-14e0-11eb-3b90-89aefc514373
md"there are many more than 50 versicolors out there. this is just a _random sample_ of versicolors (well, let's assume these versicolors were randomly selected for sepal length measurements).

from this sample of 50, we want to make an inference about the sepal length of the _entire population_ of versicolors. 👀

> with high probability, the empirical distribution of a large random sample will resemble the distribution of the population from which the sample was drawn. [source](https://www.inferentialthinking.com/chapters/10/3/Empirical_Distribution_of_a_Statistic.html)

in practice, one takes a *random sample* from a population, as opposed to exhaustively sampling the entire population, because taking a measurement on the *entire* population is usually prohibitively expensive, time-consuming, and/or impractial.

in this context, we don't need to measure the sepal length of _every_ versicolor out there to get an idea of what a typical sepal length is.

🐸 visualize the empirical distribution of sepal lengths of versicolors with a histogram.

_empirical distribution_: the distribution of observed data, often visualized by a histogram
"

# ╔═╡ fff76802-14dd-11eb-3dcb-630c54eb3966


# ╔═╡ b098a1e8-14e1-11eb-37af-f51ff458342a
md"
(most likely) the empirical histogram above (from the random sample) resembles the distribution of sepal lengths of the entire population. this is what justifies making conclusions about a *population* from a *random sample* of it, i.e. this is what justifies *statistical inference*! 

of course, (i) the empirical distribution from the random sample is more likely to closely resemble the distribution of the population if the random sample is large and (ii) there is an uncertainty associated with conclusions based on the random sample, since there is a possibility that the empirical distribution of the random sample differs significantly from the distribution of the population--especially if the sample size is small.

**learning objective**:
* use the data from a random sample to *estimate* an unknown parameter of a population and quantify its uncertainty, through bootstrap

we'll estimate the mean sepal length of versicolors from this random sample and obtain a confidence interval via a powerful technique called bootstrapping [alternative resource here](https://www.inferentialthinking.com/chapters/13/2/Bootstrap.html).

> A statistic (note the singular!) is any number computed using the data in a sample. The sample mean, therefore, is a statistic. [source](https://www.inferentialthinking.com/chapters/10/3/Empirical_Distribution_of_a_Statistic.html#Statistic)

🐸 compute the sample mean of the sepal length of versicolors.
this is an estimator for the population mean.
"

# ╔═╡ de56b23c-14e2-11eb-25e1-e388a868e390


# ╔═╡ 14685382-14e3-11eb-2153-29a9bd426eed
md"
**important**: almost certainly, this sample mean differs from the (true) population mean. if we repeated the experiment and randomly sampled 50 versicolors again, we'd almost certainly get a different sample mean. thus, we can view the sample mean as a random variable, where the randomness comes from the process of randomly selecting the versicolors.

#### bootstrap interval estimate of the mean

to quantify uncertainty in our estimate of the population mean, we should address the question of how the sample mean would differ from random sample to random sample. 

we can approximate the empirical distribution of the sample mean via **bootstrapping**, a powerful method based on resampling. we can think of bootstrapping as approximately simulating the process of collecting a random sample from the population.

the main idea is that we can _simulate a random sample of the population by collecting a random sample from the sample_. 👀 
* this random sample of the sample must be the same size as the sample, since the number of samples affects the estimate
* this sampling must be done with replacement (otherwise, we'd get the sample back)

essentially, we are treating the random sample as the population and sampling from it. this is justified because the empirical distribution of the sample is likely to resemble the distribution of the population.

🐸 take 1500 bootstrap samples, compute the mean of each bootstrap sample, store it in an array, and visualize the distribution of the bootstrap mean. plot a vertical dashed line as the actual sample mean you computed above.

the result is the _bootstrap empirical distribution of the sample mean_ sepal length of versicolors. its spread quantifies the uncertainty in our estimated mean of the population. a wide spread implies that the sample mean (under the current sample size) varies dramatically from sample to sample (owing, e.g. to small sample size). 

!!! hint
    the `sample` function (see [docs](https://juliastats.org/StatsBase.jl/stable/sampling/#StatsBase.sample)) will be helpful.
"

# ╔═╡ 658a0214-14e4-11eb-3225-b1f690e3993b


# ╔═╡ 483ab8ba-14e5-11eb-28dc-a5f1c3f7f21b


# ╔═╡ ca01c91a-14e5-11eb-2e02-3bee646d2414
md"
instead of reporting our _point estimate_ of the sepal length of versicolors, as our sample mean, report an _interval estimate_ of the mean. this is defined to be the interval such that e.g., 95% of bootstrap sample means fall in this interval. 

more specifically, 2.5% of bootstrap sample means fall to the left of the interval, and 2.5% of bootstrap sample means fall to the right of the interval. 

🐸 compute the interval estimate of the mean of the sepal length of versicolors by computing the 2.5% percentile and 97.5% percentile of the list of bootstrap sample means.

!!! hint
    use the `percentile` function. see [docs](https://juliastats.org/StatsBase.jl/stable/scalarstats/#StatsBase.percentile)
"

# ╔═╡ 36d8f176-14e6-11eb-13fa-370a09e4f864


# ╔═╡ 533f3142-14e6-11eb-0946-7dca11462e78
md"
🐸 redraw the bootstrap empirical distribution of the sample mean but this time include a visualization of the interval.

!!! hint
    here is what I did:
    ```
    plot([μ_lo, μ_hi], [0, 0], color=\"C3\", lw=6, clip_on=false, zorder=100)
    ```
    but feel free to get creative, e.g. with the `fill_between` function (see [docs](https://matplotlib.org/3.1.1/api/_as_gen/matplotlib.pyplot.fill_between.html)).

"

# ╔═╡ 7ef2c324-14e6-11eb-23ee-3569ff389cb1


# ╔═╡ 375b15d6-14e6-11eb-18da-2bedd9945456
md"
so, if we were to randomly sample 50 versicolors over and over and compute the sample mean sepal length each time, essentially repeating the experiment, we estimate 95% of the sample means will fall inside the interval estimate.

we estimate that only 2.5% (2.5%) of the time will the sample mean fall to the left (right) of the interval estimate.

we thus refer to this interval as the 95% **confidence interval**. 

as a warning, bootstrap does not work very well when the sample size is small (e.g. less than 15) since then the empirical sample distribution is not likely to resemble the population distribution. but, otherwise, it is a very powerful and intuitive method for obtaining confidence intervals!

!!! warning
    do not rotely go through this notebook without understanding why are you are doing these procedures! I hope you will read [this](https://www.inferentialthinking.com/chapters/13/2/Bootstrap.html).
"

# ╔═╡ Cell order:
# ╠═eccd7a46-14dd-11eb-1c13-ef71de1f5f1f
# ╟─0ea33e4e-14de-11eb-2975-5d101d9c1008
# ╟─738474aa-14df-11eb-255f-d719c3089ed5
# ╠═f9c0e1fc-14dd-11eb-1886-59eb872025d8
# ╟─bafdfec6-14df-11eb-07ed-79856a162ab6
# ╠═6f36364e-14de-11eb-16d4-37f19de4641c
# ╟─61df6518-14e0-11eb-10ea-a5a58833a9b4
# ╠═830091d8-14de-11eb-04bf-07249b2650a4
# ╟─74b165ec-14e0-11eb-3b90-89aefc514373
# ╠═fff76802-14dd-11eb-3dcb-630c54eb3966
# ╟─b098a1e8-14e1-11eb-37af-f51ff458342a
# ╠═de56b23c-14e2-11eb-25e1-e388a868e390
# ╟─14685382-14e3-11eb-2153-29a9bd426eed
# ╠═658a0214-14e4-11eb-3225-b1f690e3993b
# ╠═483ab8ba-14e5-11eb-28dc-a5f1c3f7f21b
# ╟─ca01c91a-14e5-11eb-2e02-3bee646d2414
# ╠═36d8f176-14e6-11eb-13fa-370a09e4f864
# ╟─533f3142-14e6-11eb-0946-7dca11462e78
# ╠═7ef2c324-14e6-11eb-23ee-3569ff389cb1
# ╟─375b15d6-14e6-11eb-18da-2bedd9945456
