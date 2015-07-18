class window.Deck extends Backbone.Collection
  model: Card

  initialize: ->
    numberOfDecks = 2
    # @set 'deckLength', numberOfDecks * 52
    @add _([0...52*numberOfDecks]).shuffle().map (card) ->
      new Card
        rank: card % 13
        suit: card % 4

  dealPlayer: -> new Hand [@pop(), @pop()], @

  dealDealer: -> new Hand [@pop().flip(), @pop()], @, true

