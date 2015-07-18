assert = chai.assert

describe 'deck', ->
  deck = null
  hand = null

  beforeEach ->
    deck = new Deck()
    hand = deck.dealPlayer()

  describe 'hit', ->
    it 'should give the last card from the deck', ->
      assert.strictEqual deck.length, 102
      assert.strictEqual deck.last(), hand.hit()
      assert.strictEqual deck.length, 101

  describe 'deal player', ->
    it 'should deal two cards from deck to player', ->
      assert.strictEqual deck.length, 102
  
  describe 'dealer gets two cards', ->
    it 'should deal two cards to the dealer from deck', ->
      dealer = deck.dealDealer()
      assert.strictEqual deck.length, 100

  describe 'dealer get one card facedown', ->
    it 'should hide one card from view', ->
      dealer = deck.dealDealer()
      assert.strictEqual dealer.first().get('revealed'), false
