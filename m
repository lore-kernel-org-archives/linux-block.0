Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:59818 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933811AbeFVWTs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Jun 2018 18:19:48 -0400
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Omar Sandoval <osandov@fb.com>
Cc: linux-block@vger.kernel.org,
        Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH blktests 05/15] check: Avoid that shellcheck complains that $FULL appears unused
Date: Fri, 22 Jun 2018 15:19:36 -0700
Message-Id: <20180622221946.10987-6-bart.vanassche@wdc.com>
In-Reply-To: <20180622221946.10987-1-bart.vanassche@wdc.com>
References: <20180622221946.10987-1-bart.vanassche@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

$FULL is a global variable. Avoid that shellcheck complains about it.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
---
 check | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/check b/check
index 1774be4fe1a7..d9ffea6ec1f6 100755
--- a/check
+++ b/check
@@ -301,6 +301,8 @@ _call_test() {
 	local test_func="$1"
 	local seqres="${RESULTS_DIR}/${TEST_NAME}"
 	FULL="${seqres}.full"
+	# Avoid that shellcheck complains that $FULL appears unused.
+	echo "$FULL" >/dev/null
 	declare -A TEST_DEV_QUEUE_SAVED
 
 	_read_last_test_run
-- 
2.17.1
