jQuery(document).ready(function($){
  $(".slideshow").scrollable({size: 1}).circular().navigator().autoscroll(3000);
  $("a[href^='http:']").not("[href*='localhost']").attr('target','_blank');
  var difference = (new Date("04/06/2010") - new Date()) / 1000;
  $("#countdown").html(Math.floor(( difference < 0 ? 0 : difference ) / (60 * 60 * 24)) + ' Days');
});
