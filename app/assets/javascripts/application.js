//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require materialize
//= require materialize-sprockets
//= require materialize-form
//= require_tree .

$(document).on('turbolinks:load', function() {
  $(".button-collapse").sideNav();

  $('select').material_select();

  window.materializeForm.init()
})
$(document).on("turbolinks:click", function(){
  $("#main-spinner").show();
});

$(document).on("turbolinks:load", function(){
  $("#main-spinner").fadeOut(50);
});