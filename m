Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:59311 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752077AbeFLJ5N (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Jun 2018 05:57:13 -0400
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Omar Sandoval <osandov@osandov.com>
Cc: Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH blktests] check: add command line switch to test device drivers only
Date: Tue, 12 Jun 2018 11:57:06 +0200
Message-Id: <20180612095706.4831-1-jthumshirn@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Sometimes it's useful to only run tests which exercise a device
special driver to verify a patch for the driver doesn't introduce a
regression.

Running the whole test-suite is just a waste of time in this case, so
provide a way to only run tests which have a test_device() function
set and not a test() function.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 check | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/check b/check
index 4baa8dde2436..639fcc43f09d 100755
--- a/check
+++ b/check
@@ -395,6 +395,12 @@ _run_test() {
 	. "tests/${TEST_NAME}"
 
 	if declare -fF test >/dev/null; then
+		if [[ -v DEVICE_ONLY ]]; then
+			SKIP_REASON="test excluded by user"
+			_output_notrun "$TEST_NAME"
+			return 0
+		fi
+
 		if declare -fF requires >/dev/null && ! requires; then
 			_output_notrun "$TEST_NAME"
 			return 0
@@ -546,6 +552,9 @@ Test runs:
   -x, --exclude=TEST     exclude a test (or test group) from the list of
 			 tests to run
 
+  -d --device-only       only run test which use a test device from the
+                         TEST_DEV config setting
+
 Miscellaneous:
   -h, --help             display this help message and exit"
 
@@ -570,6 +579,7 @@ unset TEMP
 
 # Default configuration.
 QUICK_RUN=0
+DEVICE_ONLY=0
 EXCLUDE=()
 TEST_DEVS=()
 
@@ -592,6 +602,10 @@ while true; do
 			EXCLUDE+=("$2")
 			shift 2
 			;;
+		'-d'|'--device-only')
+			DEVICE_ONLY=1
+			shift 2
+			;;
 		'-h'|'--help')
 			usage out
 			;;
@@ -609,6 +623,10 @@ if [[ QUICK_RUN -ne 0 && ! -v TIMEOUT ]]; then
 	_error "QUICK_RUN specified without TIMEOUT"
 fi
 
+if [[ DEVICE_ONLY -ne 0 && ${#TEST_DEVS[@]} -eq 0 ]]; then
+	_error "DEVICE_ONLY specified without TEST_DEVS"
+fi
+
 # Convert the exclude list to an associative array.
 TEMP_EXCLUDE=("${EXCLUDE[@]}")
 unset EXCLUDE
-- 
2.16.4
