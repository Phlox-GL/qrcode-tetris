
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
                cursor $ []
                states $ .unwrap-or (get store :states) nil
                grid $ decode-map-as
                  .unwrap-or (get store :grid) nil
                  :: 'List $ :: 'List 'Dynamic
                drop-position $ decode-map-as
                  either
                    .unwrap-or (get store :drop-position) nil
                    [] 0 0
                  :: 'List 'Number
                drop-pick $ decode-map-as
                  either
                    .unwrap-or (get store :drop-pick) nil
                    [] 0 0
                  :: 'List 'Number
                dropping $ decode-map-as
                  .unwrap-or (get-in shapes-variations drop-pick) ([])
                  :: 'List $ :: 'List 'Number
                dropping-cells $ if
                  non-nil? $ .unwrap-or (get store :drop-pick) nil
                  reduce
                    map dropping $ fn (x) (complex/add drop-position x)
                    #{}
                    fn (acc x)
                      hint-fn $ {}
                        :return $ :: 'Set $ :: 'List 'Number
                        :args $ []
                          :: 'Set $ :: 'List 'Number
                          :: 'List 'Number
                      include acc x
                  #{}
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
                          :fill $ cond
                              contains? dropping-cells p
                              hslx 200 10 50
                            (non-nil? cell)
                              match
                                .unwrap-or (get cell :kind) nil
                                :preset $ .unwrap-or (get cell :color) nil
                                :collapsing $ hslx 30 90 70
                                _ $ hslx 10 80 10
                            true $ hslx 200 10 100
                  concat-all
                comp-button $ {} (:text |Reset)
                  :position $ [] 340 -40
                  :color $ hslx 0 0 100
                  :fill $ hslx 0 0 60
                  :on-pointertap $ fn (e d!)
                    d! $ :: :reset
                comp-button $ {} (:text |Fullscreen)
                  :position $ [] 340 80
                  :color $ hslx 0 0 100
                  :fill $ hslx 0 0 60
                  :on-pointertap $ fn (e d!) (js/document.body.requestFullscreen)
                if
                  .unwrap-or (get store :failed?) nil
                  text $ {}
                    :position $ [] 340 0
                    :text |Failed
                    :style $ {} (:font-size 24) (:fill |red) (:font-family "|Josefin Sans")
          :examples $ []
          :schema $ :: 'Fn $ {} (:return 'phlox.schema/PhloxElement)
            :args $ [] $ :: 'Map 'Tag 'Dynamic
            :features $ #{} :js-ffi
        'concat-all $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn concat-all (xs)
            foldl xs ([]) concat
          :examples $ []
          :schema $ :: 'Fn $ {}
            :args $ [] $ :: 'List (:: 'List 'T)
            :generics $ [] 'T
            :return $ :: 'List 'T
        'middle-idx $ %{} 'CodeEntry (:doc |)
          :code $ quote $ def middle-idx
            * 0.5 $ dec grid-size
          :examples $ []
          :schema $ :: 'Number
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote $ ns app.comp.container
          :require
            phlox.core :refer $ g hslx rect circle text container graphics create-list >>
            phlox.comp.button :refer $ comp-button
            phlox.comp.drag-point :refer $ comp-drag-point
            |shortid :as shortid
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
          :schema $ :: 'Fn $ {} (:return 'Number)
            :args $ []
            :features $ #{} :js-ffi
        'detect-tick-interval $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn detect-tick-interval ()
            decode-map-as
              js/parseInt $ .unwrap-or (get-env |interval) |300
              , 'Number
          :examples $ []
          :schema $ :: 'Fn $ {} (:return 'Number)
            :args $ []
            :features $ #{} :js-ffi
        'dev? $ %{} 'CodeEntry (:doc |)
          :code $ quote $ def dev?
            = |dev $ .unwrap-or (get-env |mode) |release
          :examples $ []
          :schema $ :: 'Bool
        'grid-size $ %{} 'CodeEntry (:doc |)
          :code $ quote $ def grid-size (detect-grid-size)
          :examples $ []
          :schema $ :: 'Number
        'site $ %{} 'CodeEntry (:doc |)
          :code $ quote $ def site
            {} (:dev-ui |http://localhost:8100/main.css) (:release-ui |http://cdn.tiye.me/favored-fonts/main.css) (:cdn-url |http://cdn.tiye.me/phlox/) (:title |Phlox) (:icon |http://cdn.tiye.me/logo/quamolit.png) (:storage-key |phlox)
          :examples $ []
          :schema $ :: 'Map 'Tag 'String
        'tick-interval $ %{} 'CodeEntry (:doc |)
          :code $ quote $ def tick-interval (detect-tick-interval)
          :examples $ []
          :schema $ :: 'Number
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote $ ns app.config
    'app.main $ %{} 'FileEntry
      :defs $ {}
        '*dispatch-fn $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defref *dispatch-fn dispatch!
          :examples $ []
          :schema $ :: 'Ref $ :: 'Fn
            {} (:return 'Unit)
              :args $ [] 'Tag 'Dynamic
        '*store $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defref *store schema/store
          :examples $ []
          :schema $ :: 'Ref $ :: 'Map 'Tag 'Dynamic
        'dispatch! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn dispatch! (op op-data)
            when
              and dev? $ not= op :states
              println |dispatch! op op-data
            let
                op-id $ decode-map-as (shortid/generate) 'String
                op-time $ decode-map-as (js/Date.now) 'Number
              reset! *store $ updater @*store op op-data op-id op-time
            , &unit
          :examples $ []
          :schema $ :: 'Fn $ {} (:return 'Unit)
            :args $ [] 'Tag 'Dynamic
            :features $ #{} :js-ffi
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
                  not $ .unwrap-or (get @*store :paused?) nil
                  not $ .unwrap-or (get @*store :failed?) nil
                @*dispatch-fn :tick nil
              , config/tick-interval
            js/window.addEventListener |keydown $ fn (event)
              match (.-key event)
                |ArrowUp $ @*dispatch-fn :up nil
                |ArrowDown $ if (.-shiftKey event) (@*dispatch-fn :down-most nil) (@*dispatch-fn :down nil)
                |ArrowLeft $ if (.-shiftKey event) (@*dispatch-fn :left-most nil) (@*dispatch-fn :left nil)
                |ArrowRight $ if (.-shiftKey event) (@*dispatch-fn :right-most nil) (@*dispatch-fn :right nil)
                "| " $ @*dispatch-fn :down-most nil
                |Enter $ @*dispatch-fn :toggle-pause nil
                _ $ do
                  println |Event: $ .-key event
                  , nil
            println "|App Started"
          :examples $ []
          :schema $ :: 'Fn $ {} (:return 'Unit)
            :args $ []
            :features $ #{} :js-ffi
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
          :schema $ :: 'Fn $ {} (:return 'Unit)
            :args $ []
        'render-app! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn render-app! ()
            render!
              comp-container $ deref *store
              fn (op)
                hint-fn $ {}
                  :args $ [] 'Enum
                  :return 'Unit
                let
                    op-tag $ decode-map-as (&enum:nth op 0) 'Tag
                    op-data $ if
                      and (= :states op-tag)
                        = 3 $ &enum:count op
                      [] (&enum:nth op 1) (&enum:nth op 2)
                      if
                        = 2 $ &enum:count op
                        &enum:nth op 1
                        , nil
                  (deref *dispatch-fn) op-tag op-data
              {}
          :examples $ []
          :schema $ :: 'Fn $ {} (:return 'Unit)
            :args $ []
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote $ ns app.main
          :require (|pixi.js :as PIXI)
            phlox.core :refer $ render! clear-phlox-caches!
            app.comp.container :refer $ comp-container
            app.schema :as schema
            app.config :refer $ dev?
            app.config :as config
            |shortid :as shortid
            app.updater :refer $ updater
            |fontfaceobserver-es :as FontFaceObserver
            |./calcit.build-errors :default build-errors
            |bottom-tip :default hud!
    'app.schema $ %{} 'FileEntry
      :defs $ {}
        'detection-pattern-5 $ %{} 'CodeEntry (:doc |)
          :code $ quote $ def detection-pattern-5
            [] ([] p1 p1 p1 p1 p1) ([] p1 p0 p0 p0 p1) ([] p1 p0 p1 p0 p1) ([] p1 p0 p0 p0 p1) ([] p1 p1 p1 p1 p1)
          :examples $ []
          :schema $ :: 'List $ :: 'List (:: 'Map 'Tag 'Dynamic)
        'detection-pattern-7 $ %{} 'CodeEntry (:doc |)
          :code $ quote $ def detection-pattern-7
            [] ([] p1 p1 p1 p1 p1 p1 p1) ([] p1 p0 p0 p0 p0 p0 p1) ([] p1 p0 p1 p1 p1 p0 p1) ([] p1 p0 p1 p1 p1 p0 p1) ([] p1 p0 p1 p1 p1 p0 p1) ([] p1 p0 p0 p0 p0 p0 p1) ([] p1 p1 p1 p1 p1 p1 p1)
          :examples $ []
          :schema $ :: 'List $ :: 'List (:: 'Map 'Tag 'Dynamic)
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
                          match
                            get-in detection-pattern-7 $ [] row-idx col-idx
                            (:some cell) cell
                            (:none) nil
                        (and (<= row-idx 7) (= col-idx 7))
                          , p0
                        (and (<= col-idx 7) (= row-idx 7))
                          , p0
                        (and (< row-idx 7) (< r-col-idx 7))
                          match
                            get-in detection-pattern-7 $ [] row-idx r-col-idx
                            (:some cell) cell
                            (:none) nil
                        (and (<= row-idx 7) (= r-col-idx 7))
                          , p0
                        (and (<= r-col-idx 7) (= row-idx 7))
                          , p0
                        (and (< r-row-idx 7) (< col-idx 7))
                          match
                            get-in detection-pattern-7 $ [] r-row-idx col-idx
                            (:some cell) cell
                            (:none) nil
                        (and (<= r-row-idx 7) (= col-idx 7))
                          , p0
                        (and (<= col-idx 7) (= r-row-idx 7))
                          , p0
                        (and (>= dx 0) (< dx 5) (>= dy 0) (< dy 5))
                          match
                            get-in detection-pattern-5 $ [] dy dx
                            (:some cell) cell
                            (:none) nil
                        true nil
          :examples $ []
          :schema $ :: 'Fn $ {}
            :args $ [] 'Number
            :return $ :: 'List $ :: 'List 'Dynamic
          :tests $ [] $ %{} 'TestEntry (:name |raw-cells-and-transpose-roundtrip)
            :code $ quote $ let
                grid $ gen-qrcode-grid 31
              assert= 31 $ count grid
              assert= true $ map? $ .unwrap
                get-in grid $ [] 0 0
              assert= true $ nil? $ .unwrap-or
                get-in grid $ [] 10 10
                , nil
              assert= grid $ app.updater/flip-grid $ app.updater/flip-grid grid
              assert= grid $ app.updater/collapse-grid grid
        'p0 $ %{} 'CodeEntry (:doc |)
          :code $ quote $ def p0
            {} (:kind :preset) (:color 0xffffff)
          :examples $ []
          :schema $ :: 'Map 'Tag 'Dynamic
        'p1 $ %{} 'CodeEntry (:doc |)
          :code $ quote $ def p1
            {} (:kind :preset) (:color 0x000000)
          :examples $ []
          :schema $ :: 'Map 'Tag 'Dynamic
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
          :schema $ :: 'List $ :: 'List
            :: 'List $ :: 'List 'Number
        'store $ %{} 'CodeEntry (:doc |)
          :code $ quote $ def store
            {}
              :states $ {} $ :cursor ([])
              :grid $ gen-qrcode-grid grid-size
              :failed? false
              :paused? false
              :score 0
              :drop-pick nil
              :drop-position nil
          :examples $ []
          :schema $ :: 'Map 'Tag 'Dynamic
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote $ ns app.schema
          :require $ app.config :refer $ grid-size
    'app.updater $ %{} 'FileEntry
      :defs $ {}
        'change-shape $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn change-shape (store)
            let
                drop-pick $ decode-map-as
                  .unwrap-or (get store :drop-pick) nil
                  :: 'List 'Number
                grid $ decode-map-as
                  .unwrap-or (get store :grid) nil
                  :: 'List $ :: 'List 'Dynamic
                pos $ decode-map-as
                  .unwrap-or (get store :drop-position) nil
                  :: 'List 'Number
                shape-index $ decode-map-as
                  option:unwrap $ first drop-pick
                  , 'Number
                shape-variants $ decode-map-as
                  .unwrap-or (nth shapes-variations shape-index) ([])
                  :: 'List $ :: 'List $ :: 'List 'Number
                prev $ .unwrap-or (last drop-pick) 0
                next-pick $ [] shape-index $ if
                  < (inc prev) (count shape-variants)
                  inc prev
                  , 0
              if (valid-put? next-pick pos grid) (assoc store :drop-pick next-pick) store
          :examples $ []
          :schema $ :: 'Fn $ {}
            :args $ [] $ :: 'Map 'Tag 'Dynamic
            :features $ #{} :js-ffi
            :return $ :: 'Map 'Tag 'Dynamic
        'collapse-column $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn collapse-column (acc col collapsed)
            if (empty? col)
              if (> collapsed 0)
                concat
                  decode-map-as (repeat nil collapsed) (:: 'List 'Dynamic)
                  , acc
                , acc
              let
                  cursor $ .unwrap-or (last col) nil
                cond
                    nil? cursor
                    recur (prepend acc nil) (butlast col) collapsed
                  (= :collapsing (.unwrap-or (get cursor :kind) nil))
                    recur acc (butlast col) (inc collapsed)
                  (= :preset (.unwrap-or (get cursor :kind) nil))
                    if (> collapsed 0)
                      recur
                        concat
                          decode-map-as ([] cursor) (:: 'List 'Dynamic)
                          decode-map-as (repeat nil collapsed) (:: 'List 'Dynamic)
                          , acc
                        butlast col
                        , 0
                      recur (prepend acc cursor) (butlast col) collapsed
                  true $ recur (prepend acc cursor) (butlast col) collapsed
          :examples $ []
          :schema $ :: 'Fn $ {}
            :args $ [] (:: 'List 'Dynamic) (:: 'List 'Dynamic) 'Number
            :features $ #{} :js-ffi
            :return $ :: 'List 'Dynamic
        'collapse-grid $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn collapse-grid (grid)
            if
              any? grid $ fn (row)
                any? row $ fn (cell)
                  and (map? cell)
                    = :collapsing $ .unwrap-or (get cell :kind) nil
              -> grid (flip-grid)
                map $ fn (col)
                  collapse-column ([]) col 0
                flip-grid
              , grid
          :examples $ []
          :schema $ :: 'Fn $ {}
            :args $ [] $ :: 'List (:: 'List 'Dynamic)
            :return $ :: 'List $ :: 'List 'Dynamic
        'contains-in? $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn contains-in? (xs path)
            if (empty? path) true $ let
                p0 $ option:unwrap $ first path
              cond
                  list? xs
                  if (number? p0)
                    if (contains? xs p0)
                      recur
                        option:unwrap $ nth xs p0
                        rest path
                      , false
                    , false
                (map? xs)
                  if (contains? xs p0)
                    recur
                      option:unwrap $ get xs p0
                      rest path
                    , false
                true false
          :examples $ []
          :schema $ :: 'Fn $ {} (:return 'Bool)
            :args $ [] 'Dynamic $ :: 'List 'Number
        'detect-collapse $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn detect-collapse (grid)
            loop
                acc $ decode-map-as ([])
                  :: 'List $ :: 'List 'Dynamic
                xs grid
                collapsed-size 0
              cond
                  empty? xs
                  if (= 0 collapsed-size) acc $ concat
                    repeat (repeat nil grid-size) collapsed-size
                    , acc
                (any? (option:unwrap (last xs)) (fn (x) (and (map? x) (= (.unwrap-or (get x :kind) nil) :preset))))
                  let
                      next-acc $ if (= 0 collapsed-size) acc $ concat
                        repeat (repeat nil grid-size) collapsed-size
                        , acc
                    recur
                      prepend next-acc $ option:unwrap $ last xs
                      butlast xs
                      , 0
                (every? (option:unwrap (last xs)) (fn (x) (and (map? x) (= (.unwrap-or (get x :kind) nil) :filled))))
                  recur acc (butlast xs) (inc collapsed-size)
                true $ recur
                  prepend acc $ option:unwrap $ last xs
                  butlast xs
                  , collapsed-size
          :examples $ []
          :schema $ :: 'Fn $ {}
            :args $ [] $ :: 'List (:: 'List 'Dynamic)
            :return $ :: 'List $ :: 'List 'Dynamic
        'drop-shape $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn drop-shape (store)
            let
                next-pos $ complex/add
                  decode-map-as
                    .unwrap-or (get store :drop-position) nil
                    :: 'List 'Number
                  [] 1 0
              if
                valid-put?
                  decode-map-as
                    .unwrap-or (get store :drop-pick) nil
                    :: 'List 'Number
                  , next-pos $ decode-map-as
                    .unwrap-or (get store :grid) nil
                    :: 'List $ :: 'List 'Dynamic
                let
                    next-store $ assoc store :drop-position next-pos
                    grid $ decode-map-as
                      .unwrap-or (get next-store :grid) nil
                      :: 'List $ :: 'List 'Dynamic
                  assoc next-store :grid $ collapse-grid grid
                let
                    pick $ decode-map-as
                      .unwrap-or (get store :drop-pick) nil
                      :: 'List 'Number
                    pos $ decode-map-as
                      .unwrap-or (get store :drop-position) nil
                      :: 'List 'Number
                    grid $ decode-map-as
                      .unwrap-or (get store :grid) nil
                      :: 'List $ :: 'List 'Dynamic
                    real-cells $ map
                      decode-map-as
                        .unwrap-or (get-in shapes-variations pick) ([])
                        :: 'List $ :: 'List 'Number
                      fn (cell) (complex/add cell pos)
                    new-grid $ mark-collapsing $ foldl real-cells grid
                      fn (acc pos)
                        hint-fn $ {}
                          :return $ :: 'List $ :: 'List 'Dynamic
                          :args $ []
                            :: 'List $ :: 'List 'Dynamic
                            :: 'List 'Number
                        decode-map-as
                          assoc-in acc pos $ {} $ :kind :filled
                          :: 'List $ :: 'List 'Dynamic
                  -> store
                    assoc :drop-position $ [] 1 $ * 0.5
                      dec $ phlox.core/ffi-number grid-size
                    assoc :drop-pick $ let
                        a $ decode-map-as
                          rand-int $ count shapes-variations
                          , 'Number
                        b $ decode-map-as
                          rand-int $ count $ .unwrap-or (nth shapes-variations a) ([])
                          , 'Number
                      [] a b
                    assoc :grid new-grid
          :examples $ []
          :schema $ :: 'Fn $ {}
            :args $ [] $ :: 'Map 'Tag 'Dynamic
            :features $ #{} :js-ffi
            :return $ :: 'Map 'Tag 'Dynamic
        'flip-grid $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn flip-grid (grid)
            let
                size $ count grid
              map (range size)
                fn (row-idx)
                  map (range size)
                    fn (col-idx)
                      .unwrap-or
                        get-in grid $ [] col-idx row-idx
                        , nil
          :examples $ []
          :schema $ :: 'Fn $ {}
            :args $ [] $ :: 'List (:: 'List 'Dynamic)
            :return $ :: 'List $ :: 'List 'Dynamic
        'mark-collapsing $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn mark-collapsing (grid)
            map grid $ fn (row)
              if (every? row non-nil?)
                map row $ fn (cell)
                  if
                    = :filled $ .unwrap-or (get cell :kind) nil
                    {} $ :kind :collapsing
                    , cell
                , row
          :examples $ []
          :schema $ :: 'Fn $ {}
            :args $ [] $ :: 'List (:: 'List 'Dynamic)
            :return $ :: 'List $ :: 'List 'Dynamic
        'move-shape $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn move-shape (store step)
            let
                next-pos $ complex/add
                  decode-map-as
                    .unwrap-or (get store :drop-position) nil
                    :: 'List 'Number
                  , step
              if
                valid-put?
                  decode-map-as
                    .unwrap-or (get store :drop-pick) nil
                    :: 'List 'Number
                  , next-pos $ decode-map-as
                    .unwrap-or (get store :grid) nil
                    :: 'List $ :: 'List 'Dynamic
                assoc store :drop-position next-pos
                , store
          :examples $ []
          :schema $ :: 'Fn $ {}
            :args $ [] (:: 'Map 'Tag 'Dynamic) (:: 'List 'Number)
            :return $ :: 'Map 'Tag 'Dynamic
        'quick-move $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn quick-move (store step)
            loop
                at $ [] 0 0
              let
                  pos $ complex/add
                    decode-map-as
                      .unwrap-or (get store :drop-position) nil
                      :: 'List 'Number
                    , at
                  next-pos $ complex/add pos step
                if
                  valid-put?
                    decode-map-as
                      .unwrap-or (get store :drop-pick) nil
                      :: 'List 'Number
                    , next-pos $ decode-map-as
                      .unwrap-or (get store :grid) nil
                      :: 'List $ :: 'List 'Dynamic
                  recur $ complex/add at step
                  assoc store :drop-position pos
          :examples $ []
          :schema $ :: 'Fn $ {}
            :args $ [] (:: 'Map 'Tag 'Dynamic) (:: 'List 'Number)
            :return $ :: 'Map 'Tag 'Dynamic
        'updater $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn updater (store op op-data op-id op-time)
            match op
              :states $ let
                  state-data $ decode-map-as op-data $ :: 'List 'Dynamic
                update-states store
                  decode-map-as
                    option:unwrap $ first state-data
                    :: 'List 'Dynamic
                  option:unwrap $ last state-data
              :hydrate-storage $ decode-map-as op-data $ :: 'Map 'Tag 'Dynamic
              :tick $ cond
                  or
                    .unwrap-or (get store :failed?) nil
                    .unwrap-or (get store :paused?) nil
                  , store
                (nil? (.unwrap-or (get store :drop-pick) nil))
                  -> store
                    assoc :drop-position $ [] 1 $ * 0.5
                      dec $ phlox.core/ffi-number grid-size
                    assoc :drop-pick $ let
                        a $ decode-map-as
                          rand-int $ count shapes-variations
                          , 'Number
                        b $ decode-map-as
                          rand-int $ count $ .unwrap-or (nth shapes-variations a) ([])
                          , 'Number
                      [] a b
                (not (valid-put? (decode-map-as (.unwrap-or (get store :drop-pick) nil) (:: 'List 'Number)) (decode-map-as (.unwrap-or (get store :drop-position) nil) (:: 'List 'Number)) (decode-map-as (.unwrap-or (get store :grid) nil) (:: 'List (:: 'List 'Dynamic)))))
                  assoc store :failed? true
                true $ drop-shape store
              :up $ change-shape store
              :left $ move-shape store $ [] 0 -1
              :right $ move-shape store $ [] 0 1
              :down $ move-shape store $ [] 1 0
              :reset schema/store
              :down-most $ quick-move store $ [] 1 0
              :left-most $ quick-move store $ [] 0 -1
              :right-most $ quick-move store $ [] 0 1
              :toggle-pause $ update store :paused? not
              _ $ do (println "|unknown op" op op-data) store
          :examples $ []
          :schema $ :: 'Fn $ {}
            :args $ [] (:: 'Map 'Tag 'Dynamic) 'Tag 'Dynamic 'String 'Number
            :features $ #{} :js-ffi
            :return $ :: 'Map 'Tag 'Dynamic
        'valid-put? $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn valid-put? (pick pos grid)
            let
                real-cells $ map
                  decode-map-as
                    .unwrap-or (get-in shapes-variations pick) ([])
                    :: 'List $ :: 'List 'Number
                  fn (cell) (complex/add cell pos)
              every? real-cells $ fn (p)
                and (contains-in? grid p)
                  nil? $ .unwrap-or (get-in grid p) nil
          :examples $ []
          :schema $ :: 'Fn $ {} (:return 'Bool)
            :args $ [] (:: 'List 'Number) (:: 'List 'Number)
              :: 'List $ :: 'List 'Dynamic
            :features $ #{} :js-ffi
          :tests $ [] $ %{} 'TestEntry (:name |empty-grid-and-occupied-cell)
            :code $ quote $ let
                grid $ repeat (repeat nil 31) 31
              assert= true $ valid-put? ([] 0 0) ([] 9 9) grid
              assert= false $ valid-put? ([] 0 0) ([] -10 -10) grid
              assert= false $ valid-put? ([] 0 0) ([] 40 40) grid
              assert= false $ valid-put? ([] 0 0) ([] 9 9)
                map grid $ fn (row)
                  map row $ fn (cell)
                    {} $ :kind :filled
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote $ ns app.updater
          :require
            phlox.cursor :refer $ update-states
            app.schema :refer $ shapes-variations
            app.schema :as schema
            app.config :refer $ grid-size
            phlox.complex :as complex
            |@calcit/std :refer $ rand rand-int
