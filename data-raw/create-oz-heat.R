# creating oz_heat

# downloaded a file from http://www.bom.gov.au/jsp/awap/temp/index.jsp
# selecting "mean maximum", "1 day" and "Austalia" - from the hyperlinked "grid"

oz_heat <- readGDAL("2017-02-11-oz-heat.grid")

