Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BCE9C433F5
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 10:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65AC760EDF
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 10:21:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239106AbhJMKXD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Oct 2021 06:23:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45085 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230005AbhJMKXC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 06:23:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634120459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YSYWHpq2MR9akUHQCfV2yM1cAtmp2ZHpGTTEYqlRXUw=;
        b=BK4dSdCJaGjHPHFXWCGiM6J5zm9CeRBXHV9L07xdprvfBaf+4Cek2YA/YMjEzwM0l+Yual
        n0dRDlvmfyPGjm7VTSt3kWeaS15GFa9y05gbOAmsGmbP6LkUJkmQ4HonFhhSQPy4uXDg2Z
        WR2TzOJ1/lEJEQsFLEvhZQUFWhmMO68=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-EAyJOMnBNpG7n0YyBk0cFg-1; Wed, 13 Oct 2021 06:20:56 -0400
X-MC-Unique: EAyJOMnBNpG7n0YyBk0cFg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E92C8362F8;
        Wed, 13 Oct 2021 10:20:54 +0000 (UTC)
Received: from T590 (ovpn-8-39.pek2.redhat.com [10.72.8.39])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AE57E60C5F;
        Wed, 13 Oct 2021 10:20:51 +0000 (UTC)
Date:   Wed, 13 Oct 2021 18:20:46 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, kashyap.desai@broadcom.com,
        hare@suse.de
Subject: Re: [PATCH] blk-mq: Fix blk_mq_tagset_busy_iter() for shared tags
Message-ID: <YWay/n+BJTLm1Alb@T590>
References: <1634114459-143003-1-git-send-email-john.garry@huawei.com>
 <YWalYoOZmpkmAZNK@T590>
 <79266509-f327-9de3-d22e-0e9fe00387ee@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79266509-f327-9de3-d22e-0e9fe00387ee@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 13, 2021 at 11:01:11AM +0100, John Garry wrote:
> On 13/10/2021 10:22, Ming Lei wrote:
> > On Wed, Oct 13, 2021 at 04:40:59PM +0800, John Garry wrote:
> > > Since it is now possible for a tagset to share a single set of tags, the
> > > iter function should not re-iter the tags for the count of #hw queues in
> > > that case. Rather it should just iter once.
> > > 
> > > Fixes: e0fdf846c7bb ("blk-mq: Use shared tags for shared sbitmap support")
> > > Reported-by: Kashyap Desai<kashyap.desai@broadcom.com>
> > > Signed-off-by: John Garry<john.garry@huawei.com>
> > > 
> > > diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> > > index 72a2724a4eee..c943b6529619 100644
> > > --- a/block/blk-mq-tag.c
> > > +++ b/block/blk-mq-tag.c
> > > @@ -378,9 +378,12 @@ void blk_mq_all_tag_iter(struct blk_mq_tags *tags, busy_tag_iter_fn *fn,
> > >   void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
> > >   		busy_tag_iter_fn *fn, void *priv)
> > >   {
> > > -	int i;
> > > +	unsigned int flags = tagset->flags;
> > > +	int i, nr_tags;
> > > +
> > > +	nr_tags = blk_mq_is_shared_tags(flags) ? 1 : tagset->nr_hw_queues;
> > > -	for (i = 0; i < tagset->nr_hw_queues; i++) {
> > > +	for (i = 0; i < nr_tags; i++) {
> > >   		if (tagset->tags && tagset->tags[i])
> > >   			__blk_mq_all_tag_iter(tagset->tags[i], fn, priv,
> > >   					      BT_TAG_ITER_STARTED);
> > blk_mq_queue_tag_busy_iter() needn't such change?
> 
> I didn't think so.
> 
> blk_mq_queue_tag_busy_iter() will indeed re-iter the tags per hctx. However
> in bt_iter(), we check rq->mq_hctx == hctx for calling the iter callback:
> 
> static bool bt_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
> {
> 	...
> 
> 	if (rq->q == hctx->queue && rq->mq_hctx == hctx)
> 		ret = iter_data->fn(hctx, rq, iter_data->data, reserved);
> 
> And this would only pass for the correct hctx which we're iter'ing for.

It is true for both shared and non-shared sbitmap since we don't share
hctx, so what does matter? With single shared tags, you can iterate over
all requests originated from all hw queues, right?

> Indeed, it would be nice not to iter excessive times, but I didn't see a
> straightforward way to change that.

In Kashyap's report, the lock contention is actually from
blk_mq_queue_tag_busy_iter(), see:

https://lore.kernel.org/linux-block/8867352d-2107-1f8a-0f1c-ef73450bf256@huawei.com/

> 
> There is also blk_mq_all_tag_iter():
> 
> void blk_mq_all_tag_iter(struct blk_mq_tags *tags, busy_tag_iter_fn *fn,
> 		void *priv)
> {
> 	__blk_mq_all_tag_iter(tags, fn, priv, BT_TAG_ITER_STATIC_RQS);
> }
> 
> But then the only user is blk_mq_hctx_has_requests():
> 
> static bool blk_mq_hctx_has_requests(struct blk_mq_hw_ctx *hctx)
> {
> 	struct blk_mq_tags *tags = hctx->sched_tags ?
> 			hctx->sched_tags : hctx->tags;
> 	struct rq_iter_data data = {
> 		.hctx	= hctx,
> 	};
> 
> 	blk_mq_all_tag_iter(tags, blk_mq_has_request, &data);
> 	return data.has_rq;
> }

This above one only iterates over the specified hctx/tags, it won't be
affected.

> 
> But, again like bt_iter(), blk_mq_has_request() will check the hctx matches:

Not see what matters wrt. checking hctx.



Thanks,
Ming

