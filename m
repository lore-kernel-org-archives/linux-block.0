Return-Path: <SRS0=horf=6J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 302DAC54FCB
	for <linux-block@archiver.kernel.org>; Sat, 25 Apr 2020 15:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1640120700
	for <linux-block@archiver.kernel.org>; Sat, 25 Apr 2020 15:48:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbgDYPsg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 25 Apr 2020 11:48:36 -0400
Received: from verein.lst.de ([213.95.11.211]:40193 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbgDYPsg (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 25 Apr 2020 11:48:36 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id CF6FA68CEC; Sat, 25 Apr 2020 17:48:32 +0200 (CEST)
Date:   Sat, 25 Apr 2020 17:48:32 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>, will@kernel.org,
        peterz@infradead.org, paulmck@kernel.org
Subject: Re: [PATCH V8 07/11] blk-mq: stop to handle IO and drain IO before
 hctx becomes inactive
Message-ID: <20200425154832.GA16004@lst.de>
References: <20200424102351.475641-1-ming.lei@redhat.com> <20200424102351.475641-8-ming.lei@redhat.com> <20200424103851.GD28156@lst.de> <20200425031723.GC477579@T590> <20200425083224.GA5634@lst.de> <20200425093437.GA495669@T590> <20200425095351.GC495669@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200425095351.GC495669@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

FYI, here is what I think we should be doing (but the memory model
experts please correct me):

 - just drop the direct_issue flag and check for the CPU, which is
   cheap enough
 - replace the raw_smp_processor_id with a get_cpu to make sure we
   don't hit the tiny migration windows
 - a bunch of random cleanups to make the code easier to read, mostly
   by being more self-documenting or improving the comments.

diff --git a/block/blk-mq.c b/block/blk-mq.c
index bfa4020256ae9..da749865f6eed 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1049,28 +1049,16 @@ static bool __blk_mq_get_driver_tag(struct request *rq)
 		atomic_inc(&data.hctx->nr_active);
 	}
 	data.hctx->tags->rqs[rq->tag] = rq;
-	return true;
-}
-
-static bool blk_mq_get_driver_tag(struct request *rq, bool direct_issue)
-{
-	if (rq->tag != -1)
-		return true;
 
-	if (!__blk_mq_get_driver_tag(rq))
-		return false;
 	/*
-	 * Add one memory barrier in case that direct issue IO process is
-	 * migrated to other CPU which may not belong to this hctx, so we can
-	 * order driver tag assignment and checking BLK_MQ_S_INACTIVE.
-	 * Otherwise, barrier() is enough given both setting BLK_MQ_S_INACTIVE
-	 * and driver tag assignment are run on the same CPU in case that
-	 * BLK_MQ_S_INACTIVE is set.
+	 * Ensure updates to rq->tag and tags->rqs[] are seen by
+	 * blk_mq_tags_inflight_rqs.  This pairs with the smp_mb__after_atomic
+	 * in blk_mq_hctx_notify_offline.  This only matters in case a process
+	 * gets migrated to another CPU that is not mapped to this hctx.
 	 */
-	if (unlikely(direct_issue && rq->mq_ctx->cpu != raw_smp_processor_id()))
+	if (rq->mq_ctx->cpu != get_cpu())
 		smp_mb();
-	else
-		barrier();
+	put_cpu();
 
 	if (unlikely(test_bit(BLK_MQ_S_INACTIVE, &rq->mq_hctx->state))) {
 		blk_mq_put_driver_tag(rq);
@@ -1079,6 +1067,13 @@ static bool blk_mq_get_driver_tag(struct request *rq, bool direct_issue)
 	return true;
 }
 
+static bool blk_mq_get_driver_tag(struct request *rq)
+{
+	if (rq->tag != -1)
+		return true;
+	return __blk_mq_get_driver_tag(rq);
+}
+
 static int blk_mq_dispatch_wake(wait_queue_entry_t *wait, unsigned mode,
 				int flags, void *key)
 {
@@ -1125,7 +1120,7 @@ static bool blk_mq_mark_tag_wait(struct blk_mq_hw_ctx *hctx,
 		 * Don't clear RESTART here, someone else could have set it.
 		 * At most this will cost an extra queue run.
 		 */
-		return blk_mq_get_driver_tag(rq, false);
+		return blk_mq_get_driver_tag(rq);
 	}
 
 	wait = &hctx->dispatch_wait;
@@ -1151,7 +1146,7 @@ static bool blk_mq_mark_tag_wait(struct blk_mq_hw_ctx *hctx,
 	 * allocation failure and adding the hardware queue to the wait
 	 * queue.
 	 */
-	ret = blk_mq_get_driver_tag(rq, false);
+	ret = blk_mq_get_driver_tag(rq);
 	if (!ret) {
 		spin_unlock(&hctx->dispatch_wait_lock);
 		spin_unlock_irq(&wq->lock);
@@ -1252,7 +1247,7 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
 			break;
 		}
 
-		if (!blk_mq_get_driver_tag(rq, false)) {
+		if (!blk_mq_get_driver_tag(rq)) {
 			/*
 			 * The initial allocation attempt failed, so we need to
 			 * rerun the hardware queue when a tag is freed. The
@@ -1284,7 +1279,7 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
 			bd.last = true;
 		else {
 			nxt = list_first_entry(list, struct request, queuelist);
-			bd.last = !blk_mq_get_driver_tag(nxt, false);
+			bd.last = !blk_mq_get_driver_tag(nxt);
 		}
 
 		ret = q->mq_ops->queue_rq(hctx, &bd);
@@ -1886,7 +1881,7 @@ static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 	if (!blk_mq_get_dispatch_budget(hctx))
 		goto insert;
 
-	if (!blk_mq_get_driver_tag(rq, true)) {
+	if (!blk_mq_get_driver_tag(rq)) {
 		blk_mq_put_dispatch_budget(hctx);
 		goto insert;
 	}
@@ -2327,23 +2322,24 @@ static bool blk_mq_inflight_rq(struct request *rq, void *data,
 static unsigned blk_mq_tags_inflight_rqs(struct blk_mq_hw_ctx *hctx)
 {
 	struct count_inflight_data count_data = {
-		.count	= 0,
 		.hctx	= hctx,
 	};
 
 	blk_mq_all_tag_busy_iter(hctx->tags, blk_mq_count_inflight_rq,
 			blk_mq_inflight_rq, &count_data);
-
 	return count_data.count;
 }
 
-static void blk_mq_hctx_drain_inflight_rqs(struct blk_mq_hw_ctx *hctx)
+static inline bool blk_mq_last_cpu_in_hctx(unsigned int cpu,
+		struct blk_mq_hw_ctx *hctx)
 {
-	while (1) {
-		if (!blk_mq_tags_inflight_rqs(hctx))
-			break;
-		msleep(5);
-	}
+	if (!cpumask_test_cpu(cpu, hctx->cpumask))
+		return false;
+	if (cpumask_next_and(-1, hctx->cpumask, cpu_online_mask) != cpu)
+		return false;
+	if (cpumask_next_and(cpu, hctx->cpumask, cpu_online_mask) < nr_cpu_ids)
+		return false;
+	return true;
 }
 
 static int blk_mq_hctx_notify_offline(unsigned int cpu, struct hlist_node *node)
@@ -2351,25 +2347,19 @@ static int blk_mq_hctx_notify_offline(unsigned int cpu, struct hlist_node *node)
 	struct blk_mq_hw_ctx *hctx = hlist_entry_safe(node,
 			struct blk_mq_hw_ctx, cpuhp_online);
 
-	if (!cpumask_test_cpu(cpu, hctx->cpumask))
-		return 0;
-
-	if ((cpumask_next_and(-1, hctx->cpumask, cpu_online_mask) != cpu) ||
-	    (cpumask_next_and(cpu, hctx->cpumask, cpu_online_mask) < nr_cpu_ids))
+	if (!blk_mq_last_cpu_in_hctx(cpu, hctx))
 		return 0;
 
 	/*
-	 * The current CPU is the last one in this hctx, S_INACTIVE
-	 * can be observed in dispatch path without any barrier needed,
-	 * cause both are run on one same CPU.
+	 * Order setting BLK_MQ_S_INACTIVE versus checking rq->tag and rqs[tag],
+	 * in blk_mq_tags_inflight_rqs.  It pairs with the smp_mb() in
+	 * blk_mq_get_driver_tag.
 	 */
 	set_bit(BLK_MQ_S_INACTIVE, &hctx->state);
-	/*
-	 * Order setting BLK_MQ_S_INACTIVE and checking rq->tag & rqs[tag],
-	 * and its pair is the smp_mb() in blk_mq_get_driver_tag
-	 */
 	smp_mb__after_atomic();
-	blk_mq_hctx_drain_inflight_rqs(hctx);
+
+	while (blk_mq_tags_inflight_rqs(hctx))
+		msleep(5);
 	return 0;
 }
 
