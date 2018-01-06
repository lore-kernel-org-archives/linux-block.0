Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44350 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752450AbeAFI27 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 6 Jan 2018 03:28:59 -0500
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Cc: Bart Van Assche <bart.vanassche@sandisk.com>,
        Yi Zhang <yi.zhang@redhat.com>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 4/4] blk-mq: fix race between updating nr_hw_queues and switching io sched
Date: Sat,  6 Jan 2018 16:27:40 +0800
Message-Id: <20180106082740.26442-5-ming.lei@redhat.com>
In-Reply-To: <20180106082740.26442-1-ming.lei@redhat.com>
References: <20180106082740.26442-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

In both elevator_switch_mq() and blk_mq_update_nr_hw_queues(), sched tags
can be allocated, and q->nr_hw_queue is used, and race is inevitable, for
example: blk_mq_init_sched() may trigger use-after-free on hctx, which is
freed in blk_mq_realloc_hw_ctxs() when nr_hw_queues is decreased.

This patch fixes the race be holding q->sysfs_lock.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reported-by: Yi Zhang <yi.zhang@redhat.com>
Tested-by: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index dd21051fb251..111e1aa5562f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2407,6 +2407,9 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 	struct blk_mq_hw_ctx **hctxs = q->queue_hw_ctx;
 
 	blk_mq_sysfs_unregister(q);
+
+	/* protect against switching io scheduler  */
+	mutex_lock(&q->sysfs_lock);
 	for (i = 0; i < set->nr_hw_queues; i++) {
 		int node;
 
@@ -2451,6 +2454,7 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 		}
 	}
 	q->nr_hw_queues = i;
+	mutex_unlock(&q->sysfs_lock);
 	blk_mq_sysfs_register(q);
 }
 
-- 
2.9.5
