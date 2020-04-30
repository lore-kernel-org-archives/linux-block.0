Return-Path: <SRS0=29BZ=6O=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DECFCC47247
	for <linux-block@archiver.kernel.org>; Thu, 30 Apr 2020 14:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE46B2137B
	for <linux-block@archiver.kernel.org>; Thu, 30 Apr 2020 14:03:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O1BTazyx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbgD3ODR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Apr 2020 10:03:17 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35666 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726782AbgD3ODQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Apr 2020 10:03:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588255394;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Tq65J0azB/z4/durrypOaw9kEf5bZxciy5BHiqcWsHY=;
        b=O1BTazyxAK3L3cAuSg/X/kxqDFUOnP5JGVkcehKDUM5smps3ghMp0iwATa5QdhIs5NnWYY
        CRp4N8Ixfd51XDOJqJJfvRE7WaFmx8vHKne9fGlCpwczfIFAZC56VW5rrv13kLXiAIEKDk
        O/NR+xc0+Jc/BgagJiNzVSUi28oqLH0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-5ycRqCQKOXu2vfa2STuoLg-1; Thu, 30 Apr 2020 10:03:10 -0400
X-MC-Unique: 5ycRqCQKOXu2vfa2STuoLg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 58291800D24;
        Thu, 30 Apr 2020 14:03:08 +0000 (UTC)
Received: from T590 (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 664195C1B0;
        Thu, 30 Apr 2020 14:02:58 +0000 (UTC)
Date:   Thu, 30 Apr 2020 22:02:54 +0800
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
Message-ID: <20200430140254.GA996887@T590>
References: <20200425154832.GA16004@lst.de>
 <20200428155837.GA16910@hirez.programming.kicks-ass.net>
 <20200429021612.GD671522@T590>
 <20200429080728.GB29143@willie-the-truck>
 <20200429094616.GB700644@T590>
 <20200429122757.GA30247@willie-the-truck>
 <20200429134327.GC700644@T590>
 <20200429173400.GC30247@willie-the-truck>
 <20200430003945.GA719313@T590>
 <20200430110429.GI19932@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430110429.GI19932@willie-the-truck>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 30, 2020 at 12:04:29PM +0100, Will Deacon wrote:
> On Thu, Apr 30, 2020 at 08:39:45AM +0800, Ming Lei wrote:
> > On Wed, Apr 29, 2020 at 06:34:01PM +0100, Will Deacon wrote:
> > > On Wed, Apr 29, 2020 at 09:43:27PM +0800, Ming Lei wrote:
> > > > Please see the following two code paths:
> > > > 
> > > > [1] code path1:
> > > > blk_mq_hctx_notify_offline():
> > > > 	set_bit(BLK_MQ_S_INACTIVE, &hctx->state);
> > > > 
> > > > 	smp_mb() or smp_mb_after_atomic()
> > > > 
> > > > 	blk_mq_hctx_drain_inflight_rqs():
> > > > 		blk_mq_tags_inflight_rqs()
> > > > 			rq = hctx->tags->rqs[index]
> > > > 			and
> > > > 			READ rq->tag
> > > > 
> > > > [2] code path2:
> > > > 	blk_mq_get_driver_tag():
> > > > 
> > > > 		process might be migrated to other CPU here and chance is small,
> > > > 		then the follow code will be run on CPU different with code path1
> > > > 
> > > > 		rq->tag = rq->internal_tag;
> > > > 		hctx->tags->rqs[rq->tag] = rq;
> > > 
> > > I /think/ this can be distilled to the SB litmus test:
> > > 
> > > 	// blk_mq_hctx_notify_offline()		blk_mq_get_driver_tag();
> > > 	Wstate = INACTIVE			Wtag
> > > 	smp_mb()				smp_mb()
> > > 	Rtag					Rstate
> > > 
> > > and you want to make sure that either blk_mq_get_driver_tag() sees the
> > > state as INACTIVE and does the cleanup, or it doesn't and
> > > blk_mq_hctx_notify_offline() sees the newly written tag and waits for the
> > > request to complete (I don't get how that happens, but hey).
> > > 
> > > Is that right?
> > 
> > Yeah, exactly.
> > 
> > > 
> > > > 		barrier() in case that code path2 is run on same CPU with code path1
> > > > 		OR
> > > > 		smp_mb() in case that code path2 is run on different CPU with code path1 because
> > > > 		of process migration
> > > > 		
> > > > 		test_bit(BLK_MQ_S_INACTIVE, &data.hctx->state)
> > > 
> > > Couldn't you just check this at the start of blk_mq_get_driver_tag() as
> > > well, and then make the smp_mb() unconditional?
> > 
> > As I mentioned, the chance for the current process(calling
> > blk_mq_get_driver_tag()) migration is very small, we do want to
> > avoid the extra smp_mb() in the fast path.
> 
> Hmm, but your suggestion of checking 'rq->mq_ctx->cpu' only works if that
> is the same CPU on which blk_mq_hctx_notify_offline() executes. What
> provides that guarantee?

BLK_MQ_S_INACTIVE is only set when the last cpu of this hctx is becoming
offline, and blk_mq_hctx_notify_offline() is called from cpu hotplug
handler. So if there is any request of this hctx submitted from somewhere,
it has to this last cpu. That is done by blk-mq's queue mapping.

In case of direct issue, basically blk_mq_get_driver_tag() is run after
the request is allocated, that is why I mentioned the chance of
migration is very small.

> 
> If there's any chance of this thing being concurrent, then you need the

The only chance is that the process running blk_mq_get_driver_tag is
migrated to another CPU in case of direct issue. And we do add
smp_mb() for this case.

> barrier there just in case. So I'd say you either need to prevent the race,
> or live with the barrier. Do you have numbers to show how expensive it is?

Not yet, but we can save it easily in the very fast path, so why not do it?
Especially most of times preemption won't happen at all.

Also this patch itself is correct, and preempt disable via get_cpu()
suggested by Christoph isn't needed too, because migration implies
smp_mb(). I will document this point in next version.

Thanks,
Ming

