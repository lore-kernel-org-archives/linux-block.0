Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34586 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752740AbdC0MHl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Mar 2017 08:07:41 -0400
Received: by mail-pg0-f68.google.com with SMTP id o123so9635234pga.1
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2017 05:07:40 -0700 (PDT)
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Cc: Bart Van Assche <bart.vanassche@sandisk.com>,
        Hannes Reinecke <hare@suse.de>,
        Ming Lei <tom.leiming@gmail.com>, Tejun Heo <tj@kernel.org>
Subject: [PATCH v3 4/4] block: block new I/O just after queue is set as dying
Date: Mon, 27 Mar 2017 20:06:58 +0800
Message-Id: <20170327120658.29864-5-tom.leiming@gmail.com>
In-Reply-To: <20170327120658.29864-1-tom.leiming@gmail.com>
References: <20170327120658.29864-1-tom.leiming@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Before commit 780db2071a(blk-mq: decouble blk-mq freezing
from generic bypassing), the dying flag is checked before
entering queue, and Tejun converts the checking into .mq_freeze_depth,
and assumes the counter is increased just after dying flag
is set. Unfortunately we doesn't do that in blk_set_queue_dying().

This patch calls blk_freeze_queue_start() in blk_set_queue_dying(),
so that we can block new I/O coming once the queue is set as dying.

Given blk_set_queue_dying() is always called in remove path
of block device, and queue will be cleaned up later, we don't
need to worry about undoing the counter.

Cc: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Tejun Heo <tj@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 block/blk-core.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 60f364e1d36b..e22c4ea002ec 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -500,6 +500,13 @@ void blk_set_queue_dying(struct request_queue *q)
 	queue_flag_set(QUEUE_FLAG_DYING, q);
 	spin_unlock_irq(q->queue_lock);
 
+	/*
+	 * When queue DYING flag is set, we need to block new req
+	 * entering queue, so we call blk_freeze_queue_start() to
+	 * prevent I/O from crossing blk_queue_enter().
+	 */
+	blk_freeze_queue_start(q);
+
 	if (q->mq_ops)
 		blk_mq_wake_waiters(q);
 	else {
@@ -672,9 +679,9 @@ int blk_queue_enter(struct request_queue *q, bool nowait)
 		/*
 		 * read pair of barrier in blk_freeze_queue_start(),
 		 * we need to order reading __PERCPU_REF_DEAD flag of
-		 * .q_usage_counter and reading .mq_freeze_depth,
-		 * otherwise the following wait may never return if the
-		 * two reads are reordered.
+		 * .q_usage_counter and reading .mq_freeze_depth or
+		 * queue dying flag, otherwise the following wait may
+		 * never return if the two reads are reordered.
 		 */
 		smp_rmb();
 
-- 
2.9.3
