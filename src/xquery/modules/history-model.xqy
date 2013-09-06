xquery version "1.0-ml";

module namespace history = "https://github.com/dashML/model/history";

import module namespace meter="http://marklogic.com/manage/meters"
    at "/MarkLogic/manage/meter/meter.xqy";

import module namespace mdecl="http://marklogic.com/manage/meters/decl"
  at "/MarkLogic/manage/meter/meter-decl.xqy";

declare namespace rxq="﻿http://exquery.org/ns/restxq";

declare option xdmp:mapping "false";

declare function history:get-metric-names(){
element optgroup {
    element optgroup {
        attribute label {"databases"},
        for $s in $mdecl:database-status-names
        return element option{
            attribute value {"databases:" || $s},
            $s }
    },
    element optgroup {
        attribute label {"hosts"},
        for $s in $mdecl:host-status-names
        return element option{
            attribute value {"hosts:" || $s},
            $s }
    },
    element optgroup {
        attribute label {"servers"},
        for $s in $mdecl:server-status-names
        return element option{
            attribute value {"servers:" || $s},
            $s }
    },
    element optgroup {
        attribute label {"forests"},
        for $s in ( $mdecl:forest-status-names,$mdecl:forest-counts-names)
        return element option{
            attribute value {"forests:" || $s},
            $s }
    }
  }
};

declare function history:get-database(
  $meter as xs:string,
  $period as xs:string,
  $start,
  $end,
  $aggregation as xs:string,
  $format as xs:string,
  $summary as xs:boolean,
  $detail as xs:boolean,
  $databases as xs:unsignedLong*
)
{
  let $params := map:map()
  let $_ := map:put($params,"summary",$summary)
  let $_ := map:put($params,"detail",$detail)
  let $_ := map:put($params,"summary-aggregation",$aggregation)
  let $_ := map:put($params,"format",$format)
  let $_ := map:put($params,"database",$databases)
  return meter:time-series(
      xs:QName("meter:database-status"),
      (),
      $meter,$period,$start,$end,$params)
};


declare function history:get-forest(
  $meter as xs:string,
  $period as xs:string,
  $start,
  $end,
  $aggregation as xs:string,
  $format as xs:string,
  $summary as xs:boolean,
  $detail as xs:boolean,
  $forests as xs:unsignedLong*
)
{
  let $params := map:map()
  let $_ := map:put($params,"summary",$summary)
  let $_ := map:put($params,"detail",$detail)
  let $_ := map:put($params,"summary-aggregation",$aggregation)
  let $_ := map:put($params,"format",$format)
  let $_ := map:put($params,"forest",$forests)
  return meter:time-series(
      xs:QName("meter:forest-status"),
      (),
      $meter,$period,$start,$end,$params)
};



declare function history:get-host(
  $meter as xs:string,
  $period as xs:string,
  $start,
  $end,
  $aggregation as xs:string,
  $format as xs:string,
  $summary as xs:boolean,
  $detail as xs:boolean,
  $hosts as xs:unsignedLong*
)
{
  let $params := map:map()
  let $_ := map:put($params,"summary",$summary)
  let $_ := map:put($params,"detail",$detail)
  let $_ := map:put($params,"summary-aggregation",$aggregation)
  let $_ := map:put($params,"format",$format)
  let $_ := map:put($params,"host",$hosts)
  return meter:time-series(
      xs:QName("meter:host-status"),
      (),
      $meter,$period,$start,$end,$params)
};



declare function history:get-server(
  $meter as xs:string,
  $period as xs:string,
  $start,
  $end,
  $aggregation as xs:string,
  $format as xs:string,
  $summary as xs:boolean,
  $detail as xs:boolean,
  $servers as xs:unsignedLong*
)
{
  let $params := map:map()
  let $_ := map:put($params,"summary",$summary)
  let $_ := map:put($params,"detail",$detail)
  let $_ := map:put($params,"summary-aggregation",$aggregation)
  let $_ := map:put($params,"format",$format)
  let $_ := map:put($params,"server",$servers)
  return meter:time-series(
      xs:QName("meter:server-status"),
      (),
      $meter,$period,$start,$end,$params)
};
