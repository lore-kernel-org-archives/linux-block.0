Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39278 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751270AbdGLDnr (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Jul 2017 23:43:47 -0400
Date: Wed, 12 Jul 2017 11:43:39 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH 4/6] blk-mq: use EWMA to estimate congestion threshold
Message-ID: <20170712034339.GI13036@ming.t460p>
References: <20170711182103.11461-1-ming.lei@redhat.com>
 <20170711182103.11461-5-ming.lei@redhat.com>
 <1499806931.2586.40.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1499806931.2586.40.camel@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Jul 11, 2017 at 09:02:13PM +0000, Bart Van Assche wrote:
> On Wed, 2017-07-12 at 02:21 +0800, Ming Lei wrote:
> > When .queue_rq() returns BLK_STS_RESOURCE(BUSY), we can
> > consider that there is congestion in either low level
> > driver or hardware.
> > 
> > This patch uses EWMA to estimate this congestion threshold,
> > then this threshold can be used to detect/avoid congestion.
> 
> Hello Ming,
> 
> Does EWMA stand for "exponentially weighted moving average" in the context of
> this patch? If so, please mention this.

Yes and OK.

> 
> > +static void blk_mq_update_req_dispatch_busy(struct blk_mq_hw_ctx *hctx)
> > +{
> > +	struct sbitmap_queue *sbq;
> > +	unsigned depth;
> > +
> > +	sbq = &hctx->tags->bitmap_tags;
> > +	depth = sbitmap_weight(&sbq->sb);
> > +
> > +	/* use EWMA to estimate a threshold for detecting congestion */
> > +	ewma_add(hctx->avg_busy_threshold, depth, 8, 0);
> > +}
> 
> This function has been named after the context it is called from. Wouldn't it
> be more clear to change the name of this function into something that refers to
> what this function does, e.g. blk_mq_update_avg_busy_threshold()?

In the next patch, more things will be done in this function.

> 
> Additionally, I think that the behavior of e.g. the SCSI and dm-mpath drivers
> is too complicated for this approach to be effective. If you want to proceed
> with this approach I think it should be possible for block drivers to opt out
> of the mechanism introduced in the next patch.

dm might be a bit special, but for SCSI I suggest to use that since I see
obvious improvement in virtio-scsi.

But it depends on performance, if there isn't any perf loss, I'd rather
to do for all(include dm), even we can develop other smart way for
special requirement if there are.

> 
> > diff --git a/block/blk-mq.h b/block/blk-mq.h
> > index 60b01c0309bc..c4516d2a2d2c 100644
> > --- a/block/blk-mq.h
> > +++ b/block/blk-mq.h
> > @@ -133,4 +133,13 @@ static inline bool blk_mq_hw_queue_mapped(struct blk_mq_hw_ctx *hctx)
> >  	return hctx->nr_ctx && hctx->tags;
> >  }
> >  
> > +/* borrowed from bcache */
> > +#define ewma_add(ewma, val, weight, factor)                             \
> > +({                                                                      \
> > +        (ewma) *= (weight) - 1;                                         \
> > +        (ewma) += (val) << factor;                                      \
> > +        (ewma) /= (weight);                                             \
> > +        (ewma) >> factor;                                               \
> > +})
> 
> Sorry but this does not match how others define an exponentially weighted moving
> average. As far as I know the ewma values should be updated as follows:
> 
>    new_ewma = w * val + (1 - w) * current_ewma
> 
> where 0 < w <= 1 is a rational number (typically 0.05 <= w <= 0.3). See also
> https://en.wikipedia.org/wiki/EWMA_chart.

Yes, for the way in this patch, w is 1/8, and factor is zero, it is just
for computer to do it efficiently, no big difference with definition in
paper, and as you see, ewma_add() is borrowed from bcache.

-- 
Ming
