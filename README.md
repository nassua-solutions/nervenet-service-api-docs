# 概要
 - openapi.yamlからpdfを出力するツール、というか手順です。
 - 探せば1つや2つツールが見つかりますが、日本語フォント適用で苦労します。
 - 2023年末現在、結局adoc経由でpdfにするのが良いです。
 - ググるとJavaやnvmがどうのとよく出てきますが、PCローカルを汚したくないのでDocker前提です。
 - コマンドはwindowsでなく、linuxPCやWSLから実行してください。

# 手順
1. yamlディレクトリにopenapi.yamlを入れる（ファイル名変更可、コマンド叩く時に変えるのも忘れずに）
2. adoc出力
```
docker run --rm -v ${PWD}:/local openapitools/openapi-generator-cli generate -i /local/yaml/openapi.yaml -g asciidoc -o /local/adoc
```
3. 必要に応じてadocを手動修正
4. asciidocker-jpコンテナ起動
```
docker run -it -v ./adoc:/documents/ nazuma/docker-asciidoctor-jp
```
5. asciidocker-jpコンテナ内で下記を実行、htmlとpdfがadocディレクトリに入る
```
adoc index.adoc
```
```
adoc-pdf index.adoc
```

# 参考
https://qiita.com/amuyikam/items/e8a45daae59c68be0fc8#openapi-generator  
https://hub.docker.com/r/openapitools/openapi-generator-cli  
https://hub.docker.com/r/nazuma/docker-asciidoctor-jp