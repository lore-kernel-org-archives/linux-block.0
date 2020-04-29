Return-Path: <SRS0=GTSZ=6N=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81609C83003
	for <linux-block@archiver.kernel.org>; Wed, 29 Apr 2020 09:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CEE02082E
	for <linux-block@archiver.kernel.org>; Wed, 29 Apr 2020 09:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g69DBV6P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbgD2Jqj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Apr 2020 05:46:39 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:38184 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726345AbgD2Jqj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Apr 2020 05:46:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588153598;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TB5K1McbPnML6W8O8uwyMerol1WU54IkqVgJ7BdRd+o=;
        b=g69DBV6PGZcrMOfu9Ih6kxf5Kx+861GRS8ZFHQ6YDaoIDCKl96nrdnWjtVp53QJShulhmJ
        wwXdBeWVT52kAnqEBjjLx3YmxD73GoEX3GjihJcVL9tet/KB5CpSdlkOWBlPuY6OdYaMlp
        HZ9xWu1FPIaOYUgLdiXNRMi4jhRAH78=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-B0-vhw8zOm25HfibkSm7Zg-1; Wed, 29 Apr 2020 05:46:32 -0400
X-MC-Unique: B0-vhw8zOm25HfibkSm7Zg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 203B01005510;
        Wed, 29 Apr 2020 09:46:30 +0000 (UTC)
Received: from T590 (ovpn-8-27.pek2.redhat.com [10.72.8.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A34EB60E1C;
        Wed, 29 Apr 2020 09:46:21 +0000 (UTC)
Date:   Wed, 29 Apr 2020 17:46:16 +0800
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
Message-ID: <20200429094616.GB700644@T590>
References: <20200424102351.475641-8-ming.lei@redhat.com>
 <20200424103851.GD28156@lst.de>
 <20200425031723.GC477579@T590>
 <20200425083224.GA5634@lst.de>
 <20200425093437.GA495669@T590>
 <20200425095351.GC495669@T590>
 <20200425154832.GA16004@lst.de>
 <20200428155837.GA16910@hirez.programming.kicks-ass.net>
 <20200429021612.GD671522@T590>
 <20200429080728.GB29143@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429080728.GB29143@willie-the-truck>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 29, 2020 at 09:07:29AM +0100, Will Deacon wrote:
> On Wed, Apr 29, 2020 at 10:16:12AM +0800, Ming Lei wrote:
> > On Tue, Apr 28, 2020 at 05:58:37PM +0200, Peter Zijlstra wrote:
> > > On Sat, Apr 25, 2020 at 05:48:32PM +0200, Christoph Hellwig wrote:
> > > >  		atomic_inc(&data.hctx->nr_active);
> > > >  	}
> > > >  	data.hctx->tags->rqs[rq->tag] = rq;
> > > >  
> > > >  	/*
> > > > +	 * Ensure updates to rq->tag and tags->rqs[] are seen by
> > > > +	 * blk_mq_tags_inflight_rqs.  This pairs with the smp_mb__after_atomic
> > > > +	 * in blk_mq_hctx_notify_offline.  This only matters in case a process
> > > > +	 * gets migrated to another CPU that is not mapped to this hctx.
> > > >  	 */
> > > > +	if (rq->mq_ctx->cpu != get_cpu())
> > > >  		smp_mb();
> > > > +	put_cpu();
> > > 
> > > This looks exceedingly weird; how do you think you can get to another
> > > CPU and not have an smp_mb() implied in the migration itself? Also, what
> > 
> > What we need is one smp_mb() between the following two OPs:
> > 
> > 1) 
> >    rq->tag = rq->internal_tag;
> >    data.hctx->tags->rqs[rq->tag] = rq;
> > 
> > 2) 
> > 	if (unlikely(test_bit(BLK_MQ_S_INACTIVE, &rq->mq_hctx->state)))
> > 
> > And the pair of the above barrier is in blk_mq_hctx_notify_offline().
> 
> I'm struggling with this, so let me explain why. My understanding of the
> original patch [1] and your explanation above is that you want *either* of
> the following behaviours
> 
>   - __blk_mq_get_driver_tag() (i.e. (1) above) and test_bit(BLK_MQ_S_INACTIVE, ...)
>     run on the same CPU with barrier() between them, or
> 
>   - There is a migration and therefore an implied smp_mb() between them
> 
> However, given that most CPUs can speculate loads (and therefore the
> test_bit() operation), I don't understand how the "everything runs on the
> same CPU" is safe if a barrier() is required.  In other words, if the
> barrier() is needed to prevent the compiler hoisting the load, then the CPU
> can still cause problems.

Do you think the speculate loads may return wrong value of
BLK_MQ_S_INACTIVE bit in case of single CPU? BTW, writing the bit is
done on the same CPU. If yes, this machine may not obey cache consistency,
IMO.

Also smp_mb() is really barrier() in case of non-SMP, looks non-SMP code
still works well without other barrier required even though with
speculate loads.

Thanks,
Ming

> 
> Thanks,
> 
> Will
> 
> [1] https://lore.kernel.org/linux-block/20200424102351.475641-8-ming.lei@redhat.com/
> 

-- 
Ming

