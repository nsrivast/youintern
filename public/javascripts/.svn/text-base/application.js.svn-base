// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function showTab(e){
	
	/* Show all results */
	if(e == 0)
	{
		$('internship_results').style.display = "block"
		$('employer_results').style.display = "block"
		$('review_results').style.display = "block"
	}
	
	/* Show internship search results. */
	if(e == 1)
	{
		$('internship_results').style.display = "block"
		$('employer_results').style.display = "none"
		$('review_results').style.display = "none"
		$('tab1').className = "selected";
		$('tab2').className = "";
		$('tab3').className = "";
	}
	
	/* Show employer search results */
	if(e == 2)
	{
		$('internship_results').style.display = "none"
		$('employer_results').style.display = "block"
		$('review_results').style.display = "none"
		$('tab1').className = "";
		$('tab2').className = "selected";
		$('tab3').className = "";
	}
	
	/* Show review search results */
	if(e == 3)
	{
		$('internship_results').style.display = "none"
		$('employer_results').style.display = "none"
		$('review_results').style.display = "block"
		$('tab1').className = "";
		$('tab2').className = "";
		$('tab3').className = "selected";
	}
}