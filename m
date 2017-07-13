Return-Path: <linux-block-owner@vger.kernel.org>
Received: from 22.17.110.36.static.bjtelecom.net ([36.110.17.22]:12359 "EHLO
        BJEXCAS005.didichuxing.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751267AbdGMQKi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Jul 2017 12:10:38 -0400
Date: Fri, 14 Jul 2017 00:10:26 +0800
From: weiping zhang <zhangweiping@didichuxing.com>
To: <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>
Subject: [PATCH] blk-mq: only alloc hctx point as many as nr_hw_queues
Message-ID: <20170713161020.GA10325@bogon.didichuxing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

one hw queue only has one hctx, reduce it's number same as nr_hw_queues.

Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
---
 block/blk-mq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 05dfa3f..8c98f59 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2320,8 +2320,8 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	/* init q->mq_kobj and sw queues' kobjects */
 	blk_mq_sysfs_init(q);
 
-	q->queue_hw_ctx = kzalloc_node(nr_cpu_ids * sizeof(*(q->queue_hw_ctx)),
-						GFP_KERNEL, set->numa_node);
+	q->queue_hw_ctx = kzalloc_node(set->nr_hw_queues *
+			sizeof(*(q->queue_hw_ctx)),GFP_KERNEL, set->numa_node);
 	if (!q->queue_hw_ctx)
 		goto err_percpu;
 
-- 
2.9.4
