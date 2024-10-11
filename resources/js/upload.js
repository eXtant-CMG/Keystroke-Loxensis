$(document).ready(function(){
        // initialise the uploader
        // the "haha" is just an example to show how you could pass custom information (see formData in initUploader)
        initUploader("haha");
        
        // request files, if any were previously uploaded in the same session... add them to list
        sessionDocumentId = $("#yourForm").data("resid");
        
        $.getJSON("$app/modules/request_sessionfiles.xql", function(e){
            console.log("happy: " + e.session_filename);
            console.log(e["tei-files"]);
            $.each($.merge(e["tei-files"] , e["css-files"]), function (index, file) {
                console.log(file);
                var path = "user-uploads/"+e.session_filename+"/tei/"+file
                var tr = document.createElement("tr");
                var td = document.createElement("td");
                var link = document.createElement("a");
                link.href = "user-uploads/genetics/"+e.session_filename+"/tei/"+file;
                link.target = "_blank";
                var icon = document.createElement("span");
                icon.className = "material-icons";
                icon.appendChild(document.createTextNode(file));
                link.appendChild(icon);
                td.appendChild(link);
                tr.appendChild(td);
                
                td = document.createElement("td");
                td.appendChild(document.createTextNode(path));
                tr.appendChild(td);
                
                $("#files").append(tr);
                
            });
        });
        
        console.log(sessionDocumentId);
        
});



/* initUploader() initializes the fileuploader as done in TEIPublisher */
function initUploader($testdata){
    'use strict';
    $('#fileupload').fileupload({
        url: "$app/modules/upload.xql",
        dataType: 'json',
        acceptFileTypes: /(\.|\/)(xml|css)$/i,
        formData: {
            "root": $testdata
        },
        done: function (e, data) {
            //alert("done");
            $.each(data.result.files, function (index, file) {
                var tr = document.createElement("tr");
                var td = document.createElement("td");
                var link = document.createElement("a");
                link.href = file.path;
                link.target = "_blank";
                var icon = document.createElement("span");
                icon.className = "material-icons";
                icon.appendChild(document.createTextNode(file.name));
                link.appendChild(icon);
                td.appendChild(link);
                tr.appendChild(td);
                
                td = document.createElement("td");
                td.appendChild(document.createTextNode(file.path));
                tr.appendChild(td);
                
                $("#files").append(tr);
                if(file.foldertype =="transcripts"){
                    $(tr).clone().appendTo("#transcript-files");
                }else{
                    $(tr).clone().appendTo("#facsimile-files");
                }
                
            });
            //reloadDocTable();
        },
        processfail: function (e, data) {   
            //here I could potentially show the failed uploads?
            console.log('Processing ' + data.files[data.index].name + ' failed. Reason: ' + data.files[data.index].error);
            
        },
        progressall: function (e, data) {
            var progress = parseInt(data.loaded / data.total * 100, 10);
            $('#progress .progress-bar').css(
            'width',
            progress + '%');
        }
    }).on('fileuploadfail', function (e, data) {
        $.each(data.files, function (index) {
            alert('failed');
        });
    })
    .prop('disabled', ! $.support.fileInput).parent().addClass($.support.fileInput ? undefined: 'disabled');
    
   //make sure self-styled button triggers hidden input button 
   $('.fileinput-button').click(function(){
    
    $('#fileupload').click();
        });
}