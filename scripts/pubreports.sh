#!/bin/sh
cd $HOME
git clone -b gh-pages "https://$GITHUB_TOKEN@github.com/konikvranik/androidsvg.git" gh-pages || exit 1
echo Copying lint
cp -ru $TRAVIS_BUILD_DIR/android/build/outputs/lint-results* gh-pages
STAT=$?
echo Copying report
cp -ru $TRAVIS_BUILD_DIR/android/build/outputs/report* gh-pages
[ $? -eq 0 ] && STAT=0
cp -ru $TRAVIS_BUILD_DIR/android/build/report* gh-pages
[ $? -gt 0 -a $STAT -gt 0 ] && exit 1
echo CD to gh-pages
cd $HOME/gh-pages || exit 1
echo Adding lint
git add lint*
STAT=$?
echo Adding report
git add report*
[ $? -gt 0 -a $STAT -gt 0 ] && exit 1
echo Commiting
git commit -m "travis => build reports"
echo Pushing
git push
