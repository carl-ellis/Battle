// Where the service is located
var SERVICE_URL = "http://148.88.226.231:48154/battle_service.rb";

// Google api
var GOOGLE_URL = "http://ajax.googleapis.com/ajax/services/search/images?v=1.0&rsz=2&start=1&callback=?&imgtype=face&q="  

// Store the results
var RESULTS = ""

//Store the winner
var WINNER = ""

// Loading div
var LOADING_DIV = "div#loading";

// output div
var RESULTS_DIV = "div#innerresults";

// winner div
var WINNER_DIV = "div#winner";

// image div
var IMAGE_ID = "winner";


/** This function is used to call a JSON service using ajax.
  * Uses the SERVICE_URL constant.
  * 
  * @params   data              Query string to be sent to the service.
  * @params   successFunction   Success callback.
  */
function call_server(data, successFunction, completeFunction){
  if (!completeFunction) var completeFunction = function(){};
  $.ajax({
    type:'GET',
    url:SERVICE_URL,
    data:data,
    global:true,
    success:function(result){successFunction(result);},
		error:function(jqHXR,textStatus,errorThrown){ 
      alert("jqHXR: " + jqHXR.responseXML + " Text: " + textStatus + " E: " + errorThrown);
      },
    complete:function(){completeFunction();},
    dataType:'jsonp',
		crossDomain: true
	});
}

/** Initial function
  * Grabs data from the form on the page and sends to web service
	*
	* @params		form			Form object in the DOM
	*/
function init(form) {

	// Grab values from form
	n1 = form.n1.value;
	n2 = form.n2.value;

	// Null check
	if (n1 != "" && n2 != "") {
		get_results(n1, n2);
	}
}

/** Sets the callbacks and initiales the function calling
	* 
	* @param		n1				Name 1
	* @param		n2				Name 2
	*/
function get_results(n1, n2) {

	// Clear data
	RESULTS = "";
	WINNER = "";

	$(RESULTS_DIV).empty();
	$(WINNER_DIV).empty();
	$(WINNER_DIV).hide();

	show_loading();
	populate_results(n1, n2, function(){show_animation();});
}

/** Grabs results from the service
	*/
function populate_results(n1, n2, completeFunction) {

  successfunction = function(results) {
		RESULTS = results['results'];
		WINNER = results['winner'];
	};

	call_server("n1="+n1+"&n2="+n2, successfunction, completeFunction);
}

/** Shows a loading screen
  */
function show_loading() {
	$(LOADING_DIV).show();
}

/** Shows a loading screen
  */
function hide_loading() {
	$(LOADING_DIV).hide()
}

/** Shows content
	*/
function show_animation() {

	// Hide loading
	hide_loading();

	// Put data into div
	results_array = RESULTS.split('\n');

  skip = false;
	$.each(results_array, function(k,v) {
		if (v=="---") {
			skip = true;
		}
		if (!skip) {
		  $(RESULTS_DIV).append("<p class='action'>" + v + "</p>\n").delay(100);
		}
	});
	$(RESULTS_DIV).append("<a href='#' class='action' onClick='$(\"" + WINNER_DIV + "\").show()' >Show winner info</a>\n")

	fill_winner();

  no_elements = results_array.length-3;
  i = 0;
	//show
	$("p.action:eq(0)").fadeIn('fast', function() {
		i = i +1;
		if (i == no_elements-3) {
			$(this).next("p").fadeIn('fast', show_winner);
		} else {
			$(this).next("p").fadeIn('fast', arguments.callee);
		}
	});
}

/** Fills the winenr div with the copy
	*/
function fill_winner(){
	$(WINNER_DIV).append("<img src='pending.gif' id='" + IMAGE_ID + "'/>");
	$(WINNER_DIV).append("<div><p>The winner is " + WINNER + "!</p></div>");
	$(WINNER_DIV).append("<a href='#' onClick='$(\"" + WINNER_DIV + "\").hide()'>Close</a>");
  get_winner_image()
}

function show_winner(){
	$(WINNER_DIV).fadeIn('slow', function(){ $("a.action").fadeIn('slow') });
}

function get_winner_image() {
	url = GOOGLE_URL + encodeURI(WINNER);
	$.getJSON(url, function(data) {
		if(data.responseData.results.length > 0) {
			$("img#" + IMAGE_ID).attr("src", data.responseData.results[0].unescapedUrl);
			$("img#" + IMAGE_ID).attr("width", 200);
			$("img#" + IMAGE_ID).attr("height", 250);
		}
	});
}
