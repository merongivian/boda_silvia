app = angular.module('foh')

app.controller "RsvpController", ["$scope", "Restangular", ($scope, Restangular) ->
  $("select")
    .select2
      width: "element"
      minimumInputLength: 3
    .on "change", (e) ->
      Restangular.one('events', 1).one('groups', e.val).getList("guests").then (group) ->
        $scope.group = group

  $scope.newGuest = {
    name: ""
  }

  $scope.setRsvp = (guest, rsvp) ->
    guest.rsvp = rsvp
    guest.put()

  $scope.defineGuest = (guest) ->
    return if $scope.newGuest.name == ""
    guest.name = $scope.newGuest.name
    guest.is_guest = false
    guest.rsvp = true
    guest.put()

  $scope.toggleVegetarian = (guest) ->
    guest.put()

  # Restangular.one('events', 1).one('groups', 3).getList("guests").then (group) ->
  #   $scope.group = group

  $scope.rsvpStatus = (guest) ->
    return "Gracias por tu confirmacion, te esperamos !! :)" if guest.rsvp
    return "Ingresa tu nombre" if guest.is_guest
    return "Anteriormente, nos confirmaste que no podias asistir." if guest.rsvp == false
    return "Todavia no has respondido a la invitacion"

  $scope.rsvpButtonText = (guest) ->
    return "Añadirme como invitado" if guest.is_guest
    return "Si puedo asistir"

  $scope.guestName = (guest) ->
    return "Invitado" if guest.is_guest
    return guest.name
]
