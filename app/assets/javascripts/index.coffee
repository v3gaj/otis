# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery(document).on 'turbolinks:load', ->
  $('.scroller').slick({
  	dots: true, pauseOnHover: false, pauseOnFocus: false
  })

jQuery(document).on 'turbolinks:load', ->
  $('.fade').slick({
	  infinite: true,
	  autoplay: true,
	  arrows: false,
	  speed: 500,
	  fade: true,
	  dots: true,
	  cssEase: 'linear'
	});



