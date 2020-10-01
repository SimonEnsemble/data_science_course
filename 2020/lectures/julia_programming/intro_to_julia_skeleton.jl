### A Pluto.jl notebook ###
# v0.11.14

using Markdown
using InteractiveUtils

# ╔═╡ 1f74ddfe-fd19-11ea-1a0f-678021182d2c
md"
## Introduction to the Julia programming language
![Julia logo](https://julialang.org/assets/infra/logo.svg)

_why Julia?_
* free, open-source
* high-level, thus easy to use
* dynamic, thus feels interactive
* expressive, read-like-a-book syntax
* high-performance (fast) (design choices allow just-in-time compiler to make optimizations, resulting in fast code)
* safety (offers optional type assertion)
* designed especially for scientific computing
* easy parallelization accross cores
* multiple dispatch (we'll see later)

> Julia: A language that walks like Python, runs like C

[link to official Julia website](https://julialang.org/) and 

[link to recent Nature article on Julia](https://www.nature.com/articles/d41586-019-02310-3)

_resources_:
* [official Julia documentation](https://docs.julialang.org/en/v1/)
* [Learn Julia in Y minutes](https://learnxinyminutes.com/docs/julia/)
* [Julia express](http://bogumilkaminski.pl/files/julia_express.pdf)
"

# ╔═╡ 2f9e20c0-fd1c-11ea-1064-411a3bbb014e
md"
# `Pluto` notebooks

(you're in one)

a `Pluto` notebook is a simple, dynamic, interactive Julia programming environment. in addition to code, it can contain documentation/writing to make a self-contained document, like in this cell!

YouTube video on `Pluto`: [here](https://www.youtube.com/watch?v=IAF8DjrQSSk).

the language used to format writing in `Pluto` is Markdown. see [here](https://docs.julialang.org/en/v1/stdlib/Markdown/) for the formatting possibilities.

e.g., code formatting inline `f(x)=cos(3.0 * π)` and in display:
```
function f(x)
	return cos(3.0 * π)
end
```
e.g. math formatting inline $f(x)=x^2\sin(x)$ and in display, via ``\LaTeX``
```math
f(x)=x^2 \sin(x)
```

go ahead, make your own markdown cell in `Pluto`!
"

# ╔═╡ f3fee3ca-fd1c-11ea-2906-9d8d6b874f66
md"
# learn Julia by example

### variable assignment

> an assignment statement sets and/or re-sets the value stored in the storage location(s) denoted by a variable name; in other words, it copies a value into the variable - [Wikipedia](https://en.wikipedia.org/wiki/Assignment_(computer_science))
"

# ╔═╡ b99409d6-fd1f-11ea-1cd5-e97615600cea


# ╔═╡ e267492c-fd1f-11ea-20a3-9f7759e16280
md"
\"we assign `x` to be 5.3\" $\neq$ \"x equals 5.3\"!

read [here](https://en.wikipedia.org/wiki/Assignment_(computer_science)#Assignment_versus_equality).
"

# ╔═╡ 0ae926cc-fd20-11ea-3e7f-1b8af64f05d8


# ╔═╡ 181fec1c-fd21-11ea-042c-23828f908e52
md"### types

`x` is represented on your computer using a chuck of memory consisting of 64 bits (bit = binary digit). It is represented in the [double-precision floating point format](https://en.wikipedia.org/wiki/Double-precision_floating-point_format).

![Julia logo](https://upload.wikimedia.org/wikipedia/commons/a/a9/IEEE_754_Double_Floating_Point_Format.svg)

"

# ╔═╡ 11aa062e-fd21-11ea-068b-495c13f48386


# ╔═╡ 2d622f08-fd22-11ea-2d6a-6bd48280b429


# ╔═╡ 315b0efe-fd22-11ea-1cdd-a5ded834ab2a


# ╔═╡ 2ecab27a-fd22-11ea-09f6-03f120a4e4e2


# ╔═╡ d9b74a2e-fd22-11ea-39e1-7311dbdfdfa7


# ╔═╡ e87a9ca8-fd22-11ea-28f2-b55daeb0032e
md"
the `Symbol` is an [interned string](https://en.wikipedia.org/wiki/String_interning), which makes e.g. string comparison operations faster. 

_ambitious Beavs_: The function `pointer_from_objref` in Julia allows you to see where in memory an object in Julia is stored. Experiment with a `Symbol` and `String` to illustrate that `Symbol`s are *interned* strings. A more nuanced view of the `Symbol` is [here](https://stackoverflow.com/questions/23480722/what-is-a-symbol-in-julia#) by the co-creator and core developer of Julia.
"

# ╔═╡ 97e1060a-fd23-11ea-0724-b57130b840a0


# ╔═╡ ad38b10e-fd23-11ea-39c7-abec457dd0a9


# ╔═╡ bca6e98c-fd23-11ea-3435-7de54b441520


# ╔═╡ c6038724-fd23-11ea-26f1-95f83c18b73a
md"### dictionaries

an unordered collection of (key, value) pairs. maps keys to values.
"

# ╔═╡ df7265ae-fd23-11ea-2062-590489759192


# ╔═╡ 06068334-fd25-11ea-380c-adf3a922c2ee


# ╔═╡ 0bcf7bea-fd25-11ea-02fd-734a32e86dfc


# ╔═╡ a5eef120-fd24-11ea-1fbc-9716cad65315


# ╔═╡ ef434eee-fd23-11ea-19e3-2578be44f9a0


# ╔═╡ fdc4e874-fd23-11ea-19e4-b3cfa1e8f9b4


# ╔═╡ 197e253a-fd24-11ea-3ba6-2bb768ca610a


# ╔═╡ 7b440f50-fd24-11ea-24e6-43ea33e3a9bb
md"### arrays"

# ╔═╡ 92493d42-fd24-11ea-277e-73ee6f34697f


# ╔═╡ a1574ae0-fd24-11ea-1d13-6bd7232b61dd


# ╔═╡ 9b569d44-fd24-11ea-3ae9-d9e86b734398


# ╔═╡ bdd6b318-fd24-11ea-03ca-05534b38845d


# ╔═╡ d363b716-fd25-11ea-11c9-8905dd4f3dc4
md"iterating thru an array (3 ways)"

# ╔═╡ b0312d60-fd24-11ea-2338-e33d7b7c7326


# ╔═╡ 88989cc8-fd26-11ea-2ad1-e54b6dfa0d75
md"adding elements to an array"

# ╔═╡ 8d7abd34-fd26-11ea-2ac8-59aa1152a963


# ╔═╡ 9c9cf930-fd26-11ea-369d-05487ebb4a2c


# ╔═╡ adea9760-fd26-11ea-0507-db19248c356d
md"slicing"

# ╔═╡ b37ab55c-fd26-11ea-0d2f-43020e094843


# ╔═╡ 126a590e-fd28-11ea-1c02-c3262b85add7


# ╔═╡ 185775c2-fd28-11ea-03b1-a50001c813db


# ╔═╡ 259be740-fd28-11ea-3cce-0959719ea489


# ╔═╡ 6081e190-fd28-11ea-37d5-81d995c5da53
md"slicing by `Bool`'s is especially useful for selecting certain elements of an array that obey a certain condition

e.g., let's get all array elements that are greater than 12."

# ╔═╡ 75e95b6a-fd28-11ea-3574-09b696391ec0


# ╔═╡ 8c4574e6-fd28-11ea-2d7b-41a82e763605


# ╔═╡ 382d122a-fd29-11ea-136e-3763d3b27fff
md"multi-dimensional arrays"

# ╔═╡ 3df06fcc-fd29-11ea-242e-459a5796c5e8


# ╔═╡ 47a89d1c-fd29-11ea-1249-716bfbaff87d


# ╔═╡ 56adbdc6-fd29-11ea-219a-07848f5ddbfd


# ╔═╡ 4d477196-fd29-11ea-1eeb-dd8885fafa93


# ╔═╡ 8cafc58a-fd2a-11ea-2d83-7fb53e343317
md"constructing an array, without typing out each entry manually"

# ╔═╡ 9a16deb6-fd2a-11ea-1810-8d0c1c22a39a


# ╔═╡ b9cce99e-fd2a-11ea-03fe-3d20bfb629a7


# ╔═╡ 8349134c-fd2b-11ea-3426-7f3ad78a3384
md"element-wise operations on arrays"

# ╔═╡ 8d985c22-fd2b-11ea-38c8-25c40abddf44


# ╔═╡ a0a2a016-fd2b-11ea-1be7-595c50ab3751


# ╔═╡ a5c49b8a-fd2b-11ea-317a-814aa9d072ff


# ╔═╡ bb84580c-fd2b-11ea-34fe-03e69a043bc4
md"matrix multiplication"

# ╔═╡ c8fe380e-fd2b-11ea-3d76-edf4546e3d6b


# ╔═╡ cc7c41c4-fd2b-11ea-0fdc-9d18add5fea4


# ╔═╡ e3af0b56-fd2b-11ea-1a50-cd73d2d9fd48
md"### create your own data structure"

# ╔═╡ e9f164b4-fd2b-11ea-1b4b-4b95e685950a


# ╔═╡ 376ef642-fd2d-11ea-10e8-c35996c11e35
md"### functions
$x \mapsto f(x)$
"

# ╔═╡ 3d1e04b4-fd2d-11ea-13ae-730df157ca04


# ╔═╡ 9a496a9a-fd2d-11ea-036e-05a28c1882d9


# ╔═╡ d7cf8796-fd2d-11ea-2dae-13cf938bd877


# ╔═╡ ea3373ca-fd2d-11ea-25d4-0942d7faeb0b
md"*optional positional arguments*

> In many cases, function arguments have sensible default values and therefore might not need to be passed explicitly in every call. [source](https://docs.julialang.org/en/v1/manual/functions/#Optional-Arguments-1)

say `b` is almost always 0.0. let's not force the user to pass this arugment, yet let's also allow some flexibility if the user wants to change `b` from the default of `b=0.0`."

# ╔═╡ 066b7bfa-fd2e-11ea-34b5-5d23f5a433e4


# ╔═╡ 1781a568-fd2e-11ea-1280-43c4591acacd


# ╔═╡ 28534fae-fd2e-11ea-3f5a-836d16c725f8
md"*optional keyword arguments*

> Some functions need a large number of arguments, or have a large number of behaviors. Remembering how to call such functions can be difficult. Keyword arguments can make these complex interfaces easier to use and extend by allowing arguments to be identified by name instead of only by position. [source](https://docs.julialang.org/en/v1/manual/functions/#Keyword-Arguments-1)
"

# ╔═╡ 334d0616-fd2e-11ea-2d83-3d37fee60a74


# ╔═╡ 6a9fd648-fd2e-11ea-09f8-098fd33d82ff
md"*type declarations in functions*
> The :: operator can be used to attach type annotations to expressions and variables in programs. There are two primary reasons to do this:
> * As an assertion to help confirm that your program works the way you expect,
> * To provide extra type information to the compiler, which can then improve performance in some cases
> When appended to an expression computing a value, the :: operator is read as \"is an instance of\". It can be used anywhere to assert that the value of the expression on the left is an instance of the type on the right.
> [source](https://docs.julialang.org/en/v1/manual/types/index.html#Type-Declarations-1)"

# ╔═╡ 8c73923c-fd2e-11ea-2520-1736af901c1f


# ╔═╡ 0485bc6e-fd2f-11ea-36c9-05455f0b59e3


# ╔═╡ 0dacb54c-fd2f-11ea-05ff-4df8be2ef053


# ╔═╡ f621b84c-fd30-11ea-04e2-431ca045916f


# ╔═╡ 0e0a8cba-fd31-11ea-26ed-2d27f95f54ff
md"### control flow
> a control flow statement is a statement, the execution of which results in a choice being made as to which of two or more paths a computer program will follow - [Wikipedia](https://en.wikipedia.org/wiki/Control_flow)
"

# ╔═╡ 82eb1752-fd31-11ea-17be-11666cb6e2e8


# ╔═╡ 9ff8ba12-fd33-11ea-2eca-0fe897359d25


# ╔═╡ 933d5544-fd33-11ea-06af-8debefdb728a


# ╔═╡ 19cddf3a-fd35-11ea-328f-9397bc118698
md"### randomness, sampling
"

# ╔═╡ 209e3d26-fd35-11ea-3916-853482bfa1bc


# ╔═╡ 27ef6938-fd35-11ea-07e2-0b28886507bb


# ╔═╡ 31f083f4-fd35-11ea-34d3-81f1d3e8dc6b


# ╔═╡ 37b27476-fd35-11ea-1892-79927795db0f


# ╔═╡ 4f4660e0-fd35-11ea-1186-252d22ca1c33


# ╔═╡ 55288cb8-fd35-11ea-3d35-e548167cb52e


# ╔═╡ 62314e4a-fd35-11ea-271c-d90066d6cdd9


# ╔═╡ 7432ae22-fd35-11ea-35f2-170288e9c358


# ╔═╡ 8554b92a-fd35-11ea-2956-cdf98a96f9d1
md"### mutable vs immutable"

# ╔═╡ 8e4a2f26-fd35-11ea-1009-4911e7010fe1


# ╔═╡ e44e2d7a-fd40-11ea-25cf-c1ac05a92de5


# ╔═╡ a8e165fe-fd40-11ea-2d25-192112ba9e43


# ╔═╡ Cell order:
# ╟─1f74ddfe-fd19-11ea-1a0f-678021182d2c
# ╟─2f9e20c0-fd1c-11ea-1064-411a3bbb014e
# ╟─f3fee3ca-fd1c-11ea-2906-9d8d6b874f66
# ╠═b99409d6-fd1f-11ea-1cd5-e97615600cea
# ╟─e267492c-fd1f-11ea-20a3-9f7759e16280
# ╠═0ae926cc-fd20-11ea-3e7f-1b8af64f05d8
# ╟─181fec1c-fd21-11ea-042c-23828f908e52
# ╠═11aa062e-fd21-11ea-068b-495c13f48386
# ╠═2d622f08-fd22-11ea-2d6a-6bd48280b429
# ╠═315b0efe-fd22-11ea-1cdd-a5ded834ab2a
# ╠═2ecab27a-fd22-11ea-09f6-03f120a4e4e2
# ╠═d9b74a2e-fd22-11ea-39e1-7311dbdfdfa7
# ╟─e87a9ca8-fd22-11ea-28f2-b55daeb0032e
# ╠═97e1060a-fd23-11ea-0724-b57130b840a0
# ╠═ad38b10e-fd23-11ea-39c7-abec457dd0a9
# ╠═bca6e98c-fd23-11ea-3435-7de54b441520
# ╟─c6038724-fd23-11ea-26f1-95f83c18b73a
# ╠═df7265ae-fd23-11ea-2062-590489759192
# ╠═06068334-fd25-11ea-380c-adf3a922c2ee
# ╠═0bcf7bea-fd25-11ea-02fd-734a32e86dfc
# ╠═a5eef120-fd24-11ea-1fbc-9716cad65315
# ╠═ef434eee-fd23-11ea-19e3-2578be44f9a0
# ╠═fdc4e874-fd23-11ea-19e4-b3cfa1e8f9b4
# ╠═197e253a-fd24-11ea-3ba6-2bb768ca610a
# ╟─7b440f50-fd24-11ea-24e6-43ea33e3a9bb
# ╠═92493d42-fd24-11ea-277e-73ee6f34697f
# ╠═a1574ae0-fd24-11ea-1d13-6bd7232b61dd
# ╠═9b569d44-fd24-11ea-3ae9-d9e86b734398
# ╠═bdd6b318-fd24-11ea-03ca-05534b38845d
# ╟─d363b716-fd25-11ea-11c9-8905dd4f3dc4
# ╠═b0312d60-fd24-11ea-2338-e33d7b7c7326
# ╟─88989cc8-fd26-11ea-2ad1-e54b6dfa0d75
# ╠═8d7abd34-fd26-11ea-2ac8-59aa1152a963
# ╠═9c9cf930-fd26-11ea-369d-05487ebb4a2c
# ╟─adea9760-fd26-11ea-0507-db19248c356d
# ╠═b37ab55c-fd26-11ea-0d2f-43020e094843
# ╠═126a590e-fd28-11ea-1c02-c3262b85add7
# ╠═185775c2-fd28-11ea-03b1-a50001c813db
# ╠═259be740-fd28-11ea-3cce-0959719ea489
# ╟─6081e190-fd28-11ea-37d5-81d995c5da53
# ╠═75e95b6a-fd28-11ea-3574-09b696391ec0
# ╠═8c4574e6-fd28-11ea-2d7b-41a82e763605
# ╟─382d122a-fd29-11ea-136e-3763d3b27fff
# ╠═3df06fcc-fd29-11ea-242e-459a5796c5e8
# ╠═47a89d1c-fd29-11ea-1249-716bfbaff87d
# ╠═56adbdc6-fd29-11ea-219a-07848f5ddbfd
# ╠═4d477196-fd29-11ea-1eeb-dd8885fafa93
# ╟─8cafc58a-fd2a-11ea-2d83-7fb53e343317
# ╠═9a16deb6-fd2a-11ea-1810-8d0c1c22a39a
# ╠═b9cce99e-fd2a-11ea-03fe-3d20bfb629a7
# ╟─8349134c-fd2b-11ea-3426-7f3ad78a3384
# ╠═8d985c22-fd2b-11ea-38c8-25c40abddf44
# ╠═a0a2a016-fd2b-11ea-1be7-595c50ab3751
# ╠═a5c49b8a-fd2b-11ea-317a-814aa9d072ff
# ╟─bb84580c-fd2b-11ea-34fe-03e69a043bc4
# ╠═c8fe380e-fd2b-11ea-3d76-edf4546e3d6b
# ╠═cc7c41c4-fd2b-11ea-0fdc-9d18add5fea4
# ╟─e3af0b56-fd2b-11ea-1a50-cd73d2d9fd48
# ╠═e9f164b4-fd2b-11ea-1b4b-4b95e685950a
# ╟─376ef642-fd2d-11ea-10e8-c35996c11e35
# ╠═3d1e04b4-fd2d-11ea-13ae-730df157ca04
# ╠═9a496a9a-fd2d-11ea-036e-05a28c1882d9
# ╠═d7cf8796-fd2d-11ea-2dae-13cf938bd877
# ╟─ea3373ca-fd2d-11ea-25d4-0942d7faeb0b
# ╠═066b7bfa-fd2e-11ea-34b5-5d23f5a433e4
# ╠═1781a568-fd2e-11ea-1280-43c4591acacd
# ╟─28534fae-fd2e-11ea-3f5a-836d16c725f8
# ╠═334d0616-fd2e-11ea-2d83-3d37fee60a74
# ╟─6a9fd648-fd2e-11ea-09f8-098fd33d82ff
# ╠═8c73923c-fd2e-11ea-2520-1736af901c1f
# ╠═0485bc6e-fd2f-11ea-36c9-05455f0b59e3
# ╠═0dacb54c-fd2f-11ea-05ff-4df8be2ef053
# ╟─f621b84c-fd30-11ea-04e2-431ca045916f
# ╟─0e0a8cba-fd31-11ea-26ed-2d27f95f54ff
# ╠═82eb1752-fd31-11ea-17be-11666cb6e2e8
# ╠═9ff8ba12-fd33-11ea-2eca-0fe897359d25
# ╠═933d5544-fd33-11ea-06af-8debefdb728a
# ╟─19cddf3a-fd35-11ea-328f-9397bc118698
# ╠═209e3d26-fd35-11ea-3916-853482bfa1bc
# ╠═27ef6938-fd35-11ea-07e2-0b28886507bb
# ╠═31f083f4-fd35-11ea-34d3-81f1d3e8dc6b
# ╠═37b27476-fd35-11ea-1892-79927795db0f
# ╠═4f4660e0-fd35-11ea-1186-252d22ca1c33
# ╠═55288cb8-fd35-11ea-3d35-e548167cb52e
# ╠═62314e4a-fd35-11ea-271c-d90066d6cdd9
# ╠═7432ae22-fd35-11ea-35f2-170288e9c358
# ╟─8554b92a-fd35-11ea-2956-cdf98a96f9d1
# ╠═8e4a2f26-fd35-11ea-1009-4911e7010fe1
# ╠═e44e2d7a-fd40-11ea-25cf-c1ac05a92de5
# ╠═a8e165fe-fd40-11ea-2d25-192112ba9e43
