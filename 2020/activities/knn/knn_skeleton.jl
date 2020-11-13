### A Pluto.jl notebook ###
# v0.12.10

using Markdown
using InteractiveUtils

# ╔═╡ 9510dbc8-2553-11eb-2174-594852dee80b
using CSV, 
      DataFrames,
      PyPlot,
	  ScikitLearn, # machine learning package
	  StatsBase,
	  Random,
	  Statistics

# ╔═╡ e5211554-255c-11eb-372f-29d8cb16e7f1
begin
	@sk_import neighbors : KNeighborsClassifier
	using ScikitLearn.CrossValidation: train_test_split
	@sk_import metrics : confusion_matrix
	@sk_import metrics : plot_confusion_matrix
end

# ╔═╡ 8a835846-2497-11eb-167d-d98f197b3895
md"
# the $k$-nearest neighbors ($k$-NN) supervised learning algorithm

* simple to understand
* only one hyper-parameter, $k$
* used for regression or classification
* non-parametric
* imposes only mild structural assumptions about the data

let's explore $k$-nearest neighbor classification.

🐉 discuss supervised vs. unsupervised learning. briefly explain the difference and give examples of both.
"


# ╔═╡ 165a709c-2499-11eb-24b6-29c7c9cb61dd
md"
[... your answer here...]
"

# ╔═╡ 015e2db4-2499-11eb-2c64-7331c5e90665
md"
🐉 discuss classification vs. regression. briefly explain the difference and give examples of both.
"

# ╔═╡ 1f6b1dd0-2499-11eb-325a-b31825d06f7f
md"
[... your answer here...]
"

# ╔═╡ 6dd5c5e8-2498-11eb-34e3-b33934a53da2
md"
_training data_ (examples): $\{(\mathbf{x}_1, y_1), (\mathbf{x}_2, y_2), ..., (\mathbf{x}_n, y_n)\}$ 
* let $\mathbf{x}_i \in \mathbb{R}^d$ be the feature vector of example $i$
* let $y_i \in \{0, 1\}$ is the label on data point $i$

the $k$-NN model maps a feature vector $\mathbf{x}$ of an instance to the probability that the label on this instance is 1, by estimating the conditional probability $P(Y=1|\mathbf{X}=\mathbf{x})$ as the average value of the labels on its $k$ nearest neighbors (in the training data) in feature space:

$$\hat{y}(\mathbf{x})= \frac{1}{k} \displaystyle \sum_{(\mathbf{x}_i, y_i) \in N_k(\mathbf{x})} y_i$$

* the *neighborhood* of $\mathbf{x}$, $N_k(\mathbf{x})$, is the set of $k$ \"closest\" data points in the training data set to $\mathbf{x}$
* for \"closest\" to be mathematically defined, we need a distance metric, e.g. Euclidean distance. 
* the classification rule depends on the tradeoff of false negatives vs. false positivies, but a typical rule is:

$$I[\hat{y}(\mathbf{x})>0.5]$$

with $I(\cdot)$ the indicator function. the idea is that the $k$ data points closest to $\mathbf{x}$ *vote*, with their labels, on whether we should classify this input instance point as a 0 or 1. with this classification rule, the majority vote decides the label on the instance.
"

# ╔═╡ b4455d10-2572-11eb-0581-1352407edc27
md"
!!! note
    we are using the scikitlearn library, written for Python, but calling it from Julia. 

see [here](https://github.com/cstjean/ScikitLearn.jl) for docs to ScikitLearn.jl and [here](https://scikit-learn.org/stable/) for docs to ScikitLearn in Python. 

usually you should consult the Python docs, unless you need help on importing scikitlearn functions into Julia, which I demonstrate below.
"

# ╔═╡ ef578b0a-2557-11eb-3543-b9f6bcdd2a0a
PyPlot.matplotlib.style.use("seaborn-white")

# ╔═╡ 0ea094d8-2554-11eb-169a-d77d547d81ca
md"
## classifying breast tumors as malignant or benign

data source: [UCI Machine Learning Repository](https://archive.ics.uci.edu/ml/datasets/Breast+Cancer+Wisconsin+(Diagnostic))

> Features are computed from a digitized image of a fine needle aspirate (FNA) of a breast mass. They describe characteristics of the cell nuclei present in the image.

the outcome associated with each tumor is binary:
* M = malignant
* B = benign

let's train a k-NN algo to classify tumors according to two features:
* max_smoothness of the cell nuclei 
* mean_texture of the cell nuclei

below, I read in `wdbc.data` as a data frame. each row represents a tumor from a different patient.
"

# ╔═╡ f0bf97be-2555-11eb-1620-c73bb195232b
begin
	# this is code to construct the header of the data table.
	# see wdbc.names for description of columns
	header = ["patient_id", "outcome"] # will be header eventually
	feature_names = ["radius", "texture", "perimeter", "area", 
		             "smoothness", "compactness", "concavity", 
		             "concave_pts", "symmetry", "fractal_dim"]
	for feature_name in feature_names
		for meas in ["mean_", "std_err_", "max_"]
			push!(header, meas * feature_name)
		end
	end
	
	# load in the data
	df = CSV.read("wdbc.data", header=header)
	
	# what columns we'll keep for this assignment
	keep_cols = [:patient_id, :max_smoothness, :mean_texture, :outcome]
	
	# trim and shuffle data
	df = df[shuffle(1:nrow(df)), keep_cols]
	first(df, 10)
end

# ╔═╡ f47a867e-2556-11eb-3115-d3854c0c74a8
md"
🐉 how many tumors in the data set turned out malignant? how many were benign?
"

# ╔═╡ a37680d0-2557-11eb-3808-eb7d07f9c3f0


# ╔═╡ b042d87c-2557-11eb-25d9-bb8f9b8cb6cc
md"
🐉 create an `outcome_to_color` dictionary that maps the outcome to a color, for your data visualizations. e.g. `outcome_to_color[\"M\"]` returns `\"red\"`, while `outcome_to_color[\"B\"]` returns `\"green\"`. 
"

# ╔═╡ d84b6a9e-2557-11eb-1ef7-a78495880335


# ╔═╡ 96f09ce0-255c-11eb-324e-450d014069c2
md"
🐉 split your data randomly into training and testing set. 70% train, 30% test.


use the `train_test_split` function from scikitlearn (docs [here](https://scikit-learn.org/stable/modules/generated/sklearn.model_selection.train_test_split.html)).

pass `shuffle=true` to first shuffle the data and `test_size=0.3` to ensure 25% is for test.

here is an example use:
```
ids_train, ids_test = train_test_split(1:10, test_size=0.25, shuffle=true)
ids_train # [3, 5, 10, 4, 1, 6, 2]
ids_test # [9, 8, 7]
```

then use `ids_train` and `ids_test` to split your tumor data frame into a test and train. no rows should overlap between these data frames. check the number of rows to make sure you split properly.
"

# ╔═╡ 813415e8-255d-11eb-2a46-ede41cb7b610


# ╔═╡ 8b713356-255d-11eb-2df9-41b1d0627975


# ╔═╡ 5c4f983c-2559-11eb-0a55-8fb0be7534bb
md"
🐉 use `describe(df_train, :min, :max, :mean)` (docs [here](http://juliadata.github.io/DataFrames.jl/stable/lib/functions/#DataAPI.describe)) to look at the min, max, and mean of the two features among the tumors.

note the drastic difference in scales. this is not good for k-NN algo because we need a meaningful distance metric. if the two features of drastically different scales, the distance in feature space will be dominated by one of the features.
"

# ╔═╡ ebe1c2fa-255d-11eb-1ba4-f3a0d3a0dc8f


# ╔═╡ f8000632-255d-11eb-305a-470d175e6527
md"
🐉 to achieve better performance in the k-NN, i.e. to obtain a more meaninful distance metric in feature space, do a Max-Min Normalization of each feature. that is:

$$x_s = \frac{x - \min(x)}{\max(x) - \min(x)}$$

where $x_s$ is the normalized feature and $x$ is the original feature.

this normalization of the features will ensure that the value of each feature is in the interval $[0, 1]$.

!!! important
    standardize both the test and train data. for the standardization, use the min and max of the respective feature *in the training set*. the reason we must not use test data to do the standardization is that we must pretend we don't have the test data when we train the k-NN to give a faithful estimate of generalization error when we evaluate the k-NN model on the test data.

!!! hint
    create two new columns in each the test and train data frame for these normalized features. feel free to use `describe` again to make sure you normalized correctly.
"

# ╔═╡ 6be31e6c-255a-11eb-3b66-13b21c99116b


# ╔═╡ 4d682544-255b-11eb-3e87-6fb0855e6237
md"
🐉 plot each tumor in the training set as a point in feature space. color each point according to the outcome. i.e. there should be two different colors, one for M, one for B. use your `outcome_to_color` dictionary!

* x-axis = standardized max smoothess
* y-axis = standardized mean texture
* include a legend that indicates which color is which outcome
* `gca().set_aspect(\"equal\")` for equal aspect ratio
* pass `facecolor=\"None\"` to `scatter` to make the points hollow; helps see the density when there are many points overlapping. 
"

# ╔═╡ 05afb49a-2558-11eb-2dec-5d5b443d4508


# ╔═╡ 03393b4c-255c-11eb-08f2-f7827e2c0ff6
md"
🐉 based on this plot, discuss why you think the k-NN algorithm would work here.

geometrically, what is the k-NN algo going to do if a new tumor sample comes along, and we know its max smoothness and mean texture, but we don't know if it's benign or malignant?
"

# ╔═╡ daf7d424-255e-11eb-1ce8-ebd60e000a63
md"
### training a k-NN model on the training data

see scikitlearn documentation for `KNeighborsClassifier` [here](https://scikit-learn.org/stable/modules/generated/sklearn.neighbors.KNeighborsClassifier.html)

🐉 first, we need to get our data in a format that scikitlearn wants.
write a function `df_to_X_y` that takes a data frame as input-- either your test or train data frame-- and whose last line is `X, y`. the `X` is your feature matrix and the `y` contains labels (0 = B, 1 = M).
* let `n_tumors` be the number of rows in the data frame passed into the function
* `X::Array{Float64, 2}` will be a `n_tumor` by 2 matrix. the first column will contain the standardized max smoothnesses, and the second column will contain the standardized mean texture.
* `y::Array{Float64, 1}` will be a length `n_tumor` one-dimensional array. entry $i$ of `y` will be 0 if tumor $i$ is B and $1$ if it is M.

!!! hint
    pre-allocate the arrays, then use `for (i, tumor) in enumerate(eachrow(df))` to iterate thru the rows of the data frame inside the function and load the arrays with the appropriate values.
"

# ╔═╡ 7a42a3b0-255f-11eb-08a6-3766d4bf376a


# ╔═╡ cd3265d8-255f-11eb-2a6f-3bf2170a1b21
md"
🐉 construct `X_train` and `y_train` arrays, your feature matrix and label vector for the tumors in the training set. use `df_to_X_y`.

```
X_train, y_train = df_to_X_y(df_train)
```
"

# ╔═╡ e97029ec-255f-11eb-3a0e-479d1539a3e4


# ╔═╡ a1b3d7ac-2569-11eb-195b-9744328be99f
md"
🐉 write a function `fit_kNN_model` that takes in three arguments:
* `k::Int`: # neighbors to use in the k-NN model
* `X_train::Array{Float64, 2}`: feature matrix
* `y_train::Array{Float64, 2}`: vector of targets

and returns a trained k-NN model, a `KNeighborsClassifier`. here is how to fit a k-NN model with $k=1$:

```
knn = KNeighborsClassifier(n_neighbors=1)
knn.fit(X_train, y_train)
```

see [scikitlearn docs](https://scikit-learn.org/stable/modules/generated/sklearn.neighbors.KNeighborsClassifier.html).

"

# ╔═╡ 7410d6be-256a-11eb-2aa4-831468212a2c


# ╔═╡ 90e53618-256a-11eb-22ed-7328e83dbf66
md"
🐉 fit a $k=2$-NN model to the training data.

a new tumor comes along that is not in the training set, with a standardized max smoothness = 0.3 and a standardized mean texture = 0.5. note these standardizations were done using the min and max of the features in the training data.

what does your k-NN predict for this point?

!!! hint
    try `knn_model.predict([0.3 0.5])` where `[0.3 0.5]` is a row vector, i.e. a 2D array with one row and two columns.

remake the plot of the training data you have above, with this new tumor plotted as a point of a different color than in `outcome_to_color` to differentiate it from the training data. does the k-NN classification of this new tumor make sense?
"

# ╔═╡ df597372-256a-11eb-28f8-bf49031f34ec


# ╔═╡ 5b724dd0-256b-11eb-276f-b19c09fe9620


# ╔═╡ 78b81992-256b-11eb-3b2b-5d23d8473e69


# ╔═╡ e91fe1a2-256a-11eb-2cab-4de02bb56fa2


# ╔═╡ a2886a38-256b-11eb-06a0-d1589f9db671
md"🐉 visualize the decision boundary for this $k=2$NN model.

I wrote a function for you, `draw_decision_boundary`, that should take your k-NN model as input and draw the decision boundary.

discuss with your group how it works/what it's doing.

then draw on top of this plot the training data to make sure the decision boundary makes sense.
"

# ╔═╡ b2b64ea2-256b-11eb-30f0-61f31e54acf4
function draw_decision_boundary(knn_model)
	x₁ = range(0, 1, length=100)
	x₂ = range(0, 1, length=100)

	knn_predictions = zeros(100, 100)
	for i = 1:100
		for j = 1:100
			# here's what you'll need to change
			X_new = [x₁[i] x₂[j]]
			knn_predictions[j, i] = knn_model.predict(X_new)[1] 
			# yes [j, i] not [i, j], I know it's weird.
		end
	end
	
	figure()
	levels = [0.0, 0.5, 1.0] # so countour lines are drawn between 0 and 1
	contourf(x₁, x₂, knn_predictions, 
		     alpha=0.4, levels, 
		     colors=[outcome_to_color["B"], outcome_to_color["M"]])
	xlabel("standardized max smoothess")
	ylabel("standardized mean texture")
	gca().set_aspect("equal")
	gcf()
end

# ╔═╡ 2cd2e754-256c-11eb-13f9-0febceed2d52


# ╔═╡ f0cb9660-256c-11eb-1fb8-f5f7dcb750ea
md"
#### evaluating the k-NN model on test data
🐉 assess the generalization error of your trained k-NN model on the test data.

that is, feed `X_test` into the k-NN model to make predictions about the labels on the test data, `ŷ_test`, then compare these labels to the actual labels, `y_test`, by computing the _test set accuracy_, the fraction of predictions our model got correct. this test data was not seen by the k-NN during training, so this should be a quality metric of how well the model will generalize to new tumors.

discuss why accuracy might not be the best metric in the clinic setting.
"

# ╔═╡ db257316-256d-11eb-2bcb-d1d81c78c6b7


# ╔═╡ 060fb2ba-256e-11eb-0aac-95f4cbccbd4f


# ╔═╡ 0f657bda-256e-11eb-3d6b-97493d220908


# ╔═╡ 568bc906-256e-11eb-1206-85f9dbed9fa8
md"
🐉 accuracy is not a very specific way to evaluate a model, since it does not tell you about the distribution of the classes, false positives, false negatives, etc.

the confusion matrix is in my view the most informative way to express the performance of a classification algorithm on test data.

use `plot_confusion_matrix` to plot the confusion matrix. see [scikitlearn docs](https://scikit-learn.org/stable/modules/generated/sklearn.metrics.plot_confusion_matrix.html#sklearn.metrics.plot_confusion_matrix) and the example [here](https://scikit-learn.org/stable/auto_examples/model_selection/plot_confusion_matrix.html#sphx-glr-auto-examples-model-selection-plot-confusion-matrix-py). 

!!! note
    call `gcf()` after `plot_confusion_matrix` to show the plot.

instead of 0 and 1, pass `display_labels` to make sure it reads the more informative terms, benign and malignant. you can change the `cmap` too.

with your team, discuss the meaning of _each square_ and make sure you understand what a confusion matrix is telling you.
"

# ╔═╡ 61d5bfd4-256d-11eb-1edd-77ec474964c4


# ╔═╡ 5385641c-256f-11eb-3039-893e8d1c54d7
md"
#### finding the optimal $k$
🐉 to find the best value for $k$, loop over `k=1:15`, train a k-NN model on the training data, use the model to make predictions on the test set (unseen data) to compute the accuracy. 
plot the test set accuracy against $k$, as well as the training set accuracy against $k$.
we choose the \"best\" $k$ as the one that yields the highest accuracy, as we expect it to have the highest accuracy on unseen data (future tumors that come in). use a legend to show which curve corresponds to train set accuracy, which to test set accuracy.

!!! hint
    to compute the accuracy on test and train data, you might want to use the `score` function. see the [docs](https://scikit-learn.org/stable/modules/generated/sklearn.neighbors.KNeighborsClassifier.html#sklearn.neighbors.KNeighborsClassifier.score).
"

# ╔═╡ af3ddd70-256f-11eb-133b-a7ed3cafbaa9


# ╔═╡ 32ae985e-2570-11eb-2442-ab73a7fdcc8c
md"
🐉 what is the optimal $k$? 

draw this as a vertical line in your plot above.

draw the decision boundary for this $k$.
"

# ╔═╡ 53c09572-2570-11eb-1b02-f3b2631bc847


# ╔═╡ 4575a944-2570-11eb-1362-afda09b198e1


# ╔═╡ 7ca9de1e-2570-11eb-16bf-89d6cc968867
md"🐉 for ambitious beavers, use PlutoUI to make a `Slider` for `k` and explore how the decision boundary and confusion matrix change based on k"

# ╔═╡ ab914460-2570-11eb-1e79-7d844aeb41ca


# ╔═╡ Cell order:
# ╟─8a835846-2497-11eb-167d-d98f197b3895
# ╠═165a709c-2499-11eb-24b6-29c7c9cb61dd
# ╟─015e2db4-2499-11eb-2c64-7331c5e90665
# ╠═1f6b1dd0-2499-11eb-325a-b31825d06f7f
# ╟─6dd5c5e8-2498-11eb-34e3-b33934a53da2
# ╠═9510dbc8-2553-11eb-2174-594852dee80b
# ╟─b4455d10-2572-11eb-0581-1352407edc27
# ╠═e5211554-255c-11eb-372f-29d8cb16e7f1
# ╠═ef578b0a-2557-11eb-3543-b9f6bcdd2a0a
# ╟─0ea094d8-2554-11eb-169a-d77d547d81ca
# ╠═f0bf97be-2555-11eb-1620-c73bb195232b
# ╟─f47a867e-2556-11eb-3115-d3854c0c74a8
# ╠═a37680d0-2557-11eb-3808-eb7d07f9c3f0
# ╟─b042d87c-2557-11eb-25d9-bb8f9b8cb6cc
# ╠═d84b6a9e-2557-11eb-1ef7-a78495880335
# ╟─96f09ce0-255c-11eb-324e-450d014069c2
# ╠═813415e8-255d-11eb-2a46-ede41cb7b610
# ╠═8b713356-255d-11eb-2df9-41b1d0627975
# ╟─5c4f983c-2559-11eb-0a55-8fb0be7534bb
# ╠═ebe1c2fa-255d-11eb-1ba4-f3a0d3a0dc8f
# ╟─f8000632-255d-11eb-305a-470d175e6527
# ╠═6be31e6c-255a-11eb-3b66-13b21c99116b
# ╟─4d682544-255b-11eb-3e87-6fb0855e6237
# ╠═05afb49a-2558-11eb-2dec-5d5b443d4508
# ╟─03393b4c-255c-11eb-08f2-f7827e2c0ff6
# ╟─daf7d424-255e-11eb-1ce8-ebd60e000a63
# ╠═7a42a3b0-255f-11eb-08a6-3766d4bf376a
# ╟─cd3265d8-255f-11eb-2a6f-3bf2170a1b21
# ╠═e97029ec-255f-11eb-3a0e-479d1539a3e4
# ╟─a1b3d7ac-2569-11eb-195b-9744328be99f
# ╠═7410d6be-256a-11eb-2aa4-831468212a2c
# ╟─90e53618-256a-11eb-22ed-7328e83dbf66
# ╠═df597372-256a-11eb-28f8-bf49031f34ec
# ╠═5b724dd0-256b-11eb-276f-b19c09fe9620
# ╠═78b81992-256b-11eb-3b2b-5d23d8473e69
# ╠═e91fe1a2-256a-11eb-2cab-4de02bb56fa2
# ╟─a2886a38-256b-11eb-06a0-d1589f9db671
# ╠═b2b64ea2-256b-11eb-30f0-61f31e54acf4
# ╠═2cd2e754-256c-11eb-13f9-0febceed2d52
# ╟─f0cb9660-256c-11eb-1fb8-f5f7dcb750ea
# ╠═db257316-256d-11eb-2bcb-d1d81c78c6b7
# ╠═060fb2ba-256e-11eb-0aac-95f4cbccbd4f
# ╠═0f657bda-256e-11eb-3d6b-97493d220908
# ╟─568bc906-256e-11eb-1206-85f9dbed9fa8
# ╠═61d5bfd4-256d-11eb-1edd-77ec474964c4
# ╟─5385641c-256f-11eb-3039-893e8d1c54d7
# ╠═af3ddd70-256f-11eb-133b-a7ed3cafbaa9
# ╟─32ae985e-2570-11eb-2442-ab73a7fdcc8c
# ╠═53c09572-2570-11eb-1b02-f3b2631bc847
# ╠═4575a944-2570-11eb-1362-afda09b198e1
# ╟─7ca9de1e-2570-11eb-16bf-89d6cc968867
# ╠═ab914460-2570-11eb-1e79-7d844aeb41ca
