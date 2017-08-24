Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48790 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751111AbdHXGMX (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Aug 2017 02:12:23 -0400
Date: Thu, 24 Aug 2017 14:12:08 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "loberman@redhat.com" <loberman@redhat.com>
Subject: Re: [PATCH V2 05/20] blk-mq-sched: improve dispatching from sw queue
Message-ID: <20170824061207.GF12966@ming.t460p>
References: <20170805065705.12989-1-ming.lei@redhat.com>
 <20170805065705.12989-6-ming.lei@redhat.com>
 <1503435422.2508.24.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1503435422.2508.24.camel@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Aug 22, 2017 at 08:57:03PM +0000, Bart Van Assche wrote:
> On Sat, 2017-08-05 at 14:56 +0800, Ming Lei wrote:
> > +static inline void blk_mq_do_dispatch_ctx(struct request_queue *q,
> > +					  struct blk_mq_hw_ctx *hctx)
> > +{
> > +	LIST_HEAD(rq_list);
> > +	struct blk_mq_ctx *ctx = NULL;
> > +
> > +	do {
> > +		struct request *rq;
> > +
> > +		rq = blk_mq_dispatch_rq_from_ctx(hctx, ctx);
> > +		if (!rq)
> > +			break;
> > +		list_add(&rq->queuelist, &rq_list);
> > +
> > +		/* round robin for fair dispatch */
> > +		ctx = blk_mq_next_ctx(hctx, rq->mq_ctx);
> > +	} while (blk_mq_dispatch_rq_list(q, &rq_list));
> > +}
> 
> An additional question about this patch: shouldn't request dequeuing start
> at the software queue next to the last one from which a request got dequeued
> instead of always starting at the first software queue (struct blk_mq_ctx
> *ctx = NULL) to be truly round robin?

Looks a good idea, will introduce a ctx hint in hctx for starting when
blk_mq_dispatch_rq_list() returns zero. No lock is needed since
it is just a hint.

-- 
Ming
