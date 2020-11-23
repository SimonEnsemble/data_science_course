### A Pluto.jl notebook ###
# v0.12.11

using Markdown
using InteractiveUtils

# ╔═╡ 3d94addc-2d25-11eb-2b52-c5c4c272c352
using CSV, DataFrames, PyPlot, Printf, Statistics, ScikitLearn

# ╔═╡ 9eb641c8-2d27-11eb-32e1-db765f8f523d
md"
# the data

[source](https://archive.ics.uci.edu/ml/datasets/Wine+Quality)

each row is a wine.
regarding the columns:

_input variables_ (based on physicochemical tests):
1. fixed acidity
2. volatile acidity
3. citric acid
4. residual sugar
5. chlorides
6. free sulfur dioxide
7. total sulfur dioxide
8. density
9. pH
10. sulphates
11. alcohol
_output variable_ (based on sensory data): quality (score between 0 and 10)

🐜 read in the `winequality-red.csv` as a data frame.
"

# ╔═╡ 49df754a-2d25-11eb-0aec-fd3f230cca64


# ╔═╡ 15c030f0-2d2b-11eb-171b-c9736cb18b7f
md"🐜 how many wines are there in the data set?

how many wines of each unique quality?
"

# ╔═╡ 2ca68ad2-2d2b-11eb-14e5-9b9263014e02


# ╔═╡ 2e8597ba-2d2b-11eb-1c26-57c6f35fd616


# ╔═╡ 7394d516-2d2e-11eb-2bf2-2317e1d33c2e
md"🐜 define a vector `features` that is the vector of feature names. this will help you later when you need to loop over the features.

!!! hint
    slice `names(df)` instead of manually typing the feature names out.
"

# ╔═╡ d3ad80a2-2d28-11eb-0d79-cd27639dbc0d


# ╔═╡ f95e3018-2d27-11eb-304e-fde525abb40c
md"
## goal

the goal is to use the 11 features to predict the quality of the wine, using a random forest. though the outputs are discrete numbers between 0 and 10, treat this as a regression problem, since the classes here are ordinal.

🐜 convert the data in the data frame into a feature matrix `X` and target vector `y` that scikitlearn takes as input. go ahead and convert _all_ of the data. no need to split into test/train b/c we're going to use out of bag error in a random forest as a metric of generalization error.

!!! hint
    you have 11 features now. use a `for` loop!
"

# ╔═╡ cdf77f98-2d28-11eb-10a5-4f4a44957cb6


# ╔═╡ 51a6dcf6-2d29-11eb-065a-e5e2ed1a638c
md"
🐜 we're going to train a random forest regressor. based on the scikitlearn docs [here](https://scikit-learn.org/stable/modules/generated/sklearn.ensemble.RandomForestRegressor.html) and ScikitLearn.jl docs [here](https://cstjean.github.io/ScikitLearn.jl/dev/), figure out how to import the `RandomForestRegressor`.
"

# ╔═╡ b0aae1b6-2d29-11eb-377e-5d47b29c9ee2


# ╔═╡ c392f7be-2d29-11eb-17e2-419f0e0990ed
md"
🐜 construct and train a random forest regressor of 250 trees on this data set.
"

# ╔═╡ d8885882-2d29-11eb-0851-738fa152150a


# ╔═╡ e4e25220-2d29-11eb-291b-db324077781c


# ╔═╡ e8184e2c-2d29-11eb-299a-e90a15b52451
md"
🐜 what is the out-of-bag [coefficient of determination](https://en.wikipedia.org/wiki/Coefficient_of_determination), $R^2$?

!!! hint
    see `oob_score` parameter and attribute of `RandomForestRegressor` [here](https://scikit-learn.org/stable/modules/generated/sklearn.ensemble.RandomForestRegressor.html).
"

# ╔═╡ 2bbb5ed0-2d2a-11eb-388f-55d5a96f174f


# ╔═╡ 678f3f8a-2d2a-11eb-25b3-a16adde558ae
md"
🐜 in a _parity plot_, make a scatter plot of the wines, where the x-axis has the true label (true quality) and the y-axis has the out-of-bag prediction of the label (predicted quality). this is a way to visualize the performance of the random forest. plot a diagonal line to show parity, where we want the points to fall.

!!! hint
    see `oob_prediction_` attribute in [the docs](https://scikit-learn.org/stable/modules/generated/sklearn.ensemble.RandomForestRegressor.html)
"

# ╔═╡ a3d2d2ea-2d2a-11eb-2a1b-a3d8844989c8


# ╔═╡ 0fc84ade-2d2b-11eb-0723-8be982bfb0fe
md"
🐜 because the predicted output is continuous and the true output is discrete, it is difficult to see the density of points in the above visualization. instead, draw a box plot.
"

# ╔═╡ 5cbeb04e-2d2b-11eb-27da-afe9fb9efd64


# ╔═╡ 63ee66fa-2d2b-11eb-1d44-d9df0a976836
md"
🐜 discuss the performance of the model. is the model useful for predicting the quality of wine based on its measurements of the attributes of the wine?
"

# ╔═╡ 6f6c5a6a-2d2c-11eb-1b1b-097984cbbb78
md"🐜 visualize the feature importances with a bar chart. each feature gets a bar. the height of the bar will represent the importance of the feature. which properties of the wine are most and least useful for predicting its quality?

!!! hint
    see `feature_importances_` in the [docs](https://scikit-learn.org/stable/modules/generated/sklearn.ensemble.RandomForestRegressor.html#sklearn.ensemble.RandomForestRegressor.feature_importances_)

* make sure the features are labeled with the actual names (`String`s, not `Int`s)
* permute the bars such that the bars are ordered by importance, starting with the most important first, on the left.
"

# ╔═╡ 97e8007a-2d2c-11eb-168d-e77d1626a2a8


# ╔═╡ Cell order:
# ╠═3d94addc-2d25-11eb-2b52-c5c4c272c352
# ╟─9eb641c8-2d27-11eb-32e1-db765f8f523d
# ╠═49df754a-2d25-11eb-0aec-fd3f230cca64
# ╟─15c030f0-2d2b-11eb-171b-c9736cb18b7f
# ╠═2ca68ad2-2d2b-11eb-14e5-9b9263014e02
# ╠═2e8597ba-2d2b-11eb-1c26-57c6f35fd616
# ╟─7394d516-2d2e-11eb-2bf2-2317e1d33c2e
# ╠═d3ad80a2-2d28-11eb-0d79-cd27639dbc0d
# ╟─f95e3018-2d27-11eb-304e-fde525abb40c
# ╠═cdf77f98-2d28-11eb-10a5-4f4a44957cb6
# ╟─51a6dcf6-2d29-11eb-065a-e5e2ed1a638c
# ╠═b0aae1b6-2d29-11eb-377e-5d47b29c9ee2
# ╟─c392f7be-2d29-11eb-17e2-419f0e0990ed
# ╠═d8885882-2d29-11eb-0851-738fa152150a
# ╠═e4e25220-2d29-11eb-291b-db324077781c
# ╟─e8184e2c-2d29-11eb-299a-e90a15b52451
# ╠═2bbb5ed0-2d2a-11eb-388f-55d5a96f174f
# ╟─678f3f8a-2d2a-11eb-25b3-a16adde558ae
# ╠═a3d2d2ea-2d2a-11eb-2a1b-a3d8844989c8
# ╟─0fc84ade-2d2b-11eb-0723-8be982bfb0fe
# ╠═5cbeb04e-2d2b-11eb-27da-afe9fb9efd64
# ╟─63ee66fa-2d2b-11eb-1d44-d9df0a976836
# ╟─6f6c5a6a-2d2c-11eb-1b1b-097984cbbb78
# ╠═97e8007a-2d2c-11eb-168d-e77d1626a2a8
