(: this quick and dirty xql file accepts ajax requests for all files of a user-upload-session :)
xquery version "3.1";

import module namespace config="http://exist-db.org/apps/textgenetic-KSL/config" at "config.xqm";
import module namespace functx="http://www.functx.com"; 


declare namespace output="http://www.w3.org/2010/xslt-xquery-serialization";

declare namespace xmldb="http://exist-db.org/xquery/xmldb";
declare namespace request="http://exist-db.org/xquery/request";


declare option output:method "json";
declare option output:media-type "application/json";

declare function local:get_sessionfiles() {
    let $folder := session:get-attribute("fileId")
    let $xml-collection := $config:data-root || "/user-uploads/" || $folder ||"/tei"
    let $css-collection := $config:data-root || "/user-uploads/" || $folder ||"/css"
    let $xml-files := if (xmldb:collection-available($xml-collection)) then xmldb:get-child-resources($xml-collection ) else ()
    let $css-files := if (xmldb:collection-available($css-collection)) then xmldb:get-child-resources($css-collection ) else ()
    
    return map{
            "session_filename": $folder,
            "tei-files": if (count($xml-files) = 1) then [$xml-files] else $xml-files ,
            "css-files": if (count($css-files) = 1) then [$css-files] else $css-files
    }
};

(: just an example, in case we want to add GET parameters later::)
let $action := request:get-parameter('action','')
(: return the session files (if there are any) :)
return local:get_sessionfiles()