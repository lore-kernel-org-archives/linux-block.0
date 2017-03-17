Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34534 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751320AbdCQJ7X (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Mar 2017 05:59:23 -0400
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Cc: Yi Zhang <yizhan@redhat.com>,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        Ming Lei <tom.leiming@gmail.com>, Tejun Heo <tj@kernel.org>
Subject: [PATCH v1 3/3] blk-mq: start to freeze queue just after setting dying
Date: Fri, 17 Mar 2017 17:57:11 +0800
Message-Id: <20170317095711.5819-4-tom.leiming@gmail.com>
In-Reply-To: <20170317095711.5819-1-tom.leiming@gmail.com>
References: <20170317095711.5819-1-tom.leiming@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Before commit 780db2071a(blk-mq: decouble blk-mq freezing
from generic bypassing), the dying flag is checked before
entering queue, and Tejun converts the checking into .mq_freeze_depth,
and assumes the counter is increased just after dying flag
is set. Unfortunately we doesn't do that in blk_set_queue_dying().

This patch calls blk_mq_freeze_queue_start() for blk-mq in
blk_set_queue_dying(), so that we can block new I/O coming
once the queue is set as dying.

Given blk_set_queue_dying() is always called in remove path
of block device, and queue will be cleaned up later, we don't
need to worry about undoing the counter.

Cc: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Tejun Heo <tj@kernel.org>
Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 block/blk-core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index d772c221cc17..62d4967c369f 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -500,9 +500,12 @@ void blk_set_queue_dying(struct request_queue *q)
 	queue_flag_set(QUEUE_FLAG_DYING, q);
 	spin_unlock_irq(q->queue_lock);
 
-	if (q->mq_ops)
+	if (q->mq_ops) {
 		blk_mq_wake_waiters(q);
-	else {
+
+		/* block new I/O coming */
+		blk_mq_freeze_queue_start(q);
+	} else {
 		struct request_list *rl;
 
 		spin_lock_irq(q->queue_lock);
-- 
2.9.3
