Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:43081 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967265AbeFSUYd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Jun 2018 16:24:33 -0400
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Omar Sandoval <osandov@fb.com>
Cc: linux-block@vger.kernel.org,
        Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH 8/9] check: Suppress a shellcheck warning about the DMESG_FILTER initialization
Date: Tue, 19 Jun 2018 13:23:52 -0700
Message-Id: <20180619202353.23631-9-bart.vanassche@wdc.com>
In-Reply-To: <20180619202353.23631-1-bart.vanassche@wdc.com>
References: <20180619202353.23631-1-bart.vanassche@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Avoid that shellcheck reports the following:

check:396:2: warning: Use var=$(command) to assign output (or quote to assign string). [SC2209]

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
---
 check | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/check b/check
index f1feb96b293e..e7439e163884 100755
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
