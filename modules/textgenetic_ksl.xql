module namespace ksl = "http://exist-db.org/apps/textgenetic-KSL/ksl";

import module namespace config="http://exist-db.org/apps/textgenetic-KSL/config" at "config.xqm";
import module namespace functx="http://www.functx.com"; 


declare function ksl:user-transform($mypath as xs:string?){
    (:<p>{$mypath}</p>:)
    let $tokens := tokenize($mypath,"/")

    let $xmlfile := doc($config:data-root||"/user-uploads/"|| $mypath)
    
    let $xsl1 := doc($config:app-root ||"/resources/xsl/1_make-changelist.xsl")
    let $xsl2 := doc($config:app-root ||"/resources/xsl/2_add-n-attribute.xsl")
    let $xsl3 := doc($config:app-root ||"/resources/xsl/to_html_english.xsl")
    
    let $serialization := "method=html5 media-type=text/html"
    
    let $attributes := <attributes>
                             <attr name="http://saxon.sf.net/feature/strip-whitespace" value="none"/>
                       </attributes>
    (: Saxon9??  :)
    let $params :=  <parameters>
                        <param name="css-path" value="{$tokens[1]}"/>
                    </parameters>
    
    let $transform1 := transform:transform($xmlfile    ,$xsl1   ,(),$attributes,$serialization)
    let $transform2 := transform:transform($transform1 ,$xsl2   ,(),$attributes,$serialization)
    let $transform3 := transform:stream-transform($transform2 ,$xsl3   ,($params),$attributes,$serialization)
    
    return $transform3
 

};


declare function ksl:transform($mypath as xs:string?){
    let $tokens := tokenize($mypath,"/")

    let $xmlfile := doc($config:data-root||"/user-uploads/"|| $mypath)
    
    let $xsl1 := doc($config:app-root ||"/resources/xsl/1_make-changelist.xsl")
    let $xsl2 := doc($config:app-root ||"/resources/xsl/2_add-n-attribute.xsl")
    let $xsl3 := doc($config:app-root ||"/resources/xsl/to_html.xsl")
    
    let $serialization := "method=html5 media-type=text/html"
    
    let $attributes := <attributes>
                             <attr name="http://saxon.sf.net/feature/strip-whitespace" value="none"/>
                       </attributes>
    (: Saxon9??  :)
    let $params :=  <parameters>
                        <param name="css-path" value="{$tokens[1]}"/>
                    </parameters>
    
    let $transform1 := transform:transform($xmlfile    ,$xsl1   ,(),$attributes,$serialization)
    let $transform2 := transform:transform($transform1 ,$xsl2   ,(),$attributes,$serialization)
    let $transform3 := transform:stream-transform($transform2 ,$xsl3   ,($params),$attributes,$serialization)
    
    return $transform3
    

};