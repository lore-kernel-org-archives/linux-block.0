Return-Path: <ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org
Subject: [RFC PATCH 01/14] blk-mq: allow to pass default queue flags for creating & initializing queue
Date: Wed,  8 Aug 2018 01:44:20 +0800
Message-Id: <20180807174433.8374-2-ming.lei@redhat.com>
In-Reply-To: <20180807174433.8374-1-ming.lei@redhat.com>
References: <20180807174433.8374-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

Prepare for converting the flag of BLK_MQ_F_NO_SCHED into per-queue
flag, since the following patches need this way for supporting per-host
admin queue.

Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c         | 16 +++++++++-------
 include/linux/blk-mq.h | 19 ++++++++++++++++---
 2 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index c92ce06fd565..e2d0fe503d8d 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2479,7 +2479,8 @@ void blk_mq_release(struct request_queue *q)
 	free_percpu(q->queue_ctx);
 }
 
-struct request_queue *blk_mq_init_queue(struct blk_mq_tag_set *set)
+struct request_queue *__blk_mq_init_queue(struct blk_mq_tag_set *set,
+					  unsigned long def_flags)
 {
 	struct request_queue *uninit_q, *q;
 
@@ -2487,13 +2488,13 @@ struct request_queue *blk_mq_init_queue(struct blk_mq_tag_set *set)
 	if (!uninit_q)
 		return ERR_PTR(-ENOMEM);
 
-	q = blk_mq_init_allocated_queue(set, uninit_q);
+	q = __blk_mq_init_allocated_queue(set, uninit_q, def_flags);
 	if (IS_ERR(q))
 		blk_cleanup_queue(uninit_q);
 
 	return q;
 }
-EXPORT_SYMBOL(blk_mq_init_queue);
+EXPORT_SYMBOL(__blk_mq_init_queue);
 
 static int blk_mq_hw_ctx_size(struct blk_mq_tag_set *tag_set)
 {
@@ -2567,8 +2568,9 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 	blk_mq_sysfs_register(q);
 }
 
-struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
-						  struct request_queue *q)
+struct request_queue *__blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
+						    struct request_queue *q,
+						    unsigned long def_flags)
 {
 	/* mark the queue as mq asap */
 	q->mq_ops = set->ops;
@@ -2602,7 +2604,7 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 
 	q->nr_queues = nr_cpu_ids;
 
-	q->queue_flags |= QUEUE_FLAG_MQ_DEFAULT;
+	q->queue_flags |= def_flags;
 
 	if (!(set->flags & BLK_MQ_F_SG_MERGE))
 		queue_flag_set_unlocked(QUEUE_FLAG_NO_SG_MERGE, q);
@@ -2652,7 +2654,7 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	q->mq_ops = NULL;
 	return ERR_PTR(-ENOMEM);
 }
-EXPORT_SYMBOL(blk_mq_init_allocated_queue);
+EXPORT_SYMBOL(__blk_mq_init_allocated_queue);
 
 void blk_mq_free_queue(struct request_queue *q)
 {
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 1da59c16f637..7f6ecd7b35ce 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -200,9 +200,22 @@ enum {
 	((policy & ((1 << BLK_MQ_F_ALLOC_POLICY_BITS) - 1)) \
 		<< BLK_MQ_F_ALLOC_POLICY_START_BIT)
 
-struct request_queue *blk_mq_init_queue(struct blk_mq_tag_set *);
-struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
-						  struct request_queue *q);
+struct request_queue *__blk_mq_init_queue(struct blk_mq_tag_set *, unsigned long);
+struct request_queue *__blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
+						    struct request_queue *q,
+						    unsigned long def_flags);
+
+static inline struct request_queue *blk_mq_init_queue(struct blk_mq_tag_set *set)
+{
+	return __blk_mq_init_queue(set, QUEUE_FLAG_MQ_DEFAULT);
+}
+
+static inline struct request_queue *
+blk_mq_init_allocated_queue(struct blk_mq_tag_set *set, struct request_queue *q)
+{
+	return __blk_mq_init_allocated_queue(set, q, QUEUE_FLAG_MQ_DEFAULT);
+}
+
 int blk_mq_register_dev(struct device *, struct request_queue *);
 void blk_mq_unregister_dev(struct device *, struct request_queue *);
 
-- 
2.9.5
