Return-Path: <axboe@kernel.dk>
Date: Wed, 23 Aug 2017 14:02:20 -0600
From: Jens Axboe <axboe@kernel.dk>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@infradead.org" <hch@infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"ming.lei@redhat.com" <ming.lei@redhat.com>,
	"loberman@redhat.com" <loberman@redhat.com>
Subject: Re: [PATCH V2 10/20] blk-mq-sched: introduce helpers for query,
 change busy state
Message-ID: <20170823200219.GC15083@kernel.dk>
References: <20170805065705.12989-1-ming.lei@redhat.com>
 <20170805065705.12989-11-ming.lei@redhat.com>
 <1503434472.2508.19.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1503434472.2508.19.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Aug 22 2017, Bart Van Assche wrote:
> On Sat, 2017-08-05 at 14:56 +0800, Ming Lei wrote:
> > +static inline bool blk_mq_hctx_is_dispatch_busy(struct blk_mq_hw_ctx *hctx)
> > +{
> > +	return test_bit(BLK_MQ_S_DISPATCH_BUSY, &hctx->state);
> > +}
> > +
> > +static inline void blk_mq_hctx_set_dispatch_busy(struct blk_mq_hw_ctx *hctx)
> > +{
> > +	set_bit(BLK_MQ_S_DISPATCH_BUSY, &hctx->state);
> > +}
> > +
> > +static inline void blk_mq_hctx_clear_dispatch_busy(struct blk_mq_hw_ctx *hctx)
> > +{
> > +	clear_bit(BLK_MQ_S_DISPATCH_BUSY, &hctx->state);
> > +}
> 
> Hello Ming,
> 
> Are these helper functions modified in a later patch? If not, please drop
> this patch. One line helper functions are not useful and do not improve
> readability of source code.

Agree, they just obfuscate the code. Only reason to do this is to do
things like:

static inline void blk_mq_hctx_clear_dispatch_busy(struct blk_mq_hw_ctx *hctx)
{
        if (test_bit(BLK_MQ_S_DISPATCH_BUSY, &hctx->state))
	        clear_bit(BLK_MQ_S_DISPATCH_BUSY, &hctx->state);
}

to avoid unecessary RMW (and locked instruction). At least then you can
add a single comment as to why it's done that way. Apart from that, I
prefer to open-code it so people don't have to grep to figure out wtf
blk_mq_hctx_clear_dispatch_busy() does.

-- 
Jens Axboe
