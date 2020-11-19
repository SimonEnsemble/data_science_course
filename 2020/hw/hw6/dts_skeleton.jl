### A Pluto.jl notebook ###
# v0.12.10

using Markdown
using InteractiveUtils

# ╔═╡ 0e3a4ce2-2a12-11eb-01c0-d53acd9ee763
using CSV, DataFrames, PyPlot, ScikitLearn, Random

# ╔═╡ 411dca1e-2a12-11eb-1b9c-c7d26f8ea188
begin
	# decision tree classifier
	@sk_import tree : DecisionTreeClassifier
	# K-folds cross validation
	using ScikitLearn.CrossValidation: KFold
end

# ╔═╡ 47fa0bda-2a11-11eb-2236-bf08700be4d8
your_name = "Oslo 🐶"

# ╔═╡ 130a3710-2a11-11eb-3b9b-4dc7d1cf2a6b
md"
# hw: classification with decision trees

learning objectives:
* understand the inner-workings of decision trees
* practice cross-validation and tuning the hyperparameter of a machine learning algorithm

_student name_: $your_name

"

# ╔═╡ 05f51646-2a14-11eb-0740-f75ff7eadd7f
PyPlot.matplotlib.style.use("https://gist.githubusercontent.com/JonnyCBB/c464d302fefce4722fe6cf5f461114ea/raw/64a78942d3f7b4b5054902f2cee84213eaff872f/matplotlibrc")

# ╔═╡ 70afc574-2a11-11eb-3fbf-c597fa406ce7
md"
resources on decision trees:
* interactive explanation for an introduction [here](http://www.r2d3.us/visual-intro-to-machine-learning-part-1/)
* the machine learning textbook [here](http://faculty.marshall.usc.edu/gareth-james/ISL/ISLR%20Seventh%20Printing.pdf) section 8.1
"

# ╔═╡ eedf6026-2a11-11eb-10c2-3b46c99bd61c
md"
## read in the wine data

[source](https://archive.ics.uci.edu/ml/datasets/Wine).

each row of `wine_data.csv` represents a bottle of wine. to explain the columns, two measurements are made on each bottle:
* `alcohol`: the first feature, percent alcohol in the wine
* `malic_acid`: the second feature, malic acid concentration in the wine
and each wine has a label:
* `variety`: the label, i.e. what variety/class of wine it is. the label is not explicitly given, but think: Pinot Noir (-1) vs. Syrah (1).

🐶 read in the data as a data frame.
"

# ╔═╡ 0944094e-2a12-11eb-0ea7-1f74964dfeb6


# ╔═╡ 2d400ffe-2a13-11eb-27b8-a19b7d4fec34
md"
🐶 how many wine bottles of each variety are in the data set?
"

# ╔═╡ 59221cb6-2a13-11eb-1467-afb291003fad


# ╔═╡ 70f39b94-2a13-11eb-3a49-f115fc3fc3e7
md"
## visualizing the data

🐶 to show the distribution and correlation of the two features, create a scatter plot matrix like [here](https://seaborn.pydata.org/examples/scatterplot_matrix.html). this is a two-by-two plot, where the plots on the diagonal show the distribution of the features via histograms and the plots on the off-diagonal show a scatter of the features. 
"

# ╔═╡ 2547fa92-2a14-11eb-355c-8f81fe518551
begin
	fig, axs = subplots(2, 2)
	for i = 1:2
		for j = 1:2
			if i == j
				# change each line below
				axs[i, j].hist(rand(100))
				axs[i, j].set_xlabel("blah blah")
				axs[i, j].set_ylabel("blah")
			elseif j > i
				# change each line below
				axs[i, j].scatter(rand(12), rand(12))
				axs[i, j].set_xlabel("blah")
				axs[i, j].set_ylabel("blah blah")
			else
				axs[i, j].axis("off")
			end
		end
	end
	tight_layout()
	gcf()
end

# ╔═╡ 66e645f4-2a14-11eb-3092-6b7e12e4a802
md"
🐶 now that we've investigated the distribution of and relationship between the features, now let's investigate the relationship between the labels on the wine (the varieties) and the features. to do this, draw a scatter plot of the data (the wines) in 2D feature space. 
* color each data point by the class label (two different colors).
* use a different marker for each class
* use hollow circles to help see points that are overlapping
* include a legend with the markers that indicate which class is which
"

# ╔═╡ 4bdd1e08-2a15-11eb-3002-e57e8c43a568


# ╔═╡ 2904cfec-2a16-11eb-302f-734339176f80
md"
## getting data ready for input to scikitlearn

this is to get our data in a format for building a predictive model in scikitlearn.

🐶 convert the wine data frame into a feature matrix `X` and a column vector `y` containing the labels. row `i` of `X` and entry `i` of `y` correspond to the feature vector and label, respectively, of wine `i`. 
* construct a feature matrix `X` that has `nb_wines` rows and `2` columns (one column for each feature)
* construct a column vector `y` with the labels

in our in-class activity, we wrote a function for this. but now, we'll convert the entire data into a feature matrix `X` and label vector `y`, then later slice out the entries we need when we do K-folds cross validation.
"

# ╔═╡ 1125d548-2a17-11eb-2a5a-89eeed43c5d8


# ╔═╡ 85ef36e2-2a19-11eb-2224-b76c1789d09d
md"
## warm-up training of a decision tree

🐶 train a decision tree classifier on *all* of the data, with a maximum depth, `max_depth`, of 15. see scikit-learn docs [here](https://scikit-learn.org/stable/modules/tree.html) for how to do this.

!!! hint
    to adjust the maximum depth that the tree is grown to, you'll need to pass a `max_depth` argument.
"

# ╔═╡ 40bae7e0-2a16-11eb-325f-b7c96f3b365d


# ╔═╡ 5bab6cc6-2a1a-11eb-0e79-632f2dd6ffb5
md"🐶 a new wine came along with `alcohol = 14.0` and `malic_acid=4`. use your trained decision tree to predict the variety of this wine. does the prediction make sense?
"

# ╔═╡ 7a02e184-2a1a-11eb-1742-396beff5bbc1


# ╔═╡ 7f087b1c-2a1a-11eb-3595-d713d74cc287


# ╔═╡ 43a4571c-2a1a-11eb-0495-4d02f0a63faf
md"🐶 use the `draw_decision_boundary` function below to visualize the decision boundary of your trained decision tree classifier.
* there is code missing inside the for loop. write code here to get the function to work and draw the decision boundary.
* re-draw the scatter plot of points with different colors for the wine varieties on top of this decision boundary with a `scatter` so you can readily see if the decision boundary makes sense.
"

# ╔═╡ b15be5c0-2a17-11eb-0d57-3f072233a695
function draw_decision_boundary(clf)
    alc = range(11.0, stop=14.5, length=150)
    ma = range(0.0, stop=6.0, length=150)
	
    dt_prediction = zeros(length(ma), length(alc))
    for i = 1:length(alc)
        for j = 1:length(ma)
			# write code here that fills `dt_prediction` 
			#   with a prediction from the decision tree.
			#   see our in-class activity.
			
			
			
        end
    end
    
	figure()
	contourf(alc, ma, dt_prediction, 
		[-1.0, 0.5, 2.0], alpha=0.2, colors=["C1", "C2"])
	# write code here for a scatter plot of your data.

	
	
    xlabel("alcohol")
    ylabel("malic acid")
	gcf()
end

# ╔═╡ b29117a8-2a17-11eb-250f-990346d096c7
draw_decision_boundary(dt) # dt = your trained decision tree classifier

# ╔═╡ 0a45640e-2a1b-11eb-1858-9b33fe81bbea
md"🐶 n.b. we trained the decision tree on _all_ of the data (don't do this in practice!).

evaluate the accuracy of the decision tree on the data on which it was trained (all of the data).

!!! hint
    use the `score` method of `DecisionTreeClassifier` see [scikitlearn docs](https://scikit-learn.org/stable/modules/generated/sklearn.tree.DecisionTreeClassifier.html).
"

# ╔═╡ 14bc62f4-2a1b-11eb-208c-d5435830a26b


# ╔═╡ 8cea4622-2a1b-11eb-3ea4-0d41cdeaacc4
md"
🐶 you should get perfect accuracy. 
does this imply that this decision tree will have close to 100% accuracy on unseen data (i.e., on new wines?)? why or why not? should we be impressed?
"

# ╔═╡ a2ace758-2a1b-11eb-1911-8f242aff8067
md"
well, [... your answer here...]
"

# ╔═╡ a9c57872-2a1b-11eb-24fb-27153278bc73
md"
## properly training a decision tree and evaluating its generalization error via K-folds cross validation

🐶 use $K=5$-fold cross validation to:
* choose the optimal `max_depth` hyperparameter in the decision tree classifier
* assess the accuracy of the classifier on unseen data

plot the average test set accuracy (average over the $K$ folds) against the `max_depth` hyperparameter used.

report the best `max_depth` hyperparameter and the associated average test set error (`argmax` might be useful). this test set error is a quality metric of how well the decision tree will perform on new, unseen data that is not in the training set. i.e. it is a metric of the generalization error. 

explore all max depths in the range from 1 to 15 (inclusive).
"

# ╔═╡ f3039e82-2a17-11eb-3939-1bc829f6b9b9


# ╔═╡ 14f25f00-2a19-11eb-006d-4d556dd61f48
md"
🐶 retrain a decision tree on _all_ of the data with the optimal `max_depth` hyperparameter. this is the decision tree model that you would deploy in the real world for new wines that come along.

use `draw_decision_boundary` plot the decision boundary of this model. compare it to the decision boundary that you intially had when `max_depth=15`. what are your thoughts?
"

# ╔═╡ d13b4e18-2a20-11eb-1449-37896116aef3


# ╔═╡ 99928028-2a1c-11eb-01c0-b1230943bd70
md"
## visualizing a decision tree
a huge advantage of decision trees is that they are interpretable!

🐶 use `plot_tree`, [docs here](https://scikit-learn.org/stable/modules/generated/sklearn.tree.plot_tree.html), to draw the decision tree clasifier that you trained on all of the data with the optimal hyperparamter (optimal `max_depth`).

!!! hint
    pass `feature_names=[\"alcohol\", \"malic acid\"]` and `class_names=[\"Pinot Noir\", \"Syrah\"]` to `plot_tree` to make the visualization more interpretable. also, call `gcf()` after you call `plot_tree` to show it!
"

# ╔═╡ d445548c-2a20-11eb-1bf2-ad5ad70b7bed


# ╔═╡ Cell order:
# ╟─130a3710-2a11-11eb-3b9b-4dc7d1cf2a6b
# ╠═47fa0bda-2a11-11eb-2236-bf08700be4d8
# ╠═0e3a4ce2-2a12-11eb-01c0-d53acd9ee763
# ╠═411dca1e-2a12-11eb-1b9c-c7d26f8ea188
# ╠═05f51646-2a14-11eb-0740-f75ff7eadd7f
# ╟─70afc574-2a11-11eb-3fbf-c597fa406ce7
# ╟─eedf6026-2a11-11eb-10c2-3b46c99bd61c
# ╠═0944094e-2a12-11eb-0ea7-1f74964dfeb6
# ╟─2d400ffe-2a13-11eb-27b8-a19b7d4fec34
# ╠═59221cb6-2a13-11eb-1467-afb291003fad
# ╟─70f39b94-2a13-11eb-3a49-f115fc3fc3e7
# ╠═2547fa92-2a14-11eb-355c-8f81fe518551
# ╟─66e645f4-2a14-11eb-3092-6b7e12e4a802
# ╠═4bdd1e08-2a15-11eb-3002-e57e8c43a568
# ╟─2904cfec-2a16-11eb-302f-734339176f80
# ╠═1125d548-2a17-11eb-2a5a-89eeed43c5d8
# ╟─85ef36e2-2a19-11eb-2224-b76c1789d09d
# ╠═40bae7e0-2a16-11eb-325f-b7c96f3b365d
# ╟─5bab6cc6-2a1a-11eb-0e79-632f2dd6ffb5
# ╠═7a02e184-2a1a-11eb-1742-396beff5bbc1
# ╠═7f087b1c-2a1a-11eb-3595-d713d74cc287
# ╟─43a4571c-2a1a-11eb-0495-4d02f0a63faf
# ╠═b15be5c0-2a17-11eb-0d57-3f072233a695
# ╠═b29117a8-2a17-11eb-250f-990346d096c7
# ╟─0a45640e-2a1b-11eb-1858-9b33fe81bbea
# ╠═14bc62f4-2a1b-11eb-208c-d5435830a26b
# ╟─8cea4622-2a1b-11eb-3ea4-0d41cdeaacc4
# ╠═a2ace758-2a1b-11eb-1911-8f242aff8067
# ╟─a9c57872-2a1b-11eb-24fb-27153278bc73
# ╠═f3039e82-2a17-11eb-3939-1bc829f6b9b9
# ╟─14f25f00-2a19-11eb-006d-4d556dd61f48
# ╠═d13b4e18-2a20-11eb-1449-37896116aef3
# ╟─99928028-2a1c-11eb-01c0-b1230943bd70
# ╠═d445548c-2a20-11eb-1bf2-ad5ad70b7bed
