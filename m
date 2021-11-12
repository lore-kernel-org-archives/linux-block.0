Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A26C433EF
	for <linux-block@archiver.kernel.org>; Fri, 12 Nov 2021 12:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DFB760F70
	for <linux-block@archiver.kernel.org>; Fri, 12 Nov 2021 12:47:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234881AbhKLMua (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 Nov 2021 07:50:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50924 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231433AbhKLMu3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 Nov 2021 07:50:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636721259;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vJVu7tx3hIMRi6PIT3DxyHI/yGl0LPeJZc50fkIyiIk=;
        b=GTeILVo+RXSy8r9rj+9+hvjcoe9ZsRxhkDaqRdeHtaIAixIC+tbuYWKJAyhsUXSFOdGMon
        p5PQJkdKBEyckrvipBVbbuxUDxOFuVJoh+lzID/6I3p58ueC6D0an5fuf/EOzBvWMG3P5K
        zxELQPamj9ELHLhCvZBnCR/ItLBIxd4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-WCIBEk0LNhenm2N60W3Oow-1; Fri, 12 Nov 2021 07:47:35 -0500
X-MC-Unique: WCIBEk0LNhenm2N60W3Oow-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B1574804140;
        Fri, 12 Nov 2021 12:47:34 +0000 (UTC)
Received: from T590 (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0246757CAB;
        Fri, 12 Nov 2021 12:47:20 +0000 (UTC)
Date:   Fri, 12 Nov 2021 20:47:15 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] blk-mq: setup blk_mq_alloc_data.cmd_flags after
 submit_bio_checks() is done
Message-ID: <YY5iUwZ2TVtfqfXN@T590>
References: <20211112081137.406930-1-ming.lei@redhat.com>
 <20211112082140.GA30681@lst.de>
 <YY4nv5eQUTOF5Wfv@T590>
 <20211112084441.GA32120@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211112084441.GA32120@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Nov 12, 2021 at 09:44:41AM +0100, Christoph Hellwig wrote:
> On Fri, Nov 12, 2021 at 04:37:19PM +0800, Ming Lei wrote:
> > > can only be used for reads, and no fua can be set if the preallocating
> > > I/O didn't use fua, etc.
> > > 
> > > What are the pitfalls of just chanigng cmd_flags?
> > 
> > Then we need to check cmd_flags carefully, such as hctx->type has to
> > be same, flush & passthrough flags has to be same, that said all
> > ->cmd_flags used for allocating rqs have to be same with the following
> > bio->bi_opf.
> > 
> > In usual cases, I guess all IOs submitted from same plug batch should be
> > same type. If not, we can switch to change cmd_flags.
> 
> Jens: is this a limit fitting into your use cases?
> 
> I guess as a quick fix this rejecting different flags is probably the
> best we can do for now, but I suspect we'll want to eventually relax
> them.

rw mixed workload will be affected, so I think we need to switch to
change cmd_flags, how about the following patch?

From 9ab77b7adee768272944c20b7cffc8abdb85a35b Mon Sep 17 00:00:00 2001
From: Ming Lei <ming.lei@redhat.com>
Date: Fri, 12 Nov 2021 08:14:38 +0800
Subject: [PATCH] blk-mq: fix filesystem I/O request allocation

submit_bio_checks() may update bio->bi_opf, so we have to initialize
blk_mq_alloc_data.cmd_flags with bio->bi_opf after submit_bio_checks()
returns when allocating new request.

In case of using cached request, fallback to allocate new request if
cached rq isn't compatible with the incoming bio, otherwise change
rq->cmd_flags with incoming bio->bi_opf.

Fixes: 900e080752025f00 ("block: move queue enter logic into blk_mq_submit_bio()")
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 39 ++++++++++++++++++++++++++++++---------
 block/blk-mq.h | 26 +++++++++++++++-----------
 2 files changed, 45 insertions(+), 20 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index f511db395c7f..3ab34c4f20da 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2521,12 +2521,8 @@ static struct request *blk_mq_get_new_requests(struct request_queue *q,
 	};
 	struct request *rq;
 
-	if (unlikely(bio_queue_enter(bio)))
-		return NULL;
-	if (unlikely(!submit_bio_checks(bio)))
-		goto put_exit;
 	if (blk_mq_attempt_bio_merge(q, bio, nsegs, same_queue_rq))
-		goto put_exit;
+		return NULL;
 
 	rq_qos_throttle(q, bio);
 
@@ -2543,19 +2539,32 @@ static struct request *blk_mq_get_new_requests(struct request_queue *q,
 	rq_qos_cleanup(q, bio);
 	if (bio->bi_opf & REQ_NOWAIT)
 		bio_wouldblock_error(bio);
-put_exit:
-	blk_queue_exit(q);
+
 	return NULL;
 }
 
+static inline bool blk_mq_can_use_cached_rq(struct request *rq,
+		struct bio *bio)
+{
+	if (blk_mq_get_hctx_type(bio->bi_opf) != rq->mq_hctx->type)
+		return false;
+
+	if (op_is_flush(rq->cmd_flags) != op_is_flush(bio->bi_opf))
+		return false;
+
+	return true;
+}
+
 static inline struct request *blk_mq_get_request(struct request_queue *q,
 						 struct blk_plug *plug,
 						 struct bio *bio,
 						 unsigned int nsegs,
 						 bool *same_queue_rq)
 {
+	struct request *rq;
+	bool checked = false;
+
 	if (plug) {
-		struct request *rq;
 
 		rq = rq_list_peek(&plug->cached_rq);
 		if (rq && rq->q == q) {
@@ -2564,6 +2573,10 @@ static inline struct request *blk_mq_get_request(struct request_queue *q,
 			if (blk_mq_attempt_bio_merge(q, bio, nsegs,
 						same_queue_rq))
 				return NULL;
+			checked = true;
+			if (!blk_mq_can_use_cached_rq(rq, bio))
+				goto fallback;
+			rq->cmd_flags = bio->bi_opf;
 			plug->cached_rq = rq_list_next(rq);
 			INIT_LIST_HEAD(&rq->queuelist);
 			rq_qos_throttle(q, bio);
@@ -2571,7 +2584,15 @@ static inline struct request *blk_mq_get_request(struct request_queue *q,
 		}
 	}
 
-	return blk_mq_get_new_requests(q, plug, bio, nsegs, same_queue_rq);
+fallback:
+	if (unlikely(bio_queue_enter(bio)))
+		return NULL;
+	if (!checked && !submit_bio_checks(bio))
+		return NULL;
+	rq = blk_mq_get_new_requests(q, plug, bio, nsegs, same_queue_rq);
+	if (!rq)
+		blk_queue_exit(q);
+	return rq;
 }
 
 /**
diff --git a/block/blk-mq.h b/block/blk-mq.h
index cb0b5482ca5e..4d92fc1124ae 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -89,15 +89,7 @@ static inline struct blk_mq_hw_ctx *blk_mq_map_queue_type(struct request_queue *
 	return q->queue_hw_ctx[q->tag_set->map[type].mq_map[cpu]];
 }
 
-/*
- * blk_mq_map_queue() - map (cmd_flags,type) to hardware queue
- * @q: request queue
- * @flags: request command flags
- * @ctx: software queue cpu ctx
- */
-static inline struct blk_mq_hw_ctx *blk_mq_map_queue(struct request_queue *q,
-						     unsigned int flags,
-						     struct blk_mq_ctx *ctx)
+static inline enum hctx_type blk_mq_get_hctx_type(unsigned int flags)
 {
 	enum hctx_type type = HCTX_TYPE_DEFAULT;
 
@@ -108,8 +100,20 @@ static inline struct blk_mq_hw_ctx *blk_mq_map_queue(struct request_queue *q,
 		type = HCTX_TYPE_POLL;
 	else if ((flags & REQ_OP_MASK) == REQ_OP_READ)
 		type = HCTX_TYPE_READ;
-	
-	return ctx->hctxs[type];
+	return type;
+}
+
+/*
+ * blk_mq_map_queue() - map (cmd_flags,type) to hardware queue
+ * @q: request queue
+ * @flags: request command flags
+ * @ctx: software queue cpu ctx
+ */
+static inline struct blk_mq_hw_ctx *blk_mq_map_queue(struct request_queue *q,
+						     unsigned int flags,
+						     struct blk_mq_ctx *ctx)
+{
+	return ctx->hctxs[blk_mq_get_hctx_type(flags)];
 }
 
 /*
-- 
2.31.1


-- 
Ming

