Return-Path: <prvs=4411c008b=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	=Oleksandr Natalenko <oleksandr@natalenko.name>,
	"Luis R . Rodriguez" <mcgrof@kernel.org>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Ming Lei <ming.lei@redhat.com>,
	Hannes Reinecke <hare@suse.com>,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH v5 5/8] block: Add the QUEUE_FLAG_PREEMPT_ONLY request queue flag
Date: Mon,  2 Oct 2017 15:52:15 -0700
Message-Id: <20171002225218.18548-6-bart.vanassche@wdc.com>
In-Reply-To: <20171002225218.18548-1-bart.vanassche@wdc.com>
References: <20171002225218.18548-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

This flag will be used in the next patch to let the block layer
core know whether or not a SCSI request queue has been quiesced.
A quiesced SCSI queue namely only processes RQF_PREEMPT requests.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
---
 block/blk-core.c       | 20 ++++++++++++++++++++
 include/linux/blkdev.h |  6 ++++++
 2 files changed, 26 insertions(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index 0343c7574378..c4c7fd4dcc2a 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -346,6 +346,26 @@ void blk_sync_queue(struct request_queue *q)
 }
 EXPORT_SYMBOL(blk_sync_queue);
 
+void blk_set_preempt_only(struct request_queue *q)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(q->queue_lock, flags);
+	queue_flag_set(QUEUE_FLAG_PREEMPT_ONLY, q);
+	spin_unlock_irqrestore(q->queue_lock, flags);
+}
+EXPORT_SYMBOL(blk_set_preempt_only);
+
+void blk_clear_preempt_only(struct request_queue *q)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(q->queue_lock, flags);
+	queue_flag_clear(QUEUE_FLAG_PREEMPT_ONLY, q);
+	spin_unlock_irqrestore(q->queue_lock, flags);
+}
+EXPORT_SYMBOL(blk_clear_preempt_only);
+
 /**
  * __blk_run_queue_uncond - run a queue whether or not it has been stopped
  * @q:	The queue to run
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index ab6b6c0392c2..50bf37dacf4c 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -628,6 +628,7 @@ struct request_queue {
 #define QUEUE_FLAG_REGISTERED  26	/* queue has been registered to a disk */
 #define QUEUE_FLAG_SCSI_PASSTHROUGH 27	/* queue supports SCSI commands */
 #define QUEUE_FLAG_QUIESCED    28	/* queue has been quiesced */
+#define QUEUE_FLAG_PREEMPT_ONLY	29	/* only process REQ_PREEMPT requests */
 
 #define QUEUE_FLAG_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\
 				 (1 << QUEUE_FLAG_STACKABLE)	|	\
@@ -732,6 +733,11 @@ static inline void queue_flag_clear(unsigned int flag, struct request_queue *q)
 	((rq)->cmd_flags & (REQ_FAILFAST_DEV|REQ_FAILFAST_TRANSPORT| \
 			     REQ_FAILFAST_DRIVER))
 #define blk_queue_quiesced(q)	test_bit(QUEUE_FLAG_QUIESCED, &(q)->queue_flags)
+#define blk_queue_preempt_only(q)				\
+	test_bit(QUEUE_FLAG_PREEMPT_ONLY, &(q)->queue_flags)
+
+extern void blk_set_preempt_only(struct request_queue *q);
+extern void blk_clear_preempt_only(struct request_queue *q);
 
 static inline bool blk_account_rq(struct request *rq)
 {
-- 
2.14.1
