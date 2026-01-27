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
    @view = view = new ldview do
      root: root
      init: slider: ({node}) ~>
        lc.ldrs = new ldslider root: node, min: 0, max: 10, step: 1
        lc.ldrs.on \change, ~> @value {v: it}
      text: content: ({node}) ~> (@value! or {}).v or '-'
      handler: slider: ({node}) ~> 
        lc.ldrs.set ((@value! or {}).v or 0)

  render: -> @view.render!
  content: (v) -> if v and typeof(v) == \object => v.v else v

