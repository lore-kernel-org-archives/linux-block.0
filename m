Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33490 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932250AbdCINMG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Mar 2017 08:12:06 -0500
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Cc: Yi Zhang <yizhan@redhat.com>, Ming Lei <tom.leiming@gmail.com>,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 2/2] blk-mq: start to freeze queue just after setting dying
Date: Thu,  9 Mar 2017 21:02:58 +0800
Message-Id: <1489064578-17305-4-git-send-email-tom.leiming@gmail.com>
In-Reply-To: <1489064578-17305-1-git-send-email-tom.leiming@gmail.com>
References: <1489064578-17305-1-git-send-email-tom.leiming@gmail.com>
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
need to worry about undo of the counter.

Cc: Tejun Heo <tj@kernel.org>
Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 block/blk-core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 0eeb99ef654f..559487e58296 100644
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
2.7.4
