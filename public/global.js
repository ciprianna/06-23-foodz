
function show_menu() {
  nav = document.getElementById("home");
  if(nav.className == "hide_home"){
		nav.className = "show_home";
	} else {
		nav.className = "hide_home";
	}
}

menu = document.getElementById("menu_link");
menu.addEventListener("click", show_menu);
