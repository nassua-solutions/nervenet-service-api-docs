# Nervenet Service API Docs

NerveNetを利用した、主にデモ・実証実験向けの各種サービスのAPI設計書（openapi.yaml）を  
Github Pagesによって外部公開するためのリポジトリです。  
また、pdfを出力する手順も下記に記載します。

## コンテンツ

1. **OpenAPI仕様書**
   - `pages/yaml/`ディレクトリに各種OpenAPI仕様書が格納されています。

2. **GitHub Pages公開用HTML**
   - `pages/index.html`により、動的にOpenAPI仕様書をRedocを使用して表示します。

3. **OpenAPI→Adoc→PDF変換手順**
   - `generate_adoc.sh` スクリプトを使用して、OpenAPI仕様書からAsciiDocファイルを生成します。
   - 必要に応じて生成されたAsciiDocファイルを手動で修正します。
   - `generate_pdf.sh` スクリプトを使用して、修正後のAsciiDocファイルからPDFとHTMLを生成します。

## GitHub Pagesでの公開リンク

- [自治体情報掲示板](https://<your-username>.github.io/nervenet-service-api-docs/pages/index.html?spec=openapi-bbs_3.0)

## pdf出力
 - openapi.yamlからpdfを出力する手順です。
 - PCの環境に依存しないように、Docker前提です。
 - Windowsではなく、Mac / linuxPC / WSLから実行してください。

### 手順
1. yamlディレクトリにopenapi-xxx_n.n.yamlを入れる（ファイル名は適宜変更）
2. adoc出力（処理対象ファイルの選択肢が出るので、数値で選択）
```
./generate_adoc.sh
```
3. 必要に応じてadocを手動修正
4. adocからpdfに変換（処理対象ファイルの選択肢が出るので、数値で選択）
```
./generate_pdf.sh
```

## 参考
https://qiita.com/amuyikam/items/e8a45daae59c68be0fc8#openapi-generator  
https://hub.docker.com/r/openapitools/openapi-generator-cli  
https://hub.docker.com/r/nazuma/docker-asciidoctor-jp