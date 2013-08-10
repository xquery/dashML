xquery version "1.0-ml";
module namespace test = "http://github.com/robwhitby/xray/test";

import module namespace view = "https://github.com/dashML/view"
  at "/xquery/modules/view.xqy";

import module namespace render = "https://github.com/dashML/render"
  at "/xquery/modules/dash-render.xqy";

import module namespace builder = "https://github.com/dashML/builder"
  at "/xquery/modules/dash-builder.xqy";

import module namespace history-model = "https://github.com/dashML/model/history"
  at "/xquery/modules/history-model.xqy";

import module namespace dash-model = "https://github.com/dashML/model/dash"
  at "/xquery/modules/dash-model.xqy";
  
import module namespace assert = "http://github.com/robwhitby/xray/assertions"
  at "/xray/src/assertions.xqy";

declare namespace meter="http://marklogic.com/manage/meters";

declare %test:setup function setup()
{
  xdmp:document-insert(
     "999999.xml", 
	 <dash id="999999"></dash>,
     xdmp:default-permissions(), 
     ("dashml"), 
	 10)
};

declare %test:teardown function teardown()
{
  for $doc in collection("dashml")
  return xdmp:document-delete( base-uri($doc) )
};

declare %test:case function check-spec-page()
{
    let $results := view:home-page(())
    return assert:true(exists($results))
};

declare %test:case function check-overview-page()
{
    let $results := view:overview-page(())
    return assert:true(exists($results))
};

declare %test:case function check-render-dash()
{
    let $results := render:dash(())
    return assert:true(exists($results))
};

declare %test:case function check-builder-dash()
{
    let $results := builder:dash(())
    return assert:true(exists($results))
};

declare %test:case function check-history-get()
{
    let $results := history-model:get("forest","active-fragment-count","hour")
    return assert:true(name($results) eq "active-fragment-count")
};

declare %test:case function check-dash-list()
{
    let $results := dash-model:list(())
    return assert:true(exists($results))
};

declare %test:case function check-dash-get()
{
    let $results := dash-model:get(999999)
    return assert:equal($results,<dash id="999999" xmlns=""></dash>)
};

declare %test:case function check-dash-create()
{
    let $results := dash-model:create()
    return
      assert:true(name($results) eq "id")
};

declare %test:case function check-dash-update()
{
    let $results := dash-model:list(())
    return assert:true(exists($results))
};

declare %test:case function z_check-dash-delete()
{
    let $result := dash-model:delete(999999)
    return
      assert:equal($result,())
};
