Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B4FC432BE
	for <linux-block@archiver.kernel.org>; Mon, 30 Aug 2021 10:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6837610A8
	for <linux-block@archiver.kernel.org>; Mon, 30 Aug 2021 10:11:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236367AbhH3KMh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Aug 2021 06:12:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29808 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236343AbhH3KMZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Aug 2021 06:12:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630318291;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GNS9WvnZ0xw8x+G4OAVRsDet7iU5hb6uy6leUR087lI=;
        b=WcPKysc8UGw2z56FBZ/dP85BwaNXJYauTxW7pAS4ZB8mF55SCNVkWpeLxJWRsoFbndXwMQ
        aDrrlaOiWk6TunwQuobAUkuL0XUnHvokW7HOG4aKhAhCLoFDa9RnFfuwDPwNGi6ag2WnQ4
        8k6XrHdhyqhU51H3dOEzJCjn4VCK5TQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-10RyjYvuMOSbnW5b1QszLQ-1; Mon, 30 Aug 2021 06:11:27 -0400
X-MC-Unique: 10RyjYvuMOSbnW5b1QszLQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 65D506409B;
        Mon, 30 Aug 2021 10:11:26 +0000 (UTC)
Received: from T590 (ovpn-8-36.pek2.redhat.com [10.72.8.36])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 759AB10074E5;
        Mon, 30 Aug 2021 10:11:17 +0000 (UTC)
Date:   Mon, 30 Aug 2021 18:11:12 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 1/2] blk-mq: don't call callbacks for requests that
 bypassed the scheduler
Message-ID: <YSyuwCKi2sS/RaXS@T590>
References: <20210827124100.98112-1-Niklas.Cassel@wdc.com>
 <20210827124100.98112-2-Niklas.Cassel@wdc.com>
 <YSjoZ/cul4w2l8tG@T590>
 <YSypVLe8vxmA+pUn@x1-carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSypVLe8vxmA+pUn@x1-carbon>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Aug 30, 2021 at 09:48:06AM +0000, Niklas Cassel wrote:
> On Fri, Aug 27, 2021 at 09:28:07PM +0800, Ming Lei wrote:
> > On Fri, Aug 27, 2021 at 12:41:31PM +0000, Niklas Cassel wrote:
> > > From: Niklas Cassel <niklas.cassel@wdc.com>
> > > 
> > > Currently, __blk_mq_alloc_request() calls ops.prepare_request and sets
> > > RQF_ELVPRIV.
> > > 
> > > Therefore, (if the request is not a flush) the RQF_ELVPRIV flag will be
> > > set for the request in blk_mq_submit_bio(), regardless if the request
> > > was submitted to a scheduler, or bypassed the scheduler.
> > > 
> > > Later, blk_mq_free_request() checks if the RQF_ELVPRIV flag is set,
> > > if it is, the ops.finish_request callback will be called.
> > > 
> > > The problem with this is that the finish_request scheduler callback
> > > will be called for requests that bypassed the scheduler.
> > > 
> > > Fix this by calling the scheduler ops.prepare_request callback, and
> > > set the RQF_ELVPRIV flag only immediately before calling the insert
> > > callback.
> > 
> > One request could be inserted more than one times, such as requeue,
> > however __blk_mq_alloc_request() is just run once, so is it fine to
> > call ->prepare_request more than one time for same request?
> 
> Calling ->prepare_request multiple times is fine.
> All the different I/O schedulers (BFQ, mq-deadline, kyber)
> simply use .prepare_request to clear/set elv->priv to a fixed value.
> 
> > 
> > Or I am wondering why not call ->prepare_request when the following
> > check is true?
> > 
> > 	if (e && e->type->ops.prepare_request && !op_is_flush(data->cmd_flags) &&
> > 		!blk_op_is_passthrough(data->cmd_flags))
> > 		e->type->ops.prepare_request()
> 
> 
> That might work, and might be a nicer solution indeed.
> 
> If a request got plugged, it will be inserted to the scheduler through
> blk_flush_plug_list() -> blk_mq_flush_plug_list() -> blk_mq_sched_insert_requests()
> which will insert them unconditionally.
> In this case. we know that !op_is_flush() (because if it was, blk_mq_submit_bio()
> would have inserted directly.)
> 
> 
> If we didn't plug, we do blk_mq_sched_insert_request(), which will add it if
> blk_mq_sched_bypass_insert() returns false:
> 
> blk_mq_sched_bypass_insert() is defined as:
> 
>         if ((rq->rq_flags & RQF_FLUSH_SEQ) || blk_rq_is_passthrough(rq))
>                 return true;
> Also in this case. we know that !op_is_flush() (blk_mq_submit_bio() would have
> inserted directly.)
> 
> 
> So, we could easily add && !blk_op_is_passthrough(data->cmd_flags) to the
> ->prepare_request condition in blk_mq_rq_ctx_init() like you suggested,
> but since the bypass condition also seems to look at RQF_FLUSH_SEQ, wouldn't
> we need to add RQF_FLUSH_SEQ to the condition in blk_mq_rq_ctx_init() as well?
> 
> This flag is set after blk_mq_rq_ctx_init(). Are we sure that RQF_FLUSH_SEQ
> flag will only be set for a request which op_is_flush() returned true?
> 
> (If so, then only adding  && !blk_op_is_passthrough(data->cmd_flags) should
> be fine.)

BTW, what I meant is the following change, is it fine?

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 0a33d16a7298..f98f8cc05644 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -327,20 +327,6 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 
 	data->ctx->rq_dispatched[op_is_sync(data->cmd_flags)]++;
 	refcount_set(&rq->ref, 1);
-
-	if (!op_is_flush(data->cmd_flags)) {
-		struct elevator_queue *e = data->q->elevator;
-
-		rq->elv.icq = NULL;
-		if (e && e->type->ops.prepare_request) {
-			if (e->type->icq_cache)
-				blk_mq_sched_assign_ioc(rq);
-
-			e->type->ops.prepare_request(rq);
-			rq->rq_flags |= RQF_ELVPRIV;
-		}
-	}
-
 	data->hctx->queued++;
 	return rq;
 }
@@ -359,17 +345,25 @@ static struct request *__blk_mq_alloc_request(struct blk_mq_alloc_data *data)
 	if (data->cmd_flags & REQ_NOWAIT)
 		data->flags |= BLK_MQ_REQ_NOWAIT;
 
-	if (e) {
+	if (e && !op_is_flush(data->cmd_flags) &&
+			!blk_op_is_passthrough(data->cmd_flags)) {
 		/*
 		 * Flush/passthrough requests are special and go directly to the
 		 * dispatch list. Don't include reserved tags in the
 		 * limiting, as it isn't useful.
 		 */
-		if (!op_is_flush(data->cmd_flags) &&
-		    !blk_op_is_passthrough(data->cmd_flags) &&
-		    e->type->ops.limit_depth &&
-		    !(data->flags & BLK_MQ_REQ_RESERVED))
+		if (e->type->ops.limit_depth &&
+			    !(data->flags & BLK_MQ_REQ_RESERVED))
 			e->type->ops.limit_depth(data->cmd_flags, data);
+
+		rq->elv.icq = NULL;
+		if (e->type->ops.prepare_request) {
+			if (e->type->icq_cache)
+				blk_mq_sched_assign_ioc(rq);
+
+			e->type->ops.prepare_request(rq);
+			rq->rq_flags |= RQF_ELVPRIV;
+		}
 	}
 
 retry:

Thanks, 
Ming

