### A Pluto.jl notebook ###
# v0.12.16

using Markdown
using InteractiveUtils

# ╔═╡ 0d422560-3458-11eb-21da-319ca86eccc3
using CSV, DataFrames, PyPlot, PyCall, Statistics, LinearAlgebra

# ╔═╡ 4e830f8c-3458-11eb-11d1-ad281e9993e0
seaborn = pyimport("seaborn") # import seaborn from Python

# ╔═╡ 388fcf76-3458-11eb-2dbd-278d1f1bf1d5
PyPlot.matplotlib.style.use("seaborn-dark")

# ╔═╡ d1e3572a-3457-11eb-0a30-8fceaa8f213b
md"
# learning a latent space of wine

## read in data on wines
source: [UCI machine learning repository](https://archive.ics.uci.edu/ml/datasets/Wine)

🐸 read in `wines.csv` as a `DataFrame`.

let's pretend we don't know the class to make this an unsupervised learning problem.

* _samples_ = wines
* _measurements_ = total phenols, flavanoids
"

# ╔═╡ 120e5216-3458-11eb-392a-99fa7cbbf7df
df = CSV.read("wines.csv", DataFrame)

# ╔═╡ a43de956-3458-11eb-13ad-45e93d3bfbd4
md"🐸 how many wines of each class are there?"

# ╔═╡ 801da89a-3458-11eb-1c54-13a8bad8d413
by(df, :class, count=:flavanoids=>length)

# ╔═╡ bd135a06-3458-11eb-3a5d-6b55f407b921
md"
## visualize the organization/structure of the data in feature space

because feature space is 2D, we have the luxury to see the data scattered in feature space. in real-world problems, the data will lie in a high-dimensional feature space that we are incapable of imagining (at least I am).

🐸 draw a visualization of how the data is organized/scattered in feature space.


!!! hint
    what I mean by this is to make a scatter plot of the data, where each point represents a wine, and the x-axis is feature (measurement) 1, the total phenols, and the y-axis is feature (measurement) 2, the total flavanoids.
"

# ╔═╡ 1c4b77d8-3459-11eb-07c7-8d8e3139222b
begin
	figure()
	scatter(df[:, :total_phenols], df[:, :flavanoids])
	xlabel("total phenols")
	ylabel("flavanoids")
	grid("on")
	gcf()
end

# ╔═╡ 24bd36cc-3459-11eb-32d8-0182452b0931
md"
## the data matrix, $\mathbf{X}$
* each row corresponds to a wine
* first column: total phenols
* second column: flavanoids
* data is centered

so (centered) feature vectors of the samples are in the rows of the data matrix $\mathbf{X}$.

🐸 construct the un-centered data matrix and assign it to a variable `X::Array{Float64, 2}`. we'll center the data later.
"

# ╔═╡ 442ae914-3459-11eb-06c3-9bdde1613f68
begin
	X = zeros(nrow(df), 2)
	for (i, row) in enumerate(eachrow(df))
	    X[i, 1] = row[:total_phenols]
	    X[i, 2] = row[:flavanoids]
	end
	X
end

# ╔═╡ 4d39d01a-3459-11eb-29b3-f9225e552d79
md"
🐸 center the data by subtracting from each row of the data matrix the mean \"wine vector\" $\mathbf{\bar{x}}^\intercal$

$\mathbf{\bar{x}}=\displaystyle\sum_{i=1}^m \mathbf{x}_i$

where $\mathbf{x}_i$ is the feature vector of sample $i$ and there are a total of $m$ samples.

modify `X` as opposed to creating a new variable for the centered data matrix.
"

# ╔═╡ 87f59b9e-3459-11eb-1824-297acc992748
x̄ = mean(X, dims=1)[:]

# ╔═╡ 962bdcbc-3459-11eb-39a0-47b9b2cdafe5
for i = 1:size(X)[1]
    X[i, :] = X[i, :] .- x̄
end

# ╔═╡ f101b6ae-3459-11eb-3875-a395a0375c57
md"🐸 check that the mean of the row vectors is indeed the zero vector (approximately)."

# ╔═╡ 174108ec-345a-11eb-36d9-35d2e5095220
mean(X, dims=1)[:]

# ╔═╡ bab0168a-345a-11eb-02e5-75561659b9bf
md"🐸 re-draw your visualization of the scatter of the data in _centered_ feature space. note that it should be a simple translation of your plot above, centered at $\mathbf{0}$"

# ╔═╡ c098ba5c-345a-11eb-3e91-6f973160747e
begin
	figure()
	xlabel("total phenols, centered")
	ylabel("flavanoids, centered")
	scatter(X[:, 1], X[:, 2])
	grid("on")
	gcf()
end

# ╔═╡ 192acb4a-345a-11eb-333a-63d8df730169
md"## visualize the data matrix as a heat map.

use `seaborn` to visualize the (centered) data matrix `X` as a heat map. see the [seaborn docs](https://seaborn.pydata.org/generated/seaborn.heatmap.html). 
* pass `cbar=true` to draw a colorbar
* pass `square=true` to make each entry represented as a square for a representative aspect ratio.
* pass `center=0.0` to ensure the center of the colormap is 0, since this is divergent data.

`seaborn` is a Python package that we are calling using `PyCall.jl`, hence the `pyimport` at the top of the page. for this to work, you have to have `PyCall` installed and the Seaborn Python package.
"

# ╔═╡ 2a4183ea-345a-11eb-2060-050773516512
begin
	seaborn.heatmap(X, square=true, cbar=true, cmap="PiYG", center=0.0)
	xticks([])
	yticks([])
	ylim([-0.0, 50.])
	xlabel("properties")
	ylabel("wines")
	tight_layout()
	gcf()
end

# ╔═╡ b3a77cf0-345a-11eb-0e90-b9695debce79
md"
🐸 what is the rank of the data matrix? see [docs](https://docs.julialang.org/en/v1/stdlib/LinearAlgebra/#LinearAlgebra.rank).
"

# ╔═╡ 039df0c4-345b-11eb-128c-0986317422ef
rank(X)

# ╔═╡ 3d4819f6-345b-11eb-1529-a104842997bd
md"
## the singular value decomposition of the data matrix, $\mathbf{X}$

$\mathbf{X}=\mathbf{U}\mathbf{\Sigma} \mathbf{V}^T$.

* number of wines: $w$
* number of features (flavanoids, phenols): 2

data matrix $\mathbf{X}$ is $w \times 2$.

🐸 use the `svd` function in Julia to factorize the matrix `X`. see the [Julia docs](https://docs.julialang.org/en/v1/stdlib/LinearAlgebra/#LinearAlgebra.svd).
"

# ╔═╡ 15e9d878-345c-11eb-3dad-511d97788b25
the_svd = svd(X)

# ╔═╡ 4bad84c8-345c-11eb-3df3-ddda0b7037c6
md"🐸 look at the matrix $\mathbf{U}$. is it the correct size? is it indeed orthogonal?"

# ╔═╡ 6db93d32-345c-11eb-17e3-b79c7e0f9583
U = the_svd.U # 50 x 2

# ╔═╡ 9dbb3a8a-345c-11eb-100c-53303f2c1129
U' * U

# ╔═╡ 71ca50c8-345c-11eb-3d8d-8363d702b18a
md"🐸 look at the matrix $\mathbf{V}$. is it the correct size? is it indeed orthogonal?"

# ╔═╡ 7a72af2c-345c-11eb-2c57-af89df87e520
V = the_svd.V # 2 x 2

# ╔═╡ a1b4cd72-345c-11eb-1063-971890047299
V' * V

# ╔═╡ 82a96208-345c-11eb-0b07-ed11d14a87b4
md"🐸 construct the diagonal matrix $\mathbf{\Sigma}$ from the output of the `svd` function.

!!! hint
    use the function `diagm`. see [Julia docs](https://docs.julialang.org/en/v1/stdlib/LinearAlgebra/#LinearAlgebra.diagm).
"   

# ╔═╡ a8649526-345c-11eb-09d2-19c3509819ad
Σ = diagm(the_svd.S)

# ╔═╡ e702c686-345c-11eb-3c13-05d8ed7f70eb
md"🐸 confirm that $\mathbf{X}=\mathbf{U}\mathbf{\Sigma} \mathbf{V}^T$ (to numerical precision) by doing the matrix multiplication in Julia."

# ╔═╡ 05729b28-345d-11eb-2c23-95273ede1d93
X .- U * Σ * V'

# ╔═╡ 14a2a570-345d-11eb-3b05-ebb363f9f789
md"
## visualize the principal components {$\mathbf{v}_1, \mathbf{v}_2$}

🐸 redraw the scatter of your centered data in feature space. on top of this, plot the right singular vectors {$\mathbf{v}_1, \mathbf{v}_2$}.

explain the meaning of these right singular vectors, often called _principal components_ of the data.

!!! hint
    use the `arrow` function in matplotlib. see [here](https://matplotlib.org/3.1.1/api/_as_gen/matplotlib.pyplot.arrow.html). `gca().set_aspect(\"equal\")` is imperative to see the orthogonality of these two vectors.
"

# ╔═╡ 4beb5d38-345d-11eb-3383-4ba71c51c18c
begin
	figure()
	xlabel("total phenols, centered")
	ylabel("flavanoids, centered")
	scatter(X[:, 1], X[:, 2])
	arrowz = []
	for i = 1:2
	    v = V[:, i]
	    ar = arrow(0, 0, v[1], v[2], head_width=0.05, head_length=0.1, 
	        fc="C$i", ec="C$i", lw=3)
	    push!(arrowz, ar)
	end
	gca().set_aspect("equal") # important to see orthogonality
	legend(arrowz, [L"$\mathbf{v}_1$", L"$\mathbf{v}_2$"])
	grid("on")
	gcf()
end

# ╔═╡ d31a4fbc-345d-11eb-176e-e3826ec59278
md"
## the low rank approximation to the data matrix

🐸 construct the low-rank approximation of the data matrix, $\mathbf{\hat{X}}$, by zeroing out the smallest singular value.
"

# ╔═╡ f4a86364-345d-11eb-0ea5-8f90a2d397cb
X̂ = U * diagm([the_svd.S[1], 0.0]) * V'

# ╔═╡ 0c3dfadc-345e-11eb-2956-4740607709c2
md"
🐸 to visualize the low-rank approximation of the data matrix and how it compares with the original data, draw the scatter of the centered data in feature space (again) but include also the scatter of the compressed data in the rows of the low-rank approximation $\mathbf{\hat{X}}$. connect the data by a thin black line to see correspondence between the points and to show that the compressed representation of the data is a projection of the data onto the first principal component, $\mathbf{v}_1$. draw a line along the right singular vector $\mathbf{v}_1$ (this is the lower-dimensional subspace, a line, along with the data approximately lies).
"

# ╔═╡ 04a0847a-345e-11eb-1213-698c927e8b1a
begin
	figure()
	scatter(X[:, 1], X[:, 2], color="C0", label="original data")
	scatter(X̂[:, 1], X̂[:, 2], color="C1", label="compressed data")
	for i = 1:size(X)[1]
		plot([X[i, 1], X̂[i, 1]], [X[i, 2], X̂[i, 2]], color="k", lw=1)
	end
	xlabel("total phenols, centered")
	ylabel("flavanoids, centered")
	v1 = V[:, 1] * 2
	plot([-v1[1], v1[1]], [-v1[2], v1[2]], color="C4", 
	    label=L"$\alpha\mathbf{v}_1$", lw=1)
	legend()
	grid("on")
	gca().set_aspect("equal")
	gcf()
end

# ╔═╡ 0b490c7e-345f-11eb-06aa-8ff9c4a2574c
md"
## the latent representations of the data

the latent representation of data point $i$ is $\alpha_i$, where we express data point $i$ as:

$\mathbf{x}_i\approx \alpha_i \mathbf{v}_i$

that is, we are expressing each data point in terms of the first principal component (the first right singular vector). then each data point is reduced to a single number, $\alpha_i$.

because we have a rank-1 approximation,
$\mathbf{X} \approx \sigma_1 \mathbf{u}_1\mathbf{v}_1^T$ and the latent representations of the data points (reducing each wine to a single number) are in the rows of the vector $\sigma_1 \mathbf{u}_1$
"

# ╔═╡ 52b41724-3460-11eb-0c80-f5944d2b5321
the_svd.S[1] * U[:, 1]

# ╔═╡ 8f594a38-345f-11eb-0c29-374282b4f117
the_svd.S[1] * U[:, 1] * V[:, 1]'

# ╔═╡ 4d5c66d2-3460-11eb-0a0b-551342c7db53
X̂

# ╔═╡ Cell order:
# ╠═0d422560-3458-11eb-21da-319ca86eccc3
# ╠═4e830f8c-3458-11eb-11d1-ad281e9993e0
# ╠═388fcf76-3458-11eb-2dbd-278d1f1bf1d5
# ╟─d1e3572a-3457-11eb-0a30-8fceaa8f213b
# ╠═120e5216-3458-11eb-392a-99fa7cbbf7df
# ╟─a43de956-3458-11eb-13ad-45e93d3bfbd4
# ╠═801da89a-3458-11eb-1c54-13a8bad8d413
# ╟─bd135a06-3458-11eb-3a5d-6b55f407b921
# ╠═1c4b77d8-3459-11eb-07c7-8d8e3139222b
# ╟─24bd36cc-3459-11eb-32d8-0182452b0931
# ╠═442ae914-3459-11eb-06c3-9bdde1613f68
# ╟─4d39d01a-3459-11eb-29b3-f9225e552d79
# ╠═87f59b9e-3459-11eb-1824-297acc992748
# ╠═962bdcbc-3459-11eb-39a0-47b9b2cdafe5
# ╟─f101b6ae-3459-11eb-3875-a395a0375c57
# ╠═174108ec-345a-11eb-36d9-35d2e5095220
# ╟─bab0168a-345a-11eb-02e5-75561659b9bf
# ╠═c098ba5c-345a-11eb-3e91-6f973160747e
# ╟─192acb4a-345a-11eb-333a-63d8df730169
# ╠═2a4183ea-345a-11eb-2060-050773516512
# ╟─b3a77cf0-345a-11eb-0e90-b9695debce79
# ╠═039df0c4-345b-11eb-128c-0986317422ef
# ╟─3d4819f6-345b-11eb-1529-a104842997bd
# ╠═15e9d878-345c-11eb-3dad-511d97788b25
# ╟─4bad84c8-345c-11eb-3df3-ddda0b7037c6
# ╠═6db93d32-345c-11eb-17e3-b79c7e0f9583
# ╠═9dbb3a8a-345c-11eb-100c-53303f2c1129
# ╟─71ca50c8-345c-11eb-3d8d-8363d702b18a
# ╠═7a72af2c-345c-11eb-2c57-af89df87e520
# ╠═a1b4cd72-345c-11eb-1063-971890047299
# ╟─82a96208-345c-11eb-0b07-ed11d14a87b4
# ╠═a8649526-345c-11eb-09d2-19c3509819ad
# ╟─e702c686-345c-11eb-3c13-05d8ed7f70eb
# ╠═05729b28-345d-11eb-2c23-95273ede1d93
# ╟─14a2a570-345d-11eb-3b05-ebb363f9f789
# ╠═4beb5d38-345d-11eb-3383-4ba71c51c18c
# ╟─d31a4fbc-345d-11eb-176e-e3826ec59278
# ╠═f4a86364-345d-11eb-0ea5-8f90a2d397cb
# ╟─0c3dfadc-345e-11eb-2956-4740607709c2
# ╠═04a0847a-345e-11eb-1213-698c927e8b1a
# ╟─0b490c7e-345f-11eb-06aa-8ff9c4a2574c
# ╠═52b41724-3460-11eb-0c80-f5944d2b5321
# ╠═8f594a38-345f-11eb-0c29-374282b4f117
# ╠═4d5c66d2-3460-11eb-0a0b-551342c7db53
