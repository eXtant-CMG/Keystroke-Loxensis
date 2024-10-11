xquery version "3.1";
module namespace file_view="http://exist-db.org/apps/textgenetic-KSL/file_view";
declare namespace tei="http://www.tei-c.org/ns/1.0";
import module namespace templates="http://exist-db.org/xquery/templates" ;
import module namespace config="http://exist-db.org/apps/textgenetic-KSL/config" at "config.xqm";

declare function file_view:all-files($node as node(), $model as map(*)) {
      <table class="uploads">
          <tr>
              <th>File name</th>
              <th>Text title</th>
              <th>Author</th>
              <th>Standard visualisation</th>
              <th>Annotation visualisation</th>
          </tr>
          {
          let $data-collection := $config:data-root||"/user-uploads"
          for $resource in collection($data-collection)
          let $uri := base-uri($resource)
          return
          <tr>
            <td>
                <a class="link" href="{concat('/exist/rest/', base-uri($resource))}">{util:unescape-uri(replace($uri, ".+/(.+)$", "$1"), "UTF-8")}</a>
            </td>
            <td>{$resource/tei:TEI/tei:teiHeader//tei:title/text()}</td>
            <td>{$resource/tei:TEI/tei:teiHeader//tei:author/text()}</td>
            <td>
                <a class="link" href="{concat('data/user-uploads/tei/',util:unescape-uri(replace($uri, ".+/(.+)$", "$1"), "UTF-8"))}">&#8594;</a>
            </td>
            <td>
                <a class="link" href="{concat('data/user-uploads/genetics/tei/',util:unescape-uri(replace($uri, ".+/(.+)$", "$1"), "UTF-8"))}">&#8594;</a>
            </td>
          </tr>
          }
        </table>
};