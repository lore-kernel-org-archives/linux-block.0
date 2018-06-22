Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:59818 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933863AbeFVWTx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Jun 2018 18:19:53 -0400
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Omar Sandoval <osandov@fb.com>
Cc: linux-block@vger.kernel.org,
        Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH blktests 12/15] check: Make TMPDIR absolute
Date: Fri, 22 Jun 2018 15:19:43 -0700
Message-Id: <20180622221946.10987-13-bart.vanassche@wdc.com>
In-Reply-To: <20180622221946.10987-1-bart.vanassche@wdc.com>
References: <20180622221946.10987-1-bart.vanassche@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This avoids that ${TMPDIR} gets misinterpreted if a test script
modifies the working directory.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
---
 check | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/check b/check
index cf2090f546a5..a7dd825ad03a 100755
--- a/check
+++ b/check
@@ -323,7 +323,7 @@ _call_test() {
 	fi
 
 	trap _cleanup EXIT
-	if ! TMPDIR="$(mktemp --tmpdir -p results -d "tmpdir.${TEST_NAME//\//.}.XXX")"; then
+	if ! TMPDIR="$(mktemp --tmpdir -p "$PWD/results" -d "tmpdir.${TEST_NAME//\//.}.XXX")"; then
 		return
 	fi
 
-- 
2.17.1
