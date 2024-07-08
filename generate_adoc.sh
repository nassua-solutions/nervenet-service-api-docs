#!/bin/bash

# 設定
YAML_DIR="./pages/yaml"
ADOC_DIR="./adoc"
DOCKER_GENERATOR_IMAGE="openapitools/openapi-generator-cli"

# YAMLファイルのリストを取得
yaml_files=($(ls ${YAML_DIR} | grep -E '\.ya?ml$'))
if [ ${#yaml_files[@]} -eq 0 ]; then
    echo "No YAML files found in ${YAML_DIR}."
    exit 1
fi

# YAMLファイルの選択
echo "Select an OpenAPI YAML file to convert:"
select OPENAPI_FILENAME in "${yaml_files[@]}"; do
    if [ -n "$OPENAPI_FILENAME" ]; then
        break
    else
        echo "Invalid selection. Please try again."
    fi
done

# ステップ1: yamlディレクトリにOpenAPIファイルが存在するか確認
if [ ! -f "${YAML_DIR}/${OPENAPI_FILENAME}" ]; then
    echo "Error: ${YAML_DIR}/${OPENAPI_FILENAME} not found!"
    exit 1
fi

# 出力されるadocファイル名を決定
ADOC_FILENAME="${OPENAPI_FILENAME%.*}.adoc"

# ステップ2: adoc出力
echo "Generating AsciiDoc from OpenAPI spec..."
docker run --rm -v "$(pwd)":/local ${DOCKER_GENERATOR_IMAGE} generate -i /local/${YAML_DIR}/${OPENAPI_FILENAME} -g asciidoc -o /local/${ADOC_DIR}
if [ $? -ne 0 ]; then
    echo "Error: AsciiDoc generation failed!"
    exit 1
fi

# 生成されたadocファイルをリネーム
mv "${ADOC_DIR}/index.adoc" "${ADOC_DIR}/${ADOC_FILENAME}"

echo "AsciiDoc generation complete. Please review and make any necessary manual changes to the AsciiDoc file: ${ADOC_DIR}/${ADOC_FILENAME}"
