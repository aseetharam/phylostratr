% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/tree_manipulation.R
\name{children}
\alias{children}
\alias{children.Strata}
\title{Get the immediate children of a node}
\usage{
children(x, ...)

\method{children}{Strata}(x, id, type = "name", ...)
}
\arguments{
\item{x}{phylo object}

\item{...}{Arguments passed on to \code{children.phylo}}

\item{id}{vector of ids or names}

\item{type}{id type: ['name', 'id', 'auto']}
}
\value{
vector of children, (integer(0) if there are no children)
}
\description{
Get the immediate children of a node
}
