Return-Path: <ming.lei@redhat.com>
Date: Thu, 4 May 2017 10:12:33 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Bart Van Assche <bart.vanassche@sandisk.com>,
	Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH V2 4/5] blk-mq: use hw tag for scheduling if hw tag space
 is big enough
Message-ID: <20170504021232.GB16084@ming.t460p>
References: <20170503195839.6539-1-ming.lei@redhat.com>
 <20170503195839.6539-5-ming.lei@redhat.com>
 <20170503201444.GA29177@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170503201444.GA29177@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Wed, May 03, 2017 at 02:14:45PM -0600, Jens Axboe wrote:
> On Thu, May 04 2017, Ming Lei wrote:
> > diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
> > index edafb5383b7b..241d23c18181 100644
> > --- a/block/blk-mq-sched.h
> > +++ b/block/blk-mq-sched.h
> > @@ -129,4 +136,19 @@ static inline bool blk_mq_sched_needs_restart(struct blk_mq_hw_ctx *hctx)
> >  	return test_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state);
> >  }
> >  
> > +/*
> > + * If this queue has enough hardware tags and doesn't share tags with
> > + * other queues, just use hw tag directly for scheduling.
> > + */
> > +static inline bool blk_mq_sched_may_use_hw_tag(struct request_queue *q)
> > +{
> > +	if (q->tag_set->flags & BLK_MQ_F_TAG_SHARED)
> > +		return false;
> > +
> > +	if (blk_mq_get_queue_depth(q) < q->nr_requests)
> > +		return false;
> > +
> > +	return true;
> > +}
> > +
> 
> Let's put that in block/blk-mq-sched.c instead, especially since it
> grows more code in the next patch.

OK, will do it in V3.

Thanks,
Ming
