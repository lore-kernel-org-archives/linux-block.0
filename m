Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f45.google.com ([74.125.83.45]:34764 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932088AbdC1XNk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Mar 2017 19:13:40 -0400
Received: by mail-pg0-f45.google.com with SMTP id 21so85758699pgg.1
        for <linux-block@vger.kernel.org>; Tue, 28 Mar 2017 16:13:20 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: kernel-team@fb.com
Subject: [PATCH v2 2/3] blk-mq: fix leak of q->stats
Date: Tue, 28 Mar 2017 16:12:16 -0700
Message-Id: <0c03f37f5c643eda28a3f1368425c55e407e3ffd.1490742717.git.osandov@fb.com>
In-Reply-To: <91d938665e5386f10f8756ee8c7ef3e6496ea260.1490742717.git.osandov@fb.com>
References: <91d938665e5386f10f8756ee8c7ef3e6496ea260.1490742717.git.osandov@fb.com>
In-Reply-To: <91d938665e5386f10f8756ee8c7ef3e6496ea260.1490742717.git.osandov@fb.com>
References: <91d938665e5386f10f8756ee8c7ef3e6496ea260.1490742717.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

blk_alloc_queue_node() already allocates q->stats, so
blk_mq_init_allocated_queue() is overwriting it with a new allocation.

Fixes: a83b576c9c25 ("block: fix stacked driver stats init and free")
Reviewed-by: Ming Lei <tom.leiming@gmail.com>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 block/blk-mq.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 7df9dbfab022..00eeef31db30 100644
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
