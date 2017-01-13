Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f173.google.com ([209.85.192.173]:36845 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751116AbdAMQmQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Jan 2017 11:42:16 -0500
Received: by mail-pf0-f173.google.com with SMTP id 189so33693727pfu.3
        for <linux-block@vger.kernel.org>; Fri, 13 Jan 2017 08:42:16 -0800 (PST)
Date: Fri, 13 Jan 2017 08:41:53 -0800
From: Omar Sandoval <osandov@osandov.com>
To: Hannes Reinecke <hare@suse.de>
Cc: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, bart.vanassche@sandisk.com
Subject: Re: [PATCH 08/10] blk-mq-sched: add framework for MQ capable IO
 schedulers
Message-ID: <20170113164153.GA15751@vader>
References: <1484170803-9311-1-git-send-email-axboe@fb.com>
 <1484170803-9311-9-git-send-email-axboe@fb.com>
 <a4c0edfa-7cb1-2b0d-141d-2ea9e0fb07ca@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <a4c0edfa-7cb1-2b0d-141d-2ea9e0fb07ca@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Jan 13, 2017 at 12:15:17PM +0100, Hannes Reinecke wrote:
> On 01/11/2017 10:40 PM, Jens Axboe wrote:
> > This adds a set of hooks that intercepts the blk-mq path of
> > allocating/inserting/issuing/completing requests, allowing
> > us to develop a scheduler within that framework.
> > 
> > We reuse the existing elevator scheduler API on the registration
> > side, but augment that with the scheduler flagging support for
> > the blk-mq interfce, and with a separate set of ops hooks for MQ
> > devices.
> > 
> > We split driver and scheduler tags, so we can run the scheduling
> > independent of device queue depth.
> > 
> > Signed-off-by: Jens Axboe <axboe@fb.com>
> [ .. ]
> > @@ -823,6 +847,35 @@ static inline unsigned int queued_to_index(unsigned int queued)
> >  	return min(BLK_MQ_MAX_DISPATCH_ORDER - 1, ilog2(queued) + 1);
> >  }
> >  
> > +static bool blk_mq_get_driver_tag(struct request *rq,
> > +				  struct blk_mq_hw_ctx **hctx, bool wait)
> > +{
> > +	struct blk_mq_alloc_data data = {
> > +		.q = rq->q,
> > +		.ctx = rq->mq_ctx,
> > +		.hctx = blk_mq_map_queue(rq->q, rq->mq_ctx->cpu),
> > +		.flags = wait ? 0 : BLK_MQ_REQ_NOWAIT,
> > +	};
> > +
> > +	if (blk_mq_hctx_stopped(data.hctx))
> > +		return false;
> > +
> > +	if (rq->tag != -1) {
> > +done:
> > +		if (hctx)
> > +			*hctx = data.hctx;
> > +		return true;
> > +	}
> > +
> > +	rq->tag = blk_mq_get_tag(&data);
> > +	if (rq->tag >= 0) {
> > +		data.hctx->tags->rqs[rq->tag] = rq;
> > +		goto done;
> > +	}
> > +
> > +	return false;
> > +}
> > +
> What happens with the existing request at 'rqs[rq->tag]' ?
> Surely there is one already, right?
> Things like '->init_request' assume a fully populated array, so moving
> one entry to another location is ... interesting.
> 
> I would have thought we need to do a request cloning here,
> otherwise this would introduce a memory leak, right?
> (Not to mention a potential double completion, as the request is now at
> two positions in the array)
> 
> Cheers,
> 
> Hannes

The entries in tags->rqs aren't slab objects, they're pointers into
pages allocated separately and tracked on tags->page_list. See
blk_mq_alloc_rqs(). In blk_mq_free_rqs(), we free all of the pages on
tags->page_list, so there shouldn't be a memory leak.

As for hctx->tags->rqs, entries are only overwritten when a scheduler is
enabled. In that case, the rqs array is storing pointers to requests
actually from hctx->sched_tags, so overwriting/leaking isn't an issue.
