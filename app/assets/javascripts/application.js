// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.slick
//= require turbolinks
//= require_tree .
//= require jquery_ujs
//= require jquery.remotipart


function startTimer(duration, display) {
    var timer = duration-1
    var mytimer = setInterval(function () {

    	hours = parseInt((timer / 60)/60, 10)
        minutes = parseInt((timer / 60) % 60, 10)
        seconds = parseInt(timer % 60, 10);

        hours = hours < 10 ? "0" + hours : hours;
        minutes = minutes < 10 ? "0" + minutes : minutes;
        seconds = seconds < 10 ? "0" + seconds : seconds;

        if (--timer < 0) {
            clearInterval(mytimer);
            display.textContent = "Tiempo terminado"
            $('#testForm').submit();
        }else{
        	display.textContent =  hours + ":" + minutes + ":" + seconds;
        }
    }, 1000);
}

window.onload = function () {

	jQuery.getJSON('/index/test.json', function(data) {
	  // convert the results into chart data
	  var getTime = new Date(data.time);
	  var timeHours = getTime.getUTCHours();
	  var timeMinutes = getTime.getUTCMinutes();

	  var timerMinutes = 60 * timeMinutes + (timeHours * 60) * 60,
        display = document.querySelector('#time');
    	startTimer(timerMinutes, display);
	});

    
  };