### A Pluto.jl notebook ###
# v0.12.16

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
df = CSV.read("winequality-red.csv", DataFrame)

# ╔═╡ 15c030f0-2d2b-11eb-171b-c9736cb18b7f
md"🐜 how many wines are there in the data set?

how many wines of each unique quality?
"

# ╔═╡ 2ca68ad2-2d2b-11eb-14e5-9b9263014e02
nrow(df)

# ╔═╡ 2e8597ba-2d2b-11eb-1c26-57c6f35fd616
by(df, :quality, count=:density=>length)

# ╔═╡ d3ad80a2-2d28-11eb-0d79-cd27639dbc0d
const FEATURES = names(df)[1:end-1]

# ╔═╡ f95e3018-2d27-11eb-304e-fde525abb40c
md"
## goal

the goal is to use the 11 features to predict the quality of the wine, using a random forest. though the outputs are discrete numbers between 0 and 10, treat this as a regression problem, since the classes here are ordinal.

🐜 convert the data in the data frame into a feature matrix `X` and target vector `y` that scikitlearn takes as input. go ahead and convert _all_ of the data. no need to split into test/train b/c we're going to use out of bag error in a random forest as a metric of generalization error.

!!! hint
    you have 11 features now. use a `for` loop!
"

# ╔═╡ cdf77f98-2d28-11eb-10a5-4f4a44957cb6
begin
	X = zeros(nrow(df), length(FEATURES))
	y = zeros(nrow(df))
	for (w, wine) in enumerate(eachrow(df))
		for (f, feature) in enumerate(FEATURES)
			X[w, f] = wine[feature]
		end
		y[w] = wine[:quality]
	end
	X, y
end

# ╔═╡ 51a6dcf6-2d29-11eb-065a-e5e2ed1a638c
md"
🐜 we're going to train a random forest regressor. based on the scikitlearn docs [here](https://scikit-learn.org/stable/modules/generated/sklearn.ensemble.RandomForestRegressor.html) and ScikitLearn.jl docs [here](https://cstjean.github.io/ScikitLearn.jl/dev/), figure out how to import the `RandomForestRegressor`.
"

# ╔═╡ b0aae1b6-2d29-11eb-377e-5d47b29c9ee2
@sk_import ensemble: RandomForestRegressor

# ╔═╡ c392f7be-2d29-11eb-17e2-419f0e0990ed
md"
🐜 construct and train a random forest regressor of 250 trees on this data set.
"

# ╔═╡ d8885882-2d29-11eb-0851-738fa152150a
rf = RandomForestRegressor(n_estimators=250, oob_score=true)

# ╔═╡ e4e25220-2d29-11eb-291b-db324077781c
rf.fit(X, y)

# ╔═╡ e8184e2c-2d29-11eb-299a-e90a15b52451
md"
🐜 what is the out-of-bag [coefficient of determination](https://en.wikipedia.org/wiki/Coefficient_of_determination), $R^2$?

!!! hint
    see `oob_score` parameter and attribute of `RandomForestRegressor` [here](https://scikit-learn.org/stable/modules/generated/sklearn.ensemble.RandomForestRegressor.html).
"

# ╔═╡ 2bbb5ed0-2d2a-11eb-388f-55d5a96f174f
rf.oob_score_

# ╔═╡ 678f3f8a-2d2a-11eb-25b3-a16adde558ae
md"
🐜 in a _parity plot_, make a scatter plot of the wines, where the x-axis has the true label (true quality) and the y-axis has the out-of-bag prediction of the label (predicted quality). this is a way to visualize the performance of the random forest. plot a diagonal line to show parity, where we want the points to fall.

!!! hint
    see `oob_prediction_` attribute in [the docs](https://scikit-learn.org/stable/modules/generated/sklearn.ensemble.RandomForestRegressor.html)
"

# ╔═╡ a3d2d2ea-2d2a-11eb-2a1b-a3d8844989c8
begin
	figure()
	xlabel("true quality")
	ylabel("oob predicted quality")
	scatter(y, rf.oob_prediction_, s=2)
	plot([3, 8], [3, 8])
	gcf()
end

# ╔═╡ 0fc84ade-2d2b-11eb-0723-8be982bfb0fe
md"
🐜 because the predicted output is continuous and the true output is discrete, it is difficult to see the density of points in the above visualization. instead, draw a box plot.
"

# ╔═╡ 5cbeb04e-2d2b-11eb-27da-afe9fb9efd64
begin
	figure()
	xlabel("true quality")
	ylabel("oob predicted quality")
	data = [rf.oob_prediction_[y .== q] for q = 3:8]
	boxplot(data)
	plot([1, 6], [3, 8])
	xticks(1:6, 3:8)
	gcf()
end

# ╔═╡ 63ee66fa-2d2b-11eb-1d44-d9df0a976836
md"
🐜 discuss the performance of the model. is the model useful for predicting the quality of wine based on its measurements of the attributes of the wine?

not so well in the sense that the highest and lowest rated wines are not predicted well-- this is probably due to an imbalance of the data. most of the wines are of quality 5 and 6. therefore, e.g. predicting the quality of each wine to be 5.5 is actually not too bad of a model, using the mean square error as an objective function! one solution is to force the random forest to pay more attention to the lowest and highest rated wines (somewhat rare) by passing an array `sample_weight` to the `fit` method of the `RandomForestRegressor` (see [here](https://scikit-learn.org/stable/modules/generated/sklearn.ensemble.RandomForestRegressor.html)) and up-weigh the samples with the lowest and highest ratings.

"

# ╔═╡ 9405589e-3502-11eb-0ad3-213aefb4f239
begin
	qualities = sort(unique(df[:, :quality]))
	nb_wines = [nrow(filter(wine -> wine[:quality] == q, df)) for q in qualities]
	
	figure()
	ylabel("# wines")
	xlabel("quality")
	bar(qualities, nb_wines)
	gcf()
end

# ╔═╡ 6f6c5a6a-2d2c-11eb-1b1b-097984cbbb78
md"🐜 visualize the feature importances with a bar chart. each feature gets a bar. the height of the bar will represent the importance of the feature. which properties of the wine are most and least useful for predicting its quality?

!!! hint
    see `feature_importances_` in the [docs](https://scikit-learn.org/stable/modules/generated/sklearn.ensemble.RandomForestRegressor.html#sklearn.ensemble.RandomForestRegressor.feature_importances_)

* make sure the features are labeled with the actual names (`String`s, not `Int`s)
* permute the bars such that the bars are ordered by importance, starting with the most important first, on the left.
"

# ╔═╡ 97e8007a-2d2c-11eb-168d-e77d1626a2a8
begin
	figure()
	xlabel("feature")
	ylabel("importance")
	ids_sorted = sortperm(rf.feature_importances_, rev=true)
	bar(1:length(FEATURES), rf.feature_importances_[ids_sorted])
	xticks(1:length(FEATURES), FEATURES[ids_sorted], rotation=90)
	gcf()
end

# ╔═╡ Cell order:
# ╠═3d94addc-2d25-11eb-2b52-c5c4c272c352
# ╟─9eb641c8-2d27-11eb-32e1-db765f8f523d
# ╠═49df754a-2d25-11eb-0aec-fd3f230cca64
# ╟─15c030f0-2d2b-11eb-171b-c9736cb18b7f
# ╠═2ca68ad2-2d2b-11eb-14e5-9b9263014e02
# ╠═2e8597ba-2d2b-11eb-1c26-57c6f35fd616
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
# ╠═9405589e-3502-11eb-0ad3-213aefb4f239
# ╟─6f6c5a6a-2d2c-11eb-1b1b-097984cbbb78
# ╠═97e8007a-2d2c-11eb-168d-e77d1626a2a8
