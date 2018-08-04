Return-Path: <prvs=7477a5644=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Ming Lei <ming.lei@redhat.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH v4 03/10] block, ide: Remove flag BLK_MQ_REQ_PREEMPT
Date: Fri,  3 Aug 2018 17:03:18 -0700
Message-Id: <20180804000325.3610-4-bart.vanassche@wdc.com>
In-Reply-To: <20180804000325.3610-1-bart.vanassche@wdc.com>
References: <20180804000325.3610-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Since it is no longer necessary that blk_get_request() knowns whether
or not RQF_PREEMPT will be set, remove flag BLK_MQ_REQ_PREEMPT. This
patch does not change any functionality. See also 039c635f4e66 ("ide,
scsi: Tell the block layer at request allocation time about preempt
requests").

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
---
 block/blk-core.c       | 9 +++------
 block/blk-mq.c         | 2 --
 drivers/ide/ide-pm.c   | 3 ++-
 include/linux/blk-mq.h | 4 +---
 4 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 3378fe478e67..3a5aa56eab9d 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -908,7 +908,7 @@ EXPORT_SYMBOL(blk_alloc_queue);
 /**
  * blk_queue_enter() - try to increase q->q_usage_counter
  * @q: request queue pointer
- * @flags: BLK_MQ_REQ_NOWAIT, BLK_MQ_REQ_PREEMPT and/or BLK_MQ_REQ_PM
+ * @flags: BLK_MQ_REQ_NOWAIT and/or BLK_MQ_REQ_PM
  */
 int blk_queue_enter(struct request_queue *q, blk_mq_req_flags_t flags)
 {
@@ -1431,8 +1431,6 @@ static struct request *__get_request(struct request_list *rl, unsigned int op,
 	blk_rq_set_rl(rq, rl);
 	rq->cmd_flags = op;
 	rq->rq_flags = rq_flags;
-	if (flags & BLK_MQ_REQ_PREEMPT)
-		rq->rq_flags |= RQF_PREEMPT;
 
 	/* init elvpriv */
 	if (rq_flags & RQF_ELVPRIV) {
@@ -1570,7 +1568,7 @@ static struct request *get_request(struct request_queue *q, unsigned int op,
 	goto retry;
 }
 
-/* flags: BLK_MQ_REQ_PREEMPT, BLK_MQ_REQ_PM and/or BLK_MQ_REQ_NOWAIT. */
+/* flags: BLK_MQ_REQ_PM and/or BLK_MQ_REQ_NOWAIT. */
 static struct request *blk_old_get_request(struct request_queue *q,
 				unsigned int op, blk_mq_req_flags_t flags)
 {
@@ -1613,8 +1611,7 @@ struct request *blk_get_request(struct request_queue *q, unsigned int op,
 	struct request *req;
 
 	WARN_ON_ONCE(op & REQ_NOWAIT);
-	WARN_ON_ONCE(flags & ~(BLK_MQ_REQ_NOWAIT | BLK_MQ_REQ_PREEMPT |
-			       BLK_MQ_REQ_PM));
+	WARN_ON_ONCE(flags & ~(BLK_MQ_REQ_NOWAIT | BLK_MQ_REQ_PM));
 
 	if (q->mq_ops) {
 		req = blk_mq_alloc_request(q, op, flags);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index c92ce06fd565..8b23ae34d949 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -300,8 +300,6 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 	rq->rq_flags = rq_flags;
 	rq->cpu = -1;
 	rq->cmd_flags = op;
-	if (data->flags & BLK_MQ_REQ_PREEMPT)
-		rq->rq_flags |= RQF_PREEMPT;
 	if (blk_queue_io_stat(data->q))
 		rq->rq_flags |= RQF_IO_STAT;
 	INIT_LIST_HEAD(&rq->queuelist);
diff --git a/drivers/ide/ide-pm.c b/drivers/ide/ide-pm.c
index 59217aa1d1fb..10d10e01c0f4 100644
--- a/drivers/ide/ide-pm.c
+++ b/drivers/ide/ide-pm.c
@@ -90,8 +90,9 @@ int generic_ide_resume(struct device *dev)
 	}
 
 	memset(&rqpm, 0, sizeof(rqpm));
-	rq = blk_get_request(drive->queue, REQ_OP_DRV_IN, BLK_MQ_REQ_PREEMPT);
+	rq = blk_get_request(drive->queue, REQ_OP_DRV_IN, 0);
 	ide_req(rq)->type = ATA_PRIV_PM_RESUME;
+	rq->rq_flags |= RQF_PREEMPT;
 	rq->special = &rqpm;
 	rqpm.pm_step = IDE_PM_START_RESUME;
 	rqpm.pm_state = PM_EVENT_ON;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index f15c1de51f5e..59f99b0019bb 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -221,10 +221,8 @@ enum {
 	BLK_MQ_REQ_RESERVED	= (__force blk_mq_req_flags_t)(1 << 1),
 	/* allocate internal/sched tag */
 	BLK_MQ_REQ_INTERNAL	= (__force blk_mq_req_flags_t)(1 << 2),
-	/* set RQF_PREEMPT */
-	BLK_MQ_REQ_PREEMPT	= (__force blk_mq_req_flags_t)(1 << 3),
 	/* for power management requests */
-	BLK_MQ_REQ_PM		= (__force blk_mq_req_flags_t)(1 << 4),
+	BLK_MQ_REQ_PM		= (__force blk_mq_req_flags_t)(1 << 3),
 };
 
 struct request *blk_mq_alloc_request(struct request_queue *q, unsigned int op,
-- 
2.18.0
