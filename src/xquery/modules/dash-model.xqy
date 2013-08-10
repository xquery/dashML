xquery version "1.0-ml";

module namespace dash = "https://github.com/dashML/model/dash";

import module namespace meter="http://marklogic.com/manage/meters"
    at "/MarkLogic/manage/meter/meter.xqy";

declare namespace rxq="﻿http://exquery.org/ns/restxq";

declare
  %rxq:GET
  %rxq:path('/data/dash')
  %rxq:produces('text/xml')
function dash:list(
$d1
)
{
collection("dashml")
};

declare
  %rxq:GET
  %rxq:path('/data/dash/(.*)')
  %rxq:produces('text/xml')
function dash:get(
$id
)
{
  collection("dashml")/dash[@id eq $id]
};


declare
  %rxq:POST
  %rxq:path('/data/dash/(.*)')
  %rxq:produces('text/xml')
function dash:create(
)
{
  let $id := xdmp:random()
  let $dash := element dash {
    attribute id {$id},
    (xdmp:get-request-body("xml")/.)/*
    }
  return
  (xdmp:document-insert(
     $id || ".xml", 
	 $dash,
     xdmp:default-permissions(), 
     ("dashml"), 
	 10), <id>{$id}</id>)
};


declare
  %rxq:POST
  %rxq:path('/data/dash/(.*)')
  %rxq:produces('text/xml')
function dash:update(
$id
)
{
  <dash id="{$id}"/>
};

declare
  %rxq:DELETE
  %rxq:path('/data/dash/(.*)')
  %rxq:produces('text/xml')
function dash:delete(
$id
) as empty-sequence()
{
  xdmp:document-delete($id || ".xml")
};