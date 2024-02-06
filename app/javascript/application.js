// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "custom/check"
import jQuery from "jquery"
window.$ = window.jQuery = jQuery
import("jquery-ui-dist")
$(function(){
    alert("jQuery動いた")
})
$(async() => {
    await import("jquery-ui-dist")
    $("#hoge").draggable()
})