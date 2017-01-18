Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:20989 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752810AbdARWQu (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Jan 2017 17:16:50 -0500
From: Keith Busch <keith.busch@intel.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@intel.com>
Subject: [PATCH for-4.10] blk-mq: Remove unused variable
Date: Wed, 18 Jan 2017 17:21:15 -0500
Message-Id: <1484778075-25065-1-git-send-email-keith.busch@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Signed-off-by: Keith Busch <keith.busch@intel.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 block/blk-mq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index a8e67a1..c3400b5 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -912,7 +912,6 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list)
 static void blk_mq_process_rq_list(struct blk_mq_hw_ctx *hctx)
 {
 	LIST_HEAD(rq_list);
-	LIST_HEAD(driver_list);
 
 	if (unlikely(blk_mq_hctx_stopped(hctx)))
 		return;
-- 
2.5.5

