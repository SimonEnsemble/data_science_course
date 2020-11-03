### A Pluto.jl notebook ###
# v0.12.4

using Markdown
using InteractiveUtils

# ╔═╡ 6e298030-18cb-11eb-091b-adb0ae4ccdc9
using StatsBase, PyPlot, Statistics, Printf

# ╔═╡ beb1a95e-18c8-11eb-06fb-f918449903f6
md"
# the German tank problem

learning objectives:
* understand the meaning of \"statistical inference\"
* understand what an estimator is
* understand and evaluate the properties of estimators: biasedness, consistency, and efficiency
* estimate the size of a population from a random sample

background reading:
* estimator notes by KC Border [here](https://u.pcloud.link/publink/show?code=XZkVJHXZpQdi3PokPTmc8sX0dwkL3hN2cPYV)
* an overview of the history of the German tank problem [here](https://u.pcloud.link/publink/show?code=XZ0VJHXZ7C5CYq9niPfnNV7V4s1OPk6IKq7y) (pg. 2)
* Stitch Fix blog post [here](https://multithreaded.stitchfix.com/blog/2020/09/24/what-makes-a-good-estimator/)

_problem statement_: during World War II, the Germans have a population of $n$ tanks labeled with serial numbers $1,2,...,n$. 
For the Allied forces, the number of tanks $n$ is unknown and of great interest. 
The Allied forces randomly capture/destroy $k$ tanks from the Germans (without replacement) and observe their serial numbers $\{x_1, x_2, ..., x_k\}$. The goal is to, from observing the serial numbers on this random sample of the German tanks, estimate $n$.

🐻 in the context of the German tank problem, explain what an *estimator* does.
"

# ╔═╡ 6694da2c-18cb-11eb-1fd5-43f6e9dfbdd0
md"
[your answer...]
"

# ╔═╡ 9f16e318-18cb-11eb-3272-e3157e1fbe23
md"
## data structure for a tank

🐻 for elegance, create a data `struct`ure for a tank, `Tank`, that stores one attribute of the tank, `serial_nb`: the serial number of the tank. use this data structure throughout.
"

# ╔═╡ c67df932-18cb-11eb-245a-bb366b2d4340


# ╔═╡ c7071a3c-18cb-11eb-2e9a-7f581e49e24b
md"
🐻 test your data structure by constructing a `Tank` with a random serial number between 1 and 10.

```
tank = Tank(rand(1:10))
tank.serial_nb
```
"

# ╔═╡ 126edd8e-18cc-11eb-2a0d-e12ee6ed80cc


# ╔═╡ 4a31062a-18cc-11eb-37b4-cd270bfc6744


# ╔═╡ 53453f10-18cc-11eb-22ff-21612e25a012
md"
🐻 imagine you captured three tanks with serial numbers 10, 12, and 23. create an array of tanks, `tanks::Array{Tank}` that would represent your sample.
"

# ╔═╡ 740ec838-18cc-11eb-3539-016d10292a02


# ╔═╡ 7b4897dc-18cc-11eb-3ea3-ff1836681f68
md"
🐻 I wrote a function below, `viz_tanks` that takes as input an array of tanks (like `tanks` you declared above) and visualizes their serial numbers. pass your `tanks` array into this function to make sure it works for you.
"

# ╔═╡ 12f10994-18cc-11eb-1074-57855f77b463
function viz_tanks(tanks::Array{Tank})
    nb_tanks = length(tanks)
    
    img = PyPlot.matplotlib.image.imread("tank.png")

    fig, ax = subplots(1, nb_tanks)
    for (t, tank) in enumerate(tanks)
        ax[t].imshow(img)
        ax[t].set_title(tank.serial_nb)
        ax[t].axis("off")
    end
    tight_layout()
    
	gcf()
end

# ╔═╡ 9bf4aebc-18cc-11eb-178b-45ff5604b903
 # pass your tanks array into viz_tanks. you should see an image. 

# ╔═╡ e4c3ee78-18cc-11eb-1c40-e5ab8ef67ec6
md"
## simulating tank capture

🐻 write a function `capture_tanks` to simulate the random sampling of `nb_tanks_captured` tanks from all `nb_tanks` tanks the Germans have (without replacement). return a random sample of tanks as an array of tanks, `Array{Tank}`. it should work as follows:

```
captured_tanks = capture_tanks(5, 300) # sample 5 tanks from 300, return Array{Tank}
```

!!! hint
    see the `sample` function from StatsBase.jl [here](https://juliastats.org/StatsBase.jl/stable/sampling/#StatsBase.sample).
"

# ╔═╡ 134eddfc-18cd-11eb-0149-dfe5cbc50372


# ╔═╡ b40636de-18cd-11eb-1569-2b8464dc7905
md"
🐻 test your function `captured_tanks` below by sampling 5 tanks from 10. use `viz_tanks` to visualize the result.
make sure (i) you get a different set of tanks each time you run it (unless you are lucky) and (ii) there are never repeated tanks.
"

# ╔═╡ 3952c9a0-18cd-11eb-1293-354a191d09ad


# ╔═╡ 4b874b3c-18cd-11eb-32d5-453a06843447


# ╔═╡ e1a15f4a-18cd-11eb-2ee2-21d51a9389cc
md"
## defining different estimators

an estimator maps an outcome $\{x_1, x_2, ..., x_k\}$ to an estimate for $n$, $\hat{n}$.
"

# ╔═╡ 871c7036-18ce-11eb-07f1-89b1d0d5b8d8
md"
#### estimator 1: maximum serial number

this is the [maximum likelihood estimator](https://en.wikipedia.org/wiki/Maximum_likelihood_estimation) for the German tank problem.

$\hat{n} = \max_i x_i$

🐻 in the first cell, code up this estimator as a function, `max_serial_no`. it should take as input `captured_tanks::Array{Tank}` and return an integer, which is the estimate for the number of tanks comprising the population.

in the second cell, pass in your array of tanks `captured_tanks` you defined above to `max_serial_no` to test it (i.e. to ensure it returns what it should).
"

# ╔═╡ e0fe52fe-18ce-11eb-2c6d-9d75c1f96ad4


# ╔═╡ edb0cc72-18ce-11eb-3263-4d023ab2f132


# ╔═╡ db698af6-18cf-11eb-12ff-311ef9eb5746
md"
#### estimator 2: using the median.

say we knew the median tank number, $\bar{x}$. then there must be $\bar{x}-1$ serial numbers below this and $\bar{x}-1$ serial numbers above it.

e.g. for a population of five tanks, $\{1, 2, 3, 4, 5\}$, the median is 3. so we'd guess there are $2\cdot 3-1=5$ tanks correctly with this estimator.

this suggests the following estimate for the total number of tanks:

$\hat{n}=2 * \texttt{median}(x)-1$

🐻 code up this estimator as a function, `median_based_estimator`, then test it, too.
"

# ╔═╡ 3e6cc7c6-18d0-11eb-14f9-d1f813973ab9


# ╔═╡ ca77a236-18d0-11eb-0bd7-43588f3f0794


# ╔═╡ f5c1c61a-18d0-11eb-3d30-17bfeea3ff4a
md"
this is a clever estimator, right?

🐻 however, can you think of a scenario where this estimator returns a ridiculously wrong estimate?
"

# ╔═╡ 0fd1b094-18d1-11eb-20c2-736fc12d0251
md"
[your answer... skip if you can't think of a scenario; this is a difficult conceptual problem. think about it next time you are on a walk!]
"

# ╔═╡ 1634102e-18cf-11eb-2a9b-ef53b5d243c3
md"
#### estimator 3: maximum serial number plus initial gap

the idea behind this clever estimator is that the gap between the first tank (labeled with serial number 1) and the smallest number observed is, on average, equal to the gap between the largest observed number and the tank with the largest serial number in the popluation.

$\hat{n} = \max_i x_i + \bigl(\min_i x_i -1\bigr)$

🐻 code up this estimator as a function, `max_serial_no_plus_initial_gap`, then test it, too.
"

# ╔═╡ 2eb79e7e-18cf-11eb-34a0-a172fddb31d0


# ╔═╡ 708d3c32-18cf-11eb-32da-0717690ae357


# ╔═╡ 7b8afb0e-18d1-11eb-32c6-4599d151b0bc
md"
🐻 discuss with your group to make sure you can make sense of this estimator.
"

# ╔═╡ 59cdbe88-18cf-11eb-2289-2980d4db0531
md"
#### estimator 4: maximum serial number plus gap if samples are evenly spaced

$\hat{n} = \max_i x_i + \bigl( \max_i x_i / k -1 \bigr)$

🐻 code up this estimator as a function, `max_serial_no_plus_gap_if_evenly_spaced`, then test it like the others.
"

# ╔═╡ 87dc93c6-18cf-11eb-0ddd-b19522cd8a5a


# ╔═╡ 887e360c-18cf-11eb-06f8-bfab0e46fafc


# ╔═╡ 9883455e-18d1-11eb-32b7-1d42dc0ad186
md"
## assessing the bias and efficiency (variance) of the estimators

🐻 say the Germans have `nb_tanks` tanks, and we randomly capture `nb_tanks_captured`. what is the distribution of the estimated number of tanks $\hat{n}$ (over different outcomes of this random experiment), and how does the distribution compare to the true `nb_tanks`?

study this problem with:
```
nb_tanks = 100        # total # tanks the Germans have
nb_captured_tanks = 5 # # tanks you capture
nb_simulations = 10000 # # sims of tank capture
```

!!! hint
    there are four estimators here you need to loop over. note that you _can_ create an array of functions (an array of the estimators above) and then loop over the functions. this can help you avoid repeating a lot of code.

so the simulator `capture_tanks` must know the true `nb_tanks`, of course. we're assessing how the estimators will perform when estimating the true number of tanks based on a random sample from the population, generated via `capture_tanks`. the distribution of the estimated number of tanks, over repeated samples, can be used to evaluate, for each estimator, the:
* biasedness: on average, does the estimator estimate the true number of tanks?
* efficiency: well, compare the _variance_ of the estimators among the ones that are unbiased.
we seek an estimator that is both unbiased, so that it is correct on average, and efficient, in that it exhibits the lowest variance from sample to sample among all other unbiased estimators.

visualize the distribution of estimates by a set of histograms either (i) on top of each other with opacity or (ii) in a row with shared x-axs `subplots(4, 1)`. see [here](https://matplotlib.org/3.3.2/gallery/lines_bars_and_markers/cohere.html#sphx-glr-gallery-lines-bars-and-markers-cohere-py).

!!! hint
    loop over simulations of tank captures, then inside this a loop over your estimators. store your estimates in a 2D array or in an array of arrays for plotting as a histogram.

!!! tip \"ambitious Beavers\"
    use the `text` command in matplotlib to print the mean and variance of the estimates in the plot
"

# ╔═╡ 20d4b65a-18d4-11eb-2385-e7f56c5d8861


# ╔═╡ c035fc0e-18d1-11eb-3f08-77d281bdea55


# ╔═╡ aa589166-18d4-11eb-39af-05557742b92c


# ╔═╡ ae5cda32-18d3-11eb-2be0-cb3948f6226f
md"🐻 which estimators are unbiased? among the unbiased estimators, which one exhibits the lowest variance? that's the estimator you'll want to use!"

# ╔═╡ 53e2a95a-18d4-11eb-3fb5-ad4d1602586a
md"
[your answer]
"

# ╔═╡ fb6b8dc0-18d6-11eb-01a7-39f0cc73f6ec
md"## assessing the consistency of estimator 4

🐻 to study if estimator 4 is consistent, make a visualization to compare the distribution of the estimates of the number of tanks as we increase the number of tanks we capture from 5, 10, 15, 20.

does the distribution of the estimator concentrate on the true value?

!!! hint
    this is a loop over `nb_captured_tanks`.
"

# ╔═╡ 5adbcc4e-18d8-11eb-2928-2b1dbb13f311


# ╔═╡ Cell order:
# ╟─beb1a95e-18c8-11eb-06fb-f918449903f6
# ╠═6694da2c-18cb-11eb-1fd5-43f6e9dfbdd0
# ╠═6e298030-18cb-11eb-091b-adb0ae4ccdc9
# ╟─9f16e318-18cb-11eb-3272-e3157e1fbe23
# ╠═c67df932-18cb-11eb-245a-bb366b2d4340
# ╟─c7071a3c-18cb-11eb-2e9a-7f581e49e24b
# ╠═126edd8e-18cc-11eb-2a0d-e12ee6ed80cc
# ╠═4a31062a-18cc-11eb-37b4-cd270bfc6744
# ╟─53453f10-18cc-11eb-22ff-21612e25a012
# ╠═740ec838-18cc-11eb-3539-016d10292a02
# ╟─7b4897dc-18cc-11eb-3ea3-ff1836681f68
# ╠═12f10994-18cc-11eb-1074-57855f77b463
# ╠═9bf4aebc-18cc-11eb-178b-45ff5604b903
# ╟─e4c3ee78-18cc-11eb-1c40-e5ab8ef67ec6
# ╠═134eddfc-18cd-11eb-0149-dfe5cbc50372
# ╟─b40636de-18cd-11eb-1569-2b8464dc7905
# ╠═3952c9a0-18cd-11eb-1293-354a191d09ad
# ╠═4b874b3c-18cd-11eb-32d5-453a06843447
# ╟─e1a15f4a-18cd-11eb-2ee2-21d51a9389cc
# ╟─871c7036-18ce-11eb-07f1-89b1d0d5b8d8
# ╠═e0fe52fe-18ce-11eb-2c6d-9d75c1f96ad4
# ╠═edb0cc72-18ce-11eb-3263-4d023ab2f132
# ╟─db698af6-18cf-11eb-12ff-311ef9eb5746
# ╠═3e6cc7c6-18d0-11eb-14f9-d1f813973ab9
# ╠═ca77a236-18d0-11eb-0bd7-43588f3f0794
# ╟─f5c1c61a-18d0-11eb-3d30-17bfeea3ff4a
# ╠═0fd1b094-18d1-11eb-20c2-736fc12d0251
# ╟─1634102e-18cf-11eb-2a9b-ef53b5d243c3
# ╠═2eb79e7e-18cf-11eb-34a0-a172fddb31d0
# ╠═708d3c32-18cf-11eb-32da-0717690ae357
# ╟─7b8afb0e-18d1-11eb-32c6-4599d151b0bc
# ╟─59cdbe88-18cf-11eb-2289-2980d4db0531
# ╠═87dc93c6-18cf-11eb-0ddd-b19522cd8a5a
# ╠═887e360c-18cf-11eb-06f8-bfab0e46fafc
# ╟─9883455e-18d1-11eb-32b7-1d42dc0ad186
# ╠═20d4b65a-18d4-11eb-2385-e7f56c5d8861
# ╠═c035fc0e-18d1-11eb-3f08-77d281bdea55
# ╠═aa589166-18d4-11eb-39af-05557742b92c
# ╟─ae5cda32-18d3-11eb-2be0-cb3948f6226f
# ╠═53e2a95a-18d4-11eb-3fb5-ad4d1602586a
# ╟─fb6b8dc0-18d6-11eb-01a7-39f0cc73f6ec
# ╠═5adbcc4e-18d8-11eb-2928-2b1dbb13f311
