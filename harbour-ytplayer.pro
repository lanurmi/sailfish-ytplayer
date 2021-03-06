# The name of your app.
# NOTICE: name defined in TARGET has a corresponding QML filename.
#         If name defined in TARGET is changed, following needs to be
#         done to match new name:
#         - corresponding QML filename must be changed
#         - desktop icon filename must be changed
#         - desktop filename must be changed
#         - icon definition filename in desktop file must be changed
TARGET = harbour-ytplayer

CONFIG += sailfishapp
QT += dbus

SOURCES += \
        src/YTPlayer.cpp \
        src/NativeUtil.cpp

HEADERS += \
        src/NativeUtil.h

OTHER_FILES += \
        generate-mcc-json.py \
        get_version_str.sh \
        harbour-ytplayer.desktop \
        rpm/harbour-ytplayer.yaml \
        rpm/harbour-ytplayer.spec \
        qml/YTPlayer.qml \
        qml/cover/Default.qml \
        qml/cover/VideoOverview.qml \
        qml/cover/VideoPlayer.qml \
        qml/cover/ChannelBrowser.qml \
        qml/cover/CategoryVideoList.qml \
        qml/pages/YoutubeClientV3.js \
        qml/pages/Settings.js \
        qml/pages/duration.js \
        qml/pages/Helpers.js \
        qml/pages/VideoOverview.qml \
        qml/pages/VideoPlayer.qml \
        qml/pages/YoutubeListItem.qml \
        qml/pages/Search.qml \
        qml/pages/VideoCategories.qml \
        qml/pages/Settings.qml \
        qml/pages/About.qml \
        qml/pages/KeyValueLabel.qml \
        qml/pages/StatItem.qml \
        qml/pages/ConnectionRetryTimer.qml \
        qml/pages/ChannelBrowser.qml \
        qml/pages/AsyncImage.qml \
        qml/pages/YoutubeVideoList.qml \
        qml/pages/VideoController.qml \
        qml/pages/CategoryVideoList.qml

include(third_party/notifications.pri)

MCC_DATA = mcc.txt
mcc_data.input = MCC_DATA
mcc_data.output = mcc.json
mcc_data.variable_out = OTHER_FILES
mcc_data.commands = \
        $$top_srcdir/generate-mcc-json.py \
                -i mcc.txt -o mcc.json

DEFINES += VERSION_STR=\\\"$$system($${top_srcdir}/get_version_str.sh)\\\"

QMAKE_EXTRA_COMPILERS += mcc_data

exists($${top_srcdir}/youtube-data-api-v3.key) {
        message("Using contents of yotube-data-api-v3.key")
        DEFINES += YOUTUBE_DATA_API_V3_KEY=\\\"$$cat(youtube-data-api-v3.key)\\\"
}

mcc.files = mcc.json
mcc.path = /usr/share/$${TARGET}

artwork.files = $$files(images/*)
artwork.path = /usr/share/$${TARGET}/images

localization.files = $$files(languages/*.qm)
localization.path = /usr/share/$${TARGET}/languages

INSTALLS += localization mcc artwork

TRANSLATIONS += \
        languages/en.ts

lupdate_only{
SOURCES += \
        qml/*.qml \
        qml/cover/*.qml \
        qml/pages/*.qml \
        qml/pages/*.js
}
