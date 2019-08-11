# Introducing the jsautocomplete_builder gem

## Usage

    require 'jsautocomplete_builder' 

    jab = JsAutocompleteBuilder.new(server: {list: 't205', action: 'hello3'})
    #puts jab.to_webpage
    File.write '/tmp/autocomplete.html', jab.to_webpage

The above example generates an autocomplete enabled web page. The suggestion list is fetched (using AJAX) from the relative URL at *t205* and the search request is actioned using the relative URL *hello3*.

## Resources

* jsautocomplete_builder https://rubygems.org/gems/jsautocomplete_builder

jsautocomplete_builder js builder ajax html autocomplete
