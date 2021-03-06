% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/emuR-requery.database.R
\name{requery_seq}
\alias{requery_seq}
\title{Requery sequential context of segment list in an emuDB}
\usage{
requery_seq(emuDBhandle, seglist, offset = 0, offsetRef = "START",
  length = 1, ignoreOutOfBounds = FALSE, calcTimes = TRUE,
  timeRefSegmentLevel = NULL, verbose = FALSE)
}
\arguments{
\item{emuDBhandle}{emuDB handle as returned by \code{\link{load_emuDB}}}

\item{seglist}{segment list to requery on (type: 'emuRsegs')}

\item{offset}{start item offset in sequence (default is 0, meaning the start or end item of the input segment)}

\item{offsetRef}{reference item for offset: 'START' for first and 'END' for last item of segment}

\item{length}{item length of segments in the returned segment list}

\item{ignoreOutOfBounds}{ignore result segments that are out of bundle bounds}

\item{calcTimes}{calculate times for resulting segments (results in \code{NA} values for start and end times in emuseg/emuRsegs). As it can be very computationally expensive to 
calculate the times for large nested hierarchies it can be turned of via this boolian parameter.}

\item{timeRefSegmentLevel}{set time segment level from which to derive time information. It is only necessary to set this parameter if more than one child level contains time information and the queried parent level is of type ITEM.}

\item{verbose}{be verbose. Set this to \code{TRUE} if you wish to choose which path to traverse on intersecting hierarchies. If set to \code{FALSE} (the default) all paths will be traversed (= legacy EMU bahaviour).}
}
\value{
result set object of class 'emuRsegs' containing the requeried segments
}
\description{
Function to requery sequential context of a segment list queried from an emuDB
}
\details{
Builds a new segment list on the same hierarchical level and the same length as the segment list given in \code{seglist}. The resulting segments usually have different start position and length (in terms of items of the respective level) controlled by the \code{offset},\code{offsetRef} and \code{length} parameters.
A segment here is defined as a single item or a chain of items from the respective level, e.g. if a level in a bundle instance has labels 'a', 'b' and 'c' in that order, 'a' or 'a->b' oder 'a->b->c' are all valid segments, but not 'a->c'.
\code{offsetRef} determines if the position offset is referenced to the start or the end item of the segments in the input list \code{seglist}; parameter \code{offset} determines the offset of the resulting item start position to this reference item;
parameter \code{length} sets the item length of the result segments.
If the requested segments are out of bundle item boundaries and parameter \code{ignoreOutOfBounds} is \code{FALSE} (the default), an error is generated. To get residual resulting segments that lie within the bounds the \code{ignoreOutOfBounds} parameter can be set to \code{TRUE}.
The returned segment list is usually of the same length and order as the input \code{seglist}; if \code{ignoreOutOfBounds=FALSE}, the resulting segment list may be out of sync.
}
\examples{
\dontrun{

##################################
# prerequisite: loaded ae emuDB 
# (see ?load_emuDB for more information)

## Requery previous item of 'p' on level 'Phonetic'
sl1 = query(ae, "Phonetic == p")

requery_seq(ae, sl1, offset = -1)

## Requery context (adding previuos and following elements) of 'p' on phonetic level

requery_seq(ae, sl1, offset = -1, length = 3)

## Requery previous item of n->t sequence
sl2 = query(ae, "[Phoneme == n -> Phoneme == t]")

requery_seq(ae, sl2, offset = -1)

## Requery last item within n->t sequence

requery_seq(ae, sl2, offsetRef = 'END')

## Requery following item after n->t sequence

requery_seq(ae, sl2, offset = 1, offsetRef = 'END')

## Requery context (previous and following items) of n->t sequence

requery_seq(ae, sl2, offset = -1, length = 4)

## Requery next word contexts (sequence includes target word)

sl3 = query(ae, "Text == to")
requery_seq(ae, sl3, length = 2)

## Requery following two word contexts, ignoring segment 
## sequences that are out of bundle end bounds 
requery_seq(ae, sl3, length = 3, ignoreOutOfBounds = TRUE)

}
}
\seealso{
\code{\link{query}} \code{\link{requery_hier}} \code{\link{emuRsegs}}
}
\keyword{database}
\keyword{emuDB}
\keyword{requery}
