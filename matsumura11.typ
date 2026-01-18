#set text(
  lang: "ja",
  font: ("CMU Serif", "Harano Aji Mincho"),
  size: 11pt
)
#set par(leading: 0.8em)
#show link: underline
#show link: set text(fill: blue)
#import "@preview/scienceicons:0.1.0": *
#import "@preview/hydra:0.6.2": hydra
#import "@preview/showybox:2.0.4": *
#let current-chapter = state("chapter", "")
#let bg-color = rgb("#ffffff")

#set page(
  fill: bg-color,
  numbering: "1 / 1",
  paper: "a4",
  header: context [
    #let page-num = counter(page).get().last()
    #if page-num > 1 [
      #rect(width: 100%, height: 100%, stroke: (bottom: 1pt))[
        #grid(
          columns: (1fr, 1fr, 1fr),
          align(left)[#hydra(1, skip-starting: false)], 
          align(center)[],
          align(right)[#link("https://github.com/Riley719/matsumura11")[#github-icon() ノート置き場]]
        )
      ]
    ]
  ],
  footer: context [
    #let page-num = counter(page).get().last()
    #if page-num > 1 [
      #rect(width: 100%, height: 100%, stroke: (top: 1pt))[
        #grid(
          columns: (1fr, 1fr, 1fr),
          align(left)[#link(<outline>)[目次へジャンプ]], 
          align(center)[#counter(page).display("— 1/1 —", both: true)],
          align(right)[\@Riley]
        )
      ]
    ]
  ]
)

#import "@preview/showybox:2.0.3": showybox

#let becausebox(body) = showybox(
  frame: (
    border-color: blue,
    radius: 8pt,
    thickness: 1pt,
  ),
  [
    // 本文の冒頭にアイコンをインラインで配置
    #box(baseline: 25%, circle(radius: 0.8em, stroke: 1pt + blue)[
      #set align(center + horizon)
      #text(fill: blue, size: 1.6em)[$because$]
    ])
    #h(0.1em) // アイコンと本文の間のスペース
    #body
  ]
)

#show heading.where(level: 1): it => {
    current-chapter.update(it.body)  // 状態を更新
    it  // 見出しをそのまま表示
}
#set par(justify: true)
#let title = "松村可換環論11章ノート"
#show title: set align(center)
#show title: set text(weight: "black", size: 2em, font: ("CMU Serif", "Harano Aji Mincho"))
#let author = "Riley @Na2COOH_2"
#show author: set align(center)
#show author: set text(size: 1em, font: ("CMU Serif", "Harano Aji Mincho"))
#set heading(numbering: (..args) => {
  let nums = args.pos() // 引数の位置引数を`array`として取得
  if nums.len() == 1 { // 階層総数が1しかない、即ち最高階層
    return numbering("§ 1", ..nums)
  } else {
    return numbering("1.1", ..nums)
  }
})
#let heading_font(body) = {
  // font: (日本語文字を含まないフォント, 日本語文字を含むフォント)
  set text(font: ("CMU Serif", "Harano Aji Mincho"))
  body
}
#show heading: heading_font
#show strong: set text(font: ("CMU Serif", "Harano Aji Mincho"))
#import "@preview/rubby:0.10.2": get-ruby
#let ruby = get-ruby(
  size: 0.5em,         // Ruby font size
  dy: 0pt,             // Vertical offset of the ruby
  pos: top,            // Ruby position (top or bottom)
  alignment: "center", // Ruby alignment ("center", "start", "between", "around")
  delimiter: "|",      // The delimiter between words
  auto-spacing: true,  // Automatically add necessary space around words
)

#let Ker = "Ker"
#let Spec = "Spec"
#let ovl(math) = $overline(math)$
#let cong = $tilde.equiv$
#let Max = "Max"
#let Hom = "Hom"
#let ht = "ht"
#let coht = "coht" 
#let tensor = $times.o$
#let gldim = "gl.dim"
#let Der = "Der"
#let Reg = "Reg"
#set math.mat(delim: "[")

#import "@preview/statementsp:0.1.1": *
#show heading: reset-counter(statementnum, levels: 1)
#newstatementsp(
  box-name: "axiom",
  box-display: "Axiom",
  title-color: black,
  box-color: rgb("#FFCCCC")
)
#newstatementsp(
  box-name: "def",
  box-display: "Def",
  title-color: black,
  box-color: rgb("#FFCCCC")
)
#newstatementsp(
  box-name: "th",
  box-display: "Th",
  title-color: black,
  box-color: rgb("#B380FF")
)
#newstatementsp(
  box-name: "prop",
  box-display: "Prop",
  title-color: black,
  box-color: rgb("#CCCCFF")
)
#newstatementsp(
  box-name: "lem",
  box-display: "Lem",
  title-color: black,
  box-color: rgb("#CCCCFF")
)
#newstatementsp(
  box-name: "cor",
  box-display: "Cor",
  title-color: black,
  box-color: rgb("#CCCCFF")
)
#newstatementsp(
  box-name: "rem",
  box-display: "Rem",
  title-color: black,
  box-color: rgb("#FFFF99")
)
#newstatementsp(
  box-name: "ex",
  box-display: "Ex",
  title-color: black,
  box-color: rgb("#CCCCCC")
)
#newstatementsp(
  box-name: "exer",
  box-display: "演習",
  title-color: black,
  box-color: rgb("#CCCCCC")
)

#let pfsp(
  title: "(" + text[$p r o o f$] + ")",
  body
) = [
  #title \ #body #h(1fr) $suit.spade.filled$
]

#title
#author

このノートは松村可換環論 @main の第11章「完備局所環の応用」の内容をまとめたものである．

#figure(
  image("hideyuki-matsumura.jpg", width: 25em),
  caption: [松村 英之 \ https://opc.mfo.de/detail?photo_id=11895&would_like_to_publish=1 より]
)

#pagebreak()

#show outline: set text(fill: blue)
#set outline.entry(
  fill: text(fill: black)[#repeat([$dot$], gap: 0.1em)]
)
#text(font: ("CMU Serif", "Harano Aji Mincho"), size: 2em, weight: "black")[目次#label("outline")]
#columns(3, gutter: 0em)[
  #outline(title: none, indent: 2em)
]

#pagebreak()

#counter(heading).update(30)

= 素イデアル鎖
この章の目標は，主に次のネーター局所環に関する性質のヒエラルキーを知り，理解することである．下に行くほど強い性質であり，unmixed以下はすでに11章以前に書いてある．ちなみにこの図で遊びたい場合は#link("https://q.uiver.app/#r=typst&q=WzAsMTMsWzIsOCwiXCJSTFJcIiJdLFsyLDcsIlwiSFNcIiJdLFsyLDYsIlwiQy5ULlwiIl0sWzIsNSwiXCJHb3JcIiJdLFsyLDQsIlwiQ1RSXCIiXSxbMiwzLCJcIkNNXCIiXSxbMSwzLCJcInVubWl4ZWRcIiJdLFsxLDIsIlwicXVhc2ktdW5taXhlZFwiIl0sWzEsMSwiXCJ1bml2IGNhdGVuYXJ5XCIiXSxbMCwxLCJcImZvcm1hbGx5IGNhdGVuYXJ5XCIiXSxbMiwxLCJcImVxdWkgZGltZW5zaW9uYWxcIiJdLFsxLDAsIlwiY2F0ZW5hcnlcIiJdLFszLDQsIlwibmV3IVwiIl0sWzAsMSwiIiwwLHsibGV2ZWwiOjJ9XSxbMSwyLCIiLDAseyJsZXZlbCI6Mn1dLFsyLDMsIiIsMCx7ImxldmVsIjoyfV0sWzMsNCwiIiwwLHsibGV2ZWwiOjJ9XSxbNCw1LCIiLDAseyJsZXZlbCI6Mn1dLFs2LDUsIlwiVGggMTcuNlwiIiwyLHsibGV2ZWwiOjIsInN0eWxlIjp7InRhaWwiOnsibmFtZSI6ImFycm93aGVhZCJ9fX1dLFs2LDcsIlwiVGggMTcuMlwiIiwyLHsibGV2ZWwiOjJ9XSxbNyw4LCJcIlRoIDMxLjZcIiIsMix7ImxldmVsIjoyfV0sWzcsMTAsIlwiVGggMzEuNlwiIiwyLHsibGV2ZWwiOjJ9XSxbOCw5LCIiLDAseyJsZXZlbCI6Miwic3R5bGUiOnsidGFpbCI6eyJuYW1lIjoiYXJyb3doZWFkIn19fV0sWzgsMTEsIlwiY2xlYXJcIiIsMix7ImxldmVsIjoyfV0sWzEyLDQsIiIsMCx7InNob3J0ZW4iOnsic291cmNlIjoyMCwidGFyZ2V0IjoyMH19XSxbOSw4LCJcIlRoIDMxLjZcIiIsMCx7Im9mZnNldCI6LTMsImxldmVsIjoyfV0sWzgsOSwiXCJUaCAzMS43XCIiLDAseyJvZmZzZXQiOi0zLCJsZXZlbCI6Mn1dXQ==")[ここ]にソースを置いたのでどうぞ．

#v(1em)

#import "@preview/fletcher:0.5.8": *

#align(center, diagram({
	node((3, 5), [$"RLR"$])
	node((3, 4), [$"HS"$])
	node((3, 3), [$"C.I."$])
	node((3, 2), [$"Gor"$])
	node((3, 1), [$"CTR"$])
	node((3, 0), [$"CM"$])
	node((2, 0), [$"unmixed"$])
	node((2, -1), [$"quasi-unmixed"$])
	node((2, -2), [$"universally catenary"$])
	node((1, -2), [$"formally catenary"$])
	node((3, -2), [$"equidimensional"$])
	node((2, -3), [$"catenary"$])
	node((4, 1), [new! @miyazaki])
	edge((3, 5), (3, 4), "=>")
	edge((3, 4), (3, 3), "=>")
	edge((3, 3), (3, 2), "=>")
	edge((3, 2), (3, 1), "=>")
	edge((3, 1), (3, 0), "=>")
	edge((2, 0), (3, 0), [$"Th 17.6"$], label-side: right, "<=>")
	edge((2, 0), (2, -1), [$"Th 17.2"$], label-side: right, "=>")
	edge((2, -1), (2, -2), [#linksp(<th:31.6>)], label-side: right, "=>")
	edge((2, -1), (3, -2), [#linksp(<th:31.6>)], label-side: right, "=>")
	edge((2, -2), (1, -2), "<=>")
	edge((2, -2), (2, -3), [$"clear"$], label-side: right, "=>")
	edge((4, 1), (3, 1), "->")
	edge((1, -2), (2, -2), [#linksp(<th:31.6>)], label-side: left, shift: 0.15, "=>")
	edge((2, -2), (1, -2), [#linksp(<th:31.7>)], label-side: left, shift: 0.15, "=>")
}))#label("diagram")

#v(1em)

本セクションではこのヒエラルキーの，主にunmixedから上のわちゃわちゃした部分を扱う．#text(red)[ただし，これらに触れることが目標であり，詳細な証明に立ち入ると内容が脱線するため，多くの証明は省略することにする．]面倒な部分は適切に飛ばそうということで，テキトーに進むというわけではない．多分．

ちなみに，CMとGorの間に挟まる環を探す試みが最近は主流である．Gorに関してはquasi-Gor, nearly-Gor, almost-Gor, weakly-Gor, approximately-Gorなどが知られていた．しかし，完備化や多項式環との同値性が崩れたり，低次元ではほとんど意味のない概念だったりした．そこで最近CTR環が宮崎先生により発見された．これは結構うまくいっていると思う．

#pagebreak()

#statementsp(
  box-name: "th",
  box-label: "31.1"
)[
  $A$をネーター半局所環とする．(有限個の極大イデアルしか持たないものを半局所環という．) $frak(p)$を素イデアルとする．このとき，次を満たすような素イデアル$frak(p)'$は高々有限個である．
  $
    frak(p) subset frak(p)', quad ht(frak(p)'\/frak(p)) = 1, quad ht(frak(p')) eq.not ht(frak(p)) + 1
  $
]
#pfsp[
  omit
]

catenaryの場合は，この有限個というのが0個を意味することは自明である．catenaryでなくてもこのような，いじわる素イデアルは高々有限個しか存在しないということである．

#statementsp(
  box-name: "th",
  box-title: "Ratliffの弱存在定理",
  box-label: "31.2"
)[
  $A$をネーター環とする．$frak(p) subset P$を素イデアルとする．$ht(p) = h, quad ht(P\/frak(p)) = d > 1$とおく．このとき，つぎのような素イデアル$frak(p)'$が無限に存在する．
  $
    frak(p) subset frak(p)' subset P, quad ht(frak(p)') = h+1, quad ht(P\/frak(p')) = d - 1
  $
]
#pfsp[
  まず，$ht(P\/frak(p)) = d$なので，$P = frak(p)_0 supset.neq frak(p)_1 supset.neq dots.c supset.neq frak(p)_d = frak(p)$という列をとれる．ここで$frak(p)_(d-2) supset frak(p)' supset frak(p), quad ht(frak(p)')=h+1$とすると，$ht(frak(p)_(d-2)) >= h+2$だから$frak(p)_(d-2) supset.neq frak(p)'$が従い，$ht(frak(p)) = h$なので
  $
    frak(p)_0 supset.neq frak(p)_1 supset.neq dots.c supset.neq frak(p)_(d-2) supset.neq frak(p)' supset.neq frak(p)
  $
  は，もはや間に素イデアルを挟めないから，$ht(P\/frak(p')) = d - 1$が従う．ところで，$frak(p)_(d-2)$と$frak(p)$の真の間には$ht(frak(p)'\/frak(p)) = 1$なる素イデアルが無限に存在する．これを示すため，仮に有限個$frak(p)'_1, dots.c, frak(p)'_m$で尽きるとする．$frak(p)_(d-2) supset union.big_(i=1)^(m)frak(p)'_i$であるが，もしイコールならprime avoidanceによって$frak(p)_(d-2) = frak(p)_i$となて矛盾する．よって$a in frak(p)_(d-2) \\ union.big_(i=1)^(m)frak(p)'_i$をとれる．$frak(p) + (a)$の極小素イデアル$frak(p)'_(m+1)$をとると，明らかにどの$frak(p)'_i$とも異なる．単項イデアル定理から$ht(frak(p)'_(m+1)\/frak(p))=1$となり，矛盾である．このような$frak(p)'$は，#linksp(<th:31.1>)によって，有限個を除くほとんどが$ht(frak(p)') =ht(frak(p)) + 1$を満たす．
]

ところで，この定理を使うと次がわかる．

#statementsp(
  box-name: "cor",
  number: false
)[
  $A$を単位的可換環とする．$Spec(A)$が有限集合で$dim(A) >= 2$なら，$A$はネーター環ではない．
]
#pfsp[
  $dim(A) >= 2$で$Spec(A)$が有限集合だから，$frak(p) subset P$という素イデアルで$ht(frak(p))=0, quad, ht(P\/frak(p)) = 2$なるものがある．そこで，#linksp(<th:31.2>)を適用すると，無限に素イデアルが存在することになる．矛盾．
]

特に，2次元以上の付値環はネーター環ではないことがわかる．(無限次元の場合には，単に極大イデアルの高さがもはや有限ではないのだから，標高定理からネーター環ではないことがわかる．)

次の補題1は（私の観測史上では）使っていないので省略する．

また，次の定理は松村では整域を課しているが，証明を見る限り整域である必要はなさそうである．さらに，同じことを思ったのか#link("https://users.math.msu.edu/users/rotthaus/teaching/math991/lectnotes991/ch14.pdf")[このPDF]でも整域という条件はしれっと外している．

#statementsp(
  box-name: "th",
  box-title: "Ratliffの強存在定理",
  box-label: "31.3",
  number: true
)[
  $A$をネーター環とする．$frak(p) subset P$を素イデアルとして，$ht(frak(p)) = h > 0, quad, ht(P\/frak(p)) = d > 0$ とする．このとき$0 <= i < d$をみたす各$i$に対し次の集合は無限集合である．
  $
    { frak(p)' in Spec(frak(p)') mid(|) frak(p)' subset P, quad ht(P\/frak(p)') = d - i, quad ht frak(p)' = h+i}
  $
]
#pfsp[
  omit
]

#statementsp(
  box-name: "th",
  box-title: "",
  box-label: "31.4",
  number: true
)[
  $(A, frak(m))$をネーター局所整域とする．このとき$A$がcatenaryであることと，すべての素イデアル$frak(p)$に対し，$ht(frak(p)) + coht(frak(p)) = dim(A)$を満たすことは同値である．
]
#pfsp[
  omit
]

ちなみに上の定理で整域としているのは，$(0)$がただ一つの極小素イデアルであることを使いたいからである．一般にネーター局所環では複数の極小素イデアルがあるが，どの極小素イデアルを選ぶかでcohtが変わってしまうかもしれない．それがすべて一致していたらうれしいわけである．そこで次の定義が出てくる．

#statementsp(
  box-name: "def",
  number: false
)[
  $dim(A) < infinity$なる環$A$に対して，すべての極小素イデアル$frak(p)$が$dim(A\/frak(p)) = dim(A)$をみたすとき，$A$は*equidimensional*であるという．
]

次の補題 2も使っていない気がするので省略する．

#statementsp(
  box-name: "th",
  box-title: "",
  box-label: "31.5",
  number: true
)[
  $A,B$をネーター局所環．$A -> B$を局所環の射とする．$B$が$A$上flatでequidimensionalでcatenaryであれば，$A$もそうである．さらに$forall frak(p) in Spec(A)$に対して$B\/frak(p)B$もequidimensionalである．
]
#pfsp[
  omit
]

証明では同書籍の定理15.1を使うのでそちらも参照されたい．

ところで，局所環の射がflatならば自動的にfaithfully flatである．(定理 7.3)したがって上の定理ではfaithfully flatを想定することになる．一般にfaithfully flat $A -> B$において，$B$が持つ性質が$A$にも伝播するとき，その性質はdescentするという．例えばネーター性は忠実平坦降下，faithfully flat descentする．上の定理はequidimensionalityとcatenary性がfaithfully flat descentすることを言っている．

#statementsp(
  box-name: "cor",
  box-title: "",
  number: false
)[
  $A$は正則局所環$R$の準同型像である局所環とする．このとき完備化$A^*$がequidimensionalならば，$A$もequidimensionalである．
]
#pfsp[
  omit
]

上の系でネーター性は勝手についてくるのでわざわざ述べていない．また，この系から次の定義が出てくる．

#statementsp(
  box-name: "def",
  number: false
)[
  ネーター局所環$A$において，完備化$A^*$がequidimensionalならば，$A$は*quasi-unmixed*であるという．
]

ちなみにquasi-unmixedは別名formally equidimensionalである．この名称からしてunmixedならばquasi-unmixedであることが期待される．unmixedというのはCM環であることと同値なので（定理 17.6）CM環はquasi-unmixedか？という話である．CM環は完備化してもCM環なので，CM環がequidimensionalであることを示せれば，unmixedならばquasi-unmixedであることが従う．これは定理 17.3の(i)で述べられている．

冒頭のヒエラルキーの正当化に大きくかかわるのが次の定理である．

#statementsp(
  box-name: "th",
  box-title: "",
  box-label: "31.6",
  number: true
)[
  $(A,frak(m))$をquasi-unmixedなネーター局所環とする．このとき次が成り立つ．
  
  #enum(
    numbering: "i)",
    enum.item(1)[$forall frak(p) in Spec(A)$に対して$A_(frak(p))$もquasi-unmixedである．],
    enum.item(2)[$A$のイデアル$I$に対して$A\/I$がequidimensionalであることとquasi-unmixedであることは同値である．],
    enum.item(3)[$B$がessentially of finite type over $A$である局所環でequidimensionalであれば，$B$もquasi-unmixedである．],
    enum.item(4)[$A$はuniversally catenaryである．]
    )
]
#pfsp[
  omit
]

essentially of finite type over $A$とは，$A$上有限生成な可換環の局所化であることを言う．例えば明らかなことだが，多項式環$A[x_1, dots, x_n]$の任意の極大イデアルで局所化したものはessentially of finite type over $A$である．

ところで，EGAにはquasi-unmixedを用いて，次のformally catenaryの概念が導入された．

#statementsp(
  box-name: "def",
  number: false
)[
  ネーター局所環$A$に対して，すべての素イデアル$frak(p)$に対して$A\/frak(p)$がquasi-unmixedならば，$A$は*formally catenary*であるという．
]

formally catenaryならばuniversally catenaryであることは，次のようにして示せる．
#becausebox[
  次を示せばいい．
  $
    forall frak(p) in min(A), A\/frak(p): "universally catenary" <==> A: "universally catenary"
  $
  $<==$は自明．$==>$について示す．$S$を$A$上有限生成な代数とする．任意の$S$の極小素イデアル$frak(q)$に対して$S\/frak(q)$がcatenaryなこと示せばいい．$frak(q) inter A supset frak(p)$となる$A$の極小素イデアル$frak(p)$をとる．すると，剰余環の普遍性により次の可換図式を得る．
  #align(center, diagram({
	node((-1, -1), [$A[X]$])
	node((1, -1), [$S\/frak(q)$])
	node((0, 0), [$A\/frak(p)[X]$])
	edge((-1, -1), (1, -1), "->>")
	edge((-1, -1), (0, 0), "->>")
	edge((0, 0), (1, -1), "-->")
  }))
  （図のソースは#link("https://q.uiver.app/#r=typst&q=WzAsMyxbMCwwLCJBW1hdIl0sWzIsMCwiU1xcL2ZyYWsocSkiXSxbMSwxLCJBXFwvZnJhayhwKVtYXSJdLFswLDEsIiIsMCx7InN0eWxlIjp7ImhlYWQiOnsibmFtZSI6ImVwaSJ9fX1dLFswLDIsIiIsMix7InN0eWxlIjp7ImhlYWQiOnsibmFtZSI6ImVwaSJ9fX1dLFsyLDEsIiIsMix7InN0eWxlIjp7ImJvZHkiOnsibmFtZSI6ImRhc2hlZCJ9fX1dLFszLDIsImFycm93LmNjdyIsMSx7InNob3J0ZW4iOnsic291cmNlIjoyMH0sImxldmVsIjoxLCJzdHlsZSI6eyJib2R5Ijp7Im5hbWUiOiJub25lIn0sImhlYWQiOnsibmFtZSI6Im5vbmUifX19XV0=")[こちら]）
  ゆえに$S$はcatenaryである．
]

しかし，EGAでこの概念を導入後，Ratliffがこの逆も成立することを示した．すなわち，次が成り立つ．

#statementsp(
  box-name: "th",
  box-title: "",
  box-label: "31.7",
  number: true
)[
  ネーター局所環$A$がuniversally catenaryであることとformally catenaryであることは同値である．
]
#pfsp[
  omit
]

ここでいまいちど#link(<diagram>)[冒頭のヒエラルキー]に戻って鑑賞すると面白い．

#pagebreak()

= 形式的ファイバー
本節では，geometrically regularやG-ring，Excellent ringの概念に触れる．これらは様々な可換環論的な性質が，可換環論的な操作において，ほどよく遺伝することが明らかになる．

まず，一般に環準同型 $phi colon A -> B$ に対して， $Spec(phi) colon Spec(B) -> Spec(A)$ が誘導される．このとき，$frak(p) in Spec(A)$に対して，そのファイバー$Spec(phi)^(-1)(frak(p))$を考える．$Spec(phi)^(-1)(frak(p)) = Spec(C)$となるような環を構成できるだろうか？答えはYesであり，それは$C = B tensor_A kappa(frak(p))$である．ここで$kappa(frak(p)) = A_frak(p)\/frak(p)A_frak(p)$で剰余体である．この$C$をファイバー環という．\
なぜ$C$をこのようにとるのか簡単に説明する．
#becausebox[
  次の同型変形ができる．ただし$S = phi(A \\ frak(p))$は$B$の積閉集合である．
  $
    C &= B tensor_A kappa(frak(p)) \
      &= B tensor_A (A_frak(p)\/frak(p)A_frak(p)) \
      &= S^(-1)B\/frak(p)S^(-1)B \
      &= S^(-1)B \/ frak(p)S^(-1)B
  $
  ゆえに$P in Spec(C)$は$frak(p)S^(-1)B subset P$なる$S^(-1)B$の素イデアルに対応し，この$P$は$frak(p)B subset P$かつ$P inter S = emptyset$なる$B$の素イデアルに対応する．このような$B$の素イデアルは$A$に引き戻すと$frak(p) subset phi(P)$かつ$phi^(-1)(P) inter (A \\ frak(p)) = emptyset$となる．これを整理すると，$phi^(-1)(P) = frak(p)$となる．逆にこのような$B$の素イデアルは，逆をたどれば$C$の素イデアルに対応すると分かる．したがって，$Spec(C)$の素イデアルはちょうど$Spec(phi)^(-1)(frak(p))$なる素イデアルに対応する．上の同型はすべて対応するアフィンスキームの位相同型をも与えるので，$Spec(C) = Spec(phi)^(-1)(frak(p))$は位相同型でもある．
]

特に，ネーター局所環$(A,frak(m))$に対して完備化に関する自然な射$A -> A^*$のファイバー環のことを*形式的ファイバー*という．各素イデアルにおけるファイバー環がどうなっているかを調べることで，問題を分割することができるというイメージだろうか．

#statementsp(
  box-name: "def",
  number: false
)[
  可換環に対する条件を$PP$と書くことにする．例えば$PP$:regular，CM, Gorenstein, reducedなど． \ 
  ネーター環$A$と$k subset A$: 部分体に対して，任意の有限次拡大$k'\/k$に対しても$A tensor_k k'$が，$PP$を持つとき，$A$は$k$上に*geometrically $PP$*であるという． 例えば$PP = $regularのとき，$A$は$k$上に*geometrically regular*であるという．
]

ちなみに，このとき$A tensor_k k' = A tensor_k k[alpha_1, dots, alpha_n] = A[alpha_1, dots, alpha_n]$なので，$A tensor_k k'$はネーター環である．また，$k'=k$としてもいいのだから，$A$において geometrically $PP$ならば$PP$である．

このノートでは，geometrically regularに注目する．geometrically reducedものちに紹介する西村純一の結果@nishimura の中に出てくる．西村純一は松村可換環論のKrull環の節の最後にも結果が残されている．

#statementsp(
  box-name: "prop",
  number: false
)[
  $k subset A$をネーター環とその部分体とする．次は同値である．
  #enum(
    numbering: "i)",
    enum.item(1)[$A$は$k$上にgeometrically regularである．],
    enum.item(2)[$forall frak(p) in Spec(A)$に対して，$A_frak(p)$は$k$上にgeometrically regularである．],
    enum.item(3)[$forall frak(m) in Max(A)$に対して，$A_frak(m)$は$k$上にgeometrically regularである．]
  )
  ただし，$k -> A -> A_frak(p)$という標準的な射によって$k$を$A_frak(p)$の部分体とみなす．
]
#pfsp[
  (i) $==>$ (ii): $k'\/k$を任意の有限次拡大とする．
  $
    A_frak(p) tensor k' = A_frak(p) tensor_A A tensor_k k' = A_frak(p) tensor_A (A tensor_k k')
  $
  であり，正則環の局所化で表せるので$A_frak(p) tensor k'$も正則．\ 
  (ii) $==>$ (iii): 自明．\
  (iii) $==>$ (i): $A -> A tensor_k k' = A[alpha_1, dots, alpha_n]$は整拡大である．よって任意の$frak(n) in Max(A tensor_k k')$に対して$frak(m) = frak(n) inter A in Max(A)$である．ここで$exists t in (A \\ frak(m)) inter frak(n)$とすると，$frak(m)(A tensor_k k') subset frak(n)$なので矛盾する．ゆえに$frak(n)$は$A_frak(m) tensor_A A tensor_k k'$の素イデアルと対応する．$A_frak(m) tensor_A A tensor_k k' = A_frak(m) tensor_k k'$は正則環なので，その局所化である$(A tensor_k k')_frak(n)$も正則である．$frak(n)$は任意だったから，$A tensor_k k'$は正則である．
]

次に射に対するregularityの概念などを導入し，G-ringの定義を行う．

#statementsp(
  box-name: "def",
  number: false
)[
  $phi colon A -> B$をネーター環の射とする．また，環に対する条件$PP$を考える． 

  $phi$が$PP$であるとは，任意の$frak(p) in Spec(A)$に対して，$B tensor_A kappa(frak(p))$が体$kappa(frak(p))$上にgeometrically $PP$であるときを言う．特に，$PP = $regularのとき，$phi$は*regular*であるという．

  $A$が*G-ring*であるとは，任意の$frak(p) in Spec(A)$に対して，完備化の射$A_frak(p) -> A_frak(p)^*$がregularであるときを言う．
]

複雑でわかりにくいので，射がregularであることの定義をまとめてみると次のようになる．

ネーター環の射$A -> B$がregularであるとは，任意の素イデアル$frak(p) in Spec(A)$と，任意の有限次拡大$k'\/kappa(frak(p))$に対して，$B tensor_A k'$が regularであることを言う．

今述べた形で理解する．

ところで，geometrically regularや射のregularityは，schemeのレベルで定義される．これによればスキームの射がsmoothならばregularである．@stacks-project[07R9]

さて，#linksp(<th:32.1>)を示すときに@main では定理 23.7を用いるとある．しかしこれはネーター局所環に対する定理であり，局所環を外した場合に成立するかはわからない．そこで次の補題を用意し，，これを使って#linksp(<th:32.1>)を示す．\ 
ちなみに次の補題は#linksp(<th:32.2>)における正則環に関する主張の一般化でもある．

#v(1em)

#statementsp(
  box-name: "lem",
  box-title: "",
  box-label: "",
  number: false
)[
  $phi colon A -> B$がregularとする．このとき，$A$がregularならば$B$もregularである．
]
#pfsp[
  $forall P in Spec(B)$をとり，$B_P$が正則なことを示せばいい．$frak(p) = P inter A$として，$tilde(phi) colon A_frak(p) -> B_P$というflatな局所環の射が誘導されることが簡単な普遍性の議論などによってわかる．この$tilde(phi)$もregularであることを示す．$frak(q) in Spec(A_frak(p))$を任意にとって$K\/kappa(frak(q))$を任意の有限次拡大とする．$S = B \\ P$とすれば
  $
    B_P tensor_(A_frak(p)) K &= S^(-1)(B_frak(p)) tensor_(A_frak(p)) K \
      &= (S^(-1)B)_frak(p) tensor_(A_frak(p)) K \
      &= S^(-1)(B tensor_A K) \ 
      &= S^(-1)B tensor_A A_frak(p) tensor_(A_frak(p)) K \
      &= S^(-1)B tensor_A K \
      &= S^(-1)B tensor_B (B tensor_A K)
  $
  となるが，$phi$はregularなので$B tensor_A K$は正則であり，正則間の局所化だから$B_P tensor_(A_frak(p)) K$も正則である．ゆえに$tilde(phi)$はregularである．したがって，主張はネーター局所環の射である場合に示せばいい．すると，いま，$phi colon A -> B$はflatでAが正則，さらに（$frak(m)$を$A$の極大イデアルとして）$B\/frak(m)B = B tensor_A A\/frak(m) = B tensor_A kappa(frak(m))$より，これは$phi$の正則性によって正則環．ゆえに定理 23.7から$B$も正則である．
]

#statementsp(
  box-name: "th",
  box-title: "",
  box-label: "32.1",
  number: true
)[
  $A stretch(-->)^(phi) B stretch(-->)^(psi) C$をネーター環の射とする．

  #enum(
    numbering: "i)",
    enum.item(1)[もし$phi$と$psi$がregularならば，$psi compose phi$もregularである．],
    enum.item(2)[もし$psi compose phi$がregularで，かつ$psi$がfaithfully flatならば，$phi$もregularである．]
  )
]
#pfsp[
  (i) めんどくさいので補足にとどめる．最後に$phi_L colon B_L -> C_L$という正則な射で$B_L$が正則環であることがわかる．ここで前の補題を用いて$C_L$が正則なことを示すことで証明が終了する．\ 
  (ii) $phi$がflatなのは@main の3章の初めの方に書いてあることを用いればよい．$forall frak(p) in Spec(A)$をとり，$L\/kappa(frak(p))$を有限次拡大とする．$B_L = B tensor_A L$が正則なことを示す．$C_L = C tensor_A L$は仮定から正則となり，$B_L -> C_L$はfaithfully flatなので，$B_L$も正則である．
]

最後に用いた，$A -> B$がfaithfully flatで$B$が正則ならば$A$も正則であるという事実を一応示しておく．

#becausebox[
  $forall frak(p) in Spec(A)$をとり，$A_frak(p)$が正則であることを示せばいい．忠実平坦性から，とある$P in Spec(B)$をとって$P inter A = frak(p)$となる．ゆえに$A_frak(p) -> B_P$という平坦な局所環の射が誘導される．これは局所環の射なので忠実平坦でもある．ゆえに，もとから局所環の射だったとしてよい．$gldim(A) < infinity$を示せばいい．任意の$A$加群$M$をとる．
  $
    dots.c --> P_1 --> P_0 --> M --> 0
  $
  を，$M$の射影分解とする．$P$たちは局所環$A$上の射影加群だから自由加群である．これに$tensor_A B$をすると，忠実平坦性と$P$が自由加群であることから
  $
    dots.c --> P_1 tensor_A B --> P_0 tensor_A B --> M tensor_A B --> 0
  $
  は$M tensor_A B$の射影分解になる．$B$は正則局所環なので$gldim(B) < infinity$である．したがって，十分大きい任意の$i$に対して$P_i tensor_A B = 0$である．忠実平坦性から$P_i = 0$である．ゆえに射影分解は有限であったから$"proj.dim"(M) < infinity$であり，ゆえに$gldim(A) < infinity$である．
]

Serreの定理はすごい．

忠実平坦やregularな射を仮定すると，正則関係の環（正則環，CM環など）に対して良い性質が伝播することがわかる．

#statementsp(
  box-name: "th",
  box-title: "",
  box-label: "32.2",
  number: true
)[
  $phi colon A -> B$をネーター環の射で，忠実平坦かつregularであるとする．

  #enum(
    numbering: "i)",
    enum.item(1)[$A$が正則環（またはreduced, Gorenstein, CTR, CM環）であることと，$B$が同じ性質を持つことは同値である．],
    enum.item(2)[$B$がG-ringならば，$A$もG-ringである．(逆は成立しない．)]
  )
]
#pfsp[
  (i) CTR環以外については，@main の§23の定理などからわかる．CTR環について示す．局所環の射に帰着できる．@miyazaki[Proposition 3.5]によって$B$がCTRならば$A$もCTRである．逆に$A$がCTRならば，同じく@miyazaki[Proposition 3.5]によって，$forall frak(p) in min{tr_R (omega_R)}$に対して$kappa(frak(p)) tensor_A B$がreducedなことを示せばいい．しかし，$phi$はregularなので，$kappa(frak(p)) tensor_A B$はregularであり，特にreducedである．\
  (ii) $forall frak(p) in Spec(A)$に対して$A_frak(p) -> (A_frak(p))^*$がregularなことを示す．$frak(p)$の上にある$B$の素イデアルを$P$とする．すると，次の可換図式が得られる．
  #align(center, diagram({
	node((-1, -1), [$(A_frak(p))^*$])
	node((-1, 0), [$A_frak(p)$])
	node((0, 0), [$B_P$])
	node((0, -1), [$(B_P)^*$])
	edge((-1, 0), (-1, -1), [$alpha$], label-side: left, "->")
	edge((-1, 0), (0, 0), [$f$], label-side: left, "->")
	edge((0, 0), (0, -1), [$beta$], label-side: right, "->")
	edge((-1, -1), (0, -1), [$f^*$], label-side: left, "->")
  }))
  図式のソースは#link("https://q.uiver.app/#r=typst&q=WzAsNCxbMCwwLCIoQV9mcmFrKHApKV4qIl0sWzAsMSwiQV9mcmFrKHApIl0sWzEsMSwiQl9QIl0sWzEsMCwiKEJfUCleKiJdLFsxLDAsImFscGhhIl0sWzEsMiwiZiJdLFsyLDMsImJldGEiLDJdLFswLDMsImZeKiJdXQ==")[こちら]．あとは#linksp(<th:32.1>)によって$alpha$がregularなことがわかる．
]

#statementsp(
  box-name: "th",
  box-title: "",
  box-label: "32.3",
  number: true
)[
  完備ネーター局所環はG-ringである．
]
#pfsp[
  omit
]

#statementsp(
  box-name: "th",
  box-title: "",
  box-label: "32.4",
  number: true
)[
  $A$をネーター環とする．$A$のすべての極大イデアル$frak(m)$に対して$A_frak(m) -> (A_frak(m))^*$がregularならば，$A$はG-ringである．
]
#pfsp[
  #linksp(<th:32.3>)により，$(A_frak(m))^*$はG-ringである．#linksp(<th:32.2>) (ii)より，$A_frak(m)$もG-ringである．任意の素イデアル$frak(p)$に対して，とある極大イデアル$frak(m) supset frak(p)$が存在するから，$A$はG-ringであることの定義を満たす．
]

次の二つは，環がG-ringであることの判定に使える．

#statementsp(
  box-name: "th",
  box-title: "",
  box-label: "32.5",
  number: true
)[
  $A$をネーター環とする．次は同値である．

  #enum(
    numbering: "i)",
    enum.item(1)[$A$はG-ringである．],
    enum.item(2)[$C$を有限$A$-代数で整域であるとし，$frak(m)$を$C$の極大イデアルとする．$B=C_frak(m), Q in Spec(B^*), Q inter B = 0$ならば$(B^*)_Q$は正則局所環である．]
  )
]
#pfsp[
  omit
]

#statementsp(
  box-name: "th",
  box-title: "水谷 博之",
  box-label: "32.6",
  number: true
)[
  $R$を正則とする．$forall n >= 0$に対して，$R[x_1,dots,x_n]$で(WJ)が成立すれば，$R$はG-ringである．
]
#pfsp[
  omit
]

最後の(WJ)について説明しよう．これはWeak Jacobian condition の略であり，正則環$R$に関する次の条件を言う．

(WJ): 任意の素イデアル$P in Spec(R)$で$ht(P) = r$なるものに対して，$D_1,dots, D_r in Der(R), f_1,dots, f_r in P$が存在して，$det(D_i (f_j)) in.not P$となる．

$Der(R)$は$R$からそれ自身へのderivation全体である．微分作用素みたいなもの．ちなみにこのとき，$R_p$は$dim(R_P) = r$なる正則局所環だが，$f_1, dots, f_r$は，その正則巴系である．(定理 30.4)

これらと§30の話をまとめることで，次の系を得る．

#statementsp(
  box-name: "cor",
  box-title: "",
  number: false
)[
  体上有限生成代数，本質的に有限生成代数な環はG-ringである．
]
#pfsp[
  omit
]

$k[x_1, dots, x_n]$に対して(WJ)が成立することについて触れてみよう．例えば極大イデアル$frak(m) = (x_1, dots, x_n)$と，$(partial)/(partial x_1), dots, (partial)/(partial x_n) in Der(k[x_1, dots, x_n])$と，$x_1, dots, x_n in frak(m)$に対して
$
  det((partial)/(partial x_i)(x_j)) = 1 in.not frak(m)
$
となり，たしかに$frak(m)$においては(WJ)が成立する．$k[x_1, dots, x_n]$に対して(WJ)が成立していることをいうためには，初めの素イデアル$frak(m)$を様々取り換えていかなければならない．これをやっているのが§30なのである．

ところで，#linksp(<th:32.6>)にはタイトルとして水谷 博之をあげている．彼について調べてみたが，論文が一本あるのみ@mizutani で，他の情報がほぼない．これほど立派な戦績を挙げていて消息不明なのは不思議である．

上の系は，実はそれより強いことが成り立つ．

#statementsp(
  box-name: "th",
  box-title: "Grothendieck",
  box-label: "32.7",
  number: true
)[
  $A$がG-ringならば，その上の一変数多項式環$A[x]$もG-ringである．
]
#pfsp[
  omit
]

証明は@matsumuracomalg[Theorem 77]にあるが，かなり難しい．(到達するまでの準備が長そう．)

G-ringの準同型像や局所化はG-ringであるので，これによってG-ring $A$上の有限生成代数，本質的に有限生成代数もG-ringであることが従う．

さて，#linksp(<th:32.7>)と類似の定理がべき級数でも成り立つかが気になる．すなわち，$A$がG-ringならば，$A[[x]]$もG-ringであるか？である．なんとこれは一般には成立しない．

1979年，Rotthausによって$A$が半局所環であるようなG-ringならば$A[[x]]$もG-ringであることを示した．@rotthaus \
1980年，松村可換環論初版出版．松村英之は著書の中で上述のRotthausの結果を紹介し，$A$が一般の場合も正しいのではないかと綴った．\ 
1981年，西村純一が$A$が一般の場合には反例があることを報告．@nishimura[5.~Example]

という流れのようである．西村が論文を提出したのはもう少し前なので，松村が初版を書いているときに，西村が反例を絶賛構成中であった可能性もある．ずいぶんタイムリーな話題だったのだろう．

西村の反例について，詳しくは元論文を見ていただきたいが，大雑把に説明する．まず西村はとある1次元ネーター整域$R$であってG-ringであるものを構成する．#linksp(<th:32.7>)によって一変数多項式環$R[t]$もG-ringである．しかし，これをイデアル$I = t R$で完備化して$R[[t]]$をとると，それまでに述べた定理から$R[[t]]$がN-ringではありえないことを述べる．ここに，N-ringとは，任意の素イデアル$frak(p)$に対して，完備化の射$A_frak(p) -> A_frak(p)^*$がreducedであることをいう．（G-ringのreduced バージョン．）regular ならば reduced なので，G-ringならばN-ringである．ゆえに，$R[[t]]$はG-ringではないことがわかる．

これより，西村の反例はG-ringの完備化がG-ringであるとは限らないことも与えている．

さて，§24に書いてあるが，以下について考える．

$PP$を局所環に対する条件とする．例えば，$PP$ = regular, CM, Gorenstein, reduced など．環$A$に対して$PP(A) = {frak(p) in Spec(A) mid(|) A_frak(p) #text[は] PP #text[を満たす]}$とおく．$PP$が正則局所環を表すときは特に，これを$Reg(A)$とかく．

#statementsp(
  box-name: "def",
  box-title: "",
  box-label: "",
  number: false
)[
  ネーター環$A$が次の三つを満たすとき，$A$は*Excellent ring*であるという．

  #enum(
    numbering: "i)",
    enum.item(1)[$A$はuniversally catenaryである．],
    enum.item(2)[$A$はG-ringである．],
    enum.item(3)[すべての有限$A$-代数$B$に対して，$Reg(B)$は$Spec(B)$の開集合である．]
  )
]

後ろの二つだけを満たすならば，$A$は*quasi-excellent ring*であるという．これらの条件はどれも局所化，有限生成代数をとる操作で閉じている．多分局所環ならばべき級数や完備化をとっても許されると思う．

応用上，考えつくような環は上の三つをたいてい満たしているので，冒頭に述べた「様々な可換環論的な性質が，可換環論的な操作において，ほどよく遺伝する」というのはそういうことだ．

#pagebreak()

#bibliography(
  "ref.bib"
)