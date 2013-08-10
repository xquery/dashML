xquery version "1.0-ml";

module namespace history = "https://github.com/dashML/model/history";

import module namespace meter="http://marklogic.com/manage/meters"
    at "/MarkLogic/manage/meter/meter.xqy";

declare namespace rxq="﻿http://exquery.org/ns/restxq";

declare
  %rxq:GET
  %rxq:path('/data/history/(.*)/(.*)/(.*)')
  %rxq:produces('application/xml')
function history:get(
  $resource,
  $meter,
  $period
)
{   
  let $start := ()
  let $end   := current-dateTime()
  let $params := map:map()  
  let $_ := map:put($params,"summary",true())
  let $_ := map:put($params,"detail",false())
  let $_ := map:put($params,"aggregation","avg")
  let $_ := map:put($params,"format","xml")
  return meter:time-series(xs:QName("meter:" || $resource || "-status"), (), $meter,$period,(),(),$params) 
};
