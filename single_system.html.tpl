<div>
  {% for v_sec in plots %}
  <h2>{{ v_sec["title"] }}</h2>
  <table>
    <tr>
    {% for v_plot in v_sec["plots"] %}
    <td>
      <u>{{ v_plot["title"] }}</u><br>
      {% if v_plot["src"].endswith("json") %}
      <div class="prizz_plot" src="{{ v_plot["src"] }}" float="left" max-width="fit-content"></div>
      {% else %}
      <img src="{{ v_plot["src"] }}" width="{{ v_plot["width"] }}">
      {% endif %}
    </td>
    {% endfor %}
    </tr>
  </table>
  {% endfor %}
</div>