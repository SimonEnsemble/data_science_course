### A Pluto.jl notebook ###
# v0.11.14

using Markdown
using InteractiveUtils

# ╔═╡ 1f916158-033c-11eb-3042-556418cdd61e
using DataFrames, CSV, Statistics

# ╔═╡ 1b29c142-033b-11eb-1fcd-3167939de8d2
md"
## introduction to `DataFrames`
tabular data manipulation

* a `DataFrame` is a popular data structure (in many languages) for storing data in tabular form (rows = instances, columns = features)
* the Julia package `DataFrames.jl` has many functions that operate on `DataFrames` that allow us to quickly query and manipulate data
* it can handle missing values efficiently
* the Julia package `CSV.jl` allows us to quickly and flexibly read CSV (= comma-separated value) files into `DataFrame`s and to write `DataFrame`s into a CSV file.

* `DataFrames.jl` [documentation](http://juliadata.github.io/DataFrames.jl/stable/)
* `CSV.jl` [documentation](https://juliadata.github.io/CSV.jl/stable/)
"

# ╔═╡ 31e25766-033c-11eb-3991-d55735f7977f
md"#### construct a `DataFrame` from scratch

this data table will contain information about cities in the US.

* rows = instances = cities
* columns = features = attributes of cities
"

# ╔═╡ 45806120-033c-11eb-359e-bfb9796dfee8
city = ["Corvallis", "Portland", "Eugene"]

# ╔═╡ bb7f6bbe-033c-11eb-0180-b7dcc731d8ed
population = [57961, 647805, 168916]

# ╔═╡ 2071b5b6-038f-11eb-182d-f392b2198f2e


# ╔═╡ bc58ac1c-033c-11eb-2698-f5fc4c20b8ce
md"#### append rows to a `DataFrame`

Bend, OR has a population of 94520.

Berkeley, CA has a population of 122324.

_approach 1_: think of rows of a `DataFrame` as an `Array`.
"

# ╔═╡ d172a490-033c-11eb-157e-6b95587099dd


# ╔═╡ 78b1f924-033d-11eb-2937-ff9634f5aa9a
md"
_approach 2_: think of rows of a `DataFrame` as a `Dict`ionary.
"

# ╔═╡ 4c407c9a-0353-11eb-0618-955711917f54


# ╔═╡ 5e293c82-033d-11eb-3984-7164bf9a351d
md"#### append columns to a `DataFrame`

annual rainfall [inches]:
* Corvallis: 51.0
* Portland: 43.0
* Eugene: 47.0
* Bend: 12.0
* Berkeley: 25.0
"

# ╔═╡ a5e9fc00-0353-11eb-1443-63b1c2edab7c


# ╔═╡ a67b30b0-0353-11eb-2d2f-871d7a5ffd36
md"
#### how many rows/columns are in the `DataFrame`?
"

# ╔═╡ 6249187e-035a-11eb-2f6a-d3318cf2a996


# ╔═╡ a3421e44-035e-11eb-3cf7-c70142f0591d
md"
#### renaming a column
"

# ╔═╡ a9d20a30-035e-11eb-14f4-ddf7cdaa34f6


# ╔═╡ 581bfc10-0362-11eb-1b29-cfd4320a5130
md"#### deleting a row"

# ╔═╡ 5d2707ac-0362-11eb-13e4-0d80fce58fea


# ╔═╡ b7fb0648-0390-11eb-2dc5-8b6935d2545c


# ╔═╡ b8de77aa-0362-11eb-36d9-1d905442ca13
md"
#### deleting rows that are not unique
"

# ╔═╡ cbf6250c-0362-11eb-365b-d327617f197e


# ╔═╡ 63716d2a-0362-11eb-3ce5-3b41d4bef04c
md"
#### deleting a column
"

# ╔═╡ 6d39deee-0362-11eb-3dbb-0f34eff54591


# ╔═╡ 5931d59e-0391-11eb-078b-ddb0bcaf6521


# ╔═╡ 630b0e48-035a-11eb-15a4-a312e6941407
md"#### what are the column names in the `DataFrame`?
the column names are `Symbol`s.

if you have a fancy `String` you want to convert into a `Symbol`, `Symbol(\"avg salary (USD)\")` will convert the `String` `\"avg salary (USD)\"` intoto a `Symbol`.
"

# ╔═╡ d5b7f084-035a-11eb-32ef-6d645b8e0a6e


# ╔═╡ 9003f068-0391-11eb-2806-a76e99deefaa


# ╔═╡ d663dd98-035a-11eb-156f-ff237a3944b6
md"
#### iterate through a `DataFrame`, row by row
"

# ╔═╡ 360eb67a-035b-11eb-2ab3-85adb264a387


# ╔═╡ 5d7208d4-035b-11eb-00ef-cd70b6cb79d3
md"
#### retreive a...

##### ... column

remember: the column names are `Symbol`s.

the columns are `Array`s.

_approach 1_: treat the `DataFrame` like a 2D array
"

# ╔═╡ 8d4f4ede-035b-11eb-2337-7bdb844389ae


# ╔═╡ 65353008-035b-11eb-261f-fffc23ec79a7
md"
_approach 2_: treat the `DataFrame` like a `struct`
"

# ╔═╡ 9b569b7c-035b-11eb-2d27-cd4458bbbc02


# ╔═╡ 7daa87e6-035b-11eb-3bb8-ff1bdd95714c
md"
##### ... row
"

# ╔═╡ f735e3ee-035b-11eb-33d1-755a1a9dc0a7


# ╔═╡ 1821e936-035c-11eb-0cb1-014241a2599e
md"
##### ... entry
"

# ╔═╡ 1ad35930-035c-11eb-165d-2d70f7b07713


# ╔═╡ 22623c72-035c-11eb-20f1-233b92ef16f9
md"
##### ... combination of rows/columns"

# ╔═╡ 35c1b9a8-035c-11eb-05f6-67e7bd5ef6e3


# ╔═╡ 9e01dd3a-0362-11eb-3d19-392ec2d06bd6
md"
#### find unique entries of a column
"

# ╔═╡ a6f99cc8-0362-11eb-1801-2dd5fa96efe1


# ╔═╡ 366557f2-035c-11eb-31ce-9308dd49ce0c
md"#### querying a `DataFrame`

**example 1**: query all rows where the `:city` column is \"Corvallis\"

_approach 1_: much like `Array` slicing, using an `Array` of bits
"

# ╔═╡ 93ffa426-035c-11eb-0ae3-1b9d95676c9b


# ╔═╡ 26ca5a26-035d-11eb-380f-5b62049bd5a1
md"_approach 2_: via the `filter` function.
* first argument: a function that operates on a row of the `DataFrame` (treating the row as a `Dict`) and returns `true` if we want to keep that row and `false` if we want to throw it away
* the second argument is the `DataFrame`
* there is also a `filter!` function that will remove these rows from the dataframe instead of returning a copy with the relevant rows removed
"

# ╔═╡ 5abb815e-0392-11eb-3576-a7e39e8ac6af


# ╔═╡ 6ca4c6a8-035d-11eb-158c-3380a0cafdaa
md"**example 2**: query all cities (rows) where the population is less than 500,000"

# ╔═╡ 7dad5c94-035d-11eb-1f7b-2fedd834efaa


# ╔═╡ 7e54ed24-035d-11eb-19e2-4986b3cfcab4
md"**example 3**: query all cities in the state of Oregon"

# ╔═╡ 9879f190-035d-11eb-07c6-55453426c704


# ╔═╡ 9926bdbc-035d-11eb-1824-438e97d78ab9
md"#### sorting

e.g. permute rows so that cities are listed by `:population` in reverse (`rev`) order
"

# ╔═╡ ab918a54-035d-11eb-27ae-2d70b27460ac


# ╔═╡ 9ed15498-035d-11eb-1369-53ae1eac0a27
md"
#### grouping

the `groupby` command (common in many languages) partitions the rows in the `DataFrame` into multiple `DataFrame`s such that the rows in each `DataFrame` share a common attribute. this is very useful for then performing computations on each group separately.

e.g., group the cities (rows) in `df_cities` by state.
"

# ╔═╡ c1526020-035d-11eb-2d8a-d131aa445738


# ╔═╡ e80a4a9a-0392-11eb-2d35-09bb527d7a29


# ╔═╡ 4dd5195c-035e-11eb-1991-3fd9e7bf5d25
md"
#### split, apply, combine

split into groups, apply a function, combine back

##### `by`
`by(df, :key, new_col=:col => f)` will split the `DataFrame` `df` into groups in the `:key` column, then apply function `f` to the `:col` column and put the result into the `DataFrame` as a new column named `:new_col`.

e.g., group by state, take `mean` of the rainfall column. see [docs](https://juliadata.github.io/DataFrames.jl/stable/lib/functions/#DataFrames.by).
"

# ╔═╡ 03a59b6c-035f-11eb-0a39-79c770bf5544


# ╔═╡ 90381bb4-035e-11eb-2d05-81df6049cc33
md"
##### `aggregate`
`aggregate` is similar to `by` but it applies a function to all columns in the grouped `DataFrames`. we illustrate it here with only the `:rainfall` and `:population` columns since it wouldn't make sense to take the mean of the `:city` column of `String`s. see [docs](https://juliadata.github.io/DataFrames.jl/stable/lib/functions/#DataFrames.aggregate)
"

# ╔═╡ 9966dfae-035e-11eb-1a5e-a51a17c37ed4


# ╔═╡ 8226dc8e-0362-11eb-17bf-47cae0df2907
md"#### write a `DataFrame` to a `.csv` file

use the `CSV.jl` package.

CSV = comma separated value
"

# ╔═╡ 907832ea-0362-11eb-2132-a3abadd4b1ee


# ╔═╡ c711c3f8-0393-11eb-2fbc-77693069c73f


# ╔═╡ 08e91b1c-035f-11eb-05d0-9fe60938a4e3
md"#### read in a `.csv` file into a `DataFrame`
use the `CSV.jl` package.

CSV = comma separated value
"

# ╔═╡ fdab541a-0393-11eb-0318-3390bd75a95d
pwd() # present working directory to see where CSV looks for files

# ╔═╡ 1c01557a-035f-11eb-37e8-e9497003725f


# ╔═╡ 4cf973b8-0361-11eb-1777-cf02396ba052
md"
#### joins
combine two data tables that have different columns and, possibly, rows in common.

there are [seven types of joins](http://juliadata.github.io/DataFrames.jl/stable/man/joins/). let's illustrate two here.

goal: join information about *cities* from `df_cities` and `df_incomes`. thus the *key* here is `:city` since we aim to combine rows of the two `DataFrames` on the basis of the `:city` column.

subtlety here: 
* San Francisco is in `df_incomes` but missing from `df_cities`
* Bend, Eugene, Portland are in `df_cities` but missing from `df_incomes`

##### inner join
only keep rows where the city is common between the two `DataFrames`
(throw out rows that aren't common between the two)
"

# ╔═╡ 74379f7c-0361-11eb-0192-c59bca513893


# ╔═╡ 80c12360-0361-11eb-3eb3-eddb35dac4a5
md"
##### outer join
keep all rows, fill with `missing` values when an attribute is missing in either `DataFrame`
(keep rows that aren't common between the two)
"

# ╔═╡ 02bef8b2-0362-11eb-130f-f99cc7311f5a


# ╔═╡ 098a5628-0362-11eb-33af-9fc2fbceddba
md"#### missing values
Julia has a data type to efficiently handle missing values
"

# ╔═╡ 12deee64-0362-11eb-3612-ed369a623583
missing

# ╔═╡ 977c25ce-0394-11eb-0076-0955dcfe0ca1
typeof(missing)

# ╔═╡ 1e41218c-0362-11eb-2ae3-17339b033f7a
md"columns with missing values are arrays of whatever type but `Union`'d with the `Missing` type"

# ╔═╡ 25a8858c-0362-11eb-3405-95aeea8c1338


# ╔═╡ 2fb25d0c-0362-11eb-16b3-b75f845f82a9
md"remove all rows that have a missing attribute"

# ╔═╡ 36ba914e-0362-11eb-0aa7-6fda9f1b4d02


# ╔═╡ Cell order:
# ╟─1b29c142-033b-11eb-1fcd-3167939de8d2
# ╠═1f916158-033c-11eb-3042-556418cdd61e
# ╟─31e25766-033c-11eb-3991-d55735f7977f
# ╠═45806120-033c-11eb-359e-bfb9796dfee8
# ╠═bb7f6bbe-033c-11eb-0180-b7dcc731d8ed
# ╠═2071b5b6-038f-11eb-182d-f392b2198f2e
# ╟─bc58ac1c-033c-11eb-2698-f5fc4c20b8ce
# ╠═d172a490-033c-11eb-157e-6b95587099dd
# ╟─78b1f924-033d-11eb-2937-ff9634f5aa9a
# ╠═4c407c9a-0353-11eb-0618-955711917f54
# ╟─5e293c82-033d-11eb-3984-7164bf9a351d
# ╠═a5e9fc00-0353-11eb-1443-63b1c2edab7c
# ╟─a67b30b0-0353-11eb-2d2f-871d7a5ffd36
# ╠═6249187e-035a-11eb-2f6a-d3318cf2a996
# ╟─a3421e44-035e-11eb-3cf7-c70142f0591d
# ╠═a9d20a30-035e-11eb-14f4-ddf7cdaa34f6
# ╟─581bfc10-0362-11eb-1b29-cfd4320a5130
# ╠═5d2707ac-0362-11eb-13e4-0d80fce58fea
# ╠═b7fb0648-0390-11eb-2dc5-8b6935d2545c
# ╟─b8de77aa-0362-11eb-36d9-1d905442ca13
# ╠═cbf6250c-0362-11eb-365b-d327617f197e
# ╟─63716d2a-0362-11eb-3ce5-3b41d4bef04c
# ╠═6d39deee-0362-11eb-3dbb-0f34eff54591
# ╠═5931d59e-0391-11eb-078b-ddb0bcaf6521
# ╟─630b0e48-035a-11eb-15a4-a312e6941407
# ╠═d5b7f084-035a-11eb-32ef-6d645b8e0a6e
# ╠═9003f068-0391-11eb-2806-a76e99deefaa
# ╟─d663dd98-035a-11eb-156f-ff237a3944b6
# ╠═360eb67a-035b-11eb-2ab3-85adb264a387
# ╟─5d7208d4-035b-11eb-00ef-cd70b6cb79d3
# ╠═8d4f4ede-035b-11eb-2337-7bdb844389ae
# ╟─65353008-035b-11eb-261f-fffc23ec79a7
# ╠═9b569b7c-035b-11eb-2d27-cd4458bbbc02
# ╟─7daa87e6-035b-11eb-3bb8-ff1bdd95714c
# ╠═f735e3ee-035b-11eb-33d1-755a1a9dc0a7
# ╟─1821e936-035c-11eb-0cb1-014241a2599e
# ╠═1ad35930-035c-11eb-165d-2d70f7b07713
# ╟─22623c72-035c-11eb-20f1-233b92ef16f9
# ╠═35c1b9a8-035c-11eb-05f6-67e7bd5ef6e3
# ╟─9e01dd3a-0362-11eb-3d19-392ec2d06bd6
# ╠═a6f99cc8-0362-11eb-1801-2dd5fa96efe1
# ╟─366557f2-035c-11eb-31ce-9308dd49ce0c
# ╠═93ffa426-035c-11eb-0ae3-1b9d95676c9b
# ╟─26ca5a26-035d-11eb-380f-5b62049bd5a1
# ╠═5abb815e-0392-11eb-3576-a7e39e8ac6af
# ╟─6ca4c6a8-035d-11eb-158c-3380a0cafdaa
# ╠═7dad5c94-035d-11eb-1f7b-2fedd834efaa
# ╟─7e54ed24-035d-11eb-19e2-4986b3cfcab4
# ╠═9879f190-035d-11eb-07c6-55453426c704
# ╟─9926bdbc-035d-11eb-1824-438e97d78ab9
# ╠═ab918a54-035d-11eb-27ae-2d70b27460ac
# ╟─9ed15498-035d-11eb-1369-53ae1eac0a27
# ╠═c1526020-035d-11eb-2d8a-d131aa445738
# ╠═e80a4a9a-0392-11eb-2d35-09bb527d7a29
# ╟─4dd5195c-035e-11eb-1991-3fd9e7bf5d25
# ╠═03a59b6c-035f-11eb-0a39-79c770bf5544
# ╟─90381bb4-035e-11eb-2d05-81df6049cc33
# ╠═9966dfae-035e-11eb-1a5e-a51a17c37ed4
# ╟─8226dc8e-0362-11eb-17bf-47cae0df2907
# ╠═907832ea-0362-11eb-2132-a3abadd4b1ee
# ╠═c711c3f8-0393-11eb-2fbc-77693069c73f
# ╟─08e91b1c-035f-11eb-05d0-9fe60938a4e3
# ╠═fdab541a-0393-11eb-0318-3390bd75a95d
# ╠═1c01557a-035f-11eb-37e8-e9497003725f
# ╟─4cf973b8-0361-11eb-1777-cf02396ba052
# ╠═74379f7c-0361-11eb-0192-c59bca513893
# ╟─80c12360-0361-11eb-3eb3-eddb35dac4a5
# ╠═02bef8b2-0362-11eb-130f-f99cc7311f5a
# ╟─098a5628-0362-11eb-33af-9fc2fbceddba
# ╠═12deee64-0362-11eb-3612-ed369a623583
# ╠═977c25ce-0394-11eb-0076-0955dcfe0ca1
# ╟─1e41218c-0362-11eb-2ae3-17339b033f7a
# ╠═25a8858c-0362-11eb-3405-95aeea8c1338
# ╟─2fb25d0c-0362-11eb-16b3-b75f845f82a9
# ╠═36ba914e-0362-11eb-0aa7-6fda9f1b4d02
