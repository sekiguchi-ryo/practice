document.addEventListener("turbo:load", function() {
    let check = document.querySelector(".check");
    check.addEventListener("click", function(event) {
        event.preventDefault();
        console.log("OK");
    });
});