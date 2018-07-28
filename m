Return-Path: <ming.lei@redhat.com>
Date: Sat, 28 Jul 2018 21:37:01 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Peter Geis <pgwipeout@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [Regression] Linux-Next Merge 25Jul2018 breaks mmc on Tegra.
Message-ID: <20180728133654.GA8047@ming.t460p>
References: <dacd3c28-2bfc-dd42-18a2-641217848126@gmail.com>
 <835eb17a-e192-d991-04b6-f0c82c32311e@kernel.dk>
 <f21ec2ef-7d88-117b-5dab-04c778a2d23a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f21ec2ef-7d88-117b-5dab-04c778a2d23a@gmail.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Jul 25, 2018 at 02:29:30PM -0400, Peter Geis wrote:
> On 07/25/2018 02:17 PM, Jens Axboe wrote:
> > On 7/25/18 10:28 AM, Peter Geis wrote:
> > > Good Afternoon,
> > > 
> > > I have encountered an issue on both Tegra 2 and Tegra 3 devices
> > > accessing emmc following the 25 July 2018 remote tracking merge.
> > > 
> > > The offending commit is:
> > > 6ce3dd6eec114930cf2035a8bcb1e80477ed79a8
> > > blk-mq: issue directly if hw queue isn't busy in case of 'none'.
> > 
> > Can you try my current for-next? This should fix it:
> > 
> > commit 8824f62246bef288173a6624a363352f0d4d3b09
> > Author: Ming Lei <ming.lei@redhat.com>
> > Date:   Sun Jul 22 14:10:15 2018 +0800
> > 
> >      blk-mq: fail the request in case issue failure
> > 
> 
> That commit made the current merge window, it must be reverted before
> reverting the offending commit.
> 
> With that patch, the bug triggers then the kernel waits for the mmc to
> recover. It seems however that the bug leaves the mmc in a zombie state,
> where it is processing the previous command but the kernel has no control
> over it.
> 
> [    4.233073] mmc0: Got command interrupt 0x00000001 even though no command
> operation was in progress.
> [    4.242189] mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
> [    4.248616] mmc0: sdhci: Sys addr:  0x00000000 | Version:  0x00000001
> [    4.255041] mmc0: sdhci: Blk size:  0x00007200 | Blk cnt:  0x00000000
> [    4.261465] mmc0: sdhci: Argument:  0x002e3b10 | Trn mode: 0x00000033
> [    4.267890] mmc0: sdhci: Present:   0x1ff70000 | Host ctl: 0x00000031
> [    4.274314] mmc0: sdhci: Power:     0x0000000f | Blk gap:  0x00000000
> [    4.280737] mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x00000007
> [    4.287162] mmc0: sdhci: Timeout:   0x0000000e | Int stat: 0x00000002
> [    4.293586] mmc0: sdhci: Int enab:  0x02ff000b | Sig enab: 0x02fc000b
> [    4.300010] mmc0: sdhci: AC12 err:  0x00000000 | Slot int: 0x00000000
> [    4.306433] mmc0: sdhci: Caps:      0xe7ffd080 | Caps_1:   0x00000074
> [    4.312857] mmc0: sdhci: Cmd:       0x0000123a | Max curr: 0x00969696
> [    4.319281] mmc0: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0x04800e92
> [    4.325705] mmc0: sdhci: Resp[2]:   0x074b8000 | Resp[3]:  0x00000240
> [    4.332128] mmc0: sdhci: Host ctl2: 0x00000000
> [    4.336560] mmc0: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0xae2f9220
> [    4.342981] mmc0: sdhci: ============================================

Not found issue in the two merged patches, and it might be one mmc
internal issue, could you apply the following debug patch and post
the console log?

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
index e13bdc2707ce..efb898323e2d 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -488,6 +488,9 @@ void blk_mq_free_request(struct request *rq)
 	struct blk_mq_ctx *ctx = rq->mq_ctx;
 	struct blk_mq_hw_ctx *hctx = blk_mq_map_queue(q, ctx->cpu);
 
+	if (blk_queue_debug(q))
+		trace_printk("complete: rq %d\n", rq->internal_tag);
+
 	if (rq->rq_flags & RQF_ELVPRIV) {
 		if (e && e->type->ops.mq.finish_request)
 			e->type->ops.mq.finish_request(rq);
@@ -1793,6 +1796,9 @@ void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
 
 		list_del_init(&rq->queuelist);
 		ret = blk_mq_request_issue_directly(rq);
+		if (blk_queue_debug(rq->q))
+			trace_printk("issue direct: rq %d, ret %d\n",
+					rq->internal_tag, (int)ret);
 		if (ret != BLK_STS_OK) {
 			if (ret == BLK_STS_RESOURCE ||
 					ret == BLK_STS_DEV_RESOURCE) {
@@ -1841,6 +1847,8 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 		return BLK_QC_T_NONE;
 	}
 
+	 if (blk_queue_debug(q))
+		 trace_printk("make rq %d\n", rq->internal_tag);
 	rq_qos_track(q, rq, bio);
 
 	cookie = request_to_qc_t(data.hctx, rq);
diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index 648eb6743ed5..90745829cf9a 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -257,6 +257,9 @@ static blk_status_t mmc_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 	if (mmc_card_removed(mq->card)) {
 		req->rq_flags |= RQF_QUIET;
+
+		if (blk_queue_debug(q))
+			trace_printk("queue rq %d, %s\n", req->internal_tag, "io err");
 		return BLK_STS_IOERR;
 	}
 
@@ -266,6 +269,9 @@ static blk_status_t mmc_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 	if (mq->recovery_needed) {
 		spin_unlock_irq(q->queue_lock);
+		if (blk_queue_debug(q))
+			trace_printk("queue rq %d, %s\n", req->internal_tag,
+					"resource");
 		return BLK_STS_RESOURCE;
 	}
 
@@ -274,6 +280,9 @@ static blk_status_t mmc_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
 		if (mmc_cqe_dcmd_busy(mq)) {
 			mq->cqe_busy |= MMC_CQE_DCMD_BUSY;
 			spin_unlock_irq(q->queue_lock);
+			if (blk_queue_debug(q))
+				trace_printk("queue rq %d, %s\n", req->internal_tag,
+					"resource");
 			return BLK_STS_RESOURCE;
 		}
 		break;
@@ -326,6 +335,8 @@ static blk_status_t mmc_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
 		break;
 	}
 
+	if (blk_queue_debug(q))
+		trace_printk("queue rq %d, %d\n", req->internal_tag, (int)ret);
 	if (issued != MMC_REQ_STARTED) {
 		bool put_card = false;
 
@@ -404,6 +415,8 @@ static int mmc_mq_init_queue(struct mmc_queue *mq, int q_depth,
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

Thanks,
Ming
