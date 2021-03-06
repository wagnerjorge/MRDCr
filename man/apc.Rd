% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/apc.R
\name{apc}
\alias{apc}
\title{Gera a Matriz de Constrates de Tukey}
\usage{
apc(lfm, lev = NULL)
}
\arguments{
\item{lfm}{Uma matriz de dimensões \eqn{k\times p} onde cada linha
tem os coeficientes correspondentes para estimar uma média. Essas
matrizes são facilmente obtidas com usando a função
\code{doBy::LSmatrix()}.}

\item{lev}{Um vetor com os nomes dos níveis do fator para o qual
correspondem as linhas da matriz usada em \code{lfm}. Portanto, o
número de elementos do vetor deve ser igual ao número de linhas
da matriz. O valor default é \code{NULL} e então é usado o
\code{rownames()} da matriz. Se \code{rownames()} for
\code{NULL}, uma sequência de números começando em 1 é utilizada
para representar cada linha.}
}
\value{
Uma matriz \eqn{r\times p} cujas linhas estimam o contraste
    entre cada possível par de médias, portanto \eqn{r} is
    \eqn{{k}\choose{2}}.
}
\description{
Essa função retorna os contrastes de Tukeu entre médias
    a partir da matriz que define as funções lineares dos
    coeficientes do modelo para estimar a média de mínimos
    quadrados. Essas matrizes podem ser utilizadas para fazer
    contrastes entre médias por meio da função
    \code{multcomp::glht()}.
}
\examples{

X <- diag(3)
rownames(X)
apc(X)

rownames(X) <- LETTERS[nrow(X):1]
apc(X)

apc(X, lev = LETTERS[1:nrow(X)])

#-----------------------------------------
# Usando para estimar as médias e contrates.

xtabs(~tension + wool, data = warpbreaks)

warpbreaks <- transform(warpbreaks,
                        trt = interaction(tension, wool))

m0 <- lm(log(breaks) ~ trt, data = warpbreaks)
anova(m0)

library(doBy)

L <- LSmatrix(m0, effect = "trt")
L

K <- apc(L)
K

library(multcomp)

glht(m0, linfct = L)
glht(m0, linfct = K)

aggregate(cbind(log(breaks)) ~ trt, data = warpbreaks, FUN = mean)

}
\seealso{
\code{\link[doBy]{LSmatrix}}.
}
\author{
Walmes Zeviani baseado na lista de discussão R-help.
}
