# library module: https://github.com/dashML/model/history


## Table of Contents

* Functions: [history:get-metric-names\#0](#func_history_get-metric-names_0), [history:get-database\#9](#func_history_get-database_9), [history:get-forest\#9](#func_history_get-forest_9), [history:get-host\#9](#func_history_get-host_9), [history:get-server\#9](#func_history_get-server_9), [history:get-metrics\#3](#func_history_get-metrics_3), [history:generate-sparkle-data\#1](#func_history_generate-sparkle-data_1), [history:get-log\#1](#func_history_get-log_1), [history:remove-error-log-triples\#0](#func_history_remove-error-log-triples_0), [history:generate-test-error\#0](#func_history_generate-test-error_0), [history:load-error-triples\#0](#func_history_load-error-triples_0), [history:get-error-log-data\#5](#func_history_get-error-log-data_5)


## Functions

### <a name="func_history_get-metric-names_0"/> history:get-metric-names\#0
```xquery
history:get-metric-names(
)
```
 history:get-metric-names - generate list of metric names for drop down selection   

 
### <a name="func_history_get-database_9"/> history:get-database\#9
```xquery
history:get-database(
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
```
 history:get-database - get database metrics, as alternate to using Manage API   

 
#### Params

* $meter as  xs:string

* $period as  xs:string

* $start

* $end

* $aggregation as  xs:string

* $format as  xs:string

* $summary as  xs:boolean

* $detail as  xs:boolean

* $databases as  xs:unsignedLong\*


### <a name="func_history_get-forest_9"/> history:get-forest\#9
```xquery
history:get-forest(
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
```
 history:get-forest - get forest metrics, as alternate to using Manage API   

 
#### Params

* $meter as  xs:string

* $period as  xs:string

* $start

* $end

* $aggregation as  xs:string

* $format as  xs:string

* $summary as  xs:boolean

* $detail as  xs:boolean

* $forests as  xs:unsignedLong\*


### <a name="func_history_get-host_9"/> history:get-host\#9
```xquery
history:get-host(
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
```
 history:get-host - get host metrics, as alternate to using Manage API   

 
#### Params

* $meter as  xs:string

* $period as  xs:string

* $start

* $end

* $aggregation as  xs:string

* $format as  xs:string

* $summary as  xs:boolean

* $detail as  xs:boolean

* $hosts as  xs:unsignedLong\*


### <a name="func_history_get-server_9"/> history:get-server\#9
```xquery
history:get-server(
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
```
 history:get-server - get server metrics, as alternate to using Manage API   

 
#### Params

* $meter as  xs:string

* $period as  xs:string

* $start

* $end

* $aggregation as  xs:string

* $format as  xs:string

* $summary as  xs:boolean

* $detail as  xs:boolean

* $servers as  xs:unsignedLong\*


### <a name="func_history_get-metrics_3"/> history:get-metrics\#3
```xquery
history:get-metrics(
    $resource as xs:string,
    $meter as xs:string,
    $period as xs:string
)
```
 history:get-metrics - generic entry point   

 
#### Params

* $resource as  xs:string

* $meter as  xs:string

* $period as  xs:string


### <a name="func_history_generate-sparkle-data_1"/> history:generate-sparkle-data\#1
```xquery
history:generate-sparkle-data(
    $data
)
```
 history:generate-sparkle-data - helper function for massaging data                                    into format required for sparkline   

 
#### Params

* $data


### <a name="func_history_get-log_1"/> history:get-log\#1
```xquery
history:get-log(
    $logfile as xs:string
)
```
 history:get-log - obtain error log from HTTP to avoid file path differences   

 
#### Params

* $logfile as  xs:string


### <a name="func_history_remove-error-log-triples_0"/> history:remove-error-log-triples\#0
```xquery
history:remove-error-log-triples(
)
```
 history:remove-error-log-triples - remove error_log triple graph   

 
### <a name="func_history_generate-test-error_0"/> history:generate-test-error\#0
```xquery
history:generate-test-error(
)
```
 history:generate-test-error - insert an error log trace into ErrorLog.txt   

 
### <a name="func_history_load-error-triples_0"/> history:load-error-triples\#0
```xquery
history:load-error-triples(
)
```
 history:load-error-triples - load ErrorLog.txt as triples into error_log graph   

 
### <a name="func_history_get-error-log-data_5"/> history:get-error-log-data\#5
```xquery
history:get-error-log-data(
    $loglevel as xs:string,
    $meter as xs:string,
    $end as xs:dateTime,
    $resource as xs:string,
    $period as xs:string
)
```
 history:get-error-log-data - return error log data for meter widget   

 
#### Params

* $loglevel as  xs:string

* $meter as  xs:string

* $end as  xs:dateTime

* $resource as  xs:string

* $period as  xs:string






*Generated by [xquerydoc](https://github.com/xquery/xquerydoc)*
