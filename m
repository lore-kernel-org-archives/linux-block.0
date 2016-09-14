Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44928 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1761323AbcINR27 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Sep 2016 13:28:59 -0400
Date: Wed, 14 Sep 2016 13:28:30 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: [PATCH v3 1/6] blk-mq: introduce blk_mq_delay_kick_requeue_list()
Message-ID: <20160914172829.GA55842@redhat.com>
References: <1473870576-54331-1-git-send-email-snitzer@redhat.com>
 <1473870576-54331-2-git-send-email-snitzer@redhat.com>
 <7b569638-e572-d386-d170-b49c30f5e506@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7b569638-e572-d386-d170-b49c30f5e506@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

blk_mq_delay_kick_requeue_list() provides the ability to kick the
q->requeue_list after a specified time.  To do this the request_queue's
'requeue_work' member was changed to a delayed_work.

blk_mq_delay_kick_requeue_list() allows DM to defer processing requeued
requests while it doesn't make sense to immediately requeue them
(e.g. when all paths in a DM multipath have failed).

Signed-off-by: Mike Snitzer <snitzer@redhat.com>
---
 block/blk-mq.c         | 16 ++++++++++++----
 include/linux/blk-mq.h |  1 +
 include/linux/blkdev.h |  2 +-
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 13f5a6c..844c2f3 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -501,7 +501,7 @@ EXPORT_SYMBOL(blk_mq_requeue_request);
 static void blk_mq_requeue_work(struct work_struct *work)
 {
 	struct request_queue *q =
-		container_of(work, struct request_queue, requeue_work);
+		container_of(work, struct request_queue, requeue_work.work);
 	LIST_HEAD(rq_list);
 	struct request *rq, *next;
 	unsigned long flags;
@@ -556,16 +556,24 @@ EXPORT_SYMBOL(blk_mq_add_to_requeue_list);
 
 void blk_mq_cancel_requeue_work(struct request_queue *q)
 {
-	cancel_work_sync(&q->requeue_work);
+	cancel_delayed_work_sync(&q->requeue_work);
 }
 EXPORT_SYMBOL_GPL(blk_mq_cancel_requeue_work);
 
 void blk_mq_kick_requeue_list(struct request_queue *q)
 {
-	kblockd_schedule_work(&q->requeue_work);
+	kblockd_schedule_delayed_work(&q->requeue_work, 0);
 }
 EXPORT_SYMBOL(blk_mq_kick_requeue_list);
 
+void blk_mq_delay_kick_requeue_list(struct request_queue *q,
+				    unsigned long msecs)
+{
+	kblockd_schedule_delayed_work(&q->requeue_work,
+				      msecs_to_jiffies(msecs));
+}
+EXPORT_SYMBOL(blk_mq_delay_kick_requeue_list);
+
 void blk_mq_abort_requeue_list(struct request_queue *q)
 {
 	unsigned long flags;
@@ -2082,7 +2090,7 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 
 	q->sg_reserved_size = INT_MAX;
 
-	INIT_WORK(&q->requeue_work, blk_mq_requeue_work);
+	INIT_DELAYED_WORK(&q->requeue_work, blk_mq_requeue_work);
 	INIT_LIST_HEAD(&q->requeue_list);
 	spin_lock_init(&q->requeue_lock);
 
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index e43bbff..ecec4b8 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -232,6 +232,7 @@ void blk_mq_requeue_request(struct request *rq);
 void blk_mq_add_to_requeue_list(struct request *rq, bool at_head);
 void blk_mq_cancel_requeue_work(struct request_queue *q);
 void blk_mq_kick_requeue_list(struct request_queue *q);
+void blk_mq_delay_kick_requeue_list(struct request_queue *q, unsigned long msecs);
 void blk_mq_abort_requeue_list(struct request_queue *q);
 void blk_mq_complete_request(struct request *rq, int error);
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index e79055c..b0a6189 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -449,7 +449,7 @@ struct request_queue {
 
 	struct list_head	requeue_list;
 	spinlock_t		requeue_lock;
-	struct work_struct	requeue_work;
+	struct delayed_work	requeue_work;
 
 	struct mutex		sysfs_lock;
 
-- 
2.7.4 (Apple Git-66)

