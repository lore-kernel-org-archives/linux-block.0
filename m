Return-Path: <linux-scsi-owner@vger.kernel.org>
Date: Sun, 28 Oct 2018 09:07:12 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-ide@vger.kernel.org, Johannes Thumshirn <jthumshirn@suse.de>,
        Benjamin Block <bblock@linux.vnet.ibm.com>
Subject: Re: [PATCH 13/28] bsg: convert to use blk-mq
Message-ID: <20181028160712.GC1559@infradead.org>
References: <20181025211039.11559-1-axboe@kernel.dk>
 <20181025211039.11559-14-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20181025211039.11559-14-axboe@kernel.dk>
Sender: linux-scsi-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

> +static enum blk_eh_timer_return bsg_timeout(struct request *rq, bool reserved)
> +{
> +	enum blk_eh_timer_return ret = BLK_EH_DONE;
> +	struct request_queue *q = rq->q;
> +
> +	if (q->rq_timed_out_fn)
> +		ret = q->rq_timed_out_fn(rq);
> +
> +	return ret;

This is pretty awkward.  I guess it is ok as an intermediate step,
but I really don't want to keep rq_timed_out_fn to just for bsg.

I think we should do something like this ontop of your series to move
all the bsg-lib bits outside struct request_queue:

diff --git a/block/bsg-lib.c b/block/bsg-lib.c
index 3a5938205825..21dccaf8399e 100644
--- a/block/bsg-lib.c
+++ b/block/bsg-lib.c
@@ -31,6 +31,12 @@
 
 #define uptr64(val) ((void __user *)(uintptr_t)(val))
 
+struct bsg_set {
+	struct blk_mq_tag_set	tag_set;
+	bsg_job_fn		*job_fn;
+	bsg_timeout_fn		*timeout_fn;
+};
+
 static int bsg_transport_check_proto(struct sg_io_v4 *hdr)
 {
 	if (hdr->protocol != BSG_PROTOCOL_SCSI  ||
@@ -239,6 +245,8 @@ static blk_status_t bsg_queue_rq(struct blk_mq_hw_ctx *hctx,
 	struct request_queue *q = hctx->queue;
 	struct device *dev = q->queuedata;
 	struct request *req = bd->rq;
+	struct bsg_set *bset =
+		container_of(q->tag_set, struct bsg_set, tag_set);
 	int ret;
 
 	blk_mq_start_request(req);
@@ -249,7 +257,7 @@ static blk_status_t bsg_queue_rq(struct blk_mq_hw_ctx *hctx,
 	if (!bsg_prepare_job(dev, req))
 		return BLK_STS_IOERR;
 
-	ret = q->bsg_job_fn(blk_mq_rq_to_pdu(req));
+	ret = bset->job_fn(blk_mq_rq_to_pdu(req));
 	if (ret)
 		return BLK_STS_IOERR;
 
@@ -302,13 +310,12 @@ EXPORT_SYMBOL_GPL(bsg_remove_queue);
 
 static enum blk_eh_timer_return bsg_timeout(struct request *rq, bool reserved)
 {
-	enum blk_eh_timer_return ret = BLK_EH_DONE;
-	struct request_queue *q = rq->q;
-
-	if (q->bsg_job_timeout_fn)
-		ret = q->bsg_job_timeout_fn(rq);
+	struct bsg_set *bset =
+		container_of(rq->q->tag_set, struct bsg_set, tag_set);
 
-	return ret;
+	if (!bset->timeout_fn)
+		return BLK_EH_DONE;
+	return bset->timeout_fn(rq);
 }
 
 static const struct blk_mq_ops bsg_mq_ops = {
@@ -328,16 +335,21 @@ static const struct blk_mq_ops bsg_mq_ops = {
  * @dd_job_size: size of LLD data needed for each job
  */
 struct request_queue *bsg_setup_queue(struct device *dev, const char *name,
-		bsg_job_fn *job_fn, rq_timed_out_fn *timeout, int dd_job_size)
+		bsg_job_fn *job_fn, bsg_timeout_fn *timeout, int dd_job_size)
 {
+	struct bsg_set *bset;
 	struct blk_mq_tag_set *set;
 	struct request_queue *q;
 	int ret = -ENOMEM;
 
-	set = kzalloc(sizeof(*set), GFP_KERNEL);
-	if (!set)
+	bset = kzalloc(sizeof(*bset), GFP_KERNEL);
+	if (!bset)
 		return ERR_PTR(-ENOMEM);
 
+	bset->job_fn = job_fn;
+	bset->timeout_fn = timeout;
+
+	set = &bset->tag_set;
 	set->ops = &bsg_mq_ops,
 	set->nr_hw_queues = 1;
 	set->queue_depth = 128;
@@ -354,8 +366,6 @@ struct request_queue *bsg_setup_queue(struct device *dev, const char *name,
 	}
 
 	q->queuedata = dev;
-	q->bsg_job_fn = job_fn;
-	q->bsg_job_timeout_fn = timeout;
 	blk_queue_flag_set(QUEUE_FLAG_BIDI, q);
 	blk_queue_rq_timeout(q, BLK_DEFAULT_SG_TIMEOUT);
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 82b6cf45c6e0..eb7399f76b42 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -292,15 +292,12 @@ typedef bool (poll_q_fn) (struct request_queue *q, blk_qc_t);
 struct bio_vec;
 typedef void (softirq_done_fn)(struct request *);
 typedef int (dma_drain_needed_fn)(struct request *);
-typedef int (bsg_job_fn) (struct bsg_job *);
 
 enum blk_eh_timer_return {
 	BLK_EH_DONE,		/* drivers has completed the command */
 	BLK_EH_RESET_TIMER,	/* reset timer and try again */
 };
 
-typedef enum blk_eh_timer_return (rq_timed_out_fn)(struct request *);
-
 enum blk_queue_state {
 	Queue_down,
 	Queue_up,
@@ -564,8 +561,6 @@ struct request_queue {
 	atomic_t		mq_freeze_depth;
 
 #if defined(CONFIG_BLK_DEV_BSG)
-	bsg_job_fn		*bsg_job_fn;
-	rq_timed_out_fn		*bsg_job_timeout_fn;
 	struct bsg_class_device bsg_dev;
 #endif
 
diff --git a/include/linux/bsg-lib.h b/include/linux/bsg-lib.h
index 9c9b134b1fa5..b356e0006731 100644
--- a/include/linux/bsg-lib.h
+++ b/include/linux/bsg-lib.h
@@ -31,6 +31,9 @@ struct device;
 struct scatterlist;
 struct request_queue;
 
+typedef int (bsg_job_fn) (struct bsg_job *);
+typedef enum blk_eh_timer_return (bsg_timeout_fn)(struct request *);
+
 struct bsg_buffer {
 	unsigned int payload_len;
 	int sg_cnt;
@@ -72,7 +75,7 @@ struct bsg_job {
 void bsg_job_done(struct bsg_job *job, int result,
 		  unsigned int reply_payload_rcv_len);
 struct request_queue *bsg_setup_queue(struct device *dev, const char *name,
-		bsg_job_fn *job_fn, rq_timed_out_fn *timeout, int dd_job_size);
+		bsg_job_fn *job_fn, bsg_timeout_fn *timeout, int dd_job_size);
 void bsg_remove_queue(struct request_queue *q);
 void bsg_job_put(struct bsg_job *job);
 int __must_check bsg_job_get(struct bsg_job *job);
