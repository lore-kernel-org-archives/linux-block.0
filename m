Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53294 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751214AbdHXHLG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Aug 2017 03:11:06 -0400
Date: Thu, 24 Aug 2017 15:10:54 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Damien Le Moal <damien.lemoal@wdc.com>
Cc: Bart Van Assche <Bart.VanAssche@wdc.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "loberman@redhat.com" <loberman@redhat.com>
Subject: Re: [PATCH V2 11/20] blk-mq: introduce helpers for operating
 ->dispatch list
Message-ID: <20170824071053.GN12966@ming.t460p>
References: <20170805065705.12989-1-ming.lei@redhat.com>
 <20170805065705.12989-12-ming.lei@redhat.com>
 <1503434591.2508.20.camel@wdc.com>
 <12634573-89fa-90cc-f481-464a490f7915@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <12634573-89fa-90cc-f481-464a490f7915@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Aug 24, 2017 at 09:59:13AM +0900, Damien Le Moal wrote:
> 
> On 8/23/17 05:43, Bart Van Assche wrote:
> > On Sat, 2017-08-05 at 14:56 +0800, Ming Lei wrote:
> >> +static inline bool blk_mq_has_dispatch_rqs(struct blk_mq_hw_ctx *hctx)
> >> +{
> >> +	return !list_empty_careful(&hctx->dispatch);
> >> +}
> >> +
> >> +static inline void blk_mq_add_rq_to_dispatch(struct blk_mq_hw_ctx *hctx,
> >> +		struct request *rq)
> >> +{
> >> +	spin_lock(&hctx->lock);
> >> +	list_add(&rq->queuelist, &hctx->dispatch);
> >> +	blk_mq_hctx_set_dispatch_busy(hctx);
> >> +	spin_unlock(&hctx->lock);
> >> +}
> >> +
> >> +static inline void blk_mq_add_list_to_dispatch(struct blk_mq_hw_ctx *hctx,
> >> +		struct list_head *list)
> >> +{
> >> +	spin_lock(&hctx->lock);
> >> +	list_splice_init(list, &hctx->dispatch);
> >> +	blk_mq_hctx_set_dispatch_busy(hctx);
> >> +	spin_unlock(&hctx->lock);
> >> +}
> >> +
> >> +static inline void blk_mq_add_list_to_dispatch_tail(struct blk_mq_hw_ctx *hctx,
> >> +						    struct list_head *list)
> >> +{
> >> +	spin_lock(&hctx->lock);
> >> +	list_splice_tail_init(list, &hctx->dispatch);
> >> +	blk_mq_hctx_set_dispatch_busy(hctx);
> >> +	spin_unlock(&hctx->lock);
> >> +}
> >> +
> >> +static inline void blk_mq_take_list_from_dispatch(struct blk_mq_hw_ctx *hctx,
> >> +		struct list_head *list)
> >> +{
> >> +	spin_lock(&hctx->lock);
> >> +	list_splice_init(&hctx->dispatch, list);
> >> +	spin_unlock(&hctx->lock);
> >> +}
> > 
> > Same comment for this patch: these helper functions are so short that I'm not
> > sure it is useful to introduce these helper functions.
> > 
> > Bart.
> 
> Personally, I like those very much as they give a place to hook up
> different dispatch_list handling without having to change blk-mq.c and
> blk-mq-sched.c all over the place.
> 
> I am thinking of SMR (zoned block device) support here since we need to
> to sort insert write requests in blk_mq_add_rq_to_dispatch() and
> blk_mq_add_list_to_dispatch_tail(). For this last one, the name would

Could you explain a bit why you sort insert write rq in these two
helpers? which are only triggered in case of dispatch busy.

> become a little awkward though. This sort insert would be to avoid
> breaking a sequential write request sequence sent by the disk user. This
> is needed since this reordering breakage cannot be solved only from the
> SCSI layer.

Basically this patchset tries to flush hctx->dispatch first, then
fetch requests from scheduler queue after htct->dispatch is flushed.

But it isn't strictly in this way because the implementation is lockless.

So looks the request from hctx->dispatch won't break one coming
requests from scheduler.


-- 
Ming
