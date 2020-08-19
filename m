Return-Path: <SRS0=HYnl=B5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C7E9C433DF
	for <linux-block@archiver.kernel.org>; Wed, 19 Aug 2020 14:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3771220639
	for <linux-block@archiver.kernel.org>; Wed, 19 Aug 2020 14:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ePR6MonR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbgHSOWF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Aug 2020 10:22:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57077 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726560AbgHSOWF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Aug 2020 10:22:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597846922;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a8S5IIUh7GJNHcBmoaRhz2adizeL376P9bqM1NftXwA=;
        b=ePR6MonRprbzbPVnphrkAROe+d+uYS56Z3dkCwgD5bTCT5gz9QWYJ5FYn0pI3apXyiZV4s
        8ZjwFy1UQzb80E42lf+qRUIDYYr0S9We0J3YXfo0XDsrwgcJehLG113NuAww3ILNl1ywcY
        In3AFO0NsvJp17NP0mFrlaX3oxA03xk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-I4p9tKrfP6GoyVXnLuQpxw-1; Wed, 19 Aug 2020 10:22:01 -0400
X-MC-Unique: I4p9tKrfP6GoyVXnLuQpxw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E0EF9425D2;
        Wed, 19 Aug 2020 14:21:59 +0000 (UTC)
Received: from T590 (ovpn-12-85.pek2.redhat.com [10.72.12.85])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 25F5110013C2;
        Wed, 19 Aug 2020 14:21:51 +0000 (UTC)
Date:   Wed, 19 Aug 2020 22:21:47 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [REPORT] BUG: KASAN: use-after-free in bt_iter+0x80/0xf8
Message-ID: <20200819142147.GA2795390@T590>
References: <8376443a-ec1b-0cef-8244-ed584b96fa96@huawei.com>
 <a68379af-48e7-da2b-812c-ff0fa24a41bb@huawei.com>
 <20200819000009.GB2712797@T590>
 <585bb054-2009-4abc-f1e8-802e494ba49b@huawei.com>
 <20200819085843.GA2730150@T590>
 <83de2368-a122-3b9c-db15-63ea442eecd9@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83de2368-a122-3b9c-db15-63ea442eecd9@huawei.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Aug 19, 2020 at 11:14:34AM +0100, John Garry wrote:
> On 19/08/2020 09:58, Ming Lei wrote:
> > > ah, right. I vaguely remember this. Well, if we didn't have a reliable
> > > reproducer before, we do now.
> > OK, that is great, please try the following patch:
> > 
> > diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> > index 32d82e23b095..f18632c524e9 100644
> > --- a/block/blk-mq-tag.c
> > +++ b/block/blk-mq-tag.c
> > @@ -185,19 +185,19 @@ static bool bt_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
> >   {
> >   	struct bt_iter_data *iter_data = data;
> >   	struct blk_mq_hw_ctx *hctx = iter_data->hctx;
> > -	struct blk_mq_tags *tags = hctx->tags;
> > +	struct blk_mq_tags *tags = hctx->sched_tags ?: hctx->tags;
> >   	bool reserved = iter_data->reserved;
> >   	struct request *rq;
> >   	if (!reserved)
> >   		bitnr += tags->nr_reserved_tags;
> > -	rq = tags->rqs[bitnr];
> > +	rq = tags->static_rqs[bitnr];
> >   	/*
> >   	 * We can hit rq == NULL here, because the tagging functions
> >   	 * test and set the bit before assigning ->rqs[].
> >   	 */
> > -	if (rq && rq->q == hctx->queue)
> > +	if (rq && rq->tag >= 0 && rq->q == hctx->queue)
> >   		return iter_data->fn(hctx, rq, iter_data->data, reserved);
> >   	return true;
> >   }
> > @@ -406,7 +406,7 @@ void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
> >   		return;
> >   	queue_for_each_hw_ctx(q, hctx, i) {
> > -		struct blk_mq_tags *tags = hctx->tags;
> > +		struct blk_mq_tags *tags = hctx->sched_tags ?: hctx->tags;
> >   		/*
> >   		 * If no software queues are currently mapped to this
> 
> I gave it a quick try and it looks to silence KASAN. I'll try to test more
> over the next day or so.
> 
> BTW, I doubt KASAN is even right to complain about this. I'll check that
> thread you pointed me at to learn more about what was discussed on that.

I guess that elevator switch may have to be involved in your reproducer, stale
request which are freed before switching to new elevator can stay in tags->rqs[],
then these stale requests are retrieved when reading iostat before old request slots in
tags->rqs[] are reset.

The patch should fix this issue.

Thanks,
Ming

