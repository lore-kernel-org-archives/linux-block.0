Return-Path: <axboe@kernel.dk>
Date: Wed, 23 Aug 2017 13:58:16 -0600
From: Jens Axboe <axboe@kernel.dk>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@infradead.org" <hch@infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"ming.lei@redhat.com" <ming.lei@redhat.com>,
	"loberman@redhat.com" <loberman@redhat.com>
Subject: Re: [PATCH V2 05/20] blk-mq-sched: improve dispatching from sw queue
Message-ID: <20170823195814.GB15083@kernel.dk>
References: <20170805065705.12989-1-ming.lei@redhat.com>
 <20170805065705.12989-6-ming.lei@redhat.com>
 <1503431751.2508.13.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1503431751.2508.13.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Aug 22 2017, Bart Van Assche wrote:
> On Sat, 2017-08-05 at 14:56 +0800, Ming Lei wrote:
> > easy to cause queue busy becasue of the small
>                            ^^^^^^^
>                            because?
>  
> > -static void blk_mq_do_dispatch(struct request_queue *q,
> > -			       struct elevator_queue *e,
> > -			       struct blk_mq_hw_ctx *hctx)
> > +static inline void blk_mq_do_dispatch_sched(struct request_queue *q,
> > +					    struct elevator_queue *e,
> > +					    struct blk_mq_hw_ctx *hctx)
> >  {
> >  	LIST_HEAD(rq_list);
> 
> Why to declare this function "inline"? Are you sure that the compiler
> is not smart enough to decide on its own whether or not to inline this
> function?

Ditto in other places, too. Kill them.

-- 
Jens Axboe
