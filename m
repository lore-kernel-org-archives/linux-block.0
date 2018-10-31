Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org,
	linux-ide@vger.kernel.org,
	linux-scsi@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 14/30] bsg: convert to use blk-mq
Date: Wed, 31 Oct 2018 11:59:06 -0600
Message-Id: <20181031175922.8849-15-axboe@kernel.dk>
In-Reply-To: <20181031175922.8849-1-axboe@kernel.dk>
References: <20181031175922.8849-1-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

Requires a few changes to the FC transport class as well.

Cc: linux-scsi@vger.kernel.org
Reviewed-by: Hannes Reinecke <hare@suse.com>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Tested-by: Benjamin Block <bblock@linux.vnet.ibm.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/bsg-lib.c                  | 123 +++++++++++++++++++------------
 drivers/scsi/scsi_transport_fc.c |  59 +++++++++------
 2 files changed, 110 insertions(+), 72 deletions(-)

diff --git a/block/bsg-lib.c b/block/bsg-lib.c
index 3f2e9a1bae44..faf20f4500c9 100644
--- a/block/bsg-lib.c
+++ b/block/bsg-lib.c
@@ -21,7 +21,7 @@
  *
  */
 #include <linux/slab.h>
-#include <linux/blkdev.h>
+#include <linux/blk-mq.h>
 #include <linux/delay.h>
 #include <linux/scatterlist.h>
 #include <linux/bsg-lib.h>
@@ -129,7 +129,7 @@ static void bsg_teardown_job(struct kref *kref)
 	kfree(job->request_payload.sg_list);
 	kfree(job->reply_payload.sg_list);
 
-	blk_end_request_all(rq, BLK_STS_OK);
+	blk_mq_end_request(rq, BLK_STS_OK);
 }
 
 void bsg_job_put(struct bsg_job *job)
@@ -157,15 +157,15 @@ void bsg_job_done(struct bsg_job *job, int result,
 {
 	job->result = result;
 	job->reply_payload_rcv_len = reply_payload_rcv_len;
-	blk_complete_request(blk_mq_rq_from_pdu(job));
+	blk_mq_complete_request(blk_mq_rq_from_pdu(job));
 }
 EXPORT_SYMBOL_GPL(bsg_job_done);
 
 /**
- * bsg_softirq_done - softirq done routine for destroying the bsg requests
+ * bsg_complete - softirq done routine for destroying the bsg requests
  * @rq: BSG request that holds the job to be destroyed
  */
-static void bsg_softirq_done(struct request *rq)
+static void bsg_complete(struct request *rq)
 {
 	struct bsg_job *job = blk_mq_rq_to_pdu(rq);
 
@@ -224,54 +224,46 @@ static bool bsg_prepare_job(struct device *dev, struct request *req)
 }
 
 /**
- * bsg_request_fn - generic handler for bsg requests
- * @q: request queue to manage
+ * bsg_queue_rq - generic handler for bsg requests
+ * @hctx: hardware queue
+ * @bd: queue data
  *
  * On error the create_bsg_job function should return a -Exyz error value
  * that will be set to ->result.
  *
  * Drivers/subsys should pass this to the queue init function.
  */
-static void bsg_request_fn(struct request_queue *q)
-	__releases(q->queue_lock)
-	__acquires(q->queue_lock)
+static blk_status_t bsg_queue_rq(struct blk_mq_hw_ctx *hctx,
+				 const struct blk_mq_queue_data *bd)
 {
+	struct request_queue *q = hctx->queue;
 	struct device *dev = q->queuedata;
-	struct request *req;
+	struct request *req = bd->rq;
 	int ret;
 
+	blk_mq_start_request(req);
+
 	if (!get_device(dev))
-		return;
-
-	while (1) {
-		req = blk_fetch_request(q);
-		if (!req)
-			break;
-		spin_unlock_irq(q->queue_lock);
-
-		if (!bsg_prepare_job(dev, req)) {
-			blk_end_request_all(req, BLK_STS_OK);
-			spin_lock_irq(q->queue_lock);
-			continue;
-		}
-
-		ret = q->bsg_job_fn(blk_mq_rq_to_pdu(req));
-		spin_lock_irq(q->queue_lock);
-		if (ret)
-			break;
-	}
+		return BLK_STS_IOERR;
+
+	if (!bsg_prepare_job(dev, req))
+		return BLK_STS_IOERR;
+
+	ret = q->bsg_job_fn(blk_mq_rq_to_pdu(req));
+	if (ret)
+		return BLK_STS_IOERR;
 
-	spin_unlock_irq(q->queue_lock);
 	put_device(dev);
-	spin_lock_irq(q->queue_lock);
+	return BLK_STS_OK;
 }
 
 /* called right after the request is allocated for the request_queue */
-static int bsg_init_rq(struct request_queue *q, struct request *req, gfp_t gfp)
+static int bsg_init_rq(struct blk_mq_tag_set *set, struct request *req,
+		       unsigned int hctx_idx, unsigned int numa_node)
 {
 	struct bsg_job *job = blk_mq_rq_to_pdu(req);
 
-	job->reply = kzalloc(SCSI_SENSE_BUFFERSIZE, gfp);
+	job->reply = kzalloc(SCSI_SENSE_BUFFERSIZE, GFP_KERNEL);
 	if (!job->reply)
 		return -ENOMEM;
 	return 0;
@@ -289,7 +281,8 @@ static void bsg_initialize_rq(struct request *req)
 	job->dd_data = job + 1;
 }
 
-static void bsg_exit_rq(struct request_queue *q, struct request *req)
+static void bsg_exit_rq(struct blk_mq_tag_set *set, struct request *req,
+		       unsigned int hctx_idx)
 {
 	struct bsg_job *job = blk_mq_rq_to_pdu(req);
 
@@ -299,12 +292,36 @@ static void bsg_exit_rq(struct request_queue *q, struct request *req)
 void bsg_remove_queue(struct request_queue *q)
 {
 	if (q) {
+		struct blk_mq_tag_set *set = q->tag_set;
+
 		bsg_unregister_queue(q);
 		blk_cleanup_queue(q);
+		blk_mq_free_tag_set(set);
+		kfree(set);
 	}
 }
 EXPORT_SYMBOL_GPL(bsg_remove_queue);
 
+static enum blk_eh_timer_return bsg_timeout(struct request *rq, bool reserved)
+{
+	enum blk_eh_timer_return ret = BLK_EH_DONE;
+	struct request_queue *q = rq->q;
+
+	if (q->rq_timed_out_fn)
+		ret = q->rq_timed_out_fn(rq);
+
+	return ret;
+}
+
+static const struct blk_mq_ops bsg_mq_ops = {
+	.queue_rq		= bsg_queue_rq,
+	.init_request		= bsg_init_rq,
+	.exit_request		= bsg_exit_rq,
+	.initialize_rq_fn	= bsg_initialize_rq,
+	.complete		= bsg_complete,
+	.timeout		= bsg_timeout,
+};
+
 /**
  * bsg_setup_queue - Create and add the bsg hooks so we can receive requests
  * @dev: device to attach bsg device to
@@ -315,28 +332,34 @@ EXPORT_SYMBOL_GPL(bsg_remove_queue);
 struct request_queue *bsg_setup_queue(struct device *dev, const char *name,
 		bsg_job_fn *job_fn, rq_timed_out_fn *timeout, int dd_job_size)
 {
+	struct blk_mq_tag_set *set;
 	struct request_queue *q;
-	int ret;
+	int ret = -ENOMEM;
 
-	q = blk_alloc_queue(GFP_KERNEL);
-	if (!q)
+	set = kzalloc(sizeof(*set), GFP_KERNEL);
+	if (!set)
 		return ERR_PTR(-ENOMEM);
-	q->cmd_size = sizeof(struct bsg_job) + dd_job_size;
-	q->init_rq_fn = bsg_init_rq;
-	q->exit_rq_fn = bsg_exit_rq;
-	q->initialize_rq_fn = bsg_initialize_rq;
-	q->request_fn = bsg_request_fn;
 
-	ret = blk_init_allocated_queue(q);
-	if (ret)
-		goto out_cleanup_queue;
+	set->ops = &bsg_mq_ops,
+	set->nr_hw_queues = 1;
+	set->queue_depth = 128;
+	set->numa_node = NUMA_NO_NODE;
+	set->cmd_size = sizeof(struct bsg_job) + dd_job_size;
+	set->flags = BLK_MQ_F_NO_SCHED | BLK_MQ_F_BLOCKING;
+	if (blk_mq_alloc_tag_set(set))
+		goto out_tag_set;
+
+	q = blk_mq_init_queue(set);
+	if (IS_ERR(q)) {
+		ret = PTR_ERR(q);
+		goto out_queue;
+	}
 
 	q->queuedata = dev;
 	q->bsg_job_fn = job_fn;
 	blk_queue_flag_set(QUEUE_FLAG_BIDI, q);
-	blk_queue_softirq_done(q, bsg_softirq_done);
 	blk_queue_rq_timeout(q, BLK_DEFAULT_SG_TIMEOUT);
-	blk_queue_rq_timed_out(q, timeout);
+	q->rq_timed_out_fn = timeout;
 
 	ret = bsg_register_queue(q, dev, name, &bsg_transport_ops);
 	if (ret) {
@@ -348,6 +371,10 @@ struct request_queue *bsg_setup_queue(struct device *dev, const char *name,
 	return q;
 out_cleanup_queue:
 	blk_cleanup_queue(q);
+out_queue:
+	blk_mq_free_tag_set(set);
+out_tag_set:
+	kfree(set);
 	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL_GPL(bsg_setup_queue);
diff --git a/drivers/scsi/scsi_transport_fc.c b/drivers/scsi/scsi_transport_fc.c
index 638f83ab04b2..d7035270d274 100644
--- a/drivers/scsi/scsi_transport_fc.c
+++ b/drivers/scsi/scsi_transport_fc.c
@@ -3592,7 +3592,7 @@ fc_bsg_job_timeout(struct request *req)
 
 	/* the blk_end_sync_io() doesn't check the error */
 	if (inflight)
-		__blk_complete_request(req);
+		blk_mq_end_request(req, BLK_STS_IOERR);
 	return BLK_EH_DONE;
 }
 
@@ -3684,14 +3684,9 @@ static void
 fc_bsg_goose_queue(struct fc_rport *rport)
 {
 	struct request_queue *q = rport->rqst_q;
-	unsigned long flags;
-
-	if (!q)
-		return;
 
-	spin_lock_irqsave(q->queue_lock, flags);
-	blk_run_queue_async(q);
-	spin_unlock_irqrestore(q->queue_lock, flags);
+	if (q)
+		blk_mq_run_hw_queues(q, true);
 }
 
 /**
@@ -3759,6 +3754,37 @@ static int fc_bsg_dispatch(struct bsg_job *job)
 		return fc_bsg_host_dispatch(shost, job);
 }
 
+static blk_status_t fc_bsg_rport_prep(struct fc_rport *rport)
+{
+	if (rport->port_state == FC_PORTSTATE_BLOCKED &&
+	    !(rport->flags & FC_RPORT_FAST_FAIL_TIMEDOUT))
+		return BLK_STS_RESOURCE;
+
+	if (rport->port_state != FC_PORTSTATE_ONLINE)
+		return BLK_STS_IOERR;
+
+	return BLK_STS_OK;
+}
+
+
+static int fc_bsg_dispatch_prep(struct bsg_job *job)
+{
+	struct fc_rport *rport = fc_bsg_to_rport(job);
+	blk_status_t ret;
+
+	ret = fc_bsg_rport_prep(rport);
+	switch (ret) {
+	case BLK_STS_OK:
+		break;
+	case BLK_STS_RESOURCE:
+		return -EAGAIN;
+	default:
+		return -EIO;
+	}
+
+	return fc_bsg_dispatch(job);
+}
+
 /**
  * fc_bsg_hostadd - Create and add the bsg hooks so we can receive requests
  * @shost:	shost for fc_host
@@ -3794,20 +3820,6 @@ fc_bsg_hostadd(struct Scsi_Host *shost, struct fc_host_attrs *fc_host)
 	return 0;
 }
 
-static int fc_bsg_rport_prep(struct request_queue *q, struct request *req)
-{
-	struct fc_rport *rport = dev_to_rport(q->queuedata);
-
-	if (rport->port_state == FC_PORTSTATE_BLOCKED &&
-	    !(rport->flags & FC_RPORT_FAST_FAIL_TIMEDOUT))
-		return BLKPREP_DEFER;
-
-	if (rport->port_state != FC_PORTSTATE_ONLINE)
-		return BLKPREP_KILL;
-
-	return BLKPREP_OK;
-}
-
 /**
  * fc_bsg_rportadd - Create and add the bsg hooks so we can receive requests
  * @shost:	shost that rport is attached to
@@ -3825,14 +3837,13 @@ fc_bsg_rportadd(struct Scsi_Host *shost, struct fc_rport *rport)
 	if (!i->f->bsg_request)
 		return -ENOTSUPP;
 
-	q = bsg_setup_queue(dev, dev_name(dev), fc_bsg_dispatch,
+	q = bsg_setup_queue(dev, dev_name(dev), fc_bsg_dispatch_prep,
 				fc_bsg_job_timeout, i->f->dd_bsg_size);
 	if (IS_ERR(q)) {
 		dev_err(dev, "failed to setup bsg queue\n");
 		return PTR_ERR(q);
 	}
 	__scsi_init_queue(shost, q);
-	blk_queue_prep_rq(q, fc_bsg_rport_prep);
 	blk_queue_rq_timeout(q, BLK_DEFAULT_SG_TIMEOUT);
 	rport->rqst_q = q;
 	return 0;
-- 
2.17.1
