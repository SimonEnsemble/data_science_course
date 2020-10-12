### A Pluto.jl notebook ###
# v0.11.14

using Markdown
using InteractiveUtils

# ╔═╡ 77fcc784-0534-11eb-03d4-1d4f9ccbfd83
using DataFrames, CSV, Dates, Statistics, PyPlot

# ╔═╡ afc9ecb0-067d-11eb-148f-97e8e7d76b19
# a cool style
# see https://matplotlib.org/3.2.1/gallery/style_sheets/style_sheets_reference.html
PyPlot.matplotlib.style.use("seaborn-whitegrid")

# ╔═╡ b4a6d968-0534-11eb-25ec-bfffc1768364
md"
# the avocado data set

source: [Kaggle](https://www.kaggle.com/neuromusic/avocado-prices) but I threw in some missing values to make it more interesting.

learning objectives:
* learning to manipulate data tables in `DataFrames`
* learning to make data visualizations

![avocado tree](https://upload.wikimedia.org/wikipedia/commons/thumb/f/f2/Persea_americana_fruit_2.JPG/800px-Persea_americana_fruit_2.JPG)
"

# ╔═╡ e54b7204-0534-11eb-030a-0f70b7795bd9
md"
read in the `avocado.csv` file as a `DataFrame` _without_ deleting the problematic first line of the `.csv` file.

hint: see the `header` keyword argument of `CSV.read` [docs](https://juliadata.github.io/CSV.jl/v0.6/#CSV.read).
"

# ╔═╡ f7107c7a-0534-11eb-27fa-6ba9021843c1


# ╔═╡ 0689eb44-0535-11eb-314d-fb8fc1a49a6f
md"
how many entries of the price are `missing`? see `ismissing` [docs](https://docs.julialang.org/en/v1/base/base/#Base.ismissing).
"

# ╔═╡ 0689c8b2-0535-11eb-148c-b748ef369b8e


# ╔═╡ cca7c0ac-0536-11eb-018d-25bb8609bddc
md"
go ahead and drop all rows that have `missing` values. i.e., alter the `DataFrame`.

if this doesn't work, then look at the `copycols` keyword argument of `CSV.read` in its [docs](https://juliadata.github.io/CSV.jl/v0.6/#CSV.read)

when it works, confirm that you see fewer rows, since some were dropped.
"

# ╔═╡ 0686e908-0535-11eb-07c7-4310aab61b5a


# ╔═╡ c11b81fe-06a0-11eb-1489-377cfeccc438
md"
how many different regions are represented in this data set?
"

# ╔═╡ cf2b51ca-06a0-11eb-2346-dbdd82bdb979


# ╔═╡ da06fe8c-06a0-11eb-1f3b-97bfe55e78e4
md"
what is the earliest and latest date that the price of an avocado was recorded in this data set?

!!! hint
    Julia has its own `Date` type to handle dates. see [docs](https://docs.julialang.org/en/v1/stdlib/Dates/). the `maximum` and `minimum` functions work with `Date`s.
"

# ╔═╡ 14516294-06a1-11eb-2f89-9f00bf7acb17


# ╔═╡ 1a0aa5f6-06a1-11eb-1dfd-bfb6cd66ce86


# ╔═╡ cd601dd2-0536-11eb-26cf-739a3448db57
md"
what is the mean price (over time) of an avocado in Portland?

!!! hint
    use the `filter` function.
"

# ╔═╡ fe2ab4ee-0537-11eb-0825-97af730ff5e8


# ╔═╡ 11096ad8-066e-11eb-0334-0705e2e69a79
md"
on what day was the price of an avocado the cheapest in Boston?
"

# ╔═╡ 5b0bcedc-066e-11eb-1236-f9131e77b5be


# ╔═╡ 3c2be120-066e-11eb-2890-a152fbe917d4


# ╔═╡ 72748576-066d-11eb-2a6e-570a127326ee
md"
which 5 regions have the highest mean price (over time) of an avocado?
"

# ╔═╡ d2a535ba-066d-11eb-32ef-ff10c48dffa7
md"
!!! hint
    use the `by` function to split the `DataFrame`, apply a function to a certain column, and aggregate the result into a new `DataFrame`, that you can then `sort`.
"

# ╔═╡ 91429854-066d-11eb-21d4-dbeb4d8995cd


# ╔═╡ d7a23b16-066e-11eb-34ed-1fcc91b19476
md"
find the unique values in the `type` column, so we know what types of avocadoes there are.
"

# ╔═╡ e4f3e4b8-066e-11eb-37f8-750ccb419219


# ╔═╡ 6dc2f26e-066e-11eb-0f64-ffa9c9b30045
md"
plot a histogram to show the distribution of the price of an avocado in Portland.

show two histograms on top of each other with transparency (pass `alpha=0.3` to `hist`) and two different colors. one histogram should represent the type of avocados that are conventional, the other organic. draw a legend that indicates which histogram is which. 

!!! hint
    see the `hist` function in matplotlib [here](https://matplotlib.org/3.3.1/api/_as_gen/matplotlib.pyplot.hist.html). also, use the `groupby` function to group the avocados in Portland by `type`. pass `label=avocado_type` into the `hist` function to label the histogram. then `legend()` will draw a legend. 
"

# ╔═╡ 0d19344a-066f-11eb-2c01-e75389d98097


# ╔═╡ e8b8970e-06a2-11eb-20d1-db6602f080e1
md"
depict the same information (difference in distribution of price among organic vs. conventional avocados) with a boxplot. see [here](https://matplotlib.org/3.1.1/api/_as_gen/matplotlib.pyplot.boxplot.html).
"

# ╔═╡ 386161b8-06a2-11eb-0f5e-892a482e5f11


# ╔═╡ 5833bda4-0697-11eb-136d-a90eb4de53db
md"
list the dates where organic avocadoes cost more than \$2.50 in Portland.

!!! hint
    use the `filter` function with two conditions.
"

# ╔═╡ 76dc9a78-0697-11eb-39d4-95a788b221f6


# ╔═╡ d3b84900-067d-11eb-18a2-c50b6b5f019a
md"
for Portland, make a scatter plot of the price of an organic avocado vs. a conventional avocado. each point on this scatter plot will represent a day. the idea is to see, on a typical day, the difference in price between av so you need to pair up days. plot a dashed diagonal line for equality.

!!! hint
    this one is difficult.
"

# ╔═╡ 216f7492-067f-11eb-2efa-c777fca94a4d


# ╔═╡ 55a842a2-0696-11eb-16d6-3b4cca494689


# ╔═╡ fa4d187c-0699-11eb-213f-c99e5792d76f
md"
we aim to study how the cost of organic avocados changes over the season in Boise.

make a bar plot with 12 bars, one for each month. the length of each bar should be the average avocado price for that month. make the bars horizontal and put the actual month names instead of numbers for the y-labels (\"Jan.\" instead of \"1\").

!!! hint
    it might make the problem easier if you define a new column in the `DataFrame`, `month`.

!!! hint
    Julia handles dates with a `Date` type. see [docs](https://docs.julialang.org/en/v1/stdlib/Dates/). get the month of a date with the function `month`.

!!! hint
    use the `by` function to group by month, then get the mean of the price column among the groups, then combine the result. this is what `by` does!

```julia
month(Date(\"2015-12-27\")) # 12
```
"

# ╔═╡ 180646d6-069a-11eb-3a9a-21b52520f00b


# ╔═╡ 1dfc5f0c-069b-11eb-2ed4-977265072617


# ╔═╡ 78a0d204-069a-11eb-1f74-33c19a23ced8


# ╔═╡ a2b16918-069b-11eb-146b-35a1a096f9c5


# ╔═╡ Cell order:
# ╠═77fcc784-0534-11eb-03d4-1d4f9ccbfd83
# ╠═afc9ecb0-067d-11eb-148f-97e8e7d76b19
# ╟─b4a6d968-0534-11eb-25ec-bfffc1768364
# ╟─e54b7204-0534-11eb-030a-0f70b7795bd9
# ╠═f7107c7a-0534-11eb-27fa-6ba9021843c1
# ╟─0689eb44-0535-11eb-314d-fb8fc1a49a6f
# ╠═0689c8b2-0535-11eb-148c-b748ef369b8e
# ╟─cca7c0ac-0536-11eb-018d-25bb8609bddc
# ╠═0686e908-0535-11eb-07c7-4310aab61b5a
# ╟─c11b81fe-06a0-11eb-1489-377cfeccc438
# ╠═cf2b51ca-06a0-11eb-2346-dbdd82bdb979
# ╟─da06fe8c-06a0-11eb-1f3b-97bfe55e78e4
# ╠═14516294-06a1-11eb-2f89-9f00bf7acb17
# ╠═1a0aa5f6-06a1-11eb-1dfd-bfb6cd66ce86
# ╟─cd601dd2-0536-11eb-26cf-739a3448db57
# ╠═fe2ab4ee-0537-11eb-0825-97af730ff5e8
# ╟─11096ad8-066e-11eb-0334-0705e2e69a79
# ╠═5b0bcedc-066e-11eb-1236-f9131e77b5be
# ╠═3c2be120-066e-11eb-2890-a152fbe917d4
# ╟─72748576-066d-11eb-2a6e-570a127326ee
# ╟─d2a535ba-066d-11eb-32ef-ff10c48dffa7
# ╠═91429854-066d-11eb-21d4-dbeb4d8995cd
# ╟─d7a23b16-066e-11eb-34ed-1fcc91b19476
# ╠═e4f3e4b8-066e-11eb-37f8-750ccb419219
# ╟─6dc2f26e-066e-11eb-0f64-ffa9c9b30045
# ╠═0d19344a-066f-11eb-2c01-e75389d98097
# ╟─e8b8970e-06a2-11eb-20d1-db6602f080e1
# ╠═386161b8-06a2-11eb-0f5e-892a482e5f11
# ╟─5833bda4-0697-11eb-136d-a90eb4de53db
# ╠═76dc9a78-0697-11eb-39d4-95a788b221f6
# ╟─d3b84900-067d-11eb-18a2-c50b6b5f019a
# ╠═216f7492-067f-11eb-2efa-c777fca94a4d
# ╠═55a842a2-0696-11eb-16d6-3b4cca494689
# ╟─fa4d187c-0699-11eb-213f-c99e5792d76f
# ╠═180646d6-069a-11eb-3a9a-21b52520f00b
# ╠═1dfc5f0c-069b-11eb-2ed4-977265072617
# ╠═78a0d204-069a-11eb-1f74-33c19a23ced8
# ╠═a2b16918-069b-11eb-146b-35a1a096f9c5
