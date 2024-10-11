xquery version "3.1";

import module namespace config="http://exist-db.org/apps/textgenetic-KSL/config" at "config.xqm";
import module namespace functx = "http://www.functx.com" at "/db/system/repo/functx-1.0.1/functx/functx.xq";

declare namespace json="http://www.json.org";


declare option exist:serialize "method=json media-type=application/json";

declare function local:upload($root, $paths, $payloads) {
    
    (:new eXist-collection in $path:)
    let $newCollectionId := ""
    let $collectionID := session:set-attribute("fileId", $newCollectionId)
    (:use session:set-attribute:)
    let $newCollectionFolder := $config:data-root||"/user-uploads/"
    let $newCollection := xmldb:create-collection($newCollectionFolder,$newCollectionId)
    let $cssFolder := xmldb:create-collection($newCollection, "css")
    let $teiFolder := xmldb:create-collection($newCollection, "tei")
    
    let $collectionFolder := $newCollectionFolder||$newCollectionId
    let $paths :=
        for-each-pair($paths, $payloads, function($path, $data) {
                (:todo: mime type might be better than file-ending:)
                let $fileExt := functx:substring-after-last($path,".")
                (:decide which subfolder to put the file in based on its extension:)
                let $subfolder := 
                        if ($fileExt=('XML','xml')) then 'tei' 
                        else if ($fileExt=("css","CSS")) then "css" 
                        else "none"
                let $storeFile := if ($subfolder="css") then local:addCSS($collectionFolder, $subfolder, $path, $data)
                                  else if ($subfolder="tei") then local:addTranscript($collectionFolder, $path, $data)
                                  else ""
                return map {'fullpath': $storeFile, 'filefolder': $subfolder}
    })

    return
        map {
            "files": array {
                for $path in $paths
                return
                    map {
                        "name": functx:substring-after-last($path("fullpath"),'/'),
                        "path": substring-after($path("fullpath"), $config:data-root || "/"),
                        "type": xmldb:get-mime-type($path("fullpath")),
                        "size": 93928,
                        "fullURL": $path("fullpath"),
                        "foldertype" : $path("filefolder"),
                        "collectionPath" : $collectionFolder,
                        "collectionId" : $collectionID
                    }
            }
        }
};


declare function local:addTranscript($collectionFolder as xs:string, $path as xs:string, $data as item()){
    (:.. add some pre processing..:)
    let $saveTranscript := xmldb:store($collectionFolder||"/tei/", $path,  $data)
    
    return $saveTranscript    
};


declare function local:addCSS($collectionFolder as xs:string, $subfolder as xs:string, $path as xs:string, $data as item()) {
    (:store css file:)
    (:TODO: add any pre-processing here, e.g. to filter certain rules that might mess up the entire design:)
    let $fullFolder := concat($collectionFolder,"/",$subfolder)
    let $regularSize := xmldb:store($fullFolder, $path,  $data)
    return $regularSize    
};


(:recursive function to produce a new module-,collection-, or resource-id that is not yet in use:)
(:  :declare function local:createUniqueID(){
    let $testId := fn:tokenize(util:uuid(),'-')[1]
    let $idExist := collection($config:data-root)//id($testId)
    return if ($idExist) then ( local:createUniqueID() ) else $testId 
};:)





let $name := request:get-uploaded-file-name("files[]")
let $data := request:get-uploaded-file-data("files[]")
let $root := request:get-parameter("root", "")
return
    try {
        local:upload($root, $name, $data)
    } catch * {
        map {
            "name": $name,
            "error": $err:description
        }
    }
