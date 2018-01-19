# 这里包名，要和.app的名字一样
title="MudutvIOSPublisher"

rm -rf ${title}
mkdir ${title}
mkdir ${title}/Payload
cp -r ${title}.app ${title}/Payload/${title}.app
cp Icon.png ${title}/iTunesArtwork
cd ${title}
zip -r ${title}.ipa Payload iTunesArtwork

exit 0