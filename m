Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43740 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725975AbeHYNpE (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 25 Aug 2018 09:45:04 -0400
From: Yi Zhang <yi.zhang@redhat.com>
To: gi-oh.kim@profitbricks.com, osandov@fb.com
Cc: linux-block@vger.kernel.org
Subject: [PATCH] blktests: remove unused null_blk parameter for _init_null_blk in block/016
Date: Sat, 25 Aug 2018 18:06:19 +0800
Message-Id: <20180825100619.17868-1-yi.zhang@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
---
 tests/block/016 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/block/016 b/tests/block/016
index 0e6f2e1..e0a63ad 100755
--- a/tests/block/016
+++ b/tests/block/016
@@ -32,7 +32,7 @@ requires() {
 test() {
 	echo "Running ${TEST_NAME}"
 
-	if ! _init_null_blk null_blk queue_mode=2 irqmode=2 completion_nsec=2000000000; then
+	if ! _init_null_blk queue_mode=2 irqmode=2 completion_nsec=2000000000; then
 		return 1
 	fi
 
-- 
2.17.1
