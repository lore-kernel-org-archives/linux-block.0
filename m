Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C85FCC433E0
	for <linux-block@archiver.kernel.org>; Wed, 23 Dec 2020 03:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DE71207D8
	for <linux-block@archiver.kernel.org>; Wed, 23 Dec 2020 03:34:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbgLWDes (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Dec 2020 22:34:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34355 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727336AbgLWDes (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Dec 2020 22:34:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608694400;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oH4i5u+OngfoNRkZDjWtKIPmVaBapj70GfPb8kB9uls=;
        b=VavNVrbO6EcDy6yWD6OP+HsRFX/5R8mmfV0KGLkG0W35cFhF/xf4bsbl1DY/2cy6kwUdwA
        kWTV4AN/4fb4iZM9zw/a0iDEI8DYV36gif+2MWhAVBBzMflWAUExdxqaFRUClvgA9dx06T
        IIqtmMdsjvXByK6zeoP5e1NwScYFQpg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-595-jbFCO5A1PMSww-_IN8L2KA-1; Tue, 22 Dec 2020 22:33:18 -0500
X-MC-Unique: jbFCO5A1PMSww-_IN8L2KA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DAD16107ACE4;
        Wed, 23 Dec 2020 03:33:16 +0000 (UTC)
Received: from T590 (ovpn-13-46.pek2.redhat.com [10.72.13.46])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 985F31880F;
        Wed, 23 Dec 2020 03:33:09 +0000 (UTC)
Date:   Wed, 23 Dec 2020 11:33:05 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        hare@suse.de, Kashyap Desai <kashyap.desai@broadcom.com>
Subject: Re: [PATCH 2/2] blk-mq: Improve performance of non-mq IO schedulers
 with multiple HW queues
Message-ID: <20201223033305.GA2940673@T590>
References: <20201218214412.1543-1-jack@suse.cz>
 <20201218214412.1543-3-jack@suse.cz>
 <20201219031427.GA2711539@T590>
 <20201222101822.GD13601@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201222101822.GD13601@quack2.suse.cz>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 22, 2020 at 11:18:22AM +0100, Jan Kara wrote:
> On Sat 19-12-20 11:14:27, Ming Lei wrote:
> > On Fri, Dec 18, 2020 at 10:44:12PM +0100, Jan Kara wrote:
> > > Currently when non-mq aware IO scheduler (BFQ, mq-deadline) is used for
> > > a queue with multiple HW queues, the performance it rather bad. The
> > > problem is that these IO schedulers use queue-wide locking and their
> > > dispatch function does not respect the hctx it is passed in and returns
> > > any request it finds appropriate. Thus locality of request access is
> > > broken and dispatch from multiple CPUs just contends on IO scheduler
> > > locks. For these IO schedulers there's little point in dispatching from
> > > multiple CPUs. Instead dispatch always only from a single CPU to limit
> > > contention.
> > > 
> > > Below is a comparison of dbench runs on XFS filesystem where the storage
> > > is a raid card with 64 HW queues and to it attached a single rotating
> > > disk. BFQ is used as IO scheduler:
> > > 
> > >       clients           MQ                     SQ             MQ-Patched
> > > Amean 1      39.12 (0.00%)       43.29 * -10.67%*       36.09 *   7.74%*
> > > Amean 2     128.58 (0.00%)      101.30 *  21.22%*       96.14 *  25.23%*
> > > Amean 4     577.42 (0.00%)      494.47 *  14.37%*      508.49 *  11.94%*
> > > Amean 8     610.95 (0.00%)      363.86 *  40.44%*      362.12 *  40.73%*
> > > Amean 16    391.78 (0.00%)      261.49 *  33.25%*      282.94 *  27.78%*
> > > Amean 32    324.64 (0.00%)      267.71 *  17.54%*      233.00 *  28.23%*
> > > Amean 64    295.04 (0.00%)      253.02 *  14.24%*      242.37 *  17.85%*
> > > Amean 512 10281.61 (0.00%)    10211.16 *   0.69%*    10447.53 *  -1.61%*
> > > 
> > > Numbers are times so lower is better. MQ is stock 5.10-rc6 kernel. SQ is
> > > the same kernel with megaraid_sas.host_tagset_enable=0 so that the card
> > > advertises just a single HW queue. MQ-Patched is a kernel with this
> > > patch applied.
> > > 
> > > You can see multiple hardware queues heavily hurt performance in
> > > combination with BFQ. The patch restores the performance.
> > > 
> > > Signed-off-by: Jan Kara <jack@suse.cz>
> > > ---
> > >  block/blk-mq.c           | 37 +++++++++++++++++++++++++++++++++++++
> > >  block/kyber-iosched.c    |  1 +
> > >  include/linux/elevator.h |  2 ++
> > >  3 files changed, 40 insertions(+)
> > > 
> > > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > > index 57d0461f2be5..6d80054c231b 100644
> > > --- a/block/blk-mq.c
> > > +++ b/block/blk-mq.c
> > > @@ -1663,6 +1663,31 @@ void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
> > >  }
> > >  EXPORT_SYMBOL(blk_mq_run_hw_queue);
> > >  
> > > +static struct blk_mq_hw_ctx *blk_mq_sq_iosched_hctx(struct request_queue *q)
> > > +{
> > > +	struct elevator_queue *e = q->elevator;
> > > +	struct blk_mq_hw_ctx *hctx;
> > > +
> > > +	/*
> > > +	 * The queue has multiple hardware queues but uses IO scheduler that
> > > +	 * does not respect hardware queues when dispatching? This is not a
> > > +	 * great setup but it can be sensible when we have a single rotational
> > > +	 * disk behind a raid card. Just don't bother with multiple HW queues
> > > +	 * and dispatch from hctx for the current CPU since running multiple
> > > +	 * queues just causes lock contention inside the scheduler and
> > > +	 * pointless cache bouncing because the hctx is not respected by the IO
> > > +	 * scheduler's dispatch function anyway.
> > > +	 */
> > > +	if (q->nr_hw_queues > 1 && e && e->type->ops.dispatch_request &&
> > > +	    !(e->type->elevator_features & ELEVATOR_F_MQ_AWARE)) {
> > > +		hctx = blk_mq_map_queue_type(q, HCTX_TYPE_DEFAULT,
> > > +					     raw_smp_processor_id());
> > > +		if (!blk_mq_hctx_stopped(hctx))
> > > +			return hctx;
> > > +	}
> > > +	return NULL;
> > > +}
> > > +
> > >  /**
> > >   * blk_mq_run_hw_queues - Run all hardware queues in a request queue.
> > >   * @q: Pointer to the request queue to run.
> > > @@ -1673,6 +1698,12 @@ void blk_mq_run_hw_queues(struct request_queue *q, bool async)
> > >  	struct blk_mq_hw_ctx *hctx;
> > >  	int i;
> > >  
> > > +	hctx = blk_mq_sq_iosched_hctx(q);
> > > +	if (hctx) {
> > > +		blk_mq_run_hw_queue(hctx, async);
> > > +		return;
> > > +	}
> > > +
> > 
> > This approach looks reasonable, just wondering which code path is wrt.
> > blk_mq_run_hw_queues() improvement by this patch.
> > 
> > Since ed5dd6a67d5e ("scsi: core: Only re-run queue in scsi_end_request() if device
> > queue is busy") is merged, blk_mq_run_hw_queues() is only called from scsi_end_request()
> > when the scsi device is busy for megaraid.
> > 
> > Another one is bfq_schedule_dispatch(), in which blk_mq_run_hw_queues()
> > is still be called, if that is the reason, maybe it is easier to optimize
> > bfq_schedule_dispatch() by avoiding to call blk_mq_run_hw_queues().
> 
> That's a good question. Tracing shows that with dbench I'm seeing *lots*
> (about 23000/s) blk_mq_delay_run_hw_queues() calls, mostly from
> __blk_mq_do_dispatch_sched(). This drops to "only" about 2000 calls/s with
> my patches applied.

There is only one blk_mq_delay_run_hw_queues(BLK_MQ_BUDGET_DELAY) in
__blk_mq_do_dispatch_sched() with 3ms delay, so in theory there will be at most
(300 * nr_hw_queues) calls/s, but nr_hw_queues could be big as nr_cpus.

> 
> So it means BFQ decided not to dispatch any request (e.g. because it is
> idling for more IO from the same process) and that triggers that path in
> __blk_mq_do_dispatch_sched() that just queues the dispatch again. So blk-mq
> ends up polling BFQ rather heavily for requests it doesn't want to give out
> :). In this sense my patch just makes the real problem less severe.
> 
> I've noticed that if ->has_work() returned false, we would not end up
> calling blk_mq_delay_run_hw_queues(). But for BFQ ->has_work() often
> returns true because it has requests queued but ->dispatch_request()
> doesn't dispatch anything because of other scheduling constraints. And so
> we end up calling blk_mq_delay_run_hw_queues() because if we allocated
> dispatch budget and didn't dispatch in the end, we could have blocked
> dispatch from another hctx and so now need to rerun that hctx to dispatch
> possibly queued requests.

Yeah, it is one BFQ specific behavior, and BFQ just said there is work
to do, but it can't be dispatched immediately.

> 
> I was thinking how we could possibly improve this. One obvious possibility
> is to modify IO schedulers so that their ->has_work() does not return true
> if they later decide not to dispatch anything. However this can happen both
> to mq-deadline and BFQ and for either of them determining whether they will
> dispatch a request or not is about as expensive as dispatching it. So it
> doesn't seem very appealing for these IO schedulers to do the work twice or
> to somehow cache the request found. What seems more workable would be for
> blk_mq_put_dispatch_budget() to return whether rerunning the queue might be
> needed or not (for SCSI, which is the only subsystem using budgeting, this

You may refer to commit a0823421a4d7("blk-mq: Rerun dispatching in the case of
budget contention")

BTW, I think the approach in your patch is good enough for handling the
issue. For BFQ and mq-deadline, it is enough to just run one hctx in
blk_mq_delay_run_hw_queues() and blk_mq_run_hw_queues().


Thanks,
Ming

