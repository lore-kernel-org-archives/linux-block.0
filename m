Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:52596 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754475AbeGIW4p (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Jul 2018 18:56:45 -0400
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Omar Sandoval <osandov@fb.com>
Cc: linux-block@vger.kernel.org,
        Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH blktests v3 2/6] check: Make $FULL an absolute path
Date: Mon,  9 Jul 2018 15:56:39 -0700
Message-Id: <20180709225643.10537-3-bart.vanassche@wdc.com>
In-Reply-To: <20180709225643.10537-1-bart.vanassche@wdc.com>
References: <20180709225643.10537-1-bart.vanassche@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This makes it safe to use $FULL in shell code that modifies (and
restores) the working directory.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
---
 check | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/check b/check
index a63553120635..5f4461f8b5b4 100755
--- a/check
+++ b/check
@@ -313,7 +313,7 @@ _call_test() {
 	local test_func="$1"
 	local seqres="${RESULTS_DIR}/${TEST_NAME}"
 	# shellcheck disable=SC2034
-	FULL="${seqres}.full"
+	FULL="$PWD/${seqres}.full"
 	declare -A TEST_DEV_QUEUE_SAVED
 
 	_read_last_test_run
-- 
2.18.0
