Return-Path: <SRS0=9ToN=AL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1690BC433E0
	for <linux-block@archiver.kernel.org>; Tue, 30 Jun 2020 00:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D683C20781
	for <linux-block@archiver.kernel.org>; Tue, 30 Jun 2020 00:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jce7pnpW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbgF3A5r (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 29 Jun 2020 20:57:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36899 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725998AbgF3A5r (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Jun 2020 20:57:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593478664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=42nLYzYhkWK6/r5DmX+hlkd7lSnr9BbdwwD5Wi4QyC8=;
        b=Jce7pnpWVDpkGo73k47nO1YamJ4wIRqyVUdvih792erFKja5x7zpLjsH0EFTKuJZ9pwFXp
        BwVXz10tqSgxIt6FcGpUouxj+WqnpZZ0JXeuX9zgItC1fnTKpHTnYWlPpXBQW3y7pdTKqA
        VtNVi3oSc1v3AGlGwmiLljPcFt7MFWw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-137-5mQI4EAgPPajF_mX7Hr3Ug-1; Mon, 29 Jun 2020 20:57:42 -0400
X-MC-Unique: 5mQI4EAgPPajF_mX7Hr3Ug-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0F3CE107ACF5;
        Tue, 30 Jun 2020 00:57:41 +0000 (UTC)
Received: from T590 (ovpn-13-98.pek2.redhat.com [10.72.13.98])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C03A428573;
        Tue, 30 Jun 2020 00:57:34 +0000 (UTC)
Date:   Tue, 30 Jun 2020 08:57:30 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        Baolin Wang <baolin.wang7@gmail.com>
Subject: Re: [PATCH V6 6/6] blk-mq: support batching dispatch in case of io
 scheduler
Message-ID: <20200630005730.GA2049266@T590>
References: <20200624230349.1046821-1-ming.lei@redhat.com>
 <20200624230349.1046821-7-ming.lei@redhat.com>
 <20200629090452.GA4892@infradead.org>
 <20200629103239.GB1881343@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629103239.GB1881343@T590>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jun 29, 2020 at 06:32:39PM +0800, Ming Lei wrote:
> On Mon, Jun 29, 2020 at 10:04:52AM +0100, Christoph Hellwig wrote:
> > > +/*
> > > + * We know bfq and deadline apply single scheduler queue instead of multi
> > > + * queue. However, the two are often used on single queue devices, also
> > > + * the current @hctx should affect the real device status most of times
> > > + * because of locality principle.
> > > + *
> > > + * So use current hctx->dispatch_busy directly for figuring out batching
> > > + * dispatch count.
> > > + */
> > 
> > I don't really understand this comment.  Also I think the code might
> > be cleaner if this function is inlined as an if/else in the only
> > caller.
> > 
> > > +static inline bool blk_mq_do_dispatch_rq_lists(struct blk_mq_hw_ctx *hctx,
> > > +		struct list_head *lists, bool multi_hctxs, unsigned count)
> > > +{
> > > +	bool ret;
> > > +
> > > +	if (!count)
> > > +		return false;
> > > +
> > > +	if (likely(!multi_hctxs))
> > > +		return blk_mq_dispatch_rq_list(hctx, lists, count);
> > 
> > Keeping these checks in the callers would keep things a little cleaner,
> > especially as the multi hctx case only really needs the lists argument.
> > 
> > > +		LIST_HEAD(list);
> > > +		struct request *new, *rq = list_first_entry(lists,
> > > +				struct request, queuelist);
> > > +		unsigned cnt = 0;
> > > +
> > > +		list_for_each_entry(new, lists, queuelist) {
> > > +			if (new->mq_hctx != rq->mq_hctx)
> > > +				break;
> > > +			cnt++;
> > > +		}
> > > +
> > > +		if (new->mq_hctx == rq->mq_hctx)
> > > +			list_splice_tail_init(lists, &list);
> > > +		else
> > > +			list_cut_before(&list, lists, &new->queuelist);
> > > +
> > > +		ret = blk_mq_dispatch_rq_list(rq->mq_hctx, &list, cnt);
> > > +	}
> > 
> > I think this has two issues:  for one ret should be ORed as any dispatch
> > or error should leaave ret set.  Also we need to splice the dispatch
> 
> OK.
> 
> > list back onto the main list here, otherwise we can lose those requests.
> 
> The dispatch list always becomes empty after blk_mq_dispatch_rq_list()
> returns, so no need to splice it back.
> 
> > 
> > FYI, while reviewing this I ended up editing things into a shape I
> > could better understand.  Let me know what you think of this version?
> > 
> > 
> > diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> > index 4c72073830f3cb..466dce99699ae4 100644
> > --- a/block/blk-mq-sched.c
> > +++ b/block/blk-mq-sched.c
> > @@ -7,6 +7,7 @@
> >  #include <linux/kernel.h>
> >  #include <linux/module.h>
> >  #include <linux/blk-mq.h>
> > +#include <linux/list_sort.h>
> >  
> >  #include <trace/events/block.h>
> >  
> > @@ -80,6 +81,38 @@ void blk_mq_sched_restart(struct blk_mq_hw_ctx *hctx)
> >  	blk_mq_run_hw_queue(hctx, true);
> >  }
> >  
> > +static int sched_rq_cmp(void *priv, struct list_head *a, struct list_head *b)
> > +{
> > +	struct request *rqa = container_of(a, struct request, queuelist);
> > +	struct request *rqb = container_of(b, struct request, queuelist);
> > +
> > +	return rqa->mq_hctx > rqb->mq_hctx;
> > +}
> > +
> > +static bool blk_mq_dispatch_hctx_list(struct list_head *rq_list)
> > +{
> > +	struct blk_mq_hw_ctx *hctx =
> > +		list_first_entry(rq_list, struct request, queuelist)->mq_hctx;
> > +	struct request *rq;
> > +	LIST_HEAD(hctx_list);
> > +	unsigned int count = 0;
> > +	bool ret;
> > +
> > +	list_for_each_entry(rq, rq_list, queuelist) {
> > +		if (rq->mq_hctx != hctx) {
> > +			list_cut_before(&hctx_list, rq_list, &rq->queuelist);
> > +			goto dispatch;
> > +		}
> > +		count++;
> > +	}
> > +	list_splice_tail_init(rq_list, &hctx_list);
> > +
> > +dispatch:
> > +	ret = blk_mq_dispatch_rq_list(hctx, &hctx_list, count);
> > +	list_splice(&hctx_list, rq_list);
> 
> The above line isn't needed.
> 
> > +	return ret;
> > +}
> > +
> >  #define BLK_MQ_BUDGET_DELAY	3		/* ms units */
> >  
> >  /*
> > @@ -90,20 +123,29 @@ void blk_mq_sched_restart(struct blk_mq_hw_ctx *hctx)
> >   * Returns -EAGAIN if hctx->dispatch was found non-empty and run_work has to
> >   * be run again.  This is necessary to avoid starving flushes.
> >   */
> > -static int blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
> > +static int __blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
> 
> The return type can be changed to 'bool'.
> 
> >  {
> >  	struct request_queue *q = hctx->queue;
> >  	struct elevator_queue *e = q->elevator;
> > +	bool multi_hctxs = false, run_queue = false;
> > +	bool dispatched = false, busy = false;
> > +	unsigned int max_dispatch;
> >  	LIST_HEAD(rq_list);
> > -	int ret = 0;
> > -	struct request *rq;
> > +	int count = 0;
> > +
> > +	if (hctx->dispatch_busy)
> > +		max_dispatch = 1;
> > +	else
> > +		max_dispatch = hctx->queue->nr_requests;
> >  
> >  	do {
> > +		struct request *rq;
> > +
> >  		if (e->type->ops.has_work && !e->type->ops.has_work(hctx))
> >  			break;
> >  
> >  		if (!list_empty_careful(&hctx->dispatch)) {
> > -			ret = -EAGAIN;
> > +			busy = true;
> >  			break;
> >  		}
> >  
> > @@ -120,7 +162,7 @@ static int blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
> >  			 * no guarantee anyone will kick the queue.  Kick it
> >  			 * ourselves.
> >  			 */
> > -			blk_mq_delay_run_hw_queues(q, BLK_MQ_BUDGET_DELAY);
> > +			run_queue = true;
> >  			break;
> >  		}
> >  
> > @@ -130,7 +172,43 @@ static int blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
> >  		 * in blk_mq_dispatch_rq_list().
> >  		 */
> >  		list_add(&rq->queuelist, &rq_list);
> 
> The above should change to list_add_tail(&rq->queuelist, &rq_list).

Hi Christoph,

Follows the revised patch, and will post it as V7 if you are fine:

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 4c72073830f3..1c52e56a19b1 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -7,6 +7,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/blk-mq.h>
+#include <linux/list_sort.h>
 
 #include <trace/events/block.h>
 
@@ -80,6 +81,37 @@ void blk_mq_sched_restart(struct blk_mq_hw_ctx *hctx)
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
+	return ret;
+}
+
 #define BLK_MQ_BUDGET_DELAY	3		/* ms units */
 
 /*
@@ -90,20 +122,29 @@ void blk_mq_sched_restart(struct blk_mq_hw_ctx *hctx)
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
 
@@ -120,7 +161,7 @@ static int blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
 			 * no guarantee anyone will kick the queue.  Kick it
 			 * ourselves.
 			 */
-			blk_mq_delay_run_hw_queues(q, BLK_MQ_BUDGET_DELAY);
+			run_queue = true;
 			break;
 		}
 
@@ -129,8 +170,42 @@ static int blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
 		 * if this rq won't be queued to driver via .queue_rq()
 		 * in blk_mq_dispatch_rq_list().
 		 */
-		list_add(&rq->queuelist, &rq_list);
-	} while (blk_mq_dispatch_rq_list(rq->mq_hctx, &rq_list, 1));
+		list_add_tail(&rq->queuelist, &rq_list);
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
+	return !!dispatched;
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
index d273a56f11c0..57ae018d5cc8 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1323,8 +1323,6 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
 	if (list_empty(list))
 		return false;
 
-	WARN_ON(!list_is_singular(list) && nr_budgets);
-
 	/*
 	 * Now process all the entries, sending them to the driver.
 	 */

Thanks, 
Ming

