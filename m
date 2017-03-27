Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f41.google.com ([74.125.83.41]:34263 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751327AbdC0RpA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Mar 2017 13:45:00 -0400
Received: by mail-pg0-f41.google.com with SMTP id 21so46955868pgg.1
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2017 10:44:59 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: linux-block@vger.kernel.org
Cc: kernel-team@fb.com
Subject: [PATCH 1/2] blk-mq: fix leak of q->stats
Date: Mon, 27 Mar 2017 10:43:58 -0700
Message-Id: <de751892a392533e8e26fffbf72ba7904cfda468.1490636543.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

blk_alloc_queue_node() already allocates q->stats, so
blk_mq_init_allocated_queue() is overwriting it with a new allocation.

Fixes: a83b576c9c25 ("block: fix stacked driver stats init and free")
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 block/blk-mq.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index c212b9644a9f..9c6b39bd8358 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2212,10 +2212,6 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	/* mark the queue as mq asap */
 	q->mq_ops = set->ops;
 
-	q->stats = blk_alloc_queue_stats();
-	if (!q->stats)
-		goto err_exit;
-
 	q->poll_cb = blk_stat_alloc_callback(blk_mq_poll_stats_fn,
 					     blk_stat_rq_ddir, 2, q);
 	if (!q->poll_cb)
-- 
2.12.1
