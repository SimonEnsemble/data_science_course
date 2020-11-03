### A Pluto.jl notebook ###
# v0.12.6

using Markdown
using InteractiveUtils

# ╔═╡ 02c897b8-1d94-11eb-072a-b194b6cbe30e
using StatsBase, Random, Statistics, PyPlot

# ╔═╡ e20257fe-1d8d-11eb-18e1-f5daed82d16a
md"
# hw 5: estimation

learning objectives:
* solidify \"what is an estimator\"
* evaluate the effectiveness of an estimator through simulation
* understand the notion of unbiasedness, consistency, and efficiency of an estimator and evaluate these qualities through simulation

### capture, mark, release, recapture

in ecology, one wishes to estimate the size of a population (e.g. of bees). it is too costly and impractical to count *every* member of a population (e.g., count all of the bees). instead, ecologists resort to a capture, mark, release, and recapture strategy. check out the [Wikipedia page](https://en.wikipedia.org/wiki/Mark_and_recapture).

let's take bees as an example. the idea is to:
1. *capture* a random sample of $k$ bees from the population (without replacement)
2. *mark*/tag each captured bee
3. *release* the marked bees back into the population
4. *recapture* a sample of $k_r$ bees from the population (without replacement)
5. count the number of marked bees, $m$, in the recaptured sample
from $k$, $k_r$, and $m$, we can estimate $n$, the total number of bees comprising the population.

let's assume:
* when the captured and marked bees are released back into the wild, they randomly (homogenously) mix with the rest of the (unmarked) bees before we recapture
* the time between capture/mark/release and recapture/count is short enough to neglect deaths, births, and migration out of the population
* marked and unmarked bees are equally likely to be captured in the recapturing phase

##### Lincoln-Petersen estimator
an intuitive estimator is found by imposing that the proportion found marked in the recaptured sample is equal to the proportion of the population that was captured/marked/released in the first phase.

\begin{equation}
\frac{k}{n}=\frac{m}{k_r}
\end{equation}

the quantity $k/n$ is the fraction of the population that you marked (unknown) and $m/k_r$ is the fraction that are marked in the recapture sample (known). we set these two proportions equal because, on average, we might expect the fraction marked in the population (after release) to be equal to the fraction marked in our sample. after all, the recaptured sample should be representative of the population! makes sense, right?  

this gives the Lincoln-Petersen estimator for the population size, $n$:
\begin{equation}
\hat{n} = \frac{k k_r}{m}
\end{equation}

##### Chapmen estimator
Chapmen derived a different estimator that we will compare to the Lincoln-Petersen estimator below.
\begin{equation}
\hat{n} = \frac{(k + 1) (k_r +1)}{m+1} - 1
\end{equation}

🐝 create a mutable data structure `Bee` that represents a bee in the population. it should have a single attribute, `marked`, that indicates whether it has been marked or not.

!!! hint
    what is the optimal data type to use for `marked`? make sure it is `mutable`, so we can later change the `marked` attribute to `true` if we mark it 😃
"

# ╔═╡ 286994ce-1d92-11eb-272f-a99fe23b243f


# ╔═╡ 2d85ff6a-1d92-11eb-2049-3dc3bc36650f
md"
🐝 write a function `initialize_bee_population` that takes as input a single argument `n::Int`, the number of bees in the population, and returns an array of bees `Array{Bee, 1}` that are all unmarked.
"

# ╔═╡ a1402548-1d92-11eb-3eaa-b930162e42db


# ╔═╡ ab9e90b0-1d92-11eb-22e7-99a0dcc994f9
md"
🐝 write a function `nb_marked` that takes in a population of bees, `bees::Array{Bee}` and returns the number of these bees that are marked.

```julia
bees = initialize_bee_population(500)
nb_marked(bees) # should return zero
```
"

# ╔═╡ f7231e16-1d92-11eb-2744-173ba6d3bf27


# ╔═╡ 2853da36-1d93-11eb-1aea-2fb0e95ce2cd
md"
🐝 write a function `capture_mark_release!` that takes in two arguments:
* `bees::Array{Bee}` the population of bees
* `k::Int` the number of bees to randomly capture (select without replacement), mark, and release
and modifies the `marked` attribute of `k` randomly selected bees in `bees` to denote that they have been marked.

!!! hint
    the function has an `!` because the `bees` array is modified inside the function. so the function doesn't need to return anything. it takes action on the array `bees` that is passed to it.

```julia
bees = initialize_bee_population(50)
capture_mark_release!(bees, 25)
nb_marked(bees) # should return 25
```
"

# ╔═╡ e72f87e4-1d93-11eb-27ba-f718310d206a


# ╔═╡ 564cab7c-1d94-11eb-3b0d-93cba33b2619
md"
🐝 write a function `recapture` that takes in two arguments:
* `bees::Array{Bee}`: an array of bees, some marked.
* `kᵣ::Int`: the number of bees to recapture
and returns a random sample (without replacement) of `nb_recapture` bees from `bees` in the form of an `Array{Bee}`.

```julia
bees = initialize_bee_population(50)
capture_mark_release!(bees, 25)
recaptured_bees = recapture(bees, 20) # should return Array{Bee} with 20 elements, ≈ 10 marked
```
"

# ╔═╡ 8340fb14-1df9-11eb-29d9-23d7f09748c8


# ╔═╡ d4c3e618-1df9-11eb-30c5-c75f5a28b535
md"
🐝 write two functions, one for each estimator:
* `lincoln_petersen_estimator`
* `chapman_estimator`

that each take in the three arguments:
* `k::Int`: # bees initially marked and released into the wild
* `kᵣ::Int`: # of bees recaptured
* `m::Int`: # of bees in recaptured sample that are marked
and returns the respective estimate $\hat{n}$ of the number of bees (see above for formulas).

!!! warning
    make sure the order of these inputs are the same in the two functions. this is important for the function below.

!!! hint
    a style tip: these can be one-liners 😎
"

# ╔═╡ bfcc7c92-1dfa-11eb-314e-d37baa762fa8


# ╔═╡ 127c87b6-1dfb-11eb-1f35-83751bd9b2b1


# ╔═╡ 13758974-1dfb-11eb-33c8-3b070315caea
md"
🐝 write a function `sim_capture_mark_release_recapture` that takes in:

* `n::Int`: # bees in the population
* `k::Int`: # bees to capture and mark
* `kᵣ::Int`: # bees to recapture (and count marked)
* `estimator::Function`: pass either `chapman_estimator` or `lincoln_peterson_estimator` that you wrote above
and returns $\hat{n}$, the estimate of the number of bees in this simulation.

use all of the functions you wrote above.
"

# ╔═╡ 047dd1e0-1dfd-11eb-3bf3-e3151bbe374f


# ╔═╡ 5d698042-1dfd-11eb-02ba-03c19ac662a5
md"
🐝 use `sim_capture_mark_release_recapture` to, via simulation, evaluate/compare the biasedness of the Chapman and Lincoln-Peterson estimators by plotting the distribution of $\hat{n}$ (two `hist`s) over many capture, mark, release, recapture simulations. 

label which histogram corresponds to which estimator (in a legend if in the same histogram panel or in a title if in two subplots). plot as a vertical line the true number of bees for comparison. print off the average and standard deviation of $\hat{n}$ over the simulations so you can assess which estimator is unbiased, and, if both are unbiased, which estimator has the smallest variance.

as a case study, use 10,000 simulations and:
```julia
n = 200
k = 50
kᵣ = 40
```

!!! tip
    if you want two panels, be sure to pass the extra arguments so that the comparison is readily apparent. `fig, axs = subplots(2, 1, sharex=true, sharey=true)`

!!! tip \"ambitious Beavs only\"
    use `text(x, y, \"my string\")` to print the mean and standard deviation of the estimates in the plot
"

# ╔═╡ ae3a7fd0-1dfd-11eb-1a1d-f5b4439ace64


# ╔═╡ b623c314-1dfd-11eb-3309-ad8c5f176aaa


# ╔═╡ f3689f2e-1dfd-11eb-3f6d-73fb363e7151
md"
🐝 which estimator should you use to estimate the size of the bee population, and why?
"

# ╔═╡ 636aa89c-1e00-11eb-1619-af8a5f2cc28b
md"
[ your answer here ]
"

# ╔═╡ 694ae5ec-1e00-11eb-21c8-dd843a066350
md"
🐝 why is the width of the distribution in the histogram important?
"

# ╔═╡ 7515377e-1e00-11eb-014f-e7c865a5997b
md"
🐝 briefly outline what simulation you would conduct to evaluate the _consistency_ of one of these estimators.

feel free to code it up if you want, but not required.
"

# ╔═╡ 9aa8215e-1e00-11eb-390c-1342671e1bdb
md"
 [your answer here]
"

# ╔═╡ Cell order:
# ╠═02c897b8-1d94-11eb-072a-b194b6cbe30e
# ╟─e20257fe-1d8d-11eb-18e1-f5daed82d16a
# ╠═286994ce-1d92-11eb-272f-a99fe23b243f
# ╟─2d85ff6a-1d92-11eb-2049-3dc3bc36650f
# ╠═a1402548-1d92-11eb-3eaa-b930162e42db
# ╟─ab9e90b0-1d92-11eb-22e7-99a0dcc994f9
# ╠═f7231e16-1d92-11eb-2744-173ba6d3bf27
# ╟─2853da36-1d93-11eb-1aea-2fb0e95ce2cd
# ╠═e72f87e4-1d93-11eb-27ba-f718310d206a
# ╟─564cab7c-1d94-11eb-3b0d-93cba33b2619
# ╠═8340fb14-1df9-11eb-29d9-23d7f09748c8
# ╟─d4c3e618-1df9-11eb-30c5-c75f5a28b535
# ╠═bfcc7c92-1dfa-11eb-314e-d37baa762fa8
# ╠═127c87b6-1dfb-11eb-1f35-83751bd9b2b1
# ╟─13758974-1dfb-11eb-33c8-3b070315caea
# ╠═047dd1e0-1dfd-11eb-3bf3-e3151bbe374f
# ╟─5d698042-1dfd-11eb-02ba-03c19ac662a5
# ╠═ae3a7fd0-1dfd-11eb-1a1d-f5b4439ace64
# ╠═b623c314-1dfd-11eb-3309-ad8c5f176aaa
# ╟─f3689f2e-1dfd-11eb-3f6d-73fb363e7151
# ╠═636aa89c-1e00-11eb-1619-af8a5f2cc28b
# ╠═694ae5ec-1e00-11eb-21c8-dd843a066350
# ╟─7515377e-1e00-11eb-014f-e7c865a5997b
# ╠═9aa8215e-1e00-11eb-390c-1342671e1bdb
