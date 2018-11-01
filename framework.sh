D_DIR}/Debug-iphonesimulator/${TARGET_NAME}.framework" "${UNIVERSAL_OUTPUT_FOLDER}"
cp -R "${BUILD_DIR}/Release-iphoneos/${TARGET_NAME}.framework/Modules/${TARGET_NAME}.swiftmodule/" "${UNIVERSAL_OUTPUT_FOLDER}${TARGET_NAME}.framework/Modules/${TARGET_NAME}.swiftmodule/"

# 合并framework，输出最终的framework到build目录
lipo -create -output "${UNIVERSAL_OUTPUT_FOLDER}/${TARGET_NAME}.framework/${TARGET_NAME}" "${BUILD_DIR}/Debug-iphonesimulator/${TARGET_NAME}.framework/${TARGET_NAME}" "${BUILD_DIR}/Debug-iphoneos/${TARGET_NAME}.framework/${TARGET_NAME}"
lipo -create -output "${UNIVERSAL_OUTPUT_FOLDER}/${TARGET_NAME}.framework/${TARGET_NAME}" "${BUILD_DIR}/Release-iphonesimulator/${TARGET_NAME}.framework/${TARGET_NAME}" "${BUILD_DIR}/Release-iphoneos/${TARGET_NAME}.framework/${TARGET_NAME}"

# 删除编译之后生成的无关的配置文件
dir_path="${UNIVERSAL_OUTPUT_FOLDER}/${TARGET_NAME}.framework/"
for file in ls $dir_path
do
if [[ ${file} =~ ".xcconfig" ]]
then
rm -f "${dir_path}/${file}"
fi
done

# 判断build文件夹是否存在，存在则删除
if [ -d "${SRCROOT}/build" ]
then
rm -rf "${SRCROOT}/build"
fi

rm -rf \
"${BUILD_DIR}/Debug-iphonesimulator" \
"${BUILD_DIR}/Release-iphonesimulator" \
"${BUILD_DIR}/Debug-iphoneos" \
"${BUILD_DIR}/Release-iphoneos"

# 打开合并后的文件夹
open "${UNIVERSAL_OUTPUT_FOLDER}"