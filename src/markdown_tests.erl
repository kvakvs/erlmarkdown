unit_test_() -> 
    [
     ?_assert(conv("![login](_underscore)") == "<p><img src=\"_underscore\" alt=\"login\" title=\"\" /></p>"),
     ?_assert(conv("[login](_underscore)") == "<p><a href=\"_underscore\">login</a></p>"),
     ?_assert(conv("    alice\n    bob\nchaz") == "<pre><code>alice\nbob\n</code></pre>\n\n<p>chaz</p>"),
     ?_assert(conv("> alice\n> bob\n> chaz") == "<blockquote>\n  <p>alice\n  bob\n  chaz</p>\n</blockquote>"),
     ?_assert(conv(" - a\n - b\n") == "<ul>\n<li>a</li>\n<li>b</li>\n</ul>"),
     ?_assert(conv(" 1. a\n 2. b\n") == "<ol>\n<li>a</li>\n<li>b</li>\n</ol>"),
     ?_assert(conv("blah ![blah][1] blah\n\n\n  [1]: http://example.com (title)") == "<p>blah <img src=\"http://example.com\" alt=\"blah\" title=\"title\" /> blah</p>"),
     ?_assert(conv("blah ![blah][1] blah\n\n\n  [1]: http://example.com \"title\"") == "<p>blah <img src=\"http://example.com\" alt=\"blah\" title=\"title\" /> blah</p>"),
     ?_assert(conv("blah ![blah][1] blah\n\n\n  [1]: http://example.com") == "<p>blah <img src=\"http://example.com\" alt=\"blah\" title=\"\" /> blah</p>"),
     ?_assert(conv("Now is the winter of `our discontent` made glorious summer by this Son of York") == "<p>Now is the winter of <code>our discontent</code> made glorious summer by this Son of York</p>"),
     ?_assert(conv("blah [blah][1] blah\n\n\n  [1]: http://example.com (title)") == "<p>blah <a href=\"http://example.com\" title=\"title\">blah</a> blah</p>"),
     ?_assert(conv("blah [blah][1] blah\n\n\n  [1]: http://example.com \"title\"") == "<p>blah <a href=\"http://example.com\" title=\"title\">blah</a> blah</p>"),
     ?_assert(conv("blah [blah][1] blah\n\n\n  [1]: http://example.com") == "<p>blah <a href=\"http://example.com\">blah</a> blah</p>"),
     ?_assert(conv("> blah\n-------------") == "<h2>> blah</h2>"),
     ?_assert(conv("  \n") == ""),
     ?_assert(conv("![alt text][1]\n\n[1]: http://example.com") == "<p><img src=\"http://example.com\" alt=\"alt text\" title=\"\" /></p>"),
     ?_assert(conv("![alt text][1]\n\n[1]: http://example.com \"optional title\"") == "<p><img src=\"http://example.com\" alt=\"alt text\" title=\"optional title\" /></p>"),
     ?_assert(conv("[link text][1]\n\n[1]: http://example.com") == "<p><a href=\"http://example.com\">link text</a></p>"),
     ?_assert(conv("[link text][1]\n\n[1]: http://example.com \"optional title\"") == "<p><a href=\"http://example.com\" title=\"optional title\">link text</a></p>"),
     ?_assert(conv("blah\n\n\nbleh") == "<p>blah</p>\n\n<p>bleh</p>"),
     ?_assert(conv("`<div>blah</div>`") == "<p><code>&lt;div&gt;blah&lt;/div&gt;</code></p>"),
     ?_assert(conv("My [link][id] test\n[id]: http://example.com") == "<p>My <a href=\"http://example.com\">link</a> test</p>"),
     ?_assert(conv("My [id] test\n[id]: http://example.com") == "<p>My <a href=\"http://example.com\">id</a> test</p>"),
     ?_assert(conv("blah <https://something.com:1234/a/path> blah\na") == "<p>blah <a href=\"https://something.com:1234/a/path\">https://something.com:1234/a/path</a> blah\na</p>"),
     ?_assert(conv("blah <http://something.com:1234/a/path> blah\na") == "<p>blah <a href=\"http://something.com:1234/a/path\">http://something.com:1234/a/path</a> blah\na</p>"),
     ?_assert(conv("[id]: /a/path\nSome text ![hey] [id] there\na") == "<p>Some text <img src=\"/a/path\" alt=\"hey\" title=\"\" /> there\na</p>"),
     ?_assert(conv("[id]: /a/path\nSome text ![hey][id] there\na") == "<p>Some text <img src=\"/a/path\" alt=\"hey\" title=\"\" /> there\na</p>"),
     ?_assert(conv("[id]:   \t \t   /a/path\nSome text [hey][id] there\na") == "<p>Some text <a href=\"/a/path\">hey</a> there\na</p>"),
     ?_assert(conv("[id]: /a/path\nSome text \\[id] there\na") == "<p>Some text [id] there\na</p>"),
     ?_assert(conv("[id]: /a/path\nSome text [hey] [id] there\na") == "<p>Some text <a href=\"/a/path\">hey</a> there\na</p>"),
     ?_assert(conv("[id]: /a/path\nSome text [hey][id] there\na") == "<p>Some text <a href=\"/a/path\">hey</a> there\na</p>"),
     ?_assert(conv("an ![](path/jpg.jpg ) image\na") == "<p>an <img src=\"path/jpg.jpg\" alt=\"\" title=\"\" /> image\na</p>"),
     ?_assert(conv("an ![Alt](path/jpg.jpg ) image\na") == "<p>an <img src=\"path/jpg.jpg\" alt=\"Alt\" title=\"\" /> image\na</p>"),
     ?_assert(conv("an ![Alt](path/jpg.jpg 'Title') image\na") == "<p>an <img src=\"path/jpg.jpg\" alt=\"Alt\" title=\"Title\" /> image\na</p>"),
     ?_assert(conv("an ![Alt](path/jpg.jpg \"Title\") image\na") == "<p>an <img src=\"path/jpg.jpg\" alt=\"Alt\" title=\"Title\" /> image\na</p>"),
     ?_assert(conv("an ![Alt] (path/jpg.jpg \"Title\") image\na") == "<p>an <img src=\"path/jpg.jpg\" alt=\"Alt\" title=\"Title\" /> image\na</p>"),
     ?_assert(conv("An [example](http://example.com/) of link\na") == "<p>An <a href=\"http://example.com/\">example</a> of link\na</p>"),
     ?_assert(conv("An [](http://example.com/ \"Title\") of link\na") == "<p>An <a href=\"http://example.com/\" title=\"Title\"></a> of link\na</p>"),
     ?_assert(conv("An [example](http://example.com/ 'Title') of link\na") == "<p>An <a href=\"http://example.com/\" title=\"Title\">example</a> of link\na</p>"),
     ?_assert(conv("An [example](http://example.com/ \"Title\") of link\na") == "<p>An <a href=\"http://example.com/\" title=\"Title\">example</a> of link\na</p>"),
     ?_assert(conv("An [example] (http://example.com/ \"Title\") of link\na") == "<p>An [example] (http://example.com/ \"Title\") of link\na</p>"),
     ?_assert(conv("a\na\n   [id]: /example.com") == "<p>a\na</p>"),
     ?_assert(conv("a\na\n   [id]: http://example.com") == "<p>a\na</p>"),
     ?_assert(conv("a\na\n[id]: <http://example.com>") == "<p>a\na</p>"),
     ?_assert(conv("a\na\n[id]: http://example.com") == "<p>a\na</p>"),
     ?_assert(conv("a\na\n[id]: http://example.com (Title)") == "<p>a\na</p>"),
     ?_assert(conv("a\na\n[id]: http://example.com \"Title\"") == "<p>a\na</p>"),
     ?_assert(conv("___blah\na") == "<p><em>_</em>blah\na</p>"),
     ?_assert(conv("---blah\na") == "<p>---blah\na</p>"),
     ?_assert(conv("***blah\na") == "<p><em>*</em>blah\na</p>"),
     ?_assert(conv("_ _ _") == "<hr />"),
     ?_assert(conv("- - -") == "<hr />"),
     ?_assert(conv("* * *") == "<hr />"),
     ?_assert(conv("_____") == "<hr />"),
     ?_assert(conv("-----") == "<hr />"),
     ?_assert(conv("*****") == "<hr />"),
     ?_assert(conv("___") == "<hr />"),
     ?_assert(conv("---") == "<hr />"),
     ?_assert(conv("***") == "<hr />"),
     ?_assert(conv("\t<div>&") == "<pre><code>&lt;div&gt;&amp;\n</code></pre>"),
     ?_assert(conv("\t<div>") == "<pre><code>&lt;div&gt;\n</code></pre>"),
     ?_assert(conv("+ a\n\t\tb") == "<ul>\n<li>a\n    b</li>\n</ul>"),
     ?_assert(conv("+ a\n  \t  b") == "<ul>\n<li>a\n    b</li>\n</ul>"),
     ?_assert(conv("+ a\n\t    b") == "<ul>\n<li>a\n    b</li>\n</ul>"),
     ?_assert(conv("\tb\n\n\n\n\nc") == "<pre><code>b\n</code></pre>\n\n<p>c</p>"),
     ?_assert(conv("\tb\n\n\n\nc") == "<pre><code>b\n</code></pre>\n\n<p>c</p>"),
     ?_assert(conv("\tb\n\n\nc") == "<pre><code>b\n</code></pre>\n\n<p>c</p>"),
     ?_assert(conv("\tb\n\nc") == "<pre><code>b\n</code></pre>\n\n<p>c</p>"),
     ?_assert(conv("\tb\nc") == "<pre><code>b\n</code></pre>\n\n<p>c</p>"),
     ?_assert(conv("\tb") == "<pre><code>b\n</code></pre>"),
     ?_assert(conv("    b") == "<pre><code>b\n</code></pre>"),
     ?_assert(conv("4. a\n\n5. b\n\n6. c") == "<ol>\n<li><p>a</p></li>\n<li><p>b</p></li>\n<li><p>c</p></li>\n</ol>"),
     ?_assert(conv("4. a\n5. b\n6. c") == "<ol>\n<li>a</li>\n<li>b</li>\n<li>c</li>\n</ol>"),
     ?_assert(conv("4. blah\nblah") == "<ol>\n<li>blah\nblah</li>\n</ol>"),
     ?_assert(conv("555.blah\na") == "<p>555.blah\na</p>"),
     ?_assert(conv("555 @blah\na") == "<p>555 @blah\na</p>"),
     ?_assert(conv("555. blah") == "<ol>\n<li>blah</li>\n</ol>"),
     ?_assert(conv("4. blah") == "<ol>\n<li>blah</li>\n</ol>"),
     ?_assert(conv("1. blah") == "<ol>\n<li>blah</li>\n</ol>"),
     ?_assert(conv("- blah\nblah") == "<ul>\n<li>blah\nblah</li>\n</ul>"),
     ?_assert(conv("- a\n\n+ b\n\n+ c\n* d") == "<ul>\n<li><p>a</p></li>\n<li><p>b</p></li>\n<li><p>c</p></li>\n<li>d</li>\n</ul>"),
     ?_assert(conv("- a\n\n+ b") == "<ul>\n<li><p>a</p></li>\n<li><p>b</p></li>\n</ul>"),
     ?_assert(conv("- a\n\n \n\t\n XX+ b") == "<ul>\n<li><p>a</p>\n\n<p>XX+ b</p></li>\n</ul>"),
     ?_assert(conv("- a\n \n \n\t\n XX+ b") == "<ul>\n<li><p>a</p>\n\n<p>XX+ b</p></li>\n</ul>"),
     ?_assert(conv("- a\n\n\n\n XX+ b") == "<ul>\n<li><p>a</p>\n\n<p>XX+ b</p></li>\n</ul>"),
     ?_assert(conv("- a\n\n\n\nXX+ b") == "<ul>\n<li>a</li>\n</ul>\n\n<p>XX+ b</p>"),
     ?_assert(conv("- a\n+ b\n- c") == "<ul>\n<li>a</li>\n<li>b</li>\n<li>c</li>\n</ul>"),
     ?_assert(conv("-blah\na") == "<p>-blah\na</p>"),
     ?_assert(conv("- blah") == "<ul>\n<li>blah</li>\n</ul>"),
     ?_assert(conv("*blah\na") == "<p>*blah\na</p>"),
     ?_assert(conv("* blah") == "<ul>\n<li>blah</li>\n</ul>"),
     ?_assert(conv("+blah\na") == "<p>+blah\na</p>"),
     ?_assert(conv("+ blah") == "<ul>\n<li>blah</li>\n</ul>"),
     ?_assert(conv("bleh\n> blah") == "<p>bleh</p>\n\n<blockquote>\n  <p>blah</p>\n</blockquote>"),
     ?_assert(conv("> blah\na") == "<blockquote>\n  <p>blah\n  a</p>\n</blockquote>"),
     ?_assert(conv("# blahblah ###\nbleh") == "<h1>blahblah</h1>\n\n<p>bleh</p>"),
     ?_assert(conv("####### blahblah\nbleh") == "<h6># blahblah</h6>\n\n<p>bleh</p>"),
     ?_assert(conv("###### blahblah\nbleh") == "<h6>blahblah</h6>\n\n<p>bleh</p>"),
     ?_assert(conv("##### blahblah\nbleh") == "<h5>blahblah</h5>\n\n<p>bleh</p>"),
     ?_assert(conv("#### blahblah\nbleh") == "<h4>blahblah</h4>\n\n<p>bleh</p>"),
     ?_assert(conv("### blahblah\nbleh") == "<h3>blahblah</h3>\n\n<p>bleh</p>"),
     ?_assert(conv("## blahblah\nbleh") == "<h2>blahblah</h2>\n\n<p>bleh</p>"),
     ?_assert(conv("# blahblah\nbleh") == "<h1>blahblah</h1>\n\n<p>bleh</p>"),
     ?_assert(conv("# blahblah ###") == "<h1>blahblah</h1>"),
     ?_assert(conv("####### blahblah") == "<h6># blahblah</h6>"),
     ?_assert(conv("###### blahblah") == "<h6>blahblah</h6>"),
     ?_assert(conv("##### blahblah") == "<h5>blahblah</h5>"),
     ?_assert(conv("#### blahblah") == "<h4>blahblah</h4>"),
     ?_assert(conv("### blahblah") == "<h3>blahblah</h3>"),
     ?_assert(conv("## blahblah") == "<h2>blahblah</h2>"),
     ?_assert(conv("# blahblah") == "<h1>blahblah</h1>"),
     ?_assert(conv("> a\n-") == "<h2>> a</h2>"),
     ?_assert(conv("> a\n=") == "<h1>> a</h1>"),
     ?_assert(conv("blahblah\n-----\nblah") == "<h2>blahblah</h2>\n\n<p>blah</p>"),
     ?_assert(conv("blahblah\n====\nblah") == "<h1>blahblah</h1>\n\n<p>blah</p>"),
     ?_assert(conv("blahblah\n-----") == "<h2>blahblah</h2>"),
     ?_assert(conv("blahblah\n====") == "<h1>blahblah</h1>"),
     ?_assert(conv("blah\r\nblah\n") == "<p>blah\nblah</p>"),
     ?_assert(conv("blah\r\nblah") == "<p>blah\nblah</p>"),
     ?_assert(conv("blah\nblah") == "<p>blah\nblah</p>"),
     ?_assert(conv("___you___ sad bastard\na") == "<p><strong><em>you</em></strong> sad bastard\na</p>"),
     ?_assert(conv("__you__ sad bastard\na") == "<p><strong>you</strong> sad bastard\na</p>"),
     ?_assert(conv("_you_ sad bastard\na") == "<p><em>you</em> sad bastard\na</p>"),
     ?_assert(conv("***you*** sad bastard\na") == "<p><strong><em>you</em></strong> sad bastard\na</p>"),
     ?_assert(conv("**you** sad bastard\na") == "<p><strong>you</strong> sad bastard\na</p>"),
     ?_assert(conv("*you* sad bastard\na") == "<p><em>you</em> sad bastard\na</p>"),
     ?_assert(conv("you \\_sad\\_ bastard\na") == "<p>you _sad_ bastard\na</p>"),
     ?_assert(conv("you \\*sad\\* bastard\na") == "<p>you *sad* bastard\na</p>"),
     ?_assert(conv("you_sad_bastard\na") == "<p>you<em>sad</em>bastard\na</p>"),
     ?_assert(conv("you*sad*bastard\na") == "<p>you<em>sad</em>bastard\na</p>"),
     ?_assert(conv("you ___sad___ bastard\na") == "<p>you <strong><em>sad</em></strong> bastard\na</p>"),
     ?_assert(conv("you __sad__ bastard\na") == "<p>you <strong>sad</strong> bastard\na</p>"),
     ?_assert(conv("you _sad_ bastard\na") == "<p>you <em>sad</em> bastard\na</p>"),
     ?_assert(conv("you ***sad*** bastard\na") == "<p>you <strong><em>sad</em></strong> bastard\na</p>"),
     ?_assert(conv("you **sad** bastard\na") == "<p>you <strong>sad</strong> bastard\na</p>"),
     ?_assert(conv("you *sad* bastard\na") == "<p>you <em>sad</em> bastard\na</p>"),
     ?_assert(conv("########\na") == "<h6>#</h6>\n\n<p>a</p>"),
     ?_assert(conv("#######\na") == "<h6>#</h6>\n\n<p>a</p>"),
     ?_assert(conv("######\na") == "<h5>#</h5>\n\n<p>a</p>"),
     ?_assert(conv("#####\na") == "<h4>#</h4>\n\n<p>a</p>"),
     ?_assert(conv("####\na") == "<h3>#</h3>\n\n<p>a</p>"),
     ?_assert(conv("###\na") == "<h2>#</h2>\n\n<p>a</p>"),
     ?_assert(conv("##\na") == "<h1>#</h1>\n\n<p>a</p>"),
     ?_assert(conv("#\na") == "<p>#\na</p>"),
     ?_assert(conv("\n[\na") == "<p>[\na</p>"),
     ?_assert(conv("\n>\na") == "<p>>\na</p>"),
     ?_assert(conv("\n-\na") == "<p>-\na</p>"),
     ?_assert(conv("\n=\na") == "<p>=\na</p>"),
     ?_assert(conv("[\na") == "<p>[\na</p>"),
     ?_assert(conv(">\na") == "<p>>\na</p>"),
     ?_assert(conv("-\na") == "<p>-\na</p>"),
     ?_assert(conv("=\na") == "<p>=\na</p>"),
     ?_assert(conv("abc\\`def\na") == "<p>abc`def\na</p>"),
     ?_assert(conv("xyz\r\nab:c\na") == "<p>xyz\nab:c\na</p>"),
     ?_assert(conv("xyz\nab:c\na") == "<p>xyz\nab:c\na</p>"),
     ?_assert(conv("xyz\tab:c\na") == "<p>xyz    ab:c\na</p>"),
     ?_assert(conv("xyz ab:c\na") == "<p>xyz ab:c\na</p>"),
     ?_assert(conv("xyz(ab:c\na") == "<p>xyz(ab:c\na</p>"),
     ?_assert(conv("xyz]ab:c\na") == "<p>xyz]ab:c\na</p>"),
     ?_assert(conv("xyz[ab:c\na") == "<p>xyz[ab:c\na</p>"),
     ?_assert(conv("xyz)ab:c\na") == "<p>xyz)ab:c\na</p>"),
     ?_assert(conv("xyz(ab:c\na") == "<p>xyz(ab:c\na</p>"),
     ?_assert(conv("xyz/ab:c\na") == "<p>xyz/ab:c\na</p>"),
     ?_assert(conv("xyz\\ab:c\na") == "<p>xyz\\ab:c\na</p>"),
     ?_assert(conv("xyz!ab:c\na") == "<p>xyz!ab:c\na</p>"),
     ?_assert(conv("xyz`ab:c\na") == "<p>xyz`ab:c\na</p>"),
     ?_assert(conv("xyz\"ab:c\na") == "<p>xyz\"ab:c\na</p>"),
     ?_assert(conv("xyz'ab:c\na") == "<p>xyz'ab:c\na</p>"),
     ?_assert(conv("xyz:ab:c\na") == "<p>xyz:ab:c\na</p>"),
     ?_assert(conv("xyz.ab:c\na") == "<p>xyz.ab:c\na</p>"),
     ?_assert(conv("xyz0ab:c\na") == "<p>xyz0ab:c\na</p>"),
     ?_assert(conv("xyz9ab:c\na") == "<p>xyz9ab:c\na</p>"),
     ?_assert(conv("xyz8ab:c\na") == "<p>xyz8ab:c\na</p>"),
     ?_assert(conv("xyz7ab:c\na") == "<p>xyz7ab:c\na</p>"),
     ?_assert(conv("xyz6ab:c\na") == "<p>xyz6ab:c\na</p>"),
     ?_assert(conv("xyz5ab:c\na") == "<p>xyz5ab:c\na</p>"),
     ?_assert(conv("xyz4ab:c\na") == "<p>xyz4ab:c\na</p>"),
     ?_assert(conv("xyz3ab:c\na") == "<p>xyz3ab:c\na</p>"),
     ?_assert(conv("xyz2ab:c\na") == "<p>xyz2ab:c\na</p>"),
     ?_assert(conv("xyz1ab:c\na") == "<p>xyz1ab:c\na</p>"),
     ?_assert(conv("xyz_ab:c\na") == "<p>xyz_ab:c\na</p>"),
     ?_assert(conv("xyz*ab:c\na") == "<p>xyz*ab:c\na</p>"),
     ?_assert(conv("xyz+ab:c\na") == "<p>xyz+ab:c\na</p>"),
     ?_assert(conv("xyz>ab:c\na") == "<p>xyz>ab:c\na</p>"),
     ?_assert(conv("xyz#ab:c\na") == "<p>xyz#ab:c\na</p>"),
     ?_assert(conv("xyz-ab:c\na") == "<p>xyz-ab:c\na</p>"),
     ?_assert(conv("xyz=ab:c\na") == "<p>xyz=ab:c\na</p>"),
     ?_assert(conv("xyz/ab:c\na") == "<p>xyz/ab:c\na</p>"),
     ?_assert(conv("\r\n ab:c\na") == "<p>ab:c\na</p>"),
     ?_assert(conv("\n ab:c\na") == "<p>ab:c\na</p>"),
     ?_assert(conv("\t ab:c\na") == "<pre><code> ab:c\n</code></pre>\n\n<p>a</p>"),
     ?_assert(conv("  ab:c\na") == "<p>ab:c\na</p>"),
     ?_assert(conv("( ab:c\na") == "<p>( ab:c\na</p>"),
     ?_assert(conv("] ab:c\na") == "<p>] ab:c\na</p>"),
     ?_assert(conv("[ ab:c\na") == "<p>[ ab:c\na</p>"),
     ?_assert(conv(") ab:c\na") == "<p>) ab:c\na</p>"),
     ?_assert(conv("( ab:c\na") == "<p>( ab:c\na</p>"),
     ?_assert(conv("/ ab:c\na") == "<p>/ ab:c\na</p>"),
     ?_assert(conv("\\ ab:c\na") == "<p>\\ ab:c\na</p>"),
     ?_assert(conv("! ab:c\na") == "<p>! ab:c\na</p>"),
     ?_assert(conv("` ab:c\na") == "<p>` ab:c\na</p>"),
     ?_assert(conv("\" ab:c\na") == "<p>\" ab:c\na</p>"),
     ?_assert(conv("' ab:c\na") == "<p>' ab:c\na</p>"),
     ?_assert(conv(": ab:c\na") == "<p>: ab:c\na</p>"),
     ?_assert(conv(". ab:c\na") == "<p>. ab:c\na</p>"),
     ?_assert(conv("0 ab:c\na") == "<p>0 ab:c\na</p>"),
     ?_assert(conv("9 ab:c\na") == "<p>9 ab:c\na</p>"),
     ?_assert(conv("8 ab:c\na") == "<p>8 ab:c\na</p>"),
     ?_assert(conv("7 ab:c\na") == "<p>7 ab:c\na</p>"),
     ?_assert(conv("6 ab:c\na") == "<p>6 ab:c\na</p>"),
     ?_assert(conv("5 ab:c\na") == "<p>5 ab:c\na</p>"),
     ?_assert(conv("4 ab:c\na") == "<p>4 ab:c\na</p>"),
     ?_assert(conv("3 ab:c\na") == "<p>3 ab:c\na</p>"),
     ?_assert(conv("2 ab:c\na") == "<p>2 ab:c\na</p>"),
     ?_assert(conv("1 ab:c\na") == "<p>1 ab:c\na</p>"),
     ?_assert(conv("_ ab:c\na") == "<p>_ ab:c\na</p>"),
     ?_assert(conv("* ab:c\na") == "<ul>\n<li>ab:c\na</li>\n</ul>"),
     ?_assert(conv("+ ab:c\na") == "<ul>\n<li>ab:c\na</li>\n</ul>"),
     ?_assert(conv("> ab:c\na") == "<blockquote>\n  <p>ab:c\n  a</p>\n</blockquote>"),
     ?_assert(conv("# ab:c\na") == "<h1>ab:c</h1>\n\n<p>a</p>"),
     ?_assert(conv("- ab:c\na") == "<ul>\n<li>ab:c\na</li>\n</ul>"),
     ?_assert(conv("= ab:c\na") == "<p>= ab:c\na</p>"),
     ?_assert(conv("/ ab:c\na") == "<p>/ ab:c\na</p>"),
     ?_assert(conv("< /ab:c\na") == "<p>&lt; /ab:c\na</p>"),
     ?_assert(conv("< ab:c\na") == "<p>&lt; ab:c\na</p>"),
     ?_assert(conv("\r\nab:c\na") == "<p>ab:c\na</p>"),
     ?_assert(conv("\nab:c\na") == "<p>ab:c\na</p>"),
     ?_assert(conv("\tab:c\na") == "<pre><code>ab:c\n</code></pre>\n\n<p>a</p>"),
     ?_assert(conv(" ab:c\na") == "<p>ab:c\na</p>"),
     ?_assert(conv("(ab:c\na") == "<p>(ab:c\na</p>"),
     ?_assert(conv("]ab:c\na") == "<p>]ab:c\na</p>"),
     ?_assert(conv("[ab:c\na") == "<p>[ab:c\na</p>"),
     ?_assert(conv(")ab:c\na") == "<p>)ab:c\na</p>"),
     ?_assert(conv("(ab:c\na") == "<p>(ab:c\na</p>"),
     ?_assert(conv("/ab:c\na") == "<p>/ab:c\na</p>"),
     ?_assert(conv("\\ab:c\na") == "<p>\\ab:c\na</p>"),
     ?_assert(conv("!ab:c\na") == "<p>!ab:c\na</p>"),
     ?_assert(conv("`ab:c\na") == "<p>`ab:c\na</p>"),
     ?_assert(conv("\"ab:c\na") == "<p>\"ab:c\na</p>"),
     ?_assert(conv("'ab:c\na") == "<p>'ab:c\na</p>"),
     ?_assert(conv(":ab:c\na") == "<p>:ab:c\na</p>"),
     ?_assert(conv(".ab:c\na") == "<p>.ab:c\na</p>"),
     ?_assert(conv("0ab:c\na") == "<p>0ab:c\na</p>"),
     ?_assert(conv("9ab:c\na") == "<p>9ab:c\na</p>"),
     ?_assert(conv("8ab:c\na") == "<p>8ab:c\na</p>"),
     ?_assert(conv("7ab:c\na") == "<p>7ab:c\na</p>"),
     ?_assert(conv("6ab:c\na") == "<p>6ab:c\na</p>"),
     ?_assert(conv("5ab:c\na") == "<p>5ab:c\na</p>"),
     ?_assert(conv("4ab:c\na") == "<p>4ab:c\na</p>"),
     ?_assert(conv("3ab:c\na") == "<p>3ab:c\na</p>"),
     ?_assert(conv("2ab:c\na") == "<p>2ab:c\na</p>"),
     ?_assert(conv("1ab:c\na") == "<p>1ab:c\na</p>"),
     ?_assert(conv("_ab:c\na") == "<p>_ab:c\na</p>"),
     ?_assert(conv("*ab:c\na") == "<p>*ab:c\na</p>"),
     ?_assert(conv("+ab:c\na") == "<p>+ab:c\na</p>"),
     ?_assert(conv(">ab:c\na") == "<blockquote>\n  <p>ab:c\n  a</p>\n</blockquote>"),
     ?_assert(conv("#ab:c\na") == "<h1>ab:c</h1>\n\n<p>a</p>"),
     ?_assert(conv("-ab:c\na") == "<p>-ab:c\na</p>"),
     ?_assert(conv("=ab:c\na") == "<p>=ab:c\na</p>"),
     ?_assert(conv("/ab:c\na") == "<p>/ab:c\na</p>"),
     ?_assert(conv("    \nHey\nHo!  \nLets Go") == "<p>Hey\nHo! <br />\nLets Go</p>"),
     ?_assert(conv("Hey Ho\t\nLets Go") == "<p>Hey Ho <br />\nLets Go</p>"),
     ?_assert(conv("Hey Ho  \nLets Go") == "<p>Hey Ho <br />\nLets Go</p>"),
     ?_assert(conv("Hey\nHo!\nHardy\n\n") == "<p>Hey\nHo!\nHardy</p>"),
     ?_assert(conv("Hey Ho!\na") == "<p>Hey Ho!\na</p>"),
     ?_assert(conv(" 3 <4\na") == "<p>3 &lt;4\na</p>"),
     ?_assert(conv(" 3 < 4\na") == "<p>3 &lt; 4\na</p>"),
     ?_assert(conv("3 > 4\na") == "<p>3 > 4\na</p>"),
     ?_assert(conv("a\nb\nc\n \n\t\n     ") == "<p>a\nb\nc</p>"),
     ?_assert(conv("a\nb\nc\n\n\n") == "<p>a\nb\nc</p>"),
     ?_assert(conv("  \n") == ""),
     ?_assert(conv("\t\n") == ""),
     ?_assert(conv("\n\n") == ""),
     ?_assert(conv("\n") == "")
    ].
