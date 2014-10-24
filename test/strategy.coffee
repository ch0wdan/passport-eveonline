sinon = require('sinon')
EveOnlineStrategy = require('../src/')
OAuth2Strategy = require('passport-oauth2')

describe 'EVE Online OAuth Strategy', ->
  before ->
    @oAuth2Strategy = sinon.spy()
    @oAuth2Strategy['authenticate'] = sinon.spy()

    @strategyOptions =
      some: 'options'
      oAuth2Strategy: @oAuth2Strategy
    @verify = ->
    @strategy = new EveOnlineStrategy(@strategyOptions, @verify)

  it "should be named 'eveonline'", ->
    @strategy.name.should.equal 'eveonline'

  it "should invoke passport-ouath2 strategy's constructor", ->
    @oAuth2Strategy.calledWith(@strategyOptions, @verify).should.be.true

  describe 'when authenticating', ->
    beforeEach ->
      @request = ' request'
      @authenticateOptions = {some: 'options'}
      @strategy.authenticate(@request, @authenticateOptions)

    it "should invoke passport-oauth2 strategy's authenticate function", ->
      @oAuth2Strategy.authenticate.calledWith(
        @request, @authenticateOptions).should.be.true