xquery version "1.0-ml";

module namespace view = "https://github.com/dashML/view";

import module namespace meter="http://marklogic.com/manage/meters"
    at "/MarkLogic/manage/meter/meter.xqy";
    
declare namespace rxq="﻿http://exquery.org/ns/restxq";

declare
  %rxq:GET
  %rxq:path('/meta/spec')
  %rxq:produces('text/html')
function view:home-page(
  $var1
)
{
<html>
<head>
<title>dashML Specification</title>
<link href="/resources/css/bootstrap.min.css" rel="stylesheet" media="screen"></link>

</head>
<body>
<h1>dashML Specification</h1>
<p>Make it easy to create custom dashboard page of metrics, leveraging MarkLogic meters</p>
<h3>components</h3>
<ul>
  <li>dashboard builder- interactive form for generating page</li>
  <li>dashboard renderer- renderer generates responsive design page of metrics</li>
</ul>
<h3>technology</h3>
<ul>
  <li>marklogic meters</li>
  <li>saxon-ce</li>
  <li>javscript</li>
</ul>
<h3>models</h3>
<ul>
  <li>meters</li>
  <li>pages</li>
  <li>dash widgets</li>
</ul>
<h3>features</h3>
<ul>
  <li>generate page</li>
  <li>set alerts/limits</li>
  <li>make 'live'</li>
</ul>
</body>
</html>
};


declare
  %rxq:GET
  %rxq:path('/meter/(.*)/(.*)/(.*)')
  %rxq:produces('application/xml')
function view:meter-sample(
  $resource,
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
  return meter:time-series(xs:QName("meter:" || $resource || "-status"), (), $meter,$period,(),(),$params) 
};
