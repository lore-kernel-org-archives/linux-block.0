Return-Path: <ming.lei@redhat.com>
Date: Tue, 31 Jul 2018 09:38:55 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Peter Geis <pgwipeout@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [Regression] Linux-Next Merge 25Jul2018 breaks mmc on Tegra.
Message-ID: <20180731013848.GA6740@ming.t460p>
References: <dacd3c28-2bfc-dd42-18a2-641217848126@gmail.com>
 <835eb17a-e192-d991-04b6-f0c82c32311e@kernel.dk>
 <f21ec2ef-7d88-117b-5dab-04c778a2d23a@gmail.com>
 <20180728133654.GA8047@ming.t460p>
 <4284a9b0-2d90-3ffa-0172-9ec5d8f6f8af@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4284a9b0-2d90-3ffa-0172-9ec5d8f6f8af@gmail.com>
List-ID: <linux-block@vger.kernel.org>

Hi Peter,

Thanks for collecting the log.

On Mon, Jul 30, 2018 at 02:55:42PM -0400, Peter Geis wrote:
> 
> 
> On 07/28/2018 09:37 AM, Ming Lei wrote:

...

> [   10.887209] systemd--112     0.n.1 2411122us : blk_mq_make_request: make
> rq -1
> [   10.890274] kworker/-98      0...1 2411506us : blk_mq_free_request:
> complete: rq -1
> [   10.893313] systemd--107     0...1 2412025us : blk_mq_make_request: make
> rq -1
> [   10.896354] systemd--107     0.... 2412323us : mmc_mq_queue_rq: queue rq
> -1, 0
> [   10.899388] systemd--107     0.... 2412327us :
> blk_mq_try_issue_list_directly: issue direct: rq -1, ret 0
> [   10.902463] (direxec-111     1...1 2413829us : blk_mq_make_request: make
> rq -1
> [   10.905513] systemd--114     1...1 2415159us : blk_mq_make_request: make
> rq -1

Above is the most interesting part in the log. MMC sets hw queue depth
as 1, and you are using none scheduler, that means the max number of
in-flight requests should be one, but the above log shows that there may
be 3 in-flight requests.

That seems really weird, but it shouldn't be related with my two patches,
which won't change the tag allocation behaviour at all. However, what matters
may be that the patch speeds up the request dispatch. Maybe one bug
in lib/sbitmap.c block/blk-mq-tag.c.

Unfortunately rq->tag wasn't shown in the log because I forget to dump
it in the debug patch, so could you apply the following new debug patch and
provide us the log again? BTW, please attach the ftrace log in the reply
mail directly, then it may be parsed/looked easily.

>From c9ffdcbb71811b6b450ab83f9f97ae227596ed6a Mon Sep 17 00:00:00 2001
From: Ming Lei <ming.lei@redhat.com>
Date: Tue, 31 Jul 2018 08:31:58 +0800
Subject: [PATCH] mmc-blk-mq-debug: debug info

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-sched.c     |  2 ++
 block/blk-mq.c           |  8 ++++++++
 drivers/mmc/core/queue.c | 16 ++++++++++++++++
 drivers/mmc/host/sdhci.c |  1 +
 include/linux/blkdev.h   |  1 +
 5 files changed, 28 insertions(+)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index cf9c66c6d35a..6573684b07e5 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -415,6 +415,8 @@ void blk_mq_sched_insert_requests(struct request_queue *q,
 			blk_mq_try_issue_list_directly(hctx, list);
 			if (list_empty(list))
 				return;
+			if (blk_queue_debug(q))
+				trace_printk("issue direct: partial done\n");
 		}
 		blk_mq_insert_requests(hctx, ctx, list);
 	}
diff --git a/block/blk-mq.c b/block/blk-mq.c
index e13bdc2707ce..fe807cd1f9ef 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -488,6 +488,9 @@ void blk_mq_free_request(struct request *rq)
 	struct blk_mq_ctx *ctx = rq->mq_ctx;
 	struct blk_mq_hw_ctx *hctx = blk_mq_map_queue(q, ctx->cpu);
 
+	if (blk_queue_debug(q))
+		trace_printk("complete: rq %d %d\n", rq->internal_tag, rq->tag);
+
 	if (rq->rq_flags & RQF_ELVPRIV) {
 		if (e && e->type->ops.mq.finish_request)
 			e->type->ops.mq.finish_request(rq);
@@ -1793,6 +1796,9 @@ void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
 
 		list_del_init(&rq->queuelist);
 		ret = blk_mq_request_issue_directly(rq);
+		if (blk_queue_debug(rq->q))
+			trace_printk("issue direct: rq %d %d, ret %d\n",
+					rq->internal_tag, rq->tag, (int)ret);
 		if (ret != BLK_STS_OK) {
 			if (ret == BLK_STS_RESOURCE ||
 					ret == BLK_STS_DEV_RESOURCE) {
@@ -1841,6 +1847,8 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 		return BLK_QC_T_NONE;
 	}
 
+	 if (blk_queue_debug(q))
+		 trace_printk("make rq %d %d\n", rq->internal_tag, rq->tag);
 	rq_qos_track(q, rq, bio);
 
 	cookie = request_to_qc_t(data.hctx, rq);
diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index 648eb6743ed5..d35f265cd5e0 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -257,6 +257,10 @@ static blk_status_t mmc_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 	if (mmc_card_removed(mq->card)) {
 		req->rq_flags |= RQF_QUIET;
+
+		if (blk_queue_debug(q))
+			trace_printk("queue rq %d %d, %s\n",
+					req->internal_tag, req->tag, "io err");
 		return BLK_STS_IOERR;
 	}
 
@@ -266,6 +270,9 @@ static blk_status_t mmc_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 	if (mq->recovery_needed) {
 		spin_unlock_irq(q->queue_lock);
+		if (blk_queue_debug(q))
+			trace_printk("queue rq %d %d, %s\n",
+					req->internal_tag, req->tag, "resource");
 		return BLK_STS_RESOURCE;
 	}
 
@@ -274,6 +281,10 @@ static blk_status_t mmc_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
 		if (mmc_cqe_dcmd_busy(mq)) {
 			mq->cqe_busy |= MMC_CQE_DCMD_BUSY;
 			spin_unlock_irq(q->queue_lock);
+			if (blk_queue_debug(q))
+				trace_printk("queue rq %d %d, %s\n",
+					req->internal_tag, req->tag,
+					"resource");
 			return BLK_STS_RESOURCE;
 		}
 		break;
@@ -326,6 +337,9 @@ static blk_status_t mmc_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
 		break;
 	}
 
+	if (blk_queue_debug(q))
+		trace_printk("queue rq %d %d, %d\n",
+				req->internal_tag, req->tag, (int)ret);
 	if (issued != MMC_REQ_STARTED) {
 		bool put_card = false;
 
@@ -404,6 +418,8 @@ static int mmc_mq_init_queue(struct mmc_queue *mq, int q_depth,
 	mq->queue->queue_lock = lock;
 	mq->queue->queuedata = mq;
 
+	blk_queue_flag_set(31, mq->queue);
+
 	return 0;
 
 free_tag_set:
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 1c828e0e9905..b2b471c2f5f6 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2640,6 +2640,7 @@ static void sdhci_cmd_irq(struct sdhci_host *host, u32 intmask)
 			return;
 		pr_err("%s: Got command interrupt 0x%08x even though no command operation was in progress.\n",
 		       mmc_hostname(host->mmc), (unsigned)intmask);
+		ftrace_dump(DUMP_ALL);
 		sdhci_dumpregs(host);
 		return;
 	}
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 050d599f5ea9..29be3a6d5903 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -741,6 +741,7 @@ bool blk_queue_flag_test_and_clear(unsigned int flag, struct request_queue *q);
 #define blk_queue_preempt_only(q)				\
 	test_bit(QUEUE_FLAG_PREEMPT_ONLY, &(q)->queue_flags)
 #define blk_queue_fua(q)	test_bit(QUEUE_FLAG_FUA, &(q)->queue_flags)
+#define blk_queue_debug(q)	test_bit(31, &(q)->queue_flags)
 
 extern int blk_set_preempt_only(struct request_queue *q);
 extern void blk_clear_preempt_only(struct request_queue *q);
-- 
2.9.5


Thanks,
Ming
