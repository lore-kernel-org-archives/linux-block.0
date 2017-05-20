Return-Path: <ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <keith.busch@intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	Zhang Yi <yizhan@redhat.com>,
	linux-block@vger.kernel.org,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v2 3/3] blk-mq: remove blk_mq_abort_requeue_list()
Date: Sat, 20 May 2017 11:56:05 +0800
Message-Id: <20170520035605.21785-4-ming.lei@redhat.com>
In-Reply-To: <20170520035605.21785-1-ming.lei@redhat.com>
References: <20170520035605.21785-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

No one uses it any more, so remove it.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c         | 19 -------------------
 include/linux/blk-mq.h |  1 -
 2 files changed, 20 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index a69ad122ed66..f2224ffd225d 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -628,25 +628,6 @@ void blk_mq_delay_kick_requeue_list(struct request_queue *q,
 }
 EXPORT_SYMBOL(blk_mq_delay_kick_requeue_list);
 
-void blk_mq_abort_requeue_list(struct request_queue *q)
-{
-	unsigned long flags;
-	LIST_HEAD(rq_list);
-
-	spin_lock_irqsave(&q->requeue_lock, flags);
-	list_splice_init(&q->requeue_list, &rq_list);
-	spin_unlock_irqrestore(&q->requeue_lock, flags);
-
-	while (!list_empty(&rq_list)) {
-		struct request *rq;
-
-		rq = list_first_entry(&rq_list, struct request, queuelist);
-		list_del_init(&rq->queuelist);
-		blk_mq_end_request(rq, -EIO);
-	}
-}
-EXPORT_SYMBOL(blk_mq_abort_requeue_list);
-
 struct request *blk_mq_tag_to_rq(struct blk_mq_tags *tags, unsigned int tag)
 {
 	if (tag < tags->nr_tags) {
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index c47aa248c640..fcd641032f8d 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -238,7 +238,6 @@ void blk_mq_add_to_requeue_list(struct request *rq, bool at_head,
 				bool kick_requeue_list);
 void blk_mq_kick_requeue_list(struct request_queue *q);
 void blk_mq_delay_kick_requeue_list(struct request_queue *q, unsigned long msecs);
-void blk_mq_abort_requeue_list(struct request_queue *q);
 void blk_mq_complete_request(struct request *rq);
 
 bool blk_mq_queue_stopped(struct request_queue *q);
-- 
2.9.4
