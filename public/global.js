
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
menu.addEventListener("click", show_sub_nav);


function show_sub_nav() {
  sub_nav = document.getElementById("sub_nav");
  if(sub_nav.className == "hide_home"){
    sub_nav.className = "show_home";
  } else {
    sub_nav.className = "hide_home";
  }
}
