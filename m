Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D177C433ED
	for <linux-block@archiver.kernel.org>; Wed,  5 May 2021 14:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC1A6613BE
	for <linux-block@archiver.kernel.org>; Wed,  5 May 2021 14:29:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbhEEOaJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 May 2021 10:30:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45898 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231792AbhEEOaC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 5 May 2021 10:30:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620224944;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RQQG2ihJBlOzrcPULXDL8J2wsb5zgRIJOBGF70oizsY=;
        b=IhbVqoV/llvi2VaJYyNXtI8JtYfSxbGwYhnEY33z5VSN49Hx2dEXc1HtLcYmie7XOGGh8i
        yk1ZjL0QcdMsFI6uQkg9XgSOd1DqNPtpLtczVwVnqlnZLn4eJmHAMb+dxP0RtKzePnNVKO
        ePIelb+iswl8No9hQmgxQ4/QX8T/cZM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-bDlbi2vgOduh4xNKWqGRbA-1; Wed, 05 May 2021 10:29:00 -0400
X-MC-Unique: bDlbi2vgOduh4xNKWqGRbA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AD998107ACE3;
        Wed,  5 May 2021 14:28:58 +0000 (UTC)
Received: from T590 (ovpn-12-80.pek2.redhat.com [10.72.12.80])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1658360BF1;
        Wed,  5 May 2021 14:28:50 +0000 (UTC)
Date:   Wed, 5 May 2021 22:28:46 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Khazhy Kumykov <khazhy@google.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        David Jeffery <djeffery@redhat.com>
Subject: Re: [PATCH V4 0/4] blk-mq: fix request UAF related with iterating
 over tagset requests
Message-ID: <YJKrnqTZSgahVDp4@T590>
References: <20210429023458.3044317-1-ming.lei@redhat.com>
 <fb0804e5-bfae-62ac-c3e6-d46a9a33ca53@huawei.com>
 <YJEzd8IYtw4GXrlT@T590>
 <fd7a28ae-6f6f-d9a3-a7a3-b9f68970e1b7@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd7a28ae-6f6f-d9a3-a7a3-b9f68970e1b7@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 05, 2021 at 12:19:21PM +0100, John Garry wrote:
> On 04/05/2021 12:43, Ming Lei wrote:
> > >           */
> > > -       if (rq && rq->q == hctx->queue && rq->mq_hctx == hctx)
> > > -               return iter_data->fn(hctx, rq, iter_data->data, reserved);
> > > +       if (rq) {
> > > +               mdelay(50);
> > > +               if (rq->q == hctx->queue && rq->mq_hctx == hctx)
> > > +   		  return iter_data->fn(hctx, rq, iter_data->data, reserved);
> > > +       }
> > >          return true;
> > >   }
> > hammmm, forget to cover bt_iter(), please test the following delta
> > patch:
> > 
> > 
> > diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> > index a3be267212b9..27815114ee3f 100644
> > --- a/block/blk-mq-tag.c
> > +++ b/block/blk-mq-tag.c
> > @@ -206,18 +206,28 @@ static bool bt_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
> >   	struct blk_mq_tags *tags = hctx->tags;
> >   	bool reserved = iter_data->reserved;
> >   	struct request *rq;
> > +	unsigned long flags;
> > +	bool ret = true;
> >   	if (!reserved)
> >   		bitnr += tags->nr_reserved_tags;
> > -	rq = tags->rqs[bitnr];
> > +	spin_lock_irqsave(&tags->lock, flags);
> > +	rq = tags->rqs[bitnr];
> >   	/*
> >   	 * We can hit rq == NULL here, because the tagging functions
> >   	 * test and set the bit before assigning ->rqs[].
> >   	 */
> > -	if (rq && rq->q == hctx->queue && rq->mq_hctx == hctx)
> > -		return iter_data->fn(hctx, rq, iter_data->data, reserved);
> > -	return true;
> > +	if (!rq || !refcount_inc_not_zero(&rq->ref)) {
> > +		spin_unlock_irqrestore(&tags->lock, flags);
> > +		return true;
> > +	}
> > +	spin_unlock_irqrestore(&tags->lock, flags);
> > +
> > +	if (rq->q == hctx->queue && rq->mq_hctx == hctx)
> > +		ret = iter_data->fn(hctx, rq, iter_data->data, reserved);
> > +	blk_mq_put_rq_ref(rq);
> > +	return ret;
> >   }
> 
> 
> This looks to work ok from my testing.

OK, thanks for your test, and will add your tested-by in V4.

Thanks,
Ming

