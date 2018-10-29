Return-Path: <linux-block-owner@vger.kernel.org>
Received: from imap.thunk.org ([74.207.234.97]:40026 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727597AbeJ3BFU (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Oct 2018 21:05:20 -0400
From: Theodore Ts'o <tytso@mit.edu>
To: linux-block@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH blktests] Add use of logger so that syslog files show when each test starts
Date: Mon, 29 Oct 2018 12:15:57 -0400
Message-Id: <20181029161557.7652-1-tytso@mit.edu>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 check | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/check b/check
index f6c3537..ebd87c0 100755
--- a/check
+++ b/check
@@ -319,6 +319,7 @@ _call_test() {
 		local dmesg_marker=""
 		CHECK_DMESG=0
 	fi
+	$LOGGER_PROG "run blktests $TEST_NAME"
 
 	trap _cleanup EXIT
 	if ! TMPDIR="$(mktemp --tmpdir -p "$OUTPUT" -d "tmpdir.${TEST_NAME//\//.}.XXX")"; then
@@ -578,6 +579,8 @@ fi
 eval set -- "$TEMP"
 unset TEMP
 
+LOGGER_PROG="$(type -P logger)" || LOGGER_PROG=true
+
 if [[ -r config ]]; then
 	# shellcheck disable=SC1091
 	. config
-- 
2.18.0.rc0
