
{}
  :about "|Machine-generated snapshot. Do not edit directly — changes will be overwritten. Use `calcit query` to inspect and `calcit edit`/`calcit tree` to modify. Run `calcit docs agents --contract` before mutations; use `--full` for first orientation or changed contract digest. Manual edits must follow format and schema conventions, then run `calcit edit format`."
  :package |app
  :entries $ {} $ :default
    {} (:description |) (:init-fn 'app.main/main!) (:mode :js) (:reload-fn 'app.main/reload!) (:target :browser)
      :feature-policy $ {}
      :modules $ [] |respo.calcit/ |respo-ui.calcit/ |phlox/
      :type-slots $ {}
  :files $ {}
    'app.comp.container $ %{} 'FileEntry
      :defs $ {}
        'comp-container $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn comp-container (store)
            let
                grid $ :grid store
                dropping-cells $ match (:piece store)
                  (:none) (#{})
                  (:some piece)
                    .foldl
                      map
                        decode-map-as
                          .unwrap-or
                            get-in shapes-variations $ :pick piece
                            []
                          List $ List Number
                        fn (x)
                          complex/add (:position piece) x
                      #{}
                      fn (acc x)
                        hint-fn $ Fn
                          Set $ List Number
                          List Number
                          -> $ Set $ List Number
                        include acc x
              ; println $ .unwrap-or (get store :failed?) nil
              container
                {} $ :position $ [] 0 0
                rect $ {}
                  :position $ [] -300 -300
                  :fill $ hslx 0 0 96
                  :size $ [] 600 600
                container ({}) & $ -> grid
                  map-indexed $ fn (row-idx row)
                    -> row $ map-indexed $ fn (col-idx cell)
                      let
                          p $ [] row-idx col-idx
                        rect $ {}
                          :position $ []
                            * (- col-idx middle-idx) 12
                            * (- row-idx middle-idx) 12
                          :size $ [] 12 12
                          :fill $ if (contains? dropping-cells p) (hslx 200 10 50)
                            match cell
                              (:none) (hslx 200 10 100)
                              (:some occupied)
                                match occupied
                                  (app.schema/PresetCell preset) (:color preset)
                                  (app.schema/BlockCell block)
                                    match block
                                      (:collapsing) (hslx 30 90 70)
                                      (:filled) (hslx 10 80 10)
                  concat-all
                comp-button $ {} (:text |Reset)
                  :position $ [] 340 -40
                  :color $ hslx 0 0 100
                  :fill $ hslx 0 0 60
                  :on-pointertap $ fn (e d!)
                    d! $ app.schema/GameOp :reset
                comp-button $ {} (:text |Fullscreen)
                  :position $ [] 340 80
                  :color $ hslx 0 0 100
                  :fill $ hslx 0 0 60
                  :on-pointertap $ fn (e d!) (js/document.body.requestFullscreen)
                , & $ if (:failed? store)
                  [] $ text $ {}
                    :position $ [] 340 0
                    :text |Failed
                    :style $ {} (:font-size 24) (:fill |red) (:font-family "|Josefin Sans")
                  []
          :examples $ []
          :schema $ quote $ Fn app.schema/GameState (-> phlox.schema/PhloxElement) (:features :js-ffi)
        'concat-all $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn concat-all (xs)
            .foldl xs ([])
              fn (acc row)
                hint-fn $ Fn (List T) (List T)
                  -> $ List T
                concat acc row
          :examples $ []
          :schema $ quote $ Fn
            List $ List T
            -> $ List T
            :generics T
        'middle-idx $ %{} 'CodeEntry (:doc |)
          :code $ quote $ def middle-idx
            * 0.5 $ dec grid-size
          :examples $ []
          :schema $ quote Number
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote $ ns app.comp.container
          :require
            phlox.core :refer $ g hslx rect circle text container graphics create-list >>
            phlox.comp.button :refer $ comp-button
            phlox.comp.drag-point :refer $ comp-drag-point
            respo-ui.core :as ui
            app.config :refer $ grid-size
            phlox.complex :as complex
            app.schema :refer $ shapes-variations
    'app.config $ %{} 'FileEntry
      :defs $ {}
        'detect-grid-size $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn detect-grid-size ()
            decode-map-as
              js/parseInt $ .unwrap-or (get-env |size) |31
              , 'Number
          :examples $ []
          :schema $ quote $ Fn (-> Number) (:features :js-ffi)
        'detect-tick-interval $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn detect-tick-interval ()
            decode-map-as
              js/parseInt $ .unwrap-or (get-env |interval) |300
              , 'Number
          :examples $ []
          :schema $ quote $ Fn (-> Number) (:features :js-ffi)
        'dev? $ %{} 'CodeEntry (:doc |)
          :code $ quote $ def dev?
            = |dev $ .unwrap-or (get-env |mode) |release
          :examples $ []
          :schema $ quote Bool
        'grid-size $ %{} 'CodeEntry (:doc |)
          :code $ quote $ def grid-size (detect-grid-size)
          :examples $ []
          :schema $ quote Number
        'site $ %{} 'CodeEntry (:doc |)
          :code $ quote $ def site
            {} (:dev-ui |http://localhost:8100/main.css) (:release-ui |http://cdn.tiye.me/favored-fonts/main.css) (:cdn-url |http://cdn.tiye.me/phlox/) (:title |Phlox) (:icon |http://cdn.tiye.me/logo/quamolit.png) (:storage-key |phlox)
          :examples $ []
          :schema $ quote $ Map Tag String
        'tick-interval $ %{} 'CodeEntry (:doc |)
          :code $ quote $ def tick-interval (detect-tick-interval)
          :examples $ []
          :schema $ quote Number
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote $ ns app.config
    'app.main $ %{} 'FileEntry
      :defs $ {}
        '*dispatch-fn $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defref *dispatch-fn dispatch!
          :examples $ []
          :schema $ quote $ Ref
            Fn app.schema/AppOp (-> Unit) (:features :js-ffi)
        '*store $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defref *store schema/store
          :examples $ []
          :schema $ quote $ Ref app.schema/GameState
        'dispatch! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn dispatch! (op)
            reset! *store $ updater @*store op
            , &unit
          :examples $ []
          :schema $ quote $ Fn app.schema/AppOp (-> Unit) (:features :js-ffi)
        'main! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn main! () (; js/console.log PIXI)
            if dev? $ load-console-formatter!
            phlox.core/ffi-then
              phlox.core/ffi-load-font $ new FontFaceObserver/default "|Josefin Sans"
              fn (event) (render-app!)
            add-watch! *store :change $ fn (store prev) (render-app!)
            js/window.addEventListener |resize $ fn (e) (render-app!)
            js/setInterval
              fn () $ if
                and
                  not $ :paused? @*store
                  not $ :failed? @*store
                @*dispatch-fn $ schema/GameOp :tick
              , config/tick-interval
            js/window.addEventListener |keydown $ fn (event)
              match (.-key event)
                |ArrowUp $ @*dispatch-fn $ schema/GameOp :rotate
                |ArrowDown $ if (.-shiftKey event)
                  @*dispatch-fn $ schema/GameOp :move-most $ [] 1 0
                  @*dispatch-fn $ schema/GameOp :move $ [] 1 0
                |ArrowLeft $ if (.-shiftKey event)
                  @*dispatch-fn $ schema/GameOp :move-most $ [] 0 -1
                  @*dispatch-fn $ schema/GameOp :move $ [] 0 -1
                |ArrowRight $ if (.-shiftKey event)
                  @*dispatch-fn $ schema/GameOp :move-most $ [] 0 1
                  @*dispatch-fn $ schema/GameOp :move $ [] 0 1
                "| " $ @*dispatch-fn $ schema/GameOp :move-most ([] 1 0)
                |Enter $ @*dispatch-fn $ schema/GameOp :toggle-pause
                _ $ do
                  println |Event: $ .-key event
                  , nil
            println "|App Started"
          :examples $ []
          :schema $ quote $ Fn (-> Unit) (:features :js-ffi)
        'reload! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn reload! ()
            if (nil? build-errors)
              do (println "|Code updated.") (clear-phlox-caches!) (reset! *dispatch-fn dispatch!) (remove-watch! *store :change)
                add-watch! *store :change $ fn (store prev) (render-app!)
                render-app!
                hud! |ok~ |Ok
              hud! |error build-errors
            , &unit
          :examples $ []
          :schema $ quote $ Fn (-> Unit)
        'render-app! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn render-app! ()
            render! (comp-container @*store) @*dispatch-fn $ {}
          :examples $ []
          :schema $ quote $ Fn (-> Unit) (:features :js-ffi)
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote $ ns app.main
          :require (|pixi.js :as PIXI)
            phlox.core :refer $ render! clear-phlox-caches!
            app.comp.container :refer $ comp-container
            app.schema :as schema
            app.config :refer $ dev?
            app.config :as config
            app.updater :refer $ updater
            |fontfaceobserver-es :as FontFaceObserver
            |./calcit.build-errors :default build-errors
            |bottom-tip :default hud!
    'app.schema $ %{} 'FileEntry
      :defs $ {}
        'AppOp $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defunion AppOp GameOp StateOp
          :examples $ []
          :schema $ quote UnionDef
        'BlockCell $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defenum BlockCell (:filled) (:collapsing)
          :examples $ []
          :schema $ quote EnumDef
        'Cell $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defunion Cell PresetCell BlockCell
          :examples $ []
          :schema $ quote UnionDef
        'FallingPiece $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defstruct FallingPiece
            :pick $ List Number
            :position $ List Number
          :examples $ []
          :schema $ quote StructDef
        'GameOp $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defenum GameOp (:tick) (:rotate)
            :move $ List Number
            :move-most $ List Number
            :reset
            :toggle-pause
          :examples $ []
          :schema $ quote EnumDef
        'GameState $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defstruct GameState
            :states $ Map Dynamic Dynamic
            :grid $ List $ List (Option app.schema/Cell)
            :failed? Bool
            :paused? Bool
            :score Number
            :piece $ Option app.schema/FallingPiece
          :examples $ []
          :schema $ quote StructDef
        'PresetCell $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defstruct PresetCell (:color Number)
          :examples $ []
          :schema $ quote StructDef
        'StateOp $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defenum StateOp
            :states (List respo.schema/CoordKey) Dynamic
          :examples $ []
          :schema $ quote EnumDef
        'collapsing-cell $ %{} 'CodeEntry (:doc |)
          :code $ quote $ def collapsing-cell
            Option :some $ BlockCell :collapsing
          :examples $ []
          :schema $ quote $ Option app.schema/Cell
        'detection-pattern-5 $ %{} 'CodeEntry (:doc |)
          :code $ quote $ def detection-pattern-5
            [] ([] p1 p1 p1 p1 p1) ([] p1 p0 p0 p0 p1) ([] p1 p0 p1 p0 p1) ([] p1 p0 p0 p0 p1) ([] p1 p1 p1 p1 p1)
          :examples $ []
          :schema $ quote $ List
            List $ Option app.schema/Cell
        'detection-pattern-7 $ %{} 'CodeEntry (:doc |)
          :code $ quote $ def detection-pattern-7
            [] ([] p1 p1 p1 p1 p1 p1 p1) ([] p1 p0 p0 p0 p0 p0 p1) ([] p1 p0 p1 p1 p1 p0 p1) ([] p1 p0 p1 p1 p1 p0 p1) ([] p1 p0 p1 p1 p1 p0 p1) ([] p1 p0 p0 p0 p0 p0 p1) ([] p1 p1 p1 p1 p1 p1 p1)
          :examples $ []
          :schema $ quote $ List
            List $ Option app.schema/Cell
        'empty-cell $ %{} 'CodeEntry (:doc |)
          :code $ quote $ def empty-cell (Option :none)
          :examples $ []
          :schema $ quote $ Option app.schema/Cell
        'filled-cell $ %{} 'CodeEntry (:doc |)
          :code $ quote $ def filled-cell
            Option :some $ BlockCell :filled
          :examples $ []
          :schema $ quote $ Option app.schema/Cell
        'gen-qrcode-grid $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn gen-qrcode-grid (size)
            map (range size)
              fn (row-idx)
                map (range size)
                  fn (col-idx)
                    let
                        r-row-idx $ - size row-idx 1
                        r-col-idx $ - size col-idx 1
                        dx $ - col-idx $ - size 9
                        dy $ - row-idx $ - size 9
                      cond
                          and (< row-idx 7) (< col-idx 7)
                          .unwrap-or
                            get-in detection-pattern-7 $ [] row-idx col-idx
                            , empty-cell
                        (and (<= row-idx 7) (= col-idx 7))
                          , p0
                        (and (<= col-idx 7) (= row-idx 7))
                          , p0
                        (and (< row-idx 7) (< r-col-idx 7))
                          .unwrap-or
                            get-in detection-pattern-7 $ [] row-idx r-col-idx
                            , empty-cell
                        (and (<= row-idx 7) (= r-col-idx 7))
                          , p0
                        (and (<= r-col-idx 7) (= row-idx 7))
                          , p0
                        (and (< r-row-idx 7) (< col-idx 7))
                          .unwrap-or
                            get-in detection-pattern-7 $ [] r-row-idx col-idx
                            , empty-cell
                        (and (<= r-row-idx 7) (= col-idx 7))
                          , p0
                        (and (<= col-idx 7) (= r-row-idx 7))
                          , p0
                        (and (>= dx 0) (< dx 5) (>= dy 0) (< dy 5))
                          .unwrap-or
                            get-in detection-pattern-5 $ [] dy dx
                            , empty-cell
                        true empty-cell
          :examples $ []
          :schema $ quote $ Fn Number
            -> $ List $ List (Option app.schema/Cell)
          :tests $ [] $ %{} 'TestEntry (:name |raw-cells-and-transpose-roundtrip)
            :code $ quote $ let
                grid $ gen-qrcode-grid 31
              assert= 31 $ .len grid
              assert= true $ = (Result :ok p1)
                get-in grid $ [] 0 0
              assert= true $ = (Result :ok empty-cell)
                get-in grid $ [] 10 10
              assert= grid $ app.updater/flip-grid $ app.updater/flip-grid grid
              assert= grid $ app.updater/collapse-grid grid
        'p0 $ %{} 'CodeEntry (:doc |)
          :code $ quote $ def p0
            Option :some $ PresetCell :color 0xffffff
          :examples $ []
          :schema $ quote $ Option app.schema/Cell
        'p1 $ %{} 'CodeEntry (:doc |)
          :code $ quote $ def p1
            Option :some $ PresetCell :color 0x000000
          :examples $ []
          :schema $ quote $ Option app.schema/Cell
        'shapes-variations $ %{} 'CodeEntry (:doc |)
          :code $ quote $ def shapes-variations
            []
              []
                [] ([] 0 -1) ([] 0 0) ([] 0 1) ([] 0 2)
                [] ([] -1 0) ([] 0 0) ([] 1 0) ([] 2 0)
              []
                [] ([] -1 0) ([] 0 -1) ([] 0 0) ([] 0 1)
                [] ([] -1 0) ([] 0 -1) ([] 0 0) ([] 1 0)
                [] ([] 0 -1) ([] 0 0) ([] 0 1) ([] 1 0)
                [] ([] -1 0) ([] 0 0) ([] 0 1) ([] 1 0)
              [] $ [] ([] -1 0) ([] -1 1) ([] 0 0) ([] 0 1)
              []
                [] ([] -1 -1) ([] 0 -1) ([] 0 0) ([] 0 1)
                [] ([] -1 0) ([] -1 1) ([] 0 0) ([] 1 0)
                [] ([] 1 1) ([] 0 -1) ([] 0 0) ([] 0 1)
                [] ([] -1 0) ([] 1 -1) ([] 0 0) ([] 1 0)
              []
                [] ([] -1 1) ([] 0 -1) ([] 0 0) ([] 0 1)
                [] ([] 1 1) ([] -1 0) ([] 0 0) ([] 1 0)
                [] ([] 1 -1) ([] 0 -1) ([] 0 0) ([] 0 1)
                [] ([] -1 -1) ([] -1 0) ([] 0 0) ([] 1 0)
              []
                [] ([] -1 0) ([] -1 1) ([] 0 -1) ([] 0 0)
                [] ([] -1 0) ([] 0 0) ([] 0 1) ([] 1 1)
              []
                [] ([] -1 -1) ([] -1 0) ([] 0 0) ([] 0 1)
                [] ([] -1 1) ([] 0 1) ([] 0 0) ([] 1 0)
          :examples $ []
          :schema $ quote $ List
            List $ List $ List Number
        'store $ %{} 'CodeEntry (:doc |)
          :code $ quote $ def store
            GameState :states
              {} $ :cursor $ []
              , :grid (gen-qrcode-grid grid-size) :failed? false :paused? false :score 0 :piece $ Option :none
          :examples $ []
          :schema $ quote app.schema/GameState
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote $ ns app.schema
          :require $ app.config :refer $ grid-size
    'app.updater $ %{} 'FileEntry
      :defs $ {}
        'block-state? $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn block-state? (cell expected)
            match cell
              (:none) false
              (:some occupied)
                match occupied
                  (app.schema/PresetCell _) false
                  (app.schema/BlockCell state) (= state expected)
          :examples $ []
          :schema $ quote $ Fn (Option app.schema/Cell) app.schema/BlockCell (-> Bool)
        'cell-at $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn cell-at (grid y x)
            match (nth grid y)
              (:some row) (nth row x)
              (:none) (Option :none)
          :examples $ []
          :schema $ quote $ Fn
            List $ List $ Option app.schema/Cell
            , Number Number
              -> $ Option $ Option app.schema/Cell
        'change-shape $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn change-shape (store piece)
            let
                pick $ :pick piece
                pos $ :position piece
                shape-index $ .unwrap $ first pick
                variants $ .unwrap $ nth shapes-variations shape-index
                prev $ .unwrap-or (last pick) 0
                next-pick $ [] shape-index $ if
                  < (inc prev) (.len variants)
                  inc prev
                  , 0
              if
                valid-put? next-pick pos $ :grid store
                with-piece store $ &struct:assoc piece :pick next-pick
                , store
          :examples $ []
          :schema $ quote $ Fn app.schema/GameState app.schema/FallingPiece (-> app.schema/GameState)
        'collapse-column $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn collapse-column (acc col collapsed)
            if (empty? col)
              concat (repeat schema/empty-cell collapsed) acc
              let
                  current $ .unwrap $ last col
                  remaining $ butlast col
                match current
                  (:none)
                    recur (prepend acc schema/empty-cell) remaining collapsed
                  (:some cell)
                    match cell
                      (app.schema/PresetCell _)
                        recur
                          concat ([] current) (repeat schema/empty-cell collapsed) acc
                          , remaining 0
                      (app.schema/BlockCell block)
                        match block
                          (:collapsing)
                            recur acc remaining $ inc collapsed
                          (:filled)
                            recur (prepend acc current) remaining collapsed
          :examples $ []
          :schema $ quote $ Fn
            List $ Option app.schema/Cell
            List $ Option app.schema/Cell
            , Number
              -> $ List $ Option app.schema/Cell
          :tests $ [] $ %{} 'TestEntry (:name |keeps-preset-barriers-while-clearing)
            :code $ quote $ assert= ([] schema/empty-cell schema/filled-cell schema/p1 schema/empty-cell schema/filled-cell)
              collapse-column ([])
                decode-map-as ([] schema/filled-cell schema/collapsing-cell schema/p1 schema/filled-cell schema/collapsing-cell)
                  List $ Option app.schema/Cell
                , 0
        'collapse-grid $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn collapse-grid (grid)
            if
              any? grid $ fn (row)
                any? row $ fn (cell)
                  block-state? cell $ schema/BlockCell :collapsing
              -> grid (flip-grid)
                map $ fn (col)
                  collapse-column ([]) col 0
                flip-grid
              , grid
          :examples $ []
          :schema $ quote $ Fn
            List $ List $ Option app.schema/Cell
            -> $ List $ List (Option app.schema/Cell)
        'drop-shape $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn drop-shape (store piece)
            let
                pick $ :pick piece
                pos $ :position piece
                grid $ :grid store
                next-pos $ complex/add pos $ [] 1 0
              if (valid-put? pick next-pos grid)
                &struct:assoc
                  with-piece store $ &struct:assoc piece :position next-pos
                  , :grid $ collapse-grid grid
                let
                    real-cells $ map
                      decode-map-as
                        .unwrap-or (get-in shapes-variations pick) ([])
                        List $ List Number
                      fn (cell) (complex/add cell pos)
                    new-grid $ mark-collapsing $ .foldl real-cells grid
                      fn (acc pos)
                        hint-fn $ Fn
                          List $ List $ Option app.schema/Cell
                          List Number
                          -> $ List $ List (Option app.schema/Cell)
                        set-cell acc pos schema/filled-cell
                  &struct:assoc
                    with-piece store $ new-piece
                    , :grid new-grid
          :examples $ []
          :schema $ quote $ Fn app.schema/GameState app.schema/FallingPiece (-> app.schema/GameState) (:features :js-ffi)
        'empty-at? $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn empty-at? (grid pos)
            match
              cell-at grid
                .unwrap $ first pos
                .unwrap $ last pos
              (:some cell) (.none? cell)
              (:none) false
          :examples $ []
          :schema $ quote $ Fn
            List $ List $ Option app.schema/Cell
            List Number
            -> Bool
        'flip-grid $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn flip-grid (grid)
            let
                size $ .len grid
              map (range size)
                fn (row-idx)
                  map (range size)
                    fn (col-idx)
                      .unwrap-or (cell-at grid col-idx row-idx) schema/empty-cell
          :examples $ []
          :schema $ quote $ Fn
            List $ List $ Option app.schema/Cell
            -> $ List $ List (Option app.schema/Cell)
        'mark-collapsing $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn mark-collapsing (grid)
            map grid $ fn (row)
              if
                every? row $ fn (cell) (.some? cell)
                map row $ fn (cell)
                  if
                    block-state? cell $ schema/BlockCell :filled
                    , schema/collapsing-cell cell
                , row
          :examples $ []
          :schema $ quote $ Fn
            List $ List $ Option app.schema/Cell
            -> $ List $ List (Option app.schema/Cell)
        'move-shape $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn move-shape (store piece step)
            let
                pos $ complex/add (:position piece) step
              if
                valid-put? (:pick piece) pos $ :grid store
                with-piece store $ &struct:assoc piece :position pos
                , store
          :examples $ []
          :schema $ quote $ Fn app.schema/GameState app.schema/FallingPiece (List Number) (-> app.schema/GameState)
        'new-piece $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn new-piece ()
            let
                a $ decode-map-as
                  rand-int $ .len shapes-variations
                  , 'Number
                b $ decode-map-as
                  rand-int $ .len $ .unwrap (nth shapes-variations a)
                  , 'Number
              schema/FallingPiece :pick ([] a b) :position $ [] 1 $ * 0.5 (dec grid-size)
          :examples $ []
          :schema $ quote $ Fn (-> app.schema/FallingPiece) (:features :js-ffi)
        'quick-move $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn quick-move (store piece step)
            loop
                at $ :position piece
              let
                  next $ complex/add at step
                if
                  valid-put? (:pick piece) next $ :grid store
                  recur next
                  with-piece store $ &struct:assoc piece :position at
          :examples $ []
          :schema $ quote $ Fn app.schema/GameState app.schema/FallingPiece (List Number) (-> app.schema/GameState)
        'set-cell $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn set-cell (grid pos cell)
            let
                y $ .unwrap $ first pos
                x $ .unwrap $ last pos
                row $ .unwrap $ nth grid y
              assoc grid y $ assoc row x cell
          :examples $ []
          :schema $ quote $ Fn
            List $ List $ Option app.schema/Cell
            List Number
            Option app.schema/Cell
            -> $ List $ List (Option app.schema/Cell)
        'updater $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn updater (store op)
            match op
              (app.schema/StateOp state-op)
                match state-op $
                  :states path value
                  &struct:assoc store :states $ decode-map-as
                    .unwrap $ get
                      update-states
                        {} $ :states $ :states store
                        , path value
                      , :states
                    Map Dynamic Dynamic
              (app.schema/GameOp game-op)
                match game-op
                  (:tick)
                    if
                      or (:failed? store) (:paused? store)
                      , store $ match (:piece store)
                        (:none)
                          with-piece store $ new-piece
                        (:some piece)
                          if
                            valid-put? (:pick piece) (:position piece) (:grid store)
                            drop-shape store piece
                            &struct:assoc store :failed? true
                  (:rotate)
                    match (:piece store)
                      (:none) store
                      (:some piece) (change-shape store piece)
                  (:move step)
                    match (:piece store)
                      (:none) store
                      (:some piece) (move-shape store piece step)
                  (:move-most step)
                    match (:piece store)
                      (:none) store
                      (:some piece) (quick-move store piece step)
                  (:reset) schema/store
                  (:toggle-pause)
                    &struct:assoc store :paused? $ not $ :paused? store
          :examples $ []
          :schema $ quote $ Fn app.schema/GameState app.schema/AppOp (-> app.schema/GameState) (:features :js-ffi)
        'valid-put? $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn valid-put? (pick pos grid)
            let
                real-cells $ map
                  decode-map-as
                    .unwrap-or (get-in shapes-variations pick) ([])
                    List $ List Number
                  fn (cell) (complex/add cell pos)
              every? real-cells $ fn (p) (empty-at? grid p)
          :examples $ []
          :schema $ quote $ Fn (List Number) (List Number)
            List $ List $ Option app.schema/Cell
            -> Bool
            :features :js-ffi
          :tests $ [] $ %{} 'TestEntry (:name |empty-grid-and-occupied-cell)
            :code $ quote $ let
                grid $ repeat (repeat schema/empty-cell 31) 31
              assert= true $ valid-put? ([] 0 0) ([] 9 9) grid
              assert= false $ valid-put? ([] 0 0) ([] -10 -10) grid
              assert= false $ valid-put? ([] 0 0) ([] 40 40) grid
              assert= false $ valid-put? ([] 0 0) ([] 9 9)
                map grid $ fn (row)
                  map row $ fn (cell) schema/filled-cell
        'with-piece $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn with-piece (store piece)
            &struct:assoc store :piece $ Option :some piece
          :examples $ []
          :schema $ quote $ Fn app.schema/GameState app.schema/FallingPiece (-> app.schema/GameState)
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote $ ns app.updater
          :require
            phlox.cursor :refer $ update-states
            app.schema :refer $ shapes-variations
            app.schema :as schema
            app.config :refer $ grid-size
            phlox.complex :as complex
            |@calcit/std :refer $ rand rand-int
