Return-Path: <SRS0=0pY0=BJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D89C433E0
	for <linux-block@archiver.kernel.org>; Thu, 30 Jul 2020 15:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53F802070B
	for <linux-block@archiver.kernel.org>; Thu, 30 Jul 2020 15:05:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XvNn6dE4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbgG3PFs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Jul 2020 11:05:48 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42493 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728092AbgG3PFr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Jul 2020 11:05:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596121545;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0dRwDR2nuLaN08zYTcVYY2ysEKD657/Mab4Mv3iOGJY=;
        b=XvNn6dE4/OgskqvVE53v8wdsGKzFCyPOnG739Xp6VSP1vQsN73nUCNrbTC0zsqYxxMMKk6
        5HXCTR3U77a96d7Dj3cowUCFBCdTfyQ5upyC2Ek2JPFFaXquYgMuRYFD/U55bL+HJl5cEn
        IeZcjtMXACo4dnSxpVDkgWv8YkeybAE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-B3PdrPmEPRCrBcmHNGothA-1; Thu, 30 Jul 2020 11:05:41 -0400
X-MC-Unique: B3PdrPmEPRCrBcmHNGothA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DC95510B13A7;
        Thu, 30 Jul 2020 15:05:39 +0000 (UTC)
Received: from T590 (ovpn-12-33.pek2.redhat.com [10.72.12.33])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 109175D9D3;
        Thu, 30 Jul 2020 15:05:35 +0000 (UTC)
Date:   Thu, 30 Jul 2020 23:05:30 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [RFC PATCH] blk-mq: implement queue quiesce via percpu_ref for
 BLK_MQ_F_BLOCKING
Message-ID: <20200730150530.GB1710335@T590>
References: <20200728134938.1505467-1-ming.lei@redhat.com>
 <20200729161229.GA3136267@dhcp-10-100-145-180.wdl.wdc.com>
 <20200729221646.GA1706771@T590>
 <b45fe77d-b09f-3649-8167-37ae13611093@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b45fe77d-b09f-3649-8167-37ae13611093@grimberg.me>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 29, 2020 at 03:42:29PM -0700, Sagi Grimberg wrote:
> 
> > > >   void blk_mq_quiesce_queue(struct request_queue *q)
> > > >   {
> > > > -	struct blk_mq_hw_ctx *hctx;
> > > > -	unsigned int i;
> > > > -	bool rcu = false;
> > > > -
> > > >   	blk_mq_quiesce_queue_nowait(q);
> > > > -	queue_for_each_hw_ctx(q, hctx, i) {
> > > > -		if (hctx->flags & BLK_MQ_F_BLOCKING)
> > > > -			synchronize_srcu(hctx->srcu);
> > > > -		else
> > > > -			rcu = true;
> > > > -	}
> > > > -	if (rcu)
> > > > +	if (q->tag_set->flags & BLK_MQ_F_BLOCKING) {
> > > > +		percpu_ref_kill(&q->dispatch_counter);
> > > > +		wait_event(q->mq_quiesce_wq,
> > > > +				percpu_ref_is_zero(&q->dispatch_counter));
> > > > +	} else
> > > >   		synchronize_rcu();
> > > >   }
> > > 
> > > 
> > > 
> > > > +static void hctx_lock(struct blk_mq_hw_ctx *hctx)
> > > >   {
> > > > -	if (!(hctx->flags & BLK_MQ_F_BLOCKING)) {
> > > > -		/* shut up gcc false positive */
> > > > -		*srcu_idx = 0;
> > > > +	if (!(hctx->flags & BLK_MQ_F_BLOCKING))
> > > >   		rcu_read_lock();
> > > > -	} else
> > > > -		*srcu_idx = srcu_read_lock(hctx->srcu);
> > > > +	else
> > > > +		percpu_ref_get(&hctx->queue->dispatch_counter);
> > > >   }
> > > 
> > > percpu_ref_get() will always succeed, even after quiesce kills it.
> > > Isn't it possible that 'percpu_ref_is_zero(&q->dispatch_counter))' may
> > > never reach 0? We only need to ensure that dispatchers will observe
> > > blk_queue_quiesced(). That doesn't require that there are no current
> > > dispatchers.
> > 
> > IMO it shouldn't be one issue in reality, because:
> > 
> > - when dispatch can't make progress, the submission side will finally
> >    stop because we either run queue from submission side or request
> >    completion
> > - submission side stops because we always have very limited requests
> > 
> > - completion side stops because requests queued to device is limited
> > too
> 
> I don't think that any requests should pass after the kill was called,
> otherwise how can we safely quiesce if requests can come in after
> it?

What we guarantee is that no request can be queued to LLD after
blk_mq_quiesce_queue returns.

With percpu_refcount, once percpu_ref_is_zero(&q->dispatch_counter)
returns true, all code path can observe the QUIESCED flag reliably just
like what SRCU does, so no any request can pass to LLD after blk_mq_quiesce_queue
returns.

> 
> > 
> > We still can handle this case by not dispatch in case that percpu_ref_tryget()
> 
> You meant tryget_live right?

Both works, but tryget_live could be better.


Thanks, 
Ming

