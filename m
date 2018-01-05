Return-Path: <linux-block-owner@vger.kernel.org>
Received: from aserp2120.oracle.com ([141.146.126.78]:42226 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751284AbeAEILo (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 Jan 2018 03:11:44 -0500
From: Liu Bo <bo.li.liu@oracle.com>
To: linux-block@vger.kernel.org
Cc: trivial@kernel.org
Subject: [PATCH] blk-mq: remove confusing comment of blk_mq_sched_dispatch_requests
Date: Fri,  5 Jan 2018 00:09:06 -0700
Message-Id: <20180105070906.29664-1-bo.li.liu@oracle.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Commit de1482974080
("blk-mq: introduce .get_budget and .put_budget in blk_mq_ops")
changes the function to return bool type, and then commit 1f460b63d4b3
("blk-mq: don't restart queue when .get_budget returns BLK_STS_RESOURCE")
changes it back to void, but the comment remains.

Signed-off-by: Liu Bo <bo.li.liu@oracle.com>
---
 block/blk-mq-sched.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index c117bd8..2ff7cf0 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -172,7 +172,6 @@ static void blk_mq_do_dispatch_ctx(struct blk_mq_hw_ctx *hctx)
 	WRITE_ONCE(hctx->dispatch_from, ctx);
 }
 
-/* return true if hw queue need to be run again */
 void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
 {
 	struct request_queue *q = hctx->queue;
-- 
2.9.4
