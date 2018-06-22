Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:29608 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933738AbeFVWTt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Jun 2018 18:19:49 -0400
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Omar Sandoval <osandov@fb.com>
Cc: linux-block@vger.kernel.org,
        Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH blktests 08/15] check: Suppress a shellcheck warning about the DMESG_FILTER initialization
Date: Fri, 22 Jun 2018 15:19:39 -0700
Message-Id: <20180622221946.10987-9-bart.vanassche@wdc.com>
In-Reply-To: <20180622221946.10987-1-bart.vanassche@wdc.com>
References: <20180622221946.10987-1-bart.vanassche@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Avoid that shellcheck reports the following:

check:396:2: warning: Use var=$(command) to assign output (or quote to assign string). [SC2209]

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
---
 check | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/check b/check
index d9ffea6ec1f6..cf2090f546a5 100755
--- a/check
+++ b/check
@@ -393,7 +393,7 @@ _call_test() {
 _run_test() {
 	TEST_NAME="$1"
 	CHECK_DMESG=1
-	DMESG_FILTER=cat
+	DMESG_FILTER="cat"
 
 	# shellcheck disable=SC1090
 	. "tests/${TEST_NAME}"
-- 
2.17.1
