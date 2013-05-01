{
    chartableimage_creator.pl v0.01:
        Last Modified: 2013/05/02 01:24:19.
        Created by @tatt61880
            https://twitter.com/tatt61880
            https://github.com/tatt61880
}

# =============================================================================

【使い方】
以下の3つを用意してください。
・nmake.exe (VisualStudioに入っています)
・ActivePerl (Windows OS用のPerl)
・PerlのImage::Magickモジュール (通称「PerlMagick」。ActivePerlのバージョンに合った物を使用してください)

inputフォルダの内容を変更し，nmakeすると，outputフォルダが作成されます。
inputフォルダにttfフォントファイルを置き，font.mkのFONTの定義を変更した後
nmakeすると，そのフォントが適用されて出力されます。

# =============================================================================

@tatt61880

