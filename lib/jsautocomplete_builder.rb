#!/usr/bin/env ruby

# file: jsautocomplete_builder.rb

require 'rexle'
require 'rexle-builder'


class JsAutocompleteBuilder

  # list: is the url of the server which returns the list
  # action: is the url of the server to process the search request
  #
  def initialize(server: {list: '', action: ''})
    @server = server
  end

  # returns just the form part
  def to_html()

html=<<EOF
      <form action='#{@server[:action]}' method='get' name='searchForm'>

        <input tabindex='2' type='text' autofocus='true' onkeyup='updateList(event.keyCode, this)' onfocus='showList()' onblur='hideList()' id='search' autocomplete='off' name='q'/>
        <input type='submit' value='search'>
        <ol id='autolist'></ol>

      </form>
EOF

  end
  
  def to_css()
    css()
  end

  def to_js()

    url = @server[:list] =~ /\?\w+=$/ ? @server[:list] : @server[:list] + '?q='
    ("\n      var serverList = '%s';\n\n" % url) + js()

  end

  def to_webpage()

    doc = Rexle.new(build_html())
    doc.root.element('body').add Rexle::Element.new('script').add_text(to_js())
    doc.root.element('head').add Rexle::Element.new('style').add_text(to_css())

    doc.xml(pretty: true)

  end

  private

  def build_html()

    RexleBuilder.build do |xml|
      xml.html do 
        xml.head do
          xml.title 'Search'
          xml.meta name: "viewport", content: \
              "width=device-width, initial-scale=1"
        end
        xml.body do
          xml.div({tabindex: '1', id: 'autosuggest'}, to_html())
          xml.p 'Search page generated using the jsautocomplete_builder gem'
        end
      end
    end
  end

  def css()
<<EOF


    body {font-family: Arial;}

    form input {
      background-color: transparent;
      padding: 0; margin: 0;
    }
    ol {
      background-color: #eee;
      position: absolute;
      left: 12px;

      padding: 0; margin: 0;
      list-style-type: none;
    }

    #autolist li {
      background-color: transparent;
      padding: 0; margin: 0;
      cursor: pointer;
    }

    #autolist li:hover, #autolist li:focus {background-color: rgba(223,223,200,7)}

    div#autosuggest {background-color: transparent; width: 14em;   }

    #autosuggest ol {display: none}

    input[type=submit] {background-color: transparent; display: inline}
EOF
  end

  def js()
<<EOF
      function ajaxRequest(url, cFunction) {
        var xhttp;
        xhttp = new XMLHttpRequest();
        xhttp.onreadystatechange = function() {
          if (this.readyState == 4 && this.status == 200) {
            cFunction(this);
          }
        };
        xhttp.open("GET", url, true);
        xhttp.send();
      }

      function ajaxFetchList(e) {  
        ajaxRequest(serverList + e.value, ajaxResponseList)
      }

      function ajaxResponseList(xhttp) {
        document.getElementById('autolist').innerHTML = xhttp.responseText;
        list = document.getElementById('autolist');
        list.style.display = 'block';
      }

      function updateList(keyCode, e) {

        // esc key?
        if (keyCode == 27)
          return

        // down arrow key?
        if (keyCode == 40) {
          showList();
          li = document.getElementById('autolist').children.item(0);
          e.value = li.textContent; 
          li.focus();
          return 
        }
        //e.value;
        if (e.value.length > 0) {
          ajaxFetchList(e);
        }
      }

      function hideList() {

        setTimeout(function(){ 
          console.log('parent: ' + document.activeElement.nodeName);
          id = document.activeElement.parentElement.id;

          if (id  !== 'autolist' && id  !== 'autosuggest') {
            list = document.getElementById('autolist');
            list.style.display = 'none';
          }
        }, 100);

      }

      function itemKeyup(keyCode, e) {

        console.log('keyCode: ' + keyCode);
        txt = document.getElementById('search');

        // enter key or spacebar key?
        if (keyCode == 13 || keyCode == 32) {
          itemSelected(e)
        }

        // up arrow?
        else if (keyCode == 38) {
          if (e.previousElementSibling) {
            txt.value = e.previousElementSibling.textContent;          
            e.previousElementSibling.focus();
          }
          else
            document.getElementById('search').focus();
        }
        // down arrow?
        else if (keyCode == 40) {

          txt.value = e.nextElementSibling.textContent;          
          e.nextElementSibling.focus();
        }
        // esc key?
        else if (keyCode == 27) {
          list = document.getElementById('autolist');
          list.style.display = 'none';
          txt.focus();
        }
      }

      function itemSelected(e) {
        txt = document.getElementById('search');
        txt.value = e.textContent;

        list = document.getElementById('autolist');
        list.style.display = 'none';
        document.searchForm.submit();
      }

      function showList() {

        console.log('parent2: ' + document.activeElement.nodeName);
        txt = document.getElementById('search');

        if (txt.value.length > 0) {
          list = document.getElementById('autolist');
          list.style.display = 'block';
        }

      }
EOF
  end

end
