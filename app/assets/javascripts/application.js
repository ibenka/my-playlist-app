// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require turbolinks
//= require_tree .

// initialize client with app credentials
SC.initialize({
  client_id: '1b53211793e50e91848a0abb56b0af30',
  redirect_uri: 'http://justinpinili-bloccit.herokuapp.com'
});

// initiate auth popup
SC.connect(function() {
  SC.get('/me', function(me) { 
    alert('Hello, ' + me.username); 
  });
});

$(document).ready(function() {
  $(".js-show-hide").click(function() {
    var selector = "." + $(this).attr('data-selector');
    if ($(selector).is(":visible")) {
      $(selector).slideUp();
    }
    else {
      $(selector).slideDown();
    }
    return false;
  });

  SC.get('/playlists/d4rk_hau5', function(playlist) {
  console.log("i work");
    for (var i = 0; i < playlist.tracks.length; i++) {
      var track_url = playlist.tracks[i][permalink_url]
      $(.here-mang).append( SC.oEmbed(track_url, { auto_play: false }, function(oEmbed) {
      console.log('oEmbed response: ' + oEmbed);
      }));
    }
  });

});
