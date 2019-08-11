# Introducing the jsautocomplete_builder gem

## Usage

    require 'jsautocomplete_builder' 

    jab = JsAutocompleteBuilder.new(server: {list: 't205', action: 'hello3'})
    #puts jab.to_webpage
    File.write '/tmp/autocomplete.html', jab.to_webpage

The above example generates an autocomplete enabled web page. The suggestion list is fetched (using AJAX) from the relative URL at *t205* and the search request is actioned using the relative URL *hello3*.

Here's a sample of what's returned from the AJAX request to *t205*:

<pre>
&lt;li tabindex='3' onblur='hideList()' onkeyup="itemKeyup(event.keyCode, this)"  onclick='itemSelected(this)'&gt;apple&lt;/li&gt;
&lt;li tabindex='4' onblur='hideList()' onkeyup="itemKeyup(event.keyCode, this)" onclick='itemSelected(this)'&gt;banana&lt;/li&gt;
&lt;li tabindex='5' onblur='hideList()' onkeyup="itemKeyup(event.keyCode, this)"  onclick='itemSelected(this)'&gt;ghi&lt;/li&gt;
&lt;li tabindex='6' onblur='hideList()' onkeyup="itemKeyup(event.keyCode, this)"  onclick='itemSelected(this)'&gt;jkl&lt;/li&gt;
</pre>

## Resources

* jsautocomplete_builder https://rubygems.org/gems/jsautocomplete_builder

jsautocomplete_builder js builder ajax html autocomplete
