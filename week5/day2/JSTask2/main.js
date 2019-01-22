"using strict";
// task 2: make a webpage that somehow makes
// requests to a different API from the Chuck Norris
// Joke API, and somehow show the results
// on the page. (so not the chuck norris one)

function ajaxGet(
    url, 
    success, 
    failure = res => console.log(res)) {

        let xhr = new XMLHttpRequest();

        xhr.addEventListener("readystatechange", () => {
            console.log(`ready-state is now: ${xhr.readyState}`);
            if (xhr.readyState == 4) {
                // we've recieved the response
                console.log(response);
                // if status code is success
                if (xhr.status >= 200 && xhr.status < 300) {
                    // success
                    success(xhr.response);
                }
                else {
                    failure(xhr.response);
                }
            }
        });
        
        xhr.open("GET", url);
        xhr.send();
}

document.addEventListener("DOMContentLoaded", () => {
    let headFiller = document.getElementById("headFiller");
    let replaceHeaderBtn = document.getElementById("replaceHeaderBtn");

    replaceHeaderBtn.addEventListener("click", () => {
        ajaxGet("https://icanhazdadjoke.com/", response => {
            let responseObj = JSON.parse(responseJSON);
            console.log(responseObj);
            let joke = responseObj.value.joke;
            headFiller.innerText = joke;
        })

        console.log("request about to be sent.");
    });
});