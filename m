Return-Path: <SRS0=rGXo=AK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90469C433E1
	for <linux-block@archiver.kernel.org>; Mon, 29 Jun 2020 20:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B64620663
	for <linux-block@archiver.kernel.org>; Mon, 29 Jun 2020 20:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="azdWIEwB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731394AbgF2UvV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731408AbgF2TNa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Jun 2020 15:13:30 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2ACC008770
        for <linux-block@vger.kernel.org>; Mon, 29 Jun 2020 02:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=quuCKPwI1ePMUGqu6Hcin0pfkWoC+v+RnwcL5SDCipU=; b=azdWIEwBSk/J4dx+4HVQvX4azY
        KN5Zx9/EYNqr123+Q6+tizWL0rsGqCMVPBXfVaSw10OpTKob2JptT4oXvVX1NX9llHgLWkbre/OQA
        aHv4yfjLfZzzzqRQhyi05+c18jHgwFiy+rYEpoTj67S2zjC7ikx15nqcFtih3yMQD/X6Hd0wrOGC+
        ptpJDJ9VYpmbkxdVnpqZYy04kd6eazJQCKOUgCdhHOkutat/ysB8mox1GmYMiJUifLhJbhThSEteN
        feDo67qZYwB/YzyZDYYIAsxg6X1XHFPS6xofR0/LFrgZ2K4OktFC0o0nuNv+89hCDwSpQylGZLZ2y
        VfzsDUCw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jppif-0001Rt-0S; Mon, 29 Jun 2020 09:04:53 +0000
Date:   Mon, 29 Jun 2020 10:04:52 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH V6 6/6] blk-mq: support batching dispatch in case of io
 scheduler
Message-ID: <20200629090452.GA4892@infradead.org>
References: <20200624230349.1046821-1-ming.lei@redhat.com>
 <20200624230349.1046821-7-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624230349.1046821-7-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> +/*
> + * We know bfq and deadline apply single scheduler queue instead of multi
> + * queue. However, the two are often used on single queue devices, also
> + * the current @hctx should affect the real device status most of times
> + * because of locality principle.
> + *
> + * So use current hctx->dispatch_busy directly for figuring out batching
> + * dispatch count.
> + */

I don't really understand this comment.  Also I think the code might
be cleaner if this function is inlined as an if/else in the only
caller.

> +static inline bool blk_mq_do_dispatch_rq_lists(struct blk_mq_hw_ctx *hctx,
> +		struct list_head *lists, bool multi_hctxs, unsigned count)
> +{
> +	bool ret;
> +
> +	if (!count)
> +		return false;
> +
> +	if (likely(!multi_hctxs))
> +		return blk_mq_dispatch_rq_list(hctx, lists, count);

Keeping these checks in the callers would keep things a little cleaner,
especially as the multi hctx case only really needs the lists argument.

> +		LIST_HEAD(list);
> +		struct request *new, *rq = list_first_entry(lists,
> +				struct request, queuelist);
> +		unsigned cnt = 0;
> +
> +		list_for_each_entry(new, lists, queuelist) {
> +			if (new->mq_hctx != rq->mq_hctx)
> +				break;
> +			cnt++;
> +		}
> +
> +		if (new->mq_hctx == rq->mq_hctx)
> +			list_splice_tail_init(lists, &list);
> +		else
> +			list_cut_before(&list, lists, &new->queuelist);
> +
> +		ret = blk_mq_dispatch_rq_list(rq->mq_hctx, &list, cnt);
> +	}

I think this has two issues:  for one ret should be ORed as any dispatch
or error should leaave ret set.  Also we need to splice the dispatch
list back onto the main list here, otherwise we can lose those requests.

FYI, while reviewing this I ended up editing things into a shape I
could better understand.  Let me know what you think of this version?


diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 4c72073830f3cb..466dce99699ae4 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -7,6 +7,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/blk-mq.h>
+#include <linux/list_sort.h>
 
 #include <trace/events/block.h>
 
@@ -80,6 +81,38 @@ void blk_mq_sched_restart(struct blk_mq_hw_ctx *hctx)
 	blk_mq_run_hw_queue(hctx, true);
 }
 
+static int sched_rq_cmp(void *priv, struct list_head *a, struct list_head *b)
+{
+	struct request *rqa = container_of(a, struct request, queuelist);
+	struct request *rqb = container_of(b, struct request, queuelist);
+
+	return rqa->mq_hctx > rqb->mq_hctx;
+}
+
+static bool blk_mq_dispatch_hctx_list(struct list_head *rq_list)
+{
+	struct blk_mq_hw_ctx *hctx =
+		list_first_entry(rq_list, struct request, queuelist)->mq_hctx;
+	struct request *rq;
+	LIST_HEAD(hctx_list);
+	unsigned int count = 0;
+	bool ret;
+
+	list_for_each_entry(rq, rq_list, queuelist) {
+		if (rq->mq_hctx != hctx) {
+			list_cut_before(&hctx_list, rq_list, &rq->queuelist);
+			goto dispatch;
+		}
+		count++;
+	}
+	list_splice_tail_init(rq_list, &hctx_list);
+
+dispatch:
+	ret = blk_mq_dispatch_rq_list(hctx, &hctx_list, count);
+	list_splice(&hctx_list, rq_list);
+	return ret;
+}
+
 #define BLK_MQ_BUDGET_DELAY	3		/* ms units */
 
 /*
@@ -90,20 +123,29 @@ void blk_mq_sched_restart(struct blk_mq_hw_ctx *hctx)
  * Returns -EAGAIN if hctx->dispatch was found non-empty and run_work has to
  * be run again.  This is necessary to avoid starving flushes.
  */
-static int blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
+static int __blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
 {
 	struct request_queue *q = hctx->queue;
 	struct elevator_queue *e = q->elevator;
+	bool multi_hctxs = false, run_queue = false;
+	bool dispatched = false, busy = false;
+	unsigned int max_dispatch;
 	LIST_HEAD(rq_list);
-	int ret = 0;
-	struct request *rq;
+	int count = 0;
+
+	if (hctx->dispatch_busy)
+		max_dispatch = 1;
+	else
+		max_dispatch = hctx->queue->nr_requests;
 
 	do {
+		struct request *rq;
+
 		if (e->type->ops.has_work && !e->type->ops.has_work(hctx))
 			break;
 
 		if (!list_empty_careful(&hctx->dispatch)) {
-			ret = -EAGAIN;
+			busy = true;
 			break;
 		}
 
@@ -120,7 +162,7 @@ static int blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
 			 * no guarantee anyone will kick the queue.  Kick it
 			 * ourselves.
 			 */
-			blk_mq_delay_run_hw_queues(q, BLK_MQ_BUDGET_DELAY);
+			run_queue = true;
 			break;
 		}
 
@@ -130,7 +172,43 @@ static int blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
 		 * in blk_mq_dispatch_rq_list().
 		 */
 		list_add(&rq->queuelist, &rq_list);
-	} while (blk_mq_dispatch_rq_list(rq->mq_hctx, &rq_list, 1));
+		if (rq->mq_hctx != hctx)
+			multi_hctxs = true;
+	} while (++count < max_dispatch);
+
+	if (!count) {
+		if (run_queue)
+			blk_mq_delay_run_hw_queues(q, BLK_MQ_BUDGET_DELAY);
+	} else if (multi_hctxs) {
+		/*
+		 * Requests from different hctx may be dequeued from some
+		 * schedulers, such as bfq and deadline.
+		 *
+		 * Sort the requests in the list according to their hctx,
+		 * dispatch batching requests from same hctx at a time.
+		 */
+		list_sort(NULL, &rq_list, sched_rq_cmp);
+		do {
+			dispatched |= blk_mq_dispatch_hctx_list(&rq_list);
+		} while (!list_empty(&rq_list));
+	} else {
+		dispatched = blk_mq_dispatch_rq_list(hctx, &rq_list, count);
+	}
+
+	if (busy)
+		return -EAGAIN;
+	if (dispatched)
+		return 1;
+	return 0;
+}
+
+static int blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
+{
+	int ret;
+
+	do {
+		ret = __blk_mq_do_dispatch_sched(hctx);
+	} while (ret == 1);
 
 	return ret;
 }
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 29e0afc2612c6b..3d8c259b0f8c58 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1321,8 +1321,6 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
 	if (list_empty(list))
 		return false;
 
-	WARN_ON(!list_is_singular(list) && nr_budgets);
-
 	/*
 	 * Now process all the entries, sending them to the driver.
 	 */
