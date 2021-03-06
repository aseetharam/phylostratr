#' Load a table of scored matches
#'
#' This must be a TAB-delimited file with a header and the following columns:
#'
#' \itemize{
#'   \item qseqid - an identifier for the query sequence
#'   \item evalue - the e-value reported by BLAST
#'   \item score  - the raw score (not the bitscore)
#'   \item staxid - the subject taxon
#' }
#'
#' @section staxid:
#'
#' The staxid column must contain NCBI taxon ids. One hit may be associated
#' with multiple taxon ids. In this case, we assume that all other fields are
#' the same over the row, and create one new row for each taxa. This situation
#' occurs, for example, in RefSeq databases, where identical sequences that are
#' shared between multiple taxa are merged into one.
#'
#' If any entries are missing taxon ids, then a warning is raised. If there are
#' only a few missing ids, this may be fine. For example, some entries in
#' RefSeq have no associated taxon ID. But if most or all of the ids are
#' missing, then you probably need to reformat your BLAST database with a taxon
#' table.
#'
#' @param filename Filename or URL. This will be read by
#' \code{readr::read_tsv}, which understands URLs and will handle
#' decompression.
#' @param na_str The characters that indicate missing data. NCBI-blast uses
#' 'N/A', so that is the default here.
#' @return A data.frame
#' @export
load_hittable <- function(filename, na_str='N/A'){
  d <- readr::read_tsv(
    filename,
    col_names=c('qseqid', 'evalue', 'score', 'staxid'),
    na=na_str,
    col_types='cddc'
  ) %>%
    dplyr::mutate(staxid = strsplit(.data$staxid, ';')) %>%
    tidyr::unnest(.data$staxid) %>%
    dplyr::mutate(staxid = as.integer(.data$staxid))

  check_hit_table(d)

  d
}
