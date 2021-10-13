Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19AFDC433F5
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 14:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E088A610EA
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 14:29:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233023AbhJMObs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Oct 2021 10:31:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36466 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234057AbhJMObr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 10:31:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634135383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TvDOG3/TIKu7XYQ57oonwZXIqqIxlTxJBy8V8rPfz/o=;
        b=R8eFa2B9xiBPHUDVRifpl80KxP5GKvVEcFCG0J1wt03fOqK+4KbWLygzTThxgkGfdc0z+p
        n6NYnduKklKx/tGSApYa3IzxO6/BsmE4ssquyf/Ysz9OidaT3/3HOPlBmD5Jpeno9c9XdX
        vjWjRgAfO3pokJERwoH8AX4jBixZr5E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-__f4wOWDN_qlX_ChorH5nw-1; Wed, 13 Oct 2021 10:29:42 -0400
X-MC-Unique: __f4wOWDN_qlX_ChorH5nw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 46E921006AAE;
        Wed, 13 Oct 2021 14:29:41 +0000 (UTC)
Received: from T590 (ovpn-8-39.pek2.redhat.com [10.72.8.39])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 84AE0380;
        Wed, 13 Oct 2021 14:29:31 +0000 (UTC)
Date:   Wed, 13 Oct 2021 22:29:26 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, kashyap.desai@broadcom.com,
        hare@suse.de, ming.lei@redhat.com
Subject: Re: [PATCH] blk-mq: Fix blk_mq_tagset_busy_iter() for shared tags
Message-ID: <YWbtRm22vohvY0Ca@T590>
References: <1634114459-143003-1-git-send-email-john.garry@huawei.com>
 <YWalYoOZmpkmAZNK@T590>
 <79266509-f327-9de3-d22e-0e9fe00387ee@huawei.com>
 <YWay/n+BJTLm1Alb@T590>
 <9f3c4d57-6b77-5345-0d4c-275962214b2a@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f3c4d57-6b77-5345-0d4c-275962214b2a@huawei.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 13, 2021 at 12:11:12PM +0100, John Garry wrote:
> > > > blk_mq_queue_tag_busy_iter() needn't such change? >> I didn't
> > > > think so.>>>> blk_mq_queue_tag_busy_iter() will indeed
> re-iter the tags per hctx. However
> > > in bt_iter(), we check rq->mq_hctx == hctx for calling the iter callback:
> > > 
> > > static bool bt_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
> > > {
> > > 	...
> > > 
> > > 	if (rq->q == hctx->queue && rq->mq_hctx == hctx)
> > > 		ret = iter_data->fn(hctx, rq, iter_data->data, reserved);
> > > 
> > > And this would only pass for the correct hctx which we're iter'ing for.
> > It is true for both shared and non-shared sbitmap since we don't share
> > hctx, so what does matter?
> 
> It matters that we are doing the right thing for shared tags. My point is we
> iter but don't call the callback unless the correct hctx.
> 
> As I see, this has not changed in transitioning from shared sbitmap to
> shared tags.
> 
> > With single shared tags, you can iterate over
> > all requests originated from all hw queues, right?
> > 
> Right, for the same request queue, we should do that.
> 
> > > Indeed, it would be nice not to iter excessive times, but I didn't see a
> > > straightforward way to change that.
> 
> 
> > In Kashyap's report, the lock contention is actually from
> > blk_mq_queue_tag_busy_iter(), see:
> > 
> > https://lore.kernel.org/linux-block/8867352d-2107-1f8a-0f1c-ef73450bf256@huawei.com/
> > 
> 
> As I understand, Kashyap mentioned no throughput regression with my series,
> but just higher cpu usage in blk_mq_find_and_get_req().
> 
> I'll see if I can see such a thing in my setup.
> 
> But could it be that since we only have a single sets of requests per
> tagset, and not a set of requests per HW queue, there is more contention on
> the common set of requests in the refcount_inc_not_zero() call ***, below:
> 
> static struct request *blk_mq_find_and_get_req(struct blk_mq_tags *tags,
> unsigned int bitnr)
> {
> 	...
> 
> 	rq = tags->rqs[bitnr];
> 	if (... || !refcount_inc_not_zero(&rq->ref)) ***
> 	...
> }

Kashyap's log shows that contention on tags->lock is increased, that
should be caused by nr_hw_queues iterating. blk_mq_find_and_get_req()
will be run nr_hw_queue times compared with pre-shared-sbitmap, since it
is done before checking rq->mq_hctx.

> 
> But I wonder why this function is even called often...
> 
> > > There is also blk_mq_all_tag_iter():
> > > 
> > > void blk_mq_all_tag_iter(struct blk_mq_tags *tags, busy_tag_iter_fn *fn,
> > > 		void *priv)
> > > {
> > > 	__blk_mq_all_tag_iter(tags, fn, priv, BT_TAG_ITER_STATIC_RQS);
> > > }
> > > 
> > > But then the only user is blk_mq_hctx_has_requests():
> > > 
> > > static bool blk_mq_hctx_has_requests(struct blk_mq_hw_ctx *hctx)
> > > {
> > > 	struct blk_mq_tags *tags = hctx->sched_tags ?
> > > 			hctx->sched_tags : hctx->tags;
> > > 	struct rq_iter_data data = {
> > > 		.hctx	= hctx,
> > > 	};
> > > 
> > > 	blk_mq_all_tag_iter(tags, blk_mq_has_request, &data);
> > > 	return data.has_rq;
> > > }
> > This above one only iterates over the specified hctx/tags, it won't be
> > affected.
> > 
> > > But, again like bt_iter(), blk_mq_has_request() will check the hctx matches:
> > Not see what matters wrt. checking hctx.
> 
> I'm just saying that something like the following would be broken for shared
> tags:
> 
> static bool blk_mq_has_request(struct request *rq, void *data, bool
> reserved)
> {
> 	struct rq_iter_data *iter_data = data;
> 
> 	iter_data->has_rq = true;
> 	return true;
> }
> 
> static bool blk_mq_hctx_has_requests(struct blk_mq_hw_ctx *hctx)
> {
> 	struct rq_iter_data data = {
> 	};
> 
> 	blk_mq_all_tag_iter(tags, blk_mq_has_request, &data);
> 	return data.has_rq;
> }
> 
> As it ignores that we want to check for a specific hctx.

No, that isn't what I meant, follows the change I suggested:


diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 72a2724a4eee..2a2ad6dfcc33 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -232,8 +232,9 @@ static bool bt_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
 	if (!rq)
 		return true;
 
-	if (rq->q == hctx->queue && rq->mq_hctx == hctx)
-		ret = iter_data->fn(hctx, rq, iter_data->data, reserved);
+	if (rq->q == hctx->queue && (rq->mq_hctx == hctx ||
+				blk_mq_is_shared_tags(hctx->flags)))
+		ret = iter_data->fn(rq->mq_hctx, rq, iter_data->data, reserved);
 	blk_mq_put_rq_ref(rq);
 	return ret;
 }
@@ -460,6 +461,9 @@ void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
 		if (tags->nr_reserved_tags)
 			bt_for_each(hctx, &tags->breserved_tags, fn, priv, true);
 		bt_for_each(hctx, &tags->bitmap_tags, fn, priv, false);
+
+		if (blk_mq_is_shared_tags(hctx->flags))
+			break;
 	}
 	blk_queue_exit(q);
 }


Thanks,
Ming

