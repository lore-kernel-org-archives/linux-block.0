Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34798 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932434AbdCXMgw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Mar 2017 08:36:52 -0400
Received: by mail-pf0-f194.google.com with SMTP id o126so207017pfb.1
        for <linux-block@vger.kernel.org>; Fri, 24 Mar 2017 05:36:52 -0700 (PDT)
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Cc: Bart Van Assche <bart.vanassche@sandisk.com>,
        Hannes Reinecke <hare@suse.de>,
        Ming Lei <tom.leiming@gmail.com>, Tejun Heo <tj@kernel.org>
Subject: [PATCH v2 4/4] block: block new I/O just after queue is set as dying
Date: Fri, 24 Mar 2017 20:36:21 +0800
Message-Id: <20170324123621.5227-5-tom.leiming@gmail.com>
In-Reply-To: <20170324123621.5227-1-tom.leiming@gmail.com>
References: <20170324123621.5227-1-tom.leiming@gmail.com>
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
 block/blk-core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 5901133d105f..f0dd9b0054ed 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -500,6 +500,9 @@ void blk_set_queue_dying(struct request_queue *q)
 	queue_flag_set(QUEUE_FLAG_DYING, q);
 	spin_unlock_irq(q->queue_lock);
 
+	/* block new I/O coming */
+	blk_freeze_queue_start(q);
+
 	if (q->mq_ops)
 		blk_mq_wake_waiters(q);
 	else {
@@ -672,8 +675,9 @@ int blk_queue_enter(struct request_queue *q, bool nowait)
 		/*
 		 * read pair of barrier in blk_freeze_queue_start(),
 		 * we need to order reading DEAD flag of .q_usage_counter
-		 * and reading .mq_freeze_depth, otherwise the following
-		 * wait may never return if the two read are reordered.
+		 * and reading .mq_freeze_depth or dying flag, otherwise
+		 * the following wait may never return if the two read
+		 * are reordered.
 		 */
 		smp_rmb();
 
-- 
2.9.3
