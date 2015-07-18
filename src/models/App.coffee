class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    # deckLength = @get('deck').get('deckLength')
    @newGame()
  newGame: -> 
    if @get('deck').length < 35
      @set 'deck', deck = new Deck()
    @set 'playerHand', @get('deck').dealPlayer()
    @set 'dealerHand', @get('deck').dealDealer()
    @trigger 'newGameStart'
    @get('playerHand').on 'busted', => 
      @trigger 'finalCard', 'Busted!! You Lose!!'
      @get('dealerHand').at(0).flip()
    @get('playerHand').on 'dealersTurn', => @get('dealerHand').finishGame()
    @get('dealerHand').on 'busted', => 
      @trigger 'finalCard', 'Dealer has Busted! You Win!!'
    @get('dealerHand').on 'gameOver', => 
      if @get('playerHand').scores() > @get('dealerHand').scores()
        @trigger 'finalCard', 'You Win!!!'
      else if @get('playerHand').scores() < @get('dealerHand').scores() && @get('dealerHand').scores() < 22
        @trigger 'finalCard', 'You Lose :(!'
      else 
        @trigger 'finalCard', 'Push!!'