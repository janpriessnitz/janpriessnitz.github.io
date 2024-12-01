<!DOCTYPE html>
<head>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</head>
<body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

<script>

function mpld3_load_lib(url, callback){
  var s = document.createElement('script');
  s.src = url;
  s.async = true;
  s.onreadystatechange = s.onload = callback;
  s.onerror = function(){console.warn("failed to load library " + url);};
  document.getElementsByTagName("head")[0].appendChild(s);
}

mpld3_load_lib("https://d3js.org/d3.v5.js", function(){
         mpld3_load_lib("https://mpld3.github.io/js/mpld3.v0.5.10.js", function() {
            draw_plots();
		 });
		 });

function load_and_draw_plot(elem) {
  const plot_src = elem.getAttribute("src");
  var fig_name = elem.getAttribute("id");
  if (fig_name === null) {
    fig_name = "fig_"+ Math.random().toString(36).substr(2, 20);
    elem.setAttribute("id", fig_name);
  }
  draw_mpld3_plot(fig_name, plot_src);
}

async function draw_mpld3_plot(fig_name, srcURI) {
  const response = await fetch(srcURI);
  const data = await response.json();
  mpld3.draw_figure(fig_name, data);
}

function draw_plots() {
    var plot_elems = document.getElementsByClassName('prizz_plot');
    for (const plot_elem of plot_elems) {
      console.log(plot_elem)
      load_and_draw_plot(plot_elem)
    }
}

async function load_single_system(src) {
  elem = document.getElementById("single-system-div");
  const response = await fetch(src);
  elem.innerHTML = await response.text();
  draw_plots();
}


</script>
<h1>Ce3NIn</h1>

<ul class="nav nav-tabs mb-3" id="flavor-tab" role="tablist">
  {% for fl in ["dressel", "hedgehog", "rashba", "weyl", "coll", "nonmag"]  %}
  <li class="nav-item" role="presentation">
    <button class="nav-link" id="flavor-home-tab" data-bs-toggle="tab" data-bs-target="#flavor-{{ fl }}" type="button" role="tab">{{ fl }}</button>
  </li>
  {% endfor %}
</ul>
<div class="tab-content" id="flavor-tabContent">
  {% for fl in ["dressel", "hedgehog", "rashba", "weyl", "coll", "nonmag"] %}
  <div class="tab-pane fade" id="flavor-{{ fl }}" role="tabpanel">


    <ul class="nav nav-tabs mb-3" id="flavor-soc-tab" role="tablist">
    {% for soc in ["soc", "nosoc"] %}
    <li class="nav-item" role="presentation">
      <button class="nav-link" id="flavor-soc-home-tab" data-bs-toggle="tab" data-bs-target="#flavor-{{ fl }}-{{ soc }}" onclick="load_single_system('single-{{ fl }}-{{ soc}}.html')" type="button" role="tab">{{ soc }}</button>
    </li>
    {% endfor %}
    </ul>

  </div>

  {% endfor %}
</div>

<div id="single-system-div"></div>