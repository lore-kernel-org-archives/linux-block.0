Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-oi0-f41.google.com ([209.85.218.41]:33909 "EHLO
        mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030888AbdDTVry (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Apr 2017 17:47:54 -0400
Received: by mail-oi0-f41.google.com with SMTP id x184so70065754oia.1
        for <linux-block@vger.kernel.org>; Thu, 20 Apr 2017 14:47:54 -0700 (PDT)
Date: Thu, 20 Apr 2017 14:47:52 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] blk-mq: fix schedule-while-atomic with scheduler attached
Message-ID: <20170420214752.GB30116@vader.DHCP.thefacebook.com>
References: <bf3c52f2-3150-1d0c-2ae3-740032707129@kernel.dk>
 <20170420213040.GA30116@vader.DHCP.thefacebook.com>
 <79636c0b-8201-2b68-ae08-f7c3b8e17aac@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <79636c0b-8201-2b68-ae08-f7c3b8e17aac@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Apr 20, 2017 at 03:41:21PM -0600, Jens Axboe wrote:
> On 04/20/2017 03:30 PM, Omar Sandoval wrote:
> > On Thu, Apr 20, 2017 at 03:13:43PM -0600, Jens Axboe wrote:
> >> We must have dropped the ctx before we call
> >> blk_mq_sched_insert_request() with can_block=true, otherwise we risk
> >> that a flush request can block on insertion if we are currently out of
> >> tags.
> >>
> >> [   47.667190] BUG: scheduling while atomic: jbd2/sda2-8/2089/0x00000002
> >> [   47.674493] Modules linked in: x86_pkg_temp_thermal btrfs xor zlib_deflate raid6_pq sr_mod cdre
> >> [   47.690572] Preemption disabled at:
> >> [   47.690584] [<ffffffff81326c7c>] blk_mq_sched_get_request+0x6c/0x280
> >> [   47.701764] CPU: 1 PID: 2089 Comm: jbd2/sda2-8 Not tainted 4.11.0-rc7+ #271
> >> [   47.709630] Hardware name: Dell Inc. PowerEdge T630/0NT78X, BIOS 2.3.4 11/09/2016
> >> [   47.718081] Call Trace:
> >> [   47.720903]  dump_stack+0x4f/0x73
> >> [   47.724694]  ? blk_mq_sched_get_request+0x6c/0x280
> >> [   47.730137]  __schedule_bug+0x6c/0xc0
> >> [   47.734314]  __schedule+0x559/0x780
> >> [   47.738302]  schedule+0x3b/0x90
> >> [   47.741899]  io_schedule+0x11/0x40
> >> [   47.745788]  blk_mq_get_tag+0x167/0x2a0
> >> [   47.750162]  ? remove_wait_queue+0x70/0x70
> >> [   47.754901]  blk_mq_get_driver_tag+0x92/0xf0
> >> [   47.759758]  blk_mq_sched_insert_request+0x134/0x170
> >> [   47.765398]  ? blk_account_io_start+0xd0/0x270
> >> [   47.770679]  blk_mq_make_request+0x1b2/0x850
> >> [   47.775766]  generic_make_request+0xf7/0x2d0
> >> [   47.780860]  submit_bio+0x5f/0x120
> >> [   47.784979]  ? submit_bio+0x5f/0x120
> >> [   47.789631]  submit_bh_wbc.isra.46+0x10d/0x130
> >> [   47.794902]  submit_bh+0xb/0x10
> >> [   47.798719]  journal_submit_commit_record+0x190/0x210
> >> [   47.804686]  ? _raw_spin_unlock+0x13/0x30
> >> [   47.809480]  jbd2_journal_commit_transaction+0x180a/0x1d00
> >> [   47.815925]  kjournald2+0xb6/0x250
> >> [   47.820022]  ? kjournald2+0xb6/0x250
> >> [   47.824328]  ? remove_wait_queue+0x70/0x70
> >> [   47.829223]  kthread+0x10e/0x140
> >> [   47.833147]  ? commit_timeout+0x10/0x10
> >> [   47.837742]  ? kthread_create_on_node+0x40/0x40
> >> [   47.843122]  ret_from_fork+0x29/0x40
> >>
> >> Fixes: a4d907b6a33b ("blk-mq: streamline blk_mq_make_request")
> >> Signed-off-by: Jens Axboe <axboe@fb.com>
> >>
> >> diff --git a/block/blk-mq.c b/block/blk-mq.c
> >> index 9d7645f24b05..323eed50d615 100644
> >> --- a/block/blk-mq.c
> >> +++ b/block/blk-mq.c
> >> @@ -1634,8 +1634,10 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
> >>  		blk_mq_try_issue_directly(data.hctx, rq, &cookie);
> >>  		return cookie;
> >>  	} else if (q->elevator) {
> >> +		blk_mq_put_ctx(data.ctx);
> >>  		blk_mq_bio_to_request(rq, bio);
> >>  		blk_mq_sched_insert_request(rq, false, true, true, true);
> >> +		return cookie;
> >>  	} else if (!blk_mq_merge_queue_io(data.hctx, data.ctx, rq, bio))
> >>  		blk_mq_run_hw_queue(data.hctx, true);
> >>  
> >>
> > 
> > I'm confused, the first thing we check in make_request is:
> > 
> > 	if (unlikely(is_flush_fua)) {
> > 		blk_mq_bio_to_request(rq, bio);
> > 		if (q->elevator) {
> > 			blk_mq_sched_insert_request(rq, false, true, true,
> > 					true);
> > 		} else {
> > 			blk_insert_flush(rq);
> > 			blk_mq_run_hw_queue(data.hctx, true);
> > 		}
> > 	}
> > 
> > and can_block doesn't do anything in the !flush case, so shouldn't it be
> > changed in that one instead?
> 
> It should be changed in both cases. But I do wonder why we're triggering
> the bottom one, and not the top one, since this is clearly a flush.
> 
> > Alternatively, blk_mq_get_tag() knows how to drop the ctx before it
> > sleeps, but blk_mq_get_driver_tag() doesn't set data.ctx. I'm not sure
> > if that'll do what we want, and this is making my head hurt.
> 
> How about the below? Drop the ctx in all the cases. We only really want
> to hold on to it for the case where we insert into the software queues.

So do we want to hold on to it or not when we insert into the software
queues? Because this change looks like it drops it before we do the
insert.

> But as long as we guarantee that all cases in that massive if/else
> drops it, we should be fine, and we can skip the various places that
> do manual returns to avoid having to hit the put_ctx/return cookie
> case at the end.
> 
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index dd9e8d6d471d..992f09772f8a 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1571,6 +1571,7 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
>  
>  	plug = current->plug;
>  	if (unlikely(is_flush_fua)) {
> +		blk_mq_put_ctx(data.ctx);
>  		blk_mq_bio_to_request(rq, bio);
>  		if (q->elevator) {
>  			blk_mq_sched_insert_request(rq, false, true, true,
> @@ -1582,6 +1583,7 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
>  	} else if (plug && q->nr_hw_queues == 1) {
>  		struct request *last = NULL;
>  
> +		blk_mq_put_ctx(data.ctx);
>  		blk_mq_bio_to_request(rq, bio);
>  
>  		/*
> @@ -1626,20 +1628,19 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
>  		if (same_queue_rq)
>  			blk_mq_try_issue_directly(data.hctx, same_queue_rq,
>  					&cookie);
> -
> -		return cookie;
>  	} else if (q->nr_hw_queues > 1 && is_sync) {
>  		blk_mq_put_ctx(data.ctx);
>  		blk_mq_bio_to_request(rq, bio);
>  		blk_mq_try_issue_directly(data.hctx, rq, &cookie);
> -		return cookie;
>  	} else if (q->elevator) {
> +		blk_mq_put_ctx(data.ctx);
>  		blk_mq_bio_to_request(rq, bio);
>  		blk_mq_sched_insert_request(rq, false, true, true, true);

If the scheduler doesn't have ->insert_request(), this'll insert into
the software queue.

> -	} else if (!blk_mq_merge_queue_io(data.hctx, data.ctx, rq, bio))

This also inserts into the software queue.

> +	} else if (!blk_mq_merge_queue_io(data.hctx, data.ctx, rq, bio)) {
> +		blk_mq_put_ctx(data.ctx);
>  		blk_mq_run_hw_queue(data.hctx, true);
> +	}
>  
> -	blk_mq_put_ctx(data.ctx);
>  	return cookie;
>  }
>  
> 
> -- 
> Jens Axboe
> 
