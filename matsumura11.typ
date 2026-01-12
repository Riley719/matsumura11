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

このノートは松村可換環論第11章「完備局所環の応用」の内容をまとめたものである．

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
この章の目標は，主に次のネーター局所環に関する性質のヒエラルキーを知り，理解することである．下に行くほど強い性質であり，unmixed以下はすでに11章以前に書いてある．

#v(3em)

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
	node((2, -2), [$"univ catenary"$])
	node((1, -2), [$"formally catenary"$])
	node((3, -2), [$"equi dimensional"$])
	node((2, -3), [$"catenary"$])
	node((4, 1), [#link("https://arxiv.org/pdf/2506.17987")[#arxiv-icon() new!]])
	edge((3, 5), (3, 4), "=>")
	edge((3, 4), (3, 3), "=>")
	edge((3, 3), (3, 2), "=>")
	edge((3, 2), (3, 1), "=>")
	edge((3, 1), (3, 0), "=>")
	edge((2, 0), (3, 0), [$"Th 17.6"$], label-side: right, "<=>")
	edge((2, 0), (2, -1), [$"Th 17.2"$], label-side: right, "=>")
	edge((2, -1), (2, -2), [$"Th 31.6"$], label-side: right, "=>")
	edge((2, -1), (3, -2), [$"Th 31.6"$], label-side: right, "=>")
	edge((2, -2), (1, -2), "<=>")
	edge((2, -2), (2, -3), [$"clear"$], label-side: right, "=>")
	edge((4, 1), (3, 1), "->")
	edge((1, -2), (2, -2), [$"Th 31.6"$], label-side: left, shift: 0.15, "=>")
	edge((2, -2), (1, -2), [$"Th 31.7"$], label-side: left, shift: 0.15, "=>")
}))

本セクションではこのヒエラルキーの，主にunmixedから上のわちゃわちゃした部分を扱う．#text(red)[ただし，これらに触れることが目標であり，詳細な証明に立ち入ると内容が脱線するため，多くの証明は省略することにする．]面倒な部分は適切に飛ばそうということで，テキトーに進むというわけではない．多分．

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