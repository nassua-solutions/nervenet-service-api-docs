#!/bin/bash

# 設定
ADOC_DIR="./adoc"
DOCKER_ASCIIDOCTOR_IMAGE="nazuma/docker-asciidoctor-jp"

# AsciiDocファイルのリストを取得
adoc_files=($(ls ${ADOC_DIR} | grep -E '\.adoc$'))
if [ ${#adoc_files[@]} -eq 0 ]; then
    echo "No AsciiDoc files found in ${ADOC_DIR}."
    exit 1
fi

# AsciiDocファイルの選択
echo "Select an AsciiDoc file to convert:"
select ADOC_FILENAME in "${adoc_files[@]}"; do
    if [ -n "$ADOC_FILENAME" ]; then
        break
    else
        echo "Invalid selection. Please try again."
    fi
done

# ステップ: PDFとHTMLの生成
echo "Starting Asciidoctor container and generating PDF and HTML..."
docker run --rm -v "$(pwd)/${ADOC_DIR}":/documents/ -w /documents/ ${DOCKER_ASCIIDOCTOR_IMAGE} /bin/bash -c "adoc-pdf ${ADOC_FILENAME}"
if [ $? -ne 0 ]; then
    echo "Error: PDF/HTML generation failed!"
    exit 1
fi

echo "Conversion complete. PDF and HTML files are located in the ${ADOC_DIR} directory."
