xquery version "1.0-ml";

module namespace view = "https://github.com/dashML/view";

import module namespace meter="http://marklogic.com/manage/meters"
    at "/MarkLogic/manage/meter/meter.xqy";
    
declare namespace rxq="﻿http://exquery.org/ns/restxq";

declare
  %rxq:GET
  %rxq:path('/test.html')
  %rxq:produces('text/html')
function view:home-page(
  $var1
)
{
<html>
<head>
<title>dashML</title>
<script type="text/javascript" language="javascript" src="/resources/Saxon-CE_1.1/Saxonce/Saxonce.nocache.js"></script>
<script type="application/xslt+xml" language="xslt2.0" src="/resources/dashml.xsl" data-source="/meter/sample"></script>

</head>
<body>
<h1>dashML</h1>

<div id="meters">test</div>

</body>
</html>
};


declare
  %rxq:GET
  %rxq:path('/meter/forest/(.*)/(.*)')
  %rxq:produces('application/xml')
function view:meter-sample(
  $meter,
  $period
)
{   
  let $start := xs:dateTime("2013-08-08T15:00:00")
  let $end   := xs:dateTime("2013-08-08T23:00:00")
  let $params := map:map()  
  let $_ := map:put($params,"summary",true())
  let $_ := map:put($params,"detail",true())
  let $_ := map:put($params,"aggregation","avg")
  let $_ := map:put($params,"format","xml")
  return meter:time-series(xs:QName("meter:forest-status"), (), $meter,$period,(),(),$params) 
};
