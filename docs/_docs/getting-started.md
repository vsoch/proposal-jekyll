---
tags: 
 - jekyll
 - github
description: Getting started with proposal-jekyll
skip_permalinks: true
author:
  name: Vanessa Sochat
  github: vsoch
---

<style>
.docs div.highlight, pre {
  margin-bottom: 0px !important;
}
</style>

<div id="readme" style="display:none"></div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>
<script src="{{ site.baseurl }}/assets/js/showdown.min.js"></script>
<script>
function getImages(string) {
  const imgRex = /<img.*?src="(.*?)"[^>]+>/g;
  const images = [];
    let img;
    while ((img = imgRex.exec(string))) {
     	images.push(img[1]);
    }
  return images;
}

function getLinks(string) {
  const imgRex = /href="(.*?)"/g;
  const links = [];
    let img;
    while ((img = imgRex.exec(string))) {
     	links.push(img[1]);
    }
  return links;
}

function basename(str) {
   var base = new String(str).substring(str.lastIndexOf('/') + 1); 
    if(base.lastIndexOf(".") != -1)       
        base = base.substring(0, base.lastIndexOf("."));
   return base;
}


function slugify(text) {
    return text
        .toLowerCase()
        .replace(/ /g,'-')
        .replace(/[^\w-]+/g,'')
        ;
}

function getParameterByName(name, url = window.location.href) {
    name = name.replace(/[\[\]]/g, '\\$&');
    var regex = new RegExp('[?&]' + name + '(=([^&#]*)|&|#|$)'),
        results = regex.exec(url);
    if (!results) return null;
    if (!results[2]) return '';
    return decodeURIComponent(results[2].replace(/\+/g, ' '));
}

$(document).ready(function(){

    url = "https://raw.githubusercontent.com/{{ site.github_user }}/{{ site.github_repo }}/main/README.md"
    $.get(url, function(data) {

        var converter = new showdown.Converter({tables: true}),
                 html = converter.makeHtml(data);

        // Find all relative markdown links and replace with pages
        var links = getLinks(html)        
        for (var i = 0; i < links.length; i++) {
            link = links[i];
            if (link.endsWith(".md") && !link.startsWith("http")) {
            
                // Logging here so we can see the pages that should be added
                console.log(link);
                html = html.replace(link, "https://raw.githubusercontent.com/{{ site.github_user }}/{{ site.github_repo }}/main/" + link);
            }
        }

        // Relative images need to be replaced by a raw GitHub url
        // We will need to do this for other relative paths too
        var images = getImages(html)
        for (var i = 0; i < images.length; i++) {
            image = images[i];
            if (!image.startsWith("http")) {
                html = html.replace(image, "https://raw.githubusercontent.com/{{ site.github_user }}/{{ site.github_repo }}/main/" + image);
            }            
        }
                
        $('#readme').html(html)
        wrapper = '<div class="language-plaintext highlighter-rouge"><div class="highlight"></div></div>'
        $("pre").wrap(wrapper);
        $('#readme').show();
    });

});
</script>
