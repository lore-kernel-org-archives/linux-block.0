Return-Path: <SRS0=9GNQ=6H=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60612C2BA19
	for <linux-block@archiver.kernel.org>; Thu, 23 Apr 2020 07:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46AA421569
	for <linux-block@archiver.kernel.org>; Thu, 23 Apr 2020 07:30:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbgDWHac (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Apr 2020 03:30:32 -0400
Received: from verein.lst.de ([213.95.11.211]:56456 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725562AbgDWHaa (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Apr 2020 03:30:30 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id D1EC768BEB; Thu, 23 Apr 2020 09:30:26 +0200 (CEST)
Date:   Thu, 23 Apr 2020 09:30:26 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Garry <john.garry@huawei.com>
Subject: Re: [PATCH V7 2/9] blk-mq: assign rq->tag in blk_mq_get_driver_tag
Message-ID: <20200423073026.GB10951@lst.de>
References: <20200418030925.31996-1-ming.lei@redhat.com> <20200418030925.31996-3-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200418030925.31996-3-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Apr 18, 2020 at 11:09:18AM +0800, Ming Lei wrote:
> Especially for none elevator, rq->tag is assigned after the request is
> allocated, so there isn't any way to figure out if one request is in
> being dispatched. Also the code path wrt. driver tag becomes a bit
> difference between none and io scheduler.
> 
> When one hctx becomes inactive, we have to prevent any request from
> being dispatched to LLD. And get driver tag provides one perfect chance
> to do that. Meantime we can drain any such requests by checking if
> rq->tag is assigned.
> 
> So only assign rq->tag until blk_mq_get_driver_tag() is called.
> 
> This way also simplifies code of dealing with driver tag a lot.

I really like this, but I find blk_mq_get_driver_tag really convoluted
after this patch, mostly due to the excessive use of gotos, but also
because it mixed tag >= 0 and tag == -1 checks, which should mean the
same as -1 is the only negative value assigned (which btw really should
grow a BLK_MQ_NO_TAG name in another patch).  I think something like
this folded into your patch would be a nice improvement and also fit
in with the changes later in the series:

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 05fe2eb615a9..fb7b35941e6c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1021,40 +1021,41 @@ static inline unsigned int queued_to_index(unsigned int queued)
 	return min(BLK_MQ_MAX_DISPATCH_ORDER - 1, ilog2(queued) + 1);
 }
 
-static bool blk_mq_get_driver_tag(struct request *rq)
+static bool __blk_mq_get_driver_tag(struct request *rq)
 {
 	struct blk_mq_alloc_data data = {
-		.q = rq->q,
-		.hctx = rq->mq_hctx,
-		.flags = BLK_MQ_REQ_NOWAIT,
-		.cmd_flags = rq->cmd_flags,
+		.q		= rq->q,
+		.hctx		= rq->mq_hctx,
+		.flags		= BLK_MQ_REQ_NOWAIT,
+		.cmd_flags	= rq->cmd_flags,
 	};
-	bool shared;
-
-	if (rq->tag >= 0)
-		goto allocated;
 
-	if (!data.hctx->sched_tags) {
+	if (data.hctx->sched_tags) {
+		if (blk_mq_tag_is_reserved(data.hctx->sched_tags,
+				rq->internal_tag))
+			data.flags |= BLK_MQ_REQ_RESERVED;
+		rq->tag = blk_mq_get_tag(&data);
+	} else {
 		rq->tag = rq->internal_tag;
-		goto set_rq;
 	}
 
-	if (blk_mq_tag_is_reserved(data.hctx->sched_tags, rq->internal_tag))
-		data.flags |= BLK_MQ_REQ_RESERVED;
-
-	rq->tag = blk_mq_get_tag(&data);
+	if (rq->tag == -1)
+		return false;
 
-set_rq:
-	shared = blk_mq_tag_busy(data.hctx);
-	if (rq->tag >= 0) {
-		if (shared) {
-			rq->rq_flags |= RQF_MQ_INFLIGHT;
-			atomic_inc(&data.hctx->nr_active);
-		}
-		data.hctx->tags->rqs[rq->tag] = rq;
+	if (blk_mq_tag_busy(data.hctx)) {
+		rq->rq_flags |= RQF_MQ_INFLIGHT;
+		atomic_inc(&data.hctx->nr_active);
 	}
-allocated:
-	return rq->tag != -1;
+	data.hctx->tags->rqs[rq->tag] = rq;
+	return true;
+}
+
+
+static bool blk_mq_get_driver_tag(struct request *rq)
+{
+	if (rq->tag == -1)
+		return __blk_mq_get_driver_tag(rq);
+	return true;
 }
 
 static int blk_mq_dispatch_wake(wait_queue_entry_t *wait, unsigned mode,
