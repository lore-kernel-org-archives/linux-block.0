Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50812 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751135AbdHXG5Y (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Aug 2017 02:57:24 -0400
Date: Thu, 24 Aug 2017 14:57:11 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "loberman@redhat.com" <loberman@redhat.com>
Subject: Re: [PATCH V2 11/20] blk-mq: introduce helpers for operating
 ->dispatch list
Message-ID: <20170824065710.GM12966@ming.t460p>
References: <20170805065705.12989-1-ming.lei@redhat.com>
 <20170805065705.12989-12-ming.lei@redhat.com>
 <1503434591.2508.20.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1503434591.2508.20.camel@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Aug 22, 2017 at 08:43:12PM +0000, Bart Van Assche wrote:
> On Sat, 2017-08-05 at 14:56 +0800, Ming Lei wrote:
> > +static inline bool blk_mq_has_dispatch_rqs(struct blk_mq_hw_ctx *hctx)
> > +{
> > +	return !list_empty_careful(&hctx->dispatch);
> > +}
> > +
> > +static inline void blk_mq_add_rq_to_dispatch(struct blk_mq_hw_ctx *hctx,
> > +		struct request *rq)
> > +{
> > +	spin_lock(&hctx->lock);
> > +	list_add(&rq->queuelist, &hctx->dispatch);
> > +	blk_mq_hctx_set_dispatch_busy(hctx);
> > +	spin_unlock(&hctx->lock);
> > +}
> > +
> > +static inline void blk_mq_add_list_to_dispatch(struct blk_mq_hw_ctx *hctx,
> > +		struct list_head *list)
> > +{
> > +	spin_lock(&hctx->lock);
> > +	list_splice_init(list, &hctx->dispatch);
> > +	blk_mq_hctx_set_dispatch_busy(hctx);
> > +	spin_unlock(&hctx->lock);
> > +}
> > +
> > +static inline void blk_mq_add_list_to_dispatch_tail(struct blk_mq_hw_ctx *hctx,
> > +						    struct list_head *list)
> > +{
> > +	spin_lock(&hctx->lock);
> > +	list_splice_tail_init(list, &hctx->dispatch);
> > +	blk_mq_hctx_set_dispatch_busy(hctx);
> > +	spin_unlock(&hctx->lock);
> > +}
> > +
> > +static inline void blk_mq_take_list_from_dispatch(struct blk_mq_hw_ctx *hctx,
> > +		struct list_head *list)
> > +{
> > +	spin_lock(&hctx->lock);
> > +	list_splice_init(&hctx->dispatch, list);
> > +	spin_unlock(&hctx->lock);
> > +}
> 
> Same comment for this patch: these helper functions are so short that I'm not
> sure it is useful to introduce these helper functions.

It will become long in the following patches.

-- 
Ming
