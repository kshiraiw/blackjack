class window.App extends Backbone.Model
  initialize: ->
    @newGame()
  newGame: -> 
    @set 'deck', deck = new Deck()
    @set 'playerHand', @get('deck').dealPlayer()
    @set 'dealerHand', @get('deck').dealDealer()
    @trigger 'newGameStart'
    @get('playerHand').on 'busted', => 
      @trigger 'finalCard'
      @get('dealerHand').at(0).flip()
      alert 'you busted'
      @newGame()
    @get('playerHand').on 'dealersTurn', => @get('dealerHand').finishGame()
    @get('dealerHand').on 'busted', => 
      @trigger 'finalCard'
      alert 'dealer busted, you win'
      @newGame()
    @get('dealerHand').on 'gameOver', => 
      console.log('something here')
      if @get('playerHand').scores() > @get('dealerHand').scores()
        alert 'you win'
        @newGame()
      else if @get('playerHand').scores() < @get('dealerHand').scores() && @get('dealerHand').scores() < 22
        alert 'you lose'
        @newGame()  