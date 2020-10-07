### A Pluto.jl notebook ###
# v0.12.0

using Markdown
using InteractiveUtils

# ╔═╡ 969bb65e-0846-11eb-0a15-69b73d5e8455
using PyPlot, DataFrames, CSV, Statistics

# ╔═╡ c078c976-0846-11eb-0857-ad714a169717
my_name = "Joe King"

# ╔═╡ af83dee4-0846-11eb-0988-254ab3e2be6b
md"
# hw2

learning objectives:
* manipulate data tables
* make quality data visualizations

student: $my_name
"

# ╔═╡ c8c0c250-0846-11eb-33fc-0700ef70825f
md"
### gapminder data

*goal*: make a scatter plot of life expectancy (y-axis) against income per person (x-axis), where each point represents a country. use the data from the year 2011. make the x-axis on a log scale. be sure to include units and axis labels.

data:
* `GDP_per_capita.csv` has a list of countries with GDP in different years
* `life_expectancy.csv` has a list of countries with life expectancy in different years

source: [Gapminder](https://www.gapminder.org/data/)

*you must read in the files as they are and do all computations in Julia (not in Excel, for example).*

!!! hint
    you'll need to `join` the `DataFrames` to make this plot, and `rename` some columns so that the `join` works.

(1) read in `GDP_per_capita.csv` as `df_gdp`. keep only the `:country` and `Symbol(`\"2011\")` columns, since those are the only ones we need.
"

# ╔═╡ 78feee6e-0847-11eb-296f-21b8e2b3a1b3


# ╔═╡ deecf8ae-08d3-11eb-2b6c-e95e5fcede8b
md"
(2) read in `life_expectancy.csv` as `df_life`. keep only the `:country` and `Symbol(`\"2011\")` columns, since those are the only ones we need.
"

# ╔═╡ dc19f0aa-08d3-11eb-33b8-4724b8e2875d


# ╔═╡ c220a44e-08d5-11eb-2d78-e5831d149ebb
md"
(3) `join` the two data frames by `:country` so you have a new data frame, `df_j`, that appears:

you'll need to rename the 2011 column in both so that they are unique, e.g. change the column names to `life_expectancy` and `gdp_per_cap`, where it is understood that they correspond to 2011. try to join the data frames without changing the column names first if you don't believe me!
"

# ╔═╡ 1212c6b2-08d6-11eb-0e78-ffe701f4423f


# ╔═╡ bda86b3a-08d1-11eb-3370-3de0e8fef367


# ╔═╡ af5445ae-08d6-11eb-1bf5-6518d70085ca
md"
(4) drop all rows that contain `missing` values.
"

# ╔═╡ 15a94598-08d7-11eb-0b8f-d503567565cd


# ╔═╡ 20c54b5e-08d7-11eb-25d3-41d652132e65
md"
(5) make your scatter plot. using `df_j`, now that you have the life expectancy and GDP per capita matched up with each country properly.

!!! warning
    think about why you needed to `join` the two data frames, don't just listen to my instructions! why not just:
    ```
    plot(df_life[:, Symbol(\"2011\")], df_gdp[:, Symbol(\"2011\")]) # wrong
    ```
"

# ╔═╡ 7c31d0a8-08d7-11eb-3211-5f80305b3fc1


# ╔═╡ ac374b18-08d7-11eb-3fb0-8568e5054050
md"

💭_ambitious Beavers_: a data viz challenge is to re-create [this Gapminder viz](https://www.gapminder.org/tools/#$chart-type=bubbles). the size is proportional to the population of the country and the color indicates the continent. you can make an animation by looping over the years and doing what you did here.

_note on causality_: the independent variable is typically on the x-axis, whereas the dependent variable is typically on the y-axis. that I chose to put the income per person on the x-axis reflects my a priori belief that life expectancy is dependent in a causal sense on the income per person more so than the other way around. we can postulate mechanisms by which this could be true, e.g. since good health care costs money. however, we could also argue the reverse: if the life expectancy of folks in a population is low owing to disease, then they won't be able to be productive and earn a lot of money. so, this is a social science question, and it would be totally fine to switch the x- and y-axis in this problem. without further study, we can only say that we are looking at the _correlation_ between these two variables. I like the idea of [these authors](https://arxiv.org/pdf/1809.09328.pdf) in Fig. 5: putting one variable in the x-axis almost tells the audience what you perceive to be the independent variable.

!!! random
    is GDP per capita = income per person? this is an economics question.
"

# ╔═╡ 2b8cf6f2-0848-11eb-266a-ff8503100051
md"
# automobiles


![](https://upload.wikimedia.org/wikipedia/commons/f/f0/Ford_Pinto.jpg)

(1) read in the CSV file `automobiles.csv` ([source of data](https://archive.ics.uci.edu/ml/datasets/automobile)). the names of the columns are not in the `.csv` file but are described [here](http://mlr.cs.umass.edu/ml/machine-learning-databases/auto-mpg/auto-mpg.names). for your convenience, I made an array of the column names below. name your data frame `df_auto`.
"

# ╔═╡ 72707a88-0848-11eb-1afa-ed88051dbc5c
automobile_col_names = [:mpg, :cylinders, :displacement, :horsepower, :weight, 
	                    :acceleration, :model_year, :origin, :car_name]

# ╔═╡ 7c513efc-0848-11eb-1fa6-b3801eba964e


# ╔═╡ 8b97908c-0848-11eb-3474-490d8d0f6cfd
md"
(2) how many automobiles are there in the data set?
"

# ╔═╡ 9142e84c-0848-11eb-3987-0f57cb7718b2


# ╔═╡ 91f9b644-0848-11eb-2c52-5156b2fcaef8
md"
(3) are there any automobiles missing information about their horsepower? how many?
"

# ╔═╡ b4556986-0848-11eb-09f0-b9465dad6d55


# ╔═╡ b51aaf98-0848-11eb-309a-a7fb8f1ce23c
md"
(4) drop the rows from the `DataFrame` that contain a `missing` attribute
"

# ╔═╡ c1b1aaa4-0848-11eb-00e5-8747afb44aaf


# ╔═╡ c2525c06-0848-11eb-003d-fb003edac637
md"
(5) make a scatter plot of the data such that:

* each point represents an automobile
* x-axis is horsepower
* y-axis is mpg (miles per gallon)
* color of point is used to illustrate acceleration (pass `c=x` into `scatter` with `x::Array{Float64, 1}` to color each point according to an array)
* a colorbar shows how the scale is depicted `colorbar(label=\"blah\")`
* the colorbar, x-axis, and y-axis are labeled
"

# ╔═╡ d598dd3a-0848-11eb-20ac-798c35f94df4


# ╔═╡ d23bfd46-0848-11eb-1552-45d37c4e7025
md"
(6) remove from the `DataFrame` all automobiles that are not Fords. All Ford automobiles contain the string \"ford\" in the `:car_name` column. the function `occursin` will be useful here.

```julia
occursin(\"ford\", \"i love ford pintos\") # true
occursin(\"ford\", \"i love subarus\") # false
```
"

# ╔═╡ f201ed2c-0848-11eb-2d6b-832c1baaf8ca


# ╔═╡ f2871b28-0848-11eb-00c3-01f58fe51263
md"
(7) of the Ford automobiles, how many unique numbers of cylinders are there?
"

# ╔═╡ 070ab6ea-0849-11eb-2651-5b73bab06d63


# ╔═╡ 0801d48e-0849-11eb-392f-8972f1c2268e
md"
(8) make a scatter plot for all Ford automobiles such that:

* each point represents an automobile
* x-axis is horsepower
* y-axis is mpg (miles per gallon)
* x-axis, and y-axis are labeled.
* title is \"Fords\"
* automobiles with different numbers of cylinders are depicted by different markers and different colors, and automobiles with the same number of cylinders share the same marker and color. for example:
    * 4 cylinders, use `marker=\"o\"` and `color=\"C0\"`
    * 6 cylinders, use `marker=\"s\"` and `color=\"C1\"`
    * 8 cylinders, use `marker=\"+\"` and `color=\"C2\"`
    I suggest a `Dict` to map the number of cylinders to a marker.
* a legend depicts the symbol and color for each number of cylinders

!!! hint
    use a `groupby` and interate over groups with different number of cylinders to make your plot. don't do it manually!
"

# ╔═╡ 82c3cc0e-0849-11eb-11fc-615e9dae9850


# ╔═╡ 85268dc4-0849-11eb-3380-45fa846dd954
md"
## ramen ratings

see `ramen-ratings.csv`.

> The Ramen Rater is a product review website for the hardcore ramen enthusiast, with over 2500 reviews to date. Each record in the dataset is a single ramen product review. Review numbers are contiguous: more recently reviewed ramen varieties have higher numbers. Brand, Variety (the product name), Country, and Style (Cup? Bowl? Tray?) are pretty self-explanatory. Stars indicate the ramen quality, as assessed by the reviewer, on a 5-point scale; this is the most important column in the dataset!

The `:top_ten` ramen attribute is `missing` if the ramen never placed in the top ten; if it is not `missing`, the `:top_ten` attribute gives us the year it placed in the top ten and its place.

source: [Kaggle](https://www.kaggle.com/residentmario/ramen-ratings/data)

(1) read in `ramen-ratings.csv` as a `DataFrame`, `df_ramen`, to work with.
"

# ╔═╡ f8442fbe-0849-11eb-17d7-4d631c2cda95


# ╔═╡ 3aaa919c-084d-11eb-0954-41eb9474c5c7
md"
(1.5) what are the names of the columns?"

# ╔═╡ 459f87b0-084d-11eb-34be-0d4eecd2a4a4


# ╔═╡ 010a12a8-084a-11eb-2700-19626b87a1a5
md"
(2) how many ratings are in the data set?
"

# ╔═╡ 068c1f82-084a-11eb-30aa-5d60427ae4bd


# ╔═╡ 07157c78-084a-11eb-2c0b-c54d504b903b
md"
(3) oddly, the `:stars` column appears as an array of `String`s, even though they should be numbers!

why? because `\"Unrated\"` appears as the `:stars` attribute in a few rows and prevents `CSV.jl` from reading in the `:stars` column as all `Float64`s.

remove all rows of the `DataFrame` that have `\"Unrated\"` as the `:stars` attribute.

!!! hint
    use `filter!`
"

# ╔═╡ 35e1057c-084a-11eb-2ca2-5197ed29f0ec


# ╔═╡ c61e349e-084e-11eb-2b8f-df45b955f1f7


# ╔═╡ 36b3881c-084a-11eb-1622-611cd8c1ff6c
md"
(4) the `:stars` column still appears as `String`s. Convert it to `Float64`s by using `parse`, which works as follows:
"

# ╔═╡ 55fc81ba-084a-11eb-11f2-79b147c4859e
parse(Float64, "3.76") # String -> Float64 🆒

# ╔═╡ 54f2a6d2-084a-11eb-07ec-a9b11468869b
md"
use `parse`, operated element-wise on the `:stars` column, to convert the ratings to `Float64`s

!!! hint
    overwrite the column. you'll need to use `df_ramen[!, :stars] = `... to overwrite the column.
"

# ╔═╡ 9eb246d2-084b-11eb-25ac-576168b24ed0


# ╔═╡ b9fff24c-084e-11eb-1de6-5955cc2de858
df_ramen[:, :stars]

# ╔═╡ 9f82f822-084b-11eb-073a-83b9d8df878b
md"
(5) What is the highest rated variety of ramen that satisfies all of the following attributes: 
* \"Nissin\" brand
* mentions \"Beef\" in the variety
* \"Pack\" style

!!! hint
    use `filter` and `sort`. return the first row of that sorted data frame.
"

# ╔═╡ b42c3bc6-084b-11eb-0a65-75692e6b2fba


# ╔═╡ b4b45a1a-084b-11eb-1811-7dfe7b645abc
md"
(6) ramen from how many different countries is rated?
"

# ╔═╡ b4442ca0-084f-11eb-174f-03c20246b347


# ╔═╡ c2374990-084b-11eb-0bca-ab96aef69b4a
md"
(7) construct a new `DataFrame`, `df_by_country`, from the data, whose rows are the countries and whose two columns, `:avg_rating` and `nb_ratings`, give the average and number of ratings of ramen, respectively, from that country.

```
	country	avg_rating	nb_ratings
	String	Float64	Int64
1	Japan	3.98161	352
2	Taiwan	3.6654	224
...
```

!!! hint
    use `by`. 
    * split the `DataFrame` into groups, partitioned by `:country`
    * apply the `mean` and `length` function to the ratings column. yes, you can pass multiple functions to be applied to different columns into `by`!
    * combine the result into one `DataFrame` with new columns `:avg_rating` and `:nb_ratings` containing the average and number of ramen ratings for each country.
"

# ╔═╡ 2015b7d6-084c-11eb-0a4d-eda3255bcc0e


# ╔═╡ 20c3cfb0-084c-11eb-3e1e-511a63a418c1
md"
(8) some countries do not have many ramens with ratings. let's drop countries from the data frame that have fewer than 100 ratings.
"

# ╔═╡ 3533d9cc-084c-11eb-08a7-dffc1732d987


# ╔═╡ a3e6ab4a-08da-11eb-2424-5d674df63e12
md"
(9) `sort!` `df_by_country` by the average rating.
"

# ╔═╡ b7e71b0c-08da-11eb-1365-93244bdde399


# ╔═╡ b8625076-08da-11eb-0c8b-ebb6e32a5965
md"
(10) make a bar plot. each country gets a bar to represent it. the length of the bar is proportional to the average rating of ramen in that country. use `df_by_country` to make the bar plot, which should only have 11 countries in it.
"

# ╔═╡ 12c89910-08db-11eb-3d9d-33b904ba76a2


# ╔═╡ Cell order:
# ╟─af83dee4-0846-11eb-0988-254ab3e2be6b
# ╠═c078c976-0846-11eb-0857-ad714a169717
# ╠═969bb65e-0846-11eb-0a15-69b73d5e8455
# ╟─c8c0c250-0846-11eb-33fc-0700ef70825f
# ╠═78feee6e-0847-11eb-296f-21b8e2b3a1b3
# ╟─deecf8ae-08d3-11eb-2b6c-e95e5fcede8b
# ╠═dc19f0aa-08d3-11eb-33b8-4724b8e2875d
# ╟─c220a44e-08d5-11eb-2d78-e5831d149ebb
# ╠═1212c6b2-08d6-11eb-0e78-ffe701f4423f
# ╠═bda86b3a-08d1-11eb-3370-3de0e8fef367
# ╟─af5445ae-08d6-11eb-1bf5-6518d70085ca
# ╠═15a94598-08d7-11eb-0b8f-d503567565cd
# ╟─20c54b5e-08d7-11eb-25d3-41d652132e65
# ╠═7c31d0a8-08d7-11eb-3211-5f80305b3fc1
# ╟─ac374b18-08d7-11eb-3fb0-8568e5054050
# ╟─2b8cf6f2-0848-11eb-266a-ff8503100051
# ╠═72707a88-0848-11eb-1afa-ed88051dbc5c
# ╠═7c513efc-0848-11eb-1fa6-b3801eba964e
# ╟─8b97908c-0848-11eb-3474-490d8d0f6cfd
# ╠═9142e84c-0848-11eb-3987-0f57cb7718b2
# ╟─91f9b644-0848-11eb-2c52-5156b2fcaef8
# ╠═b4556986-0848-11eb-09f0-b9465dad6d55
# ╟─b51aaf98-0848-11eb-309a-a7fb8f1ce23c
# ╠═c1b1aaa4-0848-11eb-00e5-8747afb44aaf
# ╟─c2525c06-0848-11eb-003d-fb003edac637
# ╠═d598dd3a-0848-11eb-20ac-798c35f94df4
# ╟─d23bfd46-0848-11eb-1552-45d37c4e7025
# ╠═f201ed2c-0848-11eb-2d6b-832c1baaf8ca
# ╟─f2871b28-0848-11eb-00c3-01f58fe51263
# ╠═070ab6ea-0849-11eb-2651-5b73bab06d63
# ╟─0801d48e-0849-11eb-392f-8972f1c2268e
# ╠═82c3cc0e-0849-11eb-11fc-615e9dae9850
# ╟─85268dc4-0849-11eb-3380-45fa846dd954
# ╠═f8442fbe-0849-11eb-17d7-4d631c2cda95
# ╟─3aaa919c-084d-11eb-0954-41eb9474c5c7
# ╠═459f87b0-084d-11eb-34be-0d4eecd2a4a4
# ╟─010a12a8-084a-11eb-2700-19626b87a1a5
# ╠═068c1f82-084a-11eb-30aa-5d60427ae4bd
# ╟─07157c78-084a-11eb-2c0b-c54d504b903b
# ╠═35e1057c-084a-11eb-2ca2-5197ed29f0ec
# ╠═c61e349e-084e-11eb-2b8f-df45b955f1f7
# ╟─36b3881c-084a-11eb-1622-611cd8c1ff6c
# ╠═55fc81ba-084a-11eb-11f2-79b147c4859e
# ╟─54f2a6d2-084a-11eb-07ec-a9b11468869b
# ╠═9eb246d2-084b-11eb-25ac-576168b24ed0
# ╠═b9fff24c-084e-11eb-1de6-5955cc2de858
# ╟─9f82f822-084b-11eb-073a-83b9d8df878b
# ╠═b42c3bc6-084b-11eb-0a65-75692e6b2fba
# ╟─b4b45a1a-084b-11eb-1811-7dfe7b645abc
# ╠═b4442ca0-084f-11eb-174f-03c20246b347
# ╟─c2374990-084b-11eb-0bca-ab96aef69b4a
# ╠═2015b7d6-084c-11eb-0a4d-eda3255bcc0e
# ╟─20c3cfb0-084c-11eb-3e1e-511a63a418c1
# ╠═3533d9cc-084c-11eb-08a7-dffc1732d987
# ╟─a3e6ab4a-08da-11eb-2424-5d674df63e12
# ╠═b7e71b0c-08da-11eb-1365-93244bdde399
# ╟─b8625076-08da-11eb-0c8b-ebb6e32a5965
# ╠═12c89910-08db-11eb-3d9d-33b904ba76a2
