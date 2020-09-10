Return-Path: <SRS0=/Scz=CT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10DD2C433E2
	for <linux-block@archiver.kernel.org>; Thu, 10 Sep 2020 14:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF25D207FB
	for <linux-block@archiver.kernel.org>; Thu, 10 Sep 2020 14:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599749781;
	bh=PHydTs//1Z0WBTdqTTnUXRZ2vHkm9CK82ppdHxvRuEo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GNaFrgowE5PYWz+is99UuGkVF4vE6aKlFZqsRLmPX4E1OQigi2+x0nKg8nGePF+Kz
	 7Z0XSh+Vejc0wCDpbPFZH/zyovdXBktazMbO4Zb5ptvMKDKq3S1fobxLga9aSEkTXe
	 hNtPQ+gZJZJA7UdZVcTIunGf7nXNHNOiHsSf4Id0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731016AbgIJO4M (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Sep 2020 10:56:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:33598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730863AbgIJOzV (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Sep 2020 10:55:21 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55D6F207FB;
        Thu, 10 Sep 2020 14:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599749721;
        bh=PHydTs//1Z0WBTdqTTnUXRZ2vHkm9CK82ppdHxvRuEo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f8jVqRVYdCaqZSptWgC5AD+FsuYiHbFCLi2QJ2FG82xlRMGt5aZlQHtLJtb2wqXRx
         UDSizF6QenG+Rr50GwG2SxV0CSDrVWOtlFNueV8lIESqmSziXBKP0o18pOGQy58MNd
         9fHkrv0FS4BLUqetoSc1kY34QVRluuVgmXeeIz+8=
Date:   Thu, 10 Sep 2020 07:55:18 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Chao Leng <lengchao@huawei.com>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH V4 2/4] blk-mq: implement queue quiesce via percpu_ref
 for BLK_MQ_F_BLOCKING
Message-ID: <20200910145518.GB3446191@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200909104116.1674592-1-ming.lei@redhat.com>
 <20200909104116.1674592-3-ming.lei@redhat.com>
 <20200909160409.GA3356175@dhcp-10-100-145-180.wdl.wdc.com>
 <20200910015321.GA7420@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910015321.GA7420@T590>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 10, 2020 at 09:53:21AM +0800, Ming Lei wrote:
> On Wed, Sep 09, 2020 at 09:04:09AM -0700, Keith Busch wrote:
> > On Wed, Sep 09, 2020 at 06:41:14PM +0800, Ming Lei wrote:
> > >  void blk_mq_quiesce_queue(struct request_queue *q)
> > >  {
> > > -	struct blk_mq_hw_ctx *hctx;
> > > -	unsigned int i;
> > > -	bool rcu = false;
> > > +	bool blocking = !!(q->tag_set->flags & BLK_MQ_F_BLOCKING);
> > > +	bool was_quiesced =__blk_mq_quiesce_queue_nowait(q);
> > >  
> > > -	__blk_mq_quiesce_queue_nowait(q);
> > > +	if (!was_quiesced && blocking)
> > > +		percpu_ref_kill(&q->dispatch_counter);
> > >  
> > > -	queue_for_each_hw_ctx(q, hctx, i) {
> > > -		if (hctx->flags & BLK_MQ_F_BLOCKING)
> > > -			synchronize_srcu(hctx->srcu);
> > > -		else
> > > -			rcu = true;
> > > -	}
> > > -	if (rcu)
> > > +	if (blocking)
> > > +		wait_event(q->mq_quiesce_wq,
> > > +				percpu_ref_is_zero(&q->dispatch_counter));
> > > +	else
> > >  		synchronize_rcu();
> > >  }
> > 
> > In the previous version, you had ensured no thread can unquiesce a queue
> > while another is waiting for quiescence. Now that the locking is gone,
> > a thread could unquiesce the queue before percpu_ref reaches zero, so
> > the wait_event() may never complete on the resurrected percpu_ref.
> > 
> > I don't think any drivers do such a thing today, but it just looks like
> > the implementation leaves open the possibility.
> 
> This driver can cause bigger trouble if it unquiesces its queue which is
> being quiesced and still not done.
> 
> However, we can avoid that by the following delta change:
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 7669fe815cf9..5632727d71fa 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -225,9 +225,16 @@ static void __blk_mq_quiesce_queue(struct request_queue *q, bool wait)
>  	if (!wait)
>  		return;
>  
> +	/*
> +	 * In case of F_BLOCKING, if driver unquiesces its queue which is being
> +	 * quiesced and still not done, it can cause bigger trouble, and we simply
> +	 * return & warn once for avoiding hang here.
> +	 */
>  	if (blocking)
>  		wait_event(q->mq_quiesce_wq,
> -				percpu_ref_is_zero(&q->dispatch_counter));
> +				percpu_ref_is_zero(&q->dispatch_counter) ||
> +				WARN_ON_ONCE(!percpu_ref_is_dying(
> +						&q->dispatch_counter)));
>  	else
>  		synchronize_rcu();
>  }

Yeah, I'm okay with this. A warning and return should be good to
indicate driver sequence errors. So if you just want to fold the above
into this patch, then I don't think I have any remaining concerns.

The other race condition is if unquiesce resurrects the ref before
quiesce kills it, and there's already a warning there too.
