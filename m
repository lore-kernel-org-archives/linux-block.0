Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD7DC77B7A
	for <linux-block@archiver.kernel.org>; Tue, 16 May 2023 08:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbjEPIj4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 May 2023 04:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231687AbjEPIjy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 May 2023 04:39:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22220A0
        for <linux-block@vger.kernel.org>; Tue, 16 May 2023 01:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684226356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UOtWOSUFFavGLUDq5kErvBtpAwaMcKo/Ye+YMdQ2LpI=;
        b=CG10KjJjoopbUbczdAOJalrxNS20iH3/t31JuPq6c6ZvYzjhxjG/oUKHu3ZFcHgtqDxNix
        MgFqE0qgkObT9cMsFraYFGXShP7xZKbOnD3/XYeHx9o29B5KHrsCvqfFxf0xz3TKioFWze
        IikkzafY2cNKMisUYrefdgyy6avQens=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-622-CzCGaF6INXmvBKa0cNpiaA-1; Tue, 16 May 2023 04:39:14 -0400
X-MC-Unique: CzCGaF6INXmvBKa0cNpiaA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8001F811E7C;
        Tue, 16 May 2023 08:39:14 +0000 (UTC)
Received: from ovpn-8-19.pek2.redhat.com (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C3EF714171C1;
        Tue, 16 May 2023 08:39:10 +0000 (UTC)
Date:   Tue, 16 May 2023 16:39:05 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Keith Busch <kbusch@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        ming.lei@redhat.com
Subject: Re: [PATCH V2 2/2] blk-mq: make sure elevator callbacks aren't
 called for passthrough request
Message-ID: <ZGNBKSaULn/gpsL0@ovpn-8-19.pek2.redhat.com>
References: <20230515144601.52811-1-ming.lei@redhat.com>
 <20230515144601.52811-3-ming.lei@redhat.com>
 <c0c4fc86-29ff-5a70-1f32-dca9af4602d5@acm.org>
 <ZGKUehOEnKThjFpR@kbusch-mbp>
 <ZGLad5yYUDJBleBQ@ovpn-8-19.pek2.redhat.com>
 <20230516062409.GB7325@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230516062409.GB7325@lst.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 16, 2023 at 08:24:09AM +0200, Christoph Hellwig wrote:
> On Tue, May 16, 2023 at 09:20:55AM +0800, Ming Lei wrote:
> > > That sounds like a good idea. It changes more behavior than what Ming is
> > > targeting here, but after looking through each use for RQF_ELV, I think
> > > not having that set really is the right thing to do in all cases for
> > > passthrough requests.
> > 
> > I did consider that approach. But:
> > 
> > - RQF_ELV actually means that the request & its tag is allocated from sched tags.
> > 
> > - if RQF_ELV is cleared for passthrough request, request may be
> >   allocated from sched tags(normal IO) and driver tags(passthrough) at the same time.
> >   This way may cause other problem, such as, breaking blk_mq_hctx_has_requests().
> >   Meantime it becomes not likely to optimize tags resource utilization in future,
> >   at least for single LUN/NS, no need to keep sched tags & driver tags
> >   in memory at the same time.
> 
> Then make that obvious.  That is:
> 
>  - rename RQF_ELV to RQV_SCHED_TAGS
>  - add the RQV_SCHED_TAGS check to your blk_mq_bypass_sched helper.
>    I'd also invert the return value and rename it to someting like
>    blk_rq_use_sched.

I can understand the point, but it may not be done by single flag, so
how about the following change?

diff --git a/block/blk-mq.c b/block/blk-mq.c
index d1b4aae43cf9..eddc2b5f3319 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -354,7 +354,7 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 		data->rq_flags |= RQF_IO_STAT;
 	rq->rq_flags = data->rq_flags;
 
-	if (!(data->rq_flags & RQF_ELV)) {
+	if (!(data->rq_flags & RQF_SCHED_TAGS)) {
 		rq->tag = tag;
 		rq->internal_tag = BLK_MQ_NO_TAG;
 	} else {
@@ -392,8 +392,7 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 		INIT_HLIST_NODE(&rq->hash);
 		RB_CLEAR_NODE(&rq->rb_node);
 
-		if (!op_is_flush(data->cmd_flags) &&
-		    e->type->ops.prepare_request) {
+		if (e->type->ops.prepare_request) {
 			e->type->ops.prepare_request(rq);
 			rq->rq_flags |= RQF_ELVPRIV;
 		}
@@ -451,15 +450,19 @@ static struct request *__blk_mq_alloc_requests(struct blk_mq_alloc_data *data)
 	if (q->elevator) {
 		struct elevator_queue *e = q->elevator;
 
-		data->rq_flags |= RQF_ELV;
+		data->rq_flags |= RQF_SCHED_TAGS;
+
+		/* both flush and passthrough request can't go into scheduler */
+		if (!op_is_flush(data->cmd_flags) &&
+		    !blk_op_is_passthrough(data->cmd_flags))
+			data->rq_flags |= RQF_ELV;
 
 		/*
 		 * Flush/passthrough requests are special and go directly to the
 		 * dispatch list. Don't include reserved tags in the
 		 * limiting, as it isn't useful.
 		 */
-		if (!op_is_flush(data->cmd_flags) &&
-		    !blk_op_is_passthrough(data->cmd_flags) &&
+		if ((data->rq_flags & RQF_ELV) &&
 		    e->type->ops.limit_depth &&
 		    !(data->flags & BLK_MQ_REQ_RESERVED))
 			e->type->ops.limit_depth(data->cmd_flags, data);
@@ -468,7 +471,7 @@ static struct request *__blk_mq_alloc_requests(struct blk_mq_alloc_data *data)
 retry:
 	data->ctx = blk_mq_get_ctx(q);
 	data->hctx = blk_mq_map_queue(q, data->cmd_flags, data->ctx);
-	if (!(data->rq_flags & RQF_ELV))
+	if (!(data->rq_flags & RQF_SCHED_TAGS))
 		blk_mq_tag_busy(data->hctx);
 
 	if (data->flags & BLK_MQ_REQ_RESERVED)
@@ -651,7 +654,7 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 	if (!q->elevator)
 		blk_mq_tag_busy(data.hctx);
 	else
-		data.rq_flags |= RQF_ELV;
+		data.rq_flags |= RQF_SCHED_TAGS;
 
 	if (flags & BLK_MQ_REQ_RESERVED)
 		data.rq_flags |= RQF_RESV;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 06caacd77ed6..b4910a6471b7 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -61,7 +61,8 @@ typedef __u32 __bitwise req_flags_t;
 #define RQF_TIMED_OUT		((__force req_flags_t)(1 << 21))
 /* queue has elevator attached */
 #define RQF_ELV			((__force req_flags_t)(1 << 22))
-#define RQF_RESV			((__force req_flags_t)(1 << 23))
+#define RQF_RESV		((__force req_flags_t)(1 << 23))
+#define RQF_SCHED_TAGS		((__force req_flags_t)(1 << 24))
 
 /* flags that prevent us from merging requests: */
 #define RQF_NOMERGE_FLAGS \



Thanks,
Ming

