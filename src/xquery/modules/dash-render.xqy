xquery version "1.0-ml";

module namespace render = "https://github.com/dashML/render";

declare namespace rxq="﻿http://exquery.org/ns/restxq";

declare
  %rxq:GET
  %rxq:path("/dashml/render")
  %rxq:produces('text/html')
function render:dash(
  $format
)
{
  if ($format eq "xml")
    then <xml/>
    else <html/>
};



