jQuery(document).ready(function($){
  $("a[href^='http:']").not("[href*='localhost']").attr('target','_blank');
  var difference = (new Date("05/26/2010") - new Date()) / 1000;
  $("#countdown").html(Math.floor(( difference < 0 ? 0 : difference ) / (60 * 60 * 24)) + ' Dias');
  $("#scroller").scrollable().circular().mousewheel().autoscroll({ 
    autoplay: true
  });
});
