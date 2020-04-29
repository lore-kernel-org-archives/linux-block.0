Return-Path: <SRS0=GTSZ=6N=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C03A2C83004
	for <linux-block@archiver.kernel.org>; Wed, 29 Apr 2020 08:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FEBE2083B
	for <linux-block@archiver.kernel.org>; Wed, 29 Apr 2020 08:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588147655;
	bh=HhWi3wS0yMwZxsIoQra2W+XnejaDI6lTRvOC64dLnwk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tu6P6P11UqZ/KnVkpqWB8RiUrF+rUcWhxo/LBtkjcjmXoAaDvdu91npO32AjIBb0d
	 hn+LICU7OG/7TrVk4InsQOiB0DoO5mycTwzQ9R1AggVJspAi3yMC3COZ96x/15LRCu
	 ZifivcOm8zX1NpoWmEoYG7ZKixdN9TD/slHSDvzY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgD2IHe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Apr 2020 04:07:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:58982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726345AbgD2IHe (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Apr 2020 04:07:34 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6149E20787;
        Wed, 29 Apr 2020 08:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588147654;
        bh=HhWi3wS0yMwZxsIoQra2W+XnejaDI6lTRvOC64dLnwk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mGGOWzki+b1NnL1vSwS5lBPHHVc5jjorVIOq3sA5lq/0F3frdASZdA0fOEwWunrar
         60YhahbmpIqbp+/dhSTZBh4AEmN8D/S6CroSydA7ai9T+STrp7m1gHZnX4H/pr6rYC
         8KacHNpX+fiJ7FnC3/NKC75tJn9oe66A2xP+P4Y0=
Date:   Wed, 29 Apr 2020 09:07:29 +0100
From:   Will Deacon <will@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>, paulmck@kernel.org
Subject: Re: [PATCH V8 07/11] blk-mq: stop to handle IO and drain IO before
 hctx becomes inactive
Message-ID: <20200429080728.GB29143@willie-the-truck>
References: <20200424102351.475641-1-ming.lei@redhat.com>
 <20200424102351.475641-8-ming.lei@redhat.com>
 <20200424103851.GD28156@lst.de>
 <20200425031723.GC477579@T590>
 <20200425083224.GA5634@lst.de>
 <20200425093437.GA495669@T590>
 <20200425095351.GC495669@T590>
 <20200425154832.GA16004@lst.de>
 <20200428155837.GA16910@hirez.programming.kicks-ass.net>
 <20200429021612.GD671522@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429021612.GD671522@T590>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 29, 2020 at 10:16:12AM +0800, Ming Lei wrote:
> On Tue, Apr 28, 2020 at 05:58:37PM +0200, Peter Zijlstra wrote:
> > On Sat, Apr 25, 2020 at 05:48:32PM +0200, Christoph Hellwig wrote:
> > >  		atomic_inc(&data.hctx->nr_active);
> > >  	}
> > >  	data.hctx->tags->rqs[rq->tag] = rq;
> > >  
> > >  	/*
> > > +	 * Ensure updates to rq->tag and tags->rqs[] are seen by
> > > +	 * blk_mq_tags_inflight_rqs.  This pairs with the smp_mb__after_atomic
> > > +	 * in blk_mq_hctx_notify_offline.  This only matters in case a process
> > > +	 * gets migrated to another CPU that is not mapped to this hctx.
> > >  	 */
> > > +	if (rq->mq_ctx->cpu != get_cpu())
> > >  		smp_mb();
> > > +	put_cpu();
> > 
> > This looks exceedingly weird; how do you think you can get to another
> > CPU and not have an smp_mb() implied in the migration itself? Also, what
> 
> What we need is one smp_mb() between the following two OPs:
> 
> 1) 
>    rq->tag = rq->internal_tag;
>    data.hctx->tags->rqs[rq->tag] = rq;
> 
> 2) 
> 	if (unlikely(test_bit(BLK_MQ_S_INACTIVE, &rq->mq_hctx->state)))
> 
> And the pair of the above barrier is in blk_mq_hctx_notify_offline().

I'm struggling with this, so let me explain why. My understanding of the
original patch [1] and your explanation above is that you want *either* of
the following behaviours

  - __blk_mq_get_driver_tag() (i.e. (1) above) and test_bit(BLK_MQ_S_INACTIVE, ...)
    run on the same CPU with barrier() between them, or

  - There is a migration and therefore an implied smp_mb() between them

However, given that most CPUs can speculate loads (and therefore the
test_bit() operation), I don't understand how the "everything runs on the
same CPU" is safe if a barrier() is required.  In other words, if the
barrier() is needed to prevent the compiler hoisting the load, then the CPU
can still cause problems.

Thanks,

Will

[1] https://lore.kernel.org/linux-block/20200424102351.475641-8-ming.lei@redhat.com/
