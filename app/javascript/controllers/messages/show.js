document.addEventListener("DOMContentLoaded", function () {
    document.getElementById("messages-tab").addEventListener("click", function (e) {
        e.preventDefault();
        document.getElementById("messaging-tab-content").classList.toggle("hidden");
    });
});
