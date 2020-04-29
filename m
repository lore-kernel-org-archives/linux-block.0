Return-Path: <SRS0=GTSZ=6N=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF3FDC83003
	for <linux-block@archiver.kernel.org>; Wed, 29 Apr 2020 13:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99701206B8
	for <linux-block@archiver.kernel.org>; Wed, 29 Apr 2020 13:43:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VKw4pqp6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgD2Nnu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Apr 2020 09:43:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51011 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726599AbgD2Nnt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Apr 2020 09:43:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588167827;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Rcn9/AvAN/EsgNMm8MtuQD1T5du/+Rn8L3sXN6Mnriw=;
        b=VKw4pqp68zehkuxR3w30/nOy9a3n98w2kJjhF49XduqfoKo42NKcG4SNMI3X/VrcgfQ/CM
        NCFTNQv+GHj51t3jap/JTm3xc3+k8rLusv80LWXEC96wJjkF9g54T/h0E4sNPYnUBRtlon
        /5cW9TiY9ZTREd4jvloCUmJYXfIBk0I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-110-o2sNc6h7NbyTyYBYT5YEQg-1; Wed, 29 Apr 2020 09:43:42 -0400
X-MC-Unique: o2sNc6h7NbyTyYBYT5YEQg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DC0EA106B38C;
        Wed, 29 Apr 2020 13:43:40 +0000 (UTC)
Received: from T590 (ovpn-8-27.pek2.redhat.com [10.72.8.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AEC671001281;
        Wed, 29 Apr 2020 13:43:32 +0000 (UTC)
Date:   Wed, 29 Apr 2020 21:43:27 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Will Deacon <will@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>, paulmck@kernel.org
Subject: Re: [PATCH V8 07/11] blk-mq: stop to handle IO and drain IO before
 hctx becomes inactive
Message-ID: <20200429134327.GC700644@T590>
References: <20200425031723.GC477579@T590>
 <20200425083224.GA5634@lst.de>
 <20200425093437.GA495669@T590>
 <20200425095351.GC495669@T590>
 <20200425154832.GA16004@lst.de>
 <20200428155837.GA16910@hirez.programming.kicks-ass.net>
 <20200429021612.GD671522@T590>
 <20200429080728.GB29143@willie-the-truck>
 <20200429094616.GB700644@T590>
 <20200429122757.GA30247@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429122757.GA30247@willie-the-truck>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 29, 2020 at 01:27:57PM +0100, Will Deacon wrote:
> On Wed, Apr 29, 2020 at 05:46:16PM +0800, Ming Lei wrote:
> > On Wed, Apr 29, 2020 at 09:07:29AM +0100, Will Deacon wrote:
> > > On Wed, Apr 29, 2020 at 10:16:12AM +0800, Ming Lei wrote:
> > > > On Tue, Apr 28, 2020 at 05:58:37PM +0200, Peter Zijlstra wrote:
> > > > > On Sat, Apr 25, 2020 at 05:48:32PM +0200, Christoph Hellwig wrote:
> > > > > >  		atomic_inc(&data.hctx->nr_active);
> > > > > >  	}
> > > > > >  	data.hctx->tags->rqs[rq->tag] = rq;
> > > > > >  
> > > > > >  	/*
> > > > > > +	 * Ensure updates to rq->tag and tags->rqs[] are seen by
> > > > > > +	 * blk_mq_tags_inflight_rqs.  This pairs with the smp_mb__after_atomic
> > > > > > +	 * in blk_mq_hctx_notify_offline.  This only matters in case a process
> > > > > > +	 * gets migrated to another CPU that is not mapped to this hctx.
> > > > > >  	 */
> > > > > > +	if (rq->mq_ctx->cpu != get_cpu())
> > > > > >  		smp_mb();
> > > > > > +	put_cpu();
> > > > > 
> > > > > This looks exceedingly weird; how do you think you can get to another
> > > > > CPU and not have an smp_mb() implied in the migration itself? Also, what
> > > > 
> > > > What we need is one smp_mb() between the following two OPs:
> > > > 
> > > > 1) 
> > > >    rq->tag = rq->internal_tag;
> > > >    data.hctx->tags->rqs[rq->tag] = rq;
> > > > 
> > > > 2) 
> > > > 	if (unlikely(test_bit(BLK_MQ_S_INACTIVE, &rq->mq_hctx->state)))
> > > > 
> > > > And the pair of the above barrier is in blk_mq_hctx_notify_offline().
> > > 
> > > I'm struggling with this, so let me explain why. My understanding of the
> > > original patch [1] and your explanation above is that you want *either* of
> > > the following behaviours
> > > 
> > >   - __blk_mq_get_driver_tag() (i.e. (1) above) and test_bit(BLK_MQ_S_INACTIVE, ...)
> > >     run on the same CPU with barrier() between them, or
> > > 
> > >   - There is a migration and therefore an implied smp_mb() between them
> > > 
> > > However, given that most CPUs can speculate loads (and therefore the
> > > test_bit() operation), I don't understand how the "everything runs on the
> > > same CPU" is safe if a barrier() is required.  In other words, if the
> > > barrier() is needed to prevent the compiler hoisting the load, then the CPU
> > > can still cause problems.
> > 
> > Do you think the speculate loads may return wrong value of
> > BLK_MQ_S_INACTIVE bit in case of single CPU? BTW, writing the bit is
> > done on the same CPU. If yes, this machine may not obey cache consistency,
> > IMO.
> 
> If the write is on the same CPU, then the read will of course return the
> value written by that write, otherwise we'd have much bigger problems!

OK, then it is nothing to with speculate loads.

> 
> But then I'm confused, because you're saying that the write is done on the
> same CPU, but previously you were saying that migration occuring before (1)
> was problematic. Can you explain a bit more about that case, please? What
> is running before (1) that is relevant here?

Please see the following two code paths:

[1] code path1:
blk_mq_hctx_notify_offline():
	set_bit(BLK_MQ_S_INACTIVE, &hctx->state);

	smp_mb() or smp_mb_after_atomic()

	blk_mq_hctx_drain_inflight_rqs():
		blk_mq_tags_inflight_rqs()
			rq = hctx->tags->rqs[index]
			and
			READ rq->tag

[2] code path2:
	blk_mq_get_driver_tag():

		process might be migrated to other CPU here and chance is small,
		then the follow code will be run on CPU different with code path1

		rq->tag = rq->internal_tag;
		hctx->tags->rqs[rq->tag] = rq;

		barrier() in case that code path2 is run on same CPU with code path1
		OR
		smp_mb() in case that code path2 is run on different CPU with code path1 because
		of process migration
		
		test_bit(BLK_MQ_S_INACTIVE, &data.hctx->state)



Thanks,
Ming

