#!/usr/bin/env python3

from jinja2 import Template
import os

# Get File Content in String
jinja2_template_string = open("main.html.tpl", 'r').read()

# Create Template Object
template = Template(jinja2_template_string)

# Render HTML Template String
html_template_string = template.render(name = "John")

open("main.html", "w").write(html_template_string)