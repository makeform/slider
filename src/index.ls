module.exports =
  pkg:
    name: \@makeform/slider
    extend: name: \@makeform/common
    host: name: \@grantdash/composer
    dependencies: [
    * name: \ldslider
    * name: \ldslider, type: \css
    ]
  init: (opt) ->
    opt.pubsub.on \inited, (o = {}) ~> @ <<< o
    opt.pubsub.fire \subinit, mod: mod.call @, opt

mod = ({root, ctx, data, parent, t, i18n}) ->
  {ldview,ldslider} = ctx
  lc = {}
  init: ->
    lc = {}
    @on \change, ~> @view.render <[slider]>
    handler = ({node}) ~> @value node.value
    @view = view = new ldview do
      root: root
      init: slider: ({node}) ~>
        lc.ldrs = new ldslider root: node, min: 0, max: 10, step: 1
        lc.ldrs.on \change, ~> @value {value: it}
      text: content: ({node}) ~> (@value! or {}).value or '-'
      handler: slider: ({node}) ~> 
        lc.ldrs.set ((@value! or {}).value or 0)

  render: -> @view.render!

