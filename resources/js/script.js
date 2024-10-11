function showhideimage() {
    // var y = document.getElementsByClassName("del context");
    
    $(".my_images").toggleClass('temporaryhide');
}

$(document).ready(function(){
                        
        $('body')
             .on("click", ".start_btn", function () {
                start();
             })
             .on("click",".refresh_btn", function(){
                refresh();
             })
             .on("click", "#countButton",function(e){
                 e.preventDefault();
                 count++;
                 switch (count) {
                     case 1:
                     previous();
                     break;
                     default:
                     decrease();
                 }})
              .on("click",".increase_btn", function(){
                  increase();
                  console.log(a);
              })
              ;
});



function increase() {
    a = a+1;
    console.log(a);
    count = 0;
    var elmnt = document.getElementById(a);
    elmnt.scrollIntoView({
        behavior: "smooth", block: "center"
    });
    document.getElementById("demo").innerHTML = "Stap: " + a + "/" + rev;
    if (elmnt.classList.contains('del')) {
        document.getElementById(a).classList.add('thick-del');
        document.getElementById(a).style.textDecoration = "line-through";
        setTimeout(function () {
            document.getElementById(a).style.display = "none";
        },
        950);
    } else if (elmnt.classList.contains('mod')) {
        document.getElementById(a).style.color = "#ff9900";
        document.getElementById(a).classList.add('thick');
        setTimeout(function () {
            document.getElementById(a).classList.remove('thick');
        },
        950);
        elmnt.scrollIntoView({
            behavior: "smooth", block: "center"
        });
    } else {
        document.getElementById(a).style.display = "inline";
        document.getElementById(a).classList.add('thick');
        setTimeout(function () {
            document.getElementById(a).classList.remove('thick');
        },
        950);
        elmnt.scrollIntoView({
            behavior: "smooth", block: "center"
        });
    }
}


function previous() {
    var elmnt = document.getElementById(a);
    elmnt.scrollIntoView({
        behavior: "smooth", block: "center", inline: "center"
    });
    
    if (elmnt.classList.contains('del')) {
        document.getElementById(a).style.display = "inline";
        document.getElementById(a).classList.remove('thick-del');
        document.getElementById(a).style.textDecoration = "none";
    } else if (elmnt.classList.contains('mod')) {
        document.getElementById(a).style.color = "white";
        elmnt.scrollIntoView({
            behavior: "smooth", block: "center", inline: "center"
        });
    } else {
        document.getElementById(a).style.display = "none";
        elmnt.scrollIntoView({
            behavior: "smooth", block: "center", inline: "center"
        });
    }
    a--;
    document.getElementById("demo").innerHTML = "Stap: " + a + "/" + rev;
}

function decrease() {
    var elmnt = document.getElementById(a);
    elmnt.scrollIntoView({
        behavior: "smooth", block: "center", inline: "center"
    });
    if (elmnt.classList.contains('del')) {
        document.getElementById(a).style.display = "inline";
        document.getElementById(a).classList.remove('thick-del');
        document.getElementById(a).style.textDecoration = "none";
    } else if (elmnt.classList.contains('mod')) {
        document.getElementById(a).style.color = "";
        elmnt.scrollIntoView({
            behavior: "smooth", block: "center", inline: "center"
        });
    } else {
        document.getElementById(a).style.display = "none";
        elmnt.scrollIntoView({
            behavior: "smooth", block: "center", inline: "center"
        });
    }
    a--;
    document.getElementById("demo").innerHTML = "Stap: " + a + "/" + rev;
}


function loop() {
    if (a < rev) {
        if (! flag) {
            return
        };
        increase();
        setTimeout(loop, 950);
    } else {
        stop();
    }
}

function stop() {
    flag = false;
}
function start() {
    flag = true;
    loop();
}


function refresh() {
    a = 0;
    $(".del").removeClass("thick-del").css({"text-decoration": "none"}).show();
    $(".add, .mod, .cont").hide();
    document.getElementById("demo").innerHTML = "Stap: " + "0" + "/" + rev;
    $("div.word")[0].scrollIntoView({behavior: "smooth"});
}


// When the user clicks on div, open the popup
function InfoFunction() {
    var popup = document.getElementById("Info");
    popup.classList.toggle("show");
}

function toggleVisibility(elementId) {
    const element = document.getElementById(elementId);
    element.style.visibility = element.style.visibility === 'visible' ? 'hidden' : 'visible';
}

function toggleClassVisibility(className, displayType = "inline") {
    const elements = document.getElementsByClassName(className);
    for (let i = 0; i < elements.length; i++) {
        elements[i].style.display = elements[i].style.display === displayType ? "none" : displayType;
    }
}
// Helper function to convert hex to RGB
function hexToRgb(hex) {
    let shorthandRegex = /^#?([a-f\d])([a-f\d])([a-f\d])$/i;
    hex = hex.replace(shorthandRegex, (m, r, g, b) => r + r + g + g + b + b);

    let result = /^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec(hex);
    return result ? `rgb(${parseInt(result[1], 16)}, ${parseInt(result[2], 16)}, ${parseInt(result[3], 16)})` : null;
}
function toggleColorAndDecoration(elements, color, textDecoration = "line-through") {
    let rgbColor = hexToRgb(color); // Convert the provided hex color to RGB

    for (let i = 0; i < elements.length; i++) {
        // Get the original color (store it in the data attribute if not already set)
        let originalColor = elements[i].getAttribute("data-original-color") || elements[i].style.color || window.getComputedStyle(elements[i]).color;
        if (!elements[i].getAttribute("data-original-color")) {
            elements[i].setAttribute("data-original-color", originalColor); // Save the original color
        }

        console.log("Original color (logged as RGB):", originalColor); // Log the original color in RGB

        // Compare RGB color values to handle resetting correctly
        if (window.getComputedStyle(elements[i]).color === rgbColor) {
            elements[i].style.color = originalColor; // Revert to the original color
            elements[i].style.textDecoration = "";   // Reset text decoration
        } else {
            elements[i].style.color = color;         // Apply the new hex color
            elements[i].style.textDecoration = textDecoration;
        }
    }
}



function showhidedeletions() {
    $(".del").toggleClass('temporaryhide');
    checkDel();
    checktypo();
}

function colordeletions() {
    toggleColorAndDecoration(document.getElementsByClassName("del context"), "#B20D30");
    toggleColorAndDecoration(document.getElementsByClassName("del pre-context"), "#F35376");
    toggleColorAndDecoration(document.getElementsByClassName("del typo"), "#875531");
    toggleColorAndDecoration(document.getElementsByClassName("del trans"), "#377495");
    checkDel();
    checktypo();
}

function checkDel() {
    toggleVisibility("checkdel");
}

function showhideadditions() {
    toggleClassVisibility("add");
    toggleClassVisibility("cont");
    toggleColorAndDecoration(document.getElementsByClassName("mod"), "#F7B801", "");  // Toggle color only
    checkAdd();
}

function checkAdd() {
    toggleVisibility("checkadd");
}

function showhiderevisions() {
    toggleVisibility("checkrevisions");
    showhideadditions();
    colordeletions();
}

function showhidetypo() {
    toggleClassVisibility("del typo");
    checktypo();
}

function checktypo() {
    toggleVisibility("checktypo");
}


function numbers() {
    toggleClassVisibility("n");
    toggleVisibility("checknumbers");
}

function BIGnumbers() {
    const elements = document.getElementsByClassName("n");
    for (let i = 0; i < elements.length; i++) {
        elements[i].style.fontSize = elements[i].style.fontSize === "100%" ? "60%" : "100%";
    }
    toggleVisibility("checkmark");
}

function symbols() {
    toggleClassVisibility("symbol");
    toggleVisibility("checksymbol");
}

function createLine() {
    toggleElementColor('transcription');
    toggleElementColor('del');
    toggleElementColor('add');
    toggleElementColor('cont');
    toggleElementColor('chap');

    toggleVisibility("checkpath");

    for (let a = 1; a <= rev; a++) {
        const first = document.getElementById(a);
        const second = document.getElementById(a + 1);
        if (!first || !second) continue; // Ensure elements exist

        const [x1, y1] = [first.offsetLeft, first.offsetTop];
        const [x2, y2] = [second.offsetLeft, second.offsetTop];

        const distance = Math.sqrt((x1 - x2) ** 2 + (y1 - y2) ** 2);
        const xMid = (x1 + x2) / 2;
        const yMid = (y1 + y2) / 2;
        const slopeInDegrees = Math.atan2(y1 - y2, x1 - x2) * (180 / Math.PI);

        const line = document.getElementById("line" + a);
        line.style.top = `${yMid}px`;
        line.style.left = `${xMid - distance / 2}px`;
        line.style.transform = `rotate(${slopeInDegrees}deg)`;
        line.style.width = `${distance}px`;
        line.style.display = line.style.display === "block" ? "none" : "block";

        setLineColor(a, y2 < y1);
        document.getElementById("line1").style.backgroundColor = "green"; // Always green
    }
}

function toggleElementColor(className) {
    const elements = document.getElementsByClassName(className);
    for (let element of elements) {
        element.style.color = element.style.color === 'rgba(0, 0, 0, 0.5)' ? '' : 'rgba(0, 0, 0, 0.5)';
    }
}

function toggleVisibility(elementId) {
    const element = document.getElementById(elementId);
    element.style.visibility = element.style.visibility === 'visible' ? 'hidden' : 'visible';
}

function setLineColor(index, isReversed) {
    const line = document.getElementById("line" + index);
    const revThreshold = rev / 10;

    const colors = isReversed
        ? ["#4E9BF9", "#2684F7", "#096FEC", "#075DC5", "#064A9D", "#043876"]
        : ["#FEB685", "#FE9D5D", "#FE8534", "#FE6C0B", "#DF5A01", "#B74A01"];

    for (let i = 0; i < colors.length; i++) {
        if (index < revThreshold * (i + 1)) {
            line.style.backgroundColor = colors[i];
            break;
        }
    }
}

function hoverByClass(className, colorOver, colorOut = "transparent") {
    const elements = document.getElementsByClassName(className);
    for (let element of elements) {
        element.onmouseover = function() {
            for (let el of elements) {
                el.style.backgroundColor = colorOver;
                el.scrollIntoView({ behavior: "smooth", block: "center" });
            }
        };
        element.onmouseout = function() {
            for (let el of elements) {
                el.style.backgroundColor = colorOut;
            }
        };
    }
}

// Initialize hover effects for notes
for (let i = 1; i <= 20; i++) {
    hoverByClass(`note${i}`, "#C4F1BE");
}

function showhidenotes() {
    var z = document.getElementsByClassName("notes");
    var i;
    for (i = 0; i < z.length; i++) {
        if (z[i].style.display === "inline") {
            z[i].style.display = "none";
        } else {
            z[i].style.display = "inline";
        }
    }
    
    checknotes();
}



function checknotes() {
    var check = document.getElementById("checknotes");
    if (check.style.visibility === 'visible') {
        check.style.visibility = 'hidden';
    } else {
        check.style.visibility = 'visible';
    }
}


