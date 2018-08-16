Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:21960 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbeHQBq1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Aug 2018 21:46:27 -0400
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-block@vger.kernel.org
Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH] block: remove duplicate initialization
Date: Thu, 16 Aug 2018 15:45:29 -0700
Message-Id: <20180816224529.3401-1-chaitanya.kulkarni@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This patch removes the duplicate initialization of q->queue_head
in the blk_alloc_queue_node(). This removes the 2nd initialization
so that we preserve the initialization order same as declaration
present in struct request_queue.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 block/blk-core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 21c7cb35d3b4..dee56c282efb 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1036,7 +1036,6 @@ struct request_queue *blk_alloc_queue_node(gfp_t gfp_mask, int node_id,
 		    laptop_mode_timer_fn, 0);
 	timer_setup(&q->timeout, blk_rq_timed_out_timer, 0);
 	INIT_WORK(&q->timeout_work, NULL);
-	INIT_LIST_HEAD(&q->queue_head);
 	INIT_LIST_HEAD(&q->timeout_list);
 	INIT_LIST_HEAD(&q->icq_list);
 #ifdef CONFIG_BLK_CGROUP
-- 
2.17.0
