Return-Path: <SRS0=GTSZ=6N=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 034BFC83000
	for <linux-block@archiver.kernel.org>; Wed, 29 Apr 2020 17:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5CBD21D7B
	for <linux-block@archiver.kernel.org>; Wed, 29 Apr 2020 17:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588182397;
	bh=y7jLaMjc4T4hoe4WeFT4Eu7M3+p08BtdcGQMPA1MtOg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=dNIg5EX/UaXYn4fn+FWn/z36j1EFbGJuI04UGkNZuE3lS+tpvWPaDBAkHP5tkKZwC
	 3REPj8D65zGPVOKGBnE3W7aIuE1LLgLqeljlAEXzgYTLeTXY3kRW1hKHquLme6lmbL
	 NFhbXVXxaMnHlWWHDl8sJ8clJeUQgYspCCjCwvjA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbgD2Rqh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Apr 2020 13:46:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:58310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726423AbgD2Rqh (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Apr 2020 13:46:37 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42E672083B;
        Wed, 29 Apr 2020 17:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588182396;
        bh=y7jLaMjc4T4hoe4WeFT4Eu7M3+p08BtdcGQMPA1MtOg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=hip7XyVw+LJzVr7aHpPGL8EGcRLPWFug1gZZoCuSa74EO/tAl2HsPo7VIjgnp59Sf
         b/KF38B6JWyVw0je5CcVDamccBIHgDYDWHn+vcuNyJvHLeDxH0hezelYneH1enKPdJ
         izxf2HpPZRusU7FH0gCgqgoIvxt10e63y0Y4qv1E=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 1F34D3522508; Wed, 29 Apr 2020 10:46:36 -0700 (PDT)
Date:   Wed, 29 Apr 2020 10:46:36 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V8 07/11] blk-mq: stop to handle IO and drain IO before
 hctx becomes inactive
Message-ID: <20200429174636.GF7560@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200425083224.GA5634@lst.de>
 <20200425093437.GA495669@T590>
 <20200425095351.GC495669@T590>
 <20200425154832.GA16004@lst.de>
 <20200428155837.GA16910@hirez.programming.kicks-ass.net>
 <20200429021612.GD671522@T590>
 <20200429080728.GB29143@willie-the-truck>
 <20200429094616.GB700644@T590>
 <20200429122757.GA30247@willie-the-truck>
 <20200429134327.GC700644@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429134327.GC700644@T590>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 29, 2020 at 09:43:27PM +0800, Ming Lei wrote:
> On Wed, Apr 29, 2020 at 01:27:57PM +0100, Will Deacon wrote:
> > On Wed, Apr 29, 2020 at 05:46:16PM +0800, Ming Lei wrote:
> > > On Wed, Apr 29, 2020 at 09:07:29AM +0100, Will Deacon wrote:
> > > > On Wed, Apr 29, 2020 at 10:16:12AM +0800, Ming Lei wrote:
> > > > > On Tue, Apr 28, 2020 at 05:58:37PM +0200, Peter Zijlstra wrote:
> > > > > > On Sat, Apr 25, 2020 at 05:48:32PM +0200, Christoph Hellwig wrote:
> > > > > > >  		atomic_inc(&data.hctx->nr_active);
> > > > > > >  	}
> > > > > > >  	data.hctx->tags->rqs[rq->tag] = rq;
> > > > > > >  
> > > > > > >  	/*
> > > > > > > +	 * Ensure updates to rq->tag and tags->rqs[] are seen by
> > > > > > > +	 * blk_mq_tags_inflight_rqs.  This pairs with the smp_mb__after_atomic
> > > > > > > +	 * in blk_mq_hctx_notify_offline.  This only matters in case a process
> > > > > > > +	 * gets migrated to another CPU that is not mapped to this hctx.
> > > > > > >  	 */
> > > > > > > +	if (rq->mq_ctx->cpu != get_cpu())
> > > > > > >  		smp_mb();
> > > > > > > +	put_cpu();
> > > > > > 
> > > > > > This looks exceedingly weird; how do you think you can get to another
> > > > > > CPU and not have an smp_mb() implied in the migration itself? Also, what
> > > > > 
> > > > > What we need is one smp_mb() between the following two OPs:
> > > > > 
> > > > > 1) 
> > > > >    rq->tag = rq->internal_tag;
> > > > >    data.hctx->tags->rqs[rq->tag] = rq;
> > > > > 
> > > > > 2) 
> > > > > 	if (unlikely(test_bit(BLK_MQ_S_INACTIVE, &rq->mq_hctx->state)))
> > > > > 
> > > > > And the pair of the above barrier is in blk_mq_hctx_notify_offline().
> > > > 
> > > > I'm struggling with this, so let me explain why. My understanding of the
> > > > original patch [1] and your explanation above is that you want *either* of
> > > > the following behaviours
> > > > 
> > > >   - __blk_mq_get_driver_tag() (i.e. (1) above) and test_bit(BLK_MQ_S_INACTIVE, ...)
> > > >     run on the same CPU with barrier() between them, or
> > > > 
> > > >   - There is a migration and therefore an implied smp_mb() between them
> > > > 
> > > > However, given that most CPUs can speculate loads (and therefore the
> > > > test_bit() operation), I don't understand how the "everything runs on the
> > > > same CPU" is safe if a barrier() is required.  In other words, if the
> > > > barrier() is needed to prevent the compiler hoisting the load, then the CPU
> > > > can still cause problems.
> > > 
> > > Do you think the speculate loads may return wrong value of
> > > BLK_MQ_S_INACTIVE bit in case of single CPU? BTW, writing the bit is
> > > done on the same CPU. If yes, this machine may not obey cache consistency,
> > > IMO.
> > 
> > If the write is on the same CPU, then the read will of course return the
> > value written by that write, otherwise we'd have much bigger problems!
> 
> OK, then it is nothing to with speculate loads.
> 
> > 
> > But then I'm confused, because you're saying that the write is done on the
> > same CPU, but previously you were saying that migration occuring before (1)
> > was problematic. Can you explain a bit more about that case, please? What
> > is running before (1) that is relevant here?
> 
> Please see the following two code paths:
> 
> [1] code path1:
> blk_mq_hctx_notify_offline():
> 	set_bit(BLK_MQ_S_INACTIVE, &hctx->state);
> 
> 	smp_mb() or smp_mb_after_atomic()
> 
> 	blk_mq_hctx_drain_inflight_rqs():
> 		blk_mq_tags_inflight_rqs()
> 			rq = hctx->tags->rqs[index]
> 			and
> 			READ rq->tag
> 
> [2] code path2:
> 	blk_mq_get_driver_tag():
> 
> 		process might be migrated to other CPU here and chance is small,
> 		then the follow code will be run on CPU different with code path1

If the process is migrated from one CPU to another, each CPU will execute
full barriers (smp_mb() or equivalent) as part of the migration.  Do those
barriers help prevent the undesired outcome?

								Thanx, Paul

> 		rq->tag = rq->internal_tag;
> 		hctx->tags->rqs[rq->tag] = rq;
> 
> 		barrier() in case that code path2 is run on same CPU with code path1
> 		OR
> 		smp_mb() in case that code path2 is run on different CPU with code path1 because
> 		of process migration
> 		
> 		test_bit(BLK_MQ_S_INACTIVE, &data.hctx->state)
> 
> 
> 
> Thanks,
> Ming
> 
