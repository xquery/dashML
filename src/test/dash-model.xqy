xquery version "1.0-ml";
module namespace test = "http://github.com/robwhitby/xray/test";

import module namespace dash-model = "https://github.com/dashML/model/dash"
  at "/xquery/modules/dash-model.xqy";

import module namespace assert = "http://github.com/robwhitby/xray/assertions"
  at "/xray/src/assertions.xqy";

declare variable $dash := <dash id="9999999999" xmlns="https://github.com/dashML/model/dash">
<title>test1</title>
<widget id="8888888888">
<title>w title</title>
<type></type>
<resource>forests</resource>
<meter>active-fragment-count</meter>
</widget>
</dash>;

declare variable $dashes := <dashes xmlns="https://github.com/dashML/model/dash">
    <dash id="9999999999">
        <title>test1</title>
        <widget id="121212121">
            <title>w title</title>
            <type></type>
            <resource>forests</resource>
            <meter>nascent-fragment-count</meter>
        </widget>
        <widget id="8888888888">
            <title>w title</title>
            <type></type>
            <resource>forests</resource>
            <meter>active-fragment-count</meter>
        </widget>
    </dash>
    <dash id="9999999991">
        <title>test2</title>
        <widget id="121212121">
            <title>w title</title>
            <type></type>
            <resource>forests</resource>
            <meter>nascent-fragment-count</meter>
        </widget>
        <widget id="8888888888">
            <title>w title</title>
            <type></type>
            <resource>forests</resource>
            <meter>active-fragment-count</meter>
        </widget>
    </dash>
</dashes>;

declare variable $dash-error := <dash>
<wrong-element/>
</dash>;

declare %test:setup function setup()
{
 (
  xdmp:document-insert(
     "999999.xml",
     $test:dash,
     xdmp:default-permissions(),
     ("dashml"), 10),
     
  xdmp:eval('
  xquery version "1.0-ml";

  xdmp:document-load("/Users/jfuller/Source/Webcomposite/dashML/etc/dash.xsd",
      <options xmlns="xdmp:document-load">
    <uri>/dash.xsd</uri>
  </options>)
  ', (),
        <options xmlns="xdmp:eval">
            <database>{xdmp:schema-database()}</database>
    </options>)
 )
};

declare %test:teardown function teardown()
{
  for $doc in collection("dashml")
  return xdmp:document-delete( base-uri($doc) )
};

declare %test:case function validate-dash-success()
{
    assert:schema-validate("validate good dashboard",$dash)
};

declare %test:case function validate-all-dashes-success()
{
    assert:schema-validate("validate good dashboard",dash-model:all())
};

declare %test:case function validate-dashes-success()
{
    assert:schema-validate("validate $dashes",$dashes)
};

declare %test:case function validate-dash-error()
{
   assert:equal(assert:schema-validate("test bad dashboard",$dash-error)//error:error/error:code,<error:code>XDMP-VALIDATENODECL</error:code>,"validate dash error")
};

declare %test:case function list-dashes()
{
    let $result := dash-model:all()
    return assert:equal($result, <dashes xmlns="https://github.com/dashML/model/dash">
      <dash id="9999999999">
        <title>test1</title>
        <widget id="8888888888">
          <title>w title</title>
          <type></type>
          <resource>forests</resource>
          <meter>active-fragment-count</meter>
        </widget>
      </dash>
    </dashes>, "list all dashes with dash-model:all()")
};


declare %test:case function get-dash()
{
    let $result := dash-model:get(9999999999)
    return assert:equal($result,<dash id="9999999999" xmlns="https://github.com/dashML/model/dash">
      <title>test1</title>
      <widget id="8888888888">
        <title>w title</title>
        <type></type>
        <resource>forests</resource>
        <meter>active-fragment-count</meter>
      </widget>
    </dash>,"test dash-model:get()")

};

declare %test:case function check-collection()
{
    assert:equal($dash-model:_COLLECTION,"dashml","check dashml collection")
};


declare %test:case function z-add-dash()
{
let $result := dash-model:create(
    "runtimetest",
    <dash xmlns="https://github.com/dashML/model/dash">
      <title>test1</title>
      <widget id="66666666666">
        <title>w title</title>
        <type></type>
        <resource>forests</resource>
        <meter>deleted-fragment-count</meter>
      </widget>
    </dash>)
    return
    (
        assert:true(exists($result)),
        assert:true($result castable as xs:unsignedLong),
        assert:equal(name($result),"id")
    )
};


declare %test:case function z-add-widget-to-dash()
{

let $getall  := dash-model:all()
let $dash-id := $getall/*[@id ne 9999999999][1]/@id/data(.)
let $result  :=
    xdmp:eval('
    import module namespace dash-model = "https://github.com/dashML/model/dash"
    at "/xquery/modules/dash-model.xqy";

    dash-model:add-widget-to-dash(
    '||$dash-id||',
    <model:widget id="4444444444"  xmlns:model="https://github.com/dashML/model/dash">
      <model:title>new widget title</model:title>
      <model:type>sparkle</model:type>
      <model:resource>databases</model:resource>
      <model:meter>active-fragment-count</model:meter>
    </model:widget>
    )',())
    
let $check := xdmp:eval('
    import module namespace dash-model = "https://github.com/dashML/model/dash"
    at "/xquery/modules/dash-model.xqy";
    dash-model:get('|| $dash-id ||')
    ',())
return (
    assert:true(exists($dash-id)),
    assert:equal(count($check/dash-model:widget),2)
    )
};

declare %test:case function z-remove-widget-to-dash()
{

let $getall  := dash-model:all()
let $dash-id := $getall/*[@id ne 9999999999][1]/@id/data(.)
let $widget-id := 4444444444
let $result  :=
    xdmp:eval('
    import module namespace dash-model = "https://github.com/dashML/model/dash"
    at "/xquery/modules/dash-model.xqy";

    dash-model:remove-widget-to-dash(
    '||$dash-id||',
    '||$widget-id||')
   ',())

let $check := xdmp:eval('
    import module namespace dash-model = "https://github.com/dashML/model/dash"
    at "/xquery/modules/dash-model.xqy";
    dash-model:get('|| $dash-id ||')
    ',())
return (
    assert:true(exists($dash-id)),
    assert:equal(count($check/dash-model:widget),1),
    assert:equal($check/dash-model:widget,<model:widget id="66666666666" xmlns:model="https://github.com/dashML/model/dash">
      <model:title>w title</model:title>
      <model:type></model:type>
      <model:resource>forests</model:resource>
      <model:meter>deleted-fragment-count</model:meter>
    </model:widget>)
    )
};

declare %test:case function z-add-dash-check-validate()
{
let $result := try{ dash-model:create(
    "runtimetest",
    <dash xmlns="https://github.com/dashML/model/dash">
      <title1>test1</title1>
      <badwidget id="66666666666">
        <title>w title</title>
        <type></type>
        <resource>forests</resource>
        <meter>deleted-fragment-count</meter>
      </badwidget>
    </dash>,fn:true())
}catch($e){$e}
    return
        assert:equal($result//error:code[1],
          <error:code xmlns:error="http://marklogic.com/xdmp/error">DASHML_ERR_CREATE</error:code>)
};


declare %test:case function z-update-dash()
{
let $getall  := dash-model:all()
let $id      := $getall/*[@id ne 9999999999]/@id/data()

let $result := dash-model:update(
    $id,
    <dash xmlns="https://github.com/dashML/model/dash">
      <title>test updated</title>
      <widget id="66666666666">
        <title>w title</title>
        <type></type>
        <resource>forests</resource>
        <meter>deleted-fragment-count</meter>
      </widget>
    </dash>)
    return
        assert:equal($result/data(),$id)
};


declare %test:case function z-update-dash-validate()
{
let $getall  := dash-model:all()
let $id      := $getall/*[@id ne 9999999999]/@id/data()

let $result := try{ dash-model:update(
    $id,
    <dash xmlns="https://github.com/dashML/model/dash">
      <title>test updated</title>
      <badwidget id="66666666666">
        <title>w title</title>
        <type></type>
        <resource>forests</resource>
        <meter>deleted-fragment-count</meter>
      </badwidget>
    </dash>,fn:true())
    }catch($e){$e}
    return
        assert:equal($result//error:code[1],<error:code xmlns:error="http://marklogic.com/xdmp/error">DASHML_ERR_CREATE</error:code>)
};


declare %test:case function zz-remove-dash()
{
let $getall  := dash-model:all()
let $id      := $getall/*[@id ne 9999999999][1]/@id/data()
let $results := xdmp:eval('
    import module namespace dash-model = "https://github.com/dashML/model/dash"
    at "/xquery/modules/dash-model.xqy";
    dash-model:remove(' || $id || ' )',())
let $check := xdmp:eval('
    import module namespace dash-model = "https://github.com/dashML/model/dash"
    at "/xquery/modules/dash-model.xqy";
    dash-model:get(' || $id || ' )',())
return
    (
        assert:equal($results,(),"check remove dash id: " || $id),
        assert:equal($check,(),"check if dash id: " || $id || "still exists")
    )
};