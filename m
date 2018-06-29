Return-Path: <ming.lei@redhat.com>
Date: Fri, 29 Jun 2018 23:34:53 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Kashyap Desai <kashyap.desai@broadcom.com>,
	Laurence Oberman <loberman@redhat.com>,
	Omar Sandoval <osandov@fb.com>, Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH V2 3/3] blk-mq: dequeue request one by one from sw queue
 iff hctx is busy
Message-ID: <20180629153447.GA15227@ming.t460p>
References: <20180629081252.13836-1-ming.lei@redhat.com>
 <20180629081252.13836-4-ming.lei@redhat.com>
 <9913ff1d-197b-32f8-254f-d554dde06f71@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9913ff1d-197b-32f8-254f-d554dde06f71@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Fri, Jun 29, 2018 at 08:58:16AM -0600, Jens Axboe wrote:
> On 6/29/18 2:12 AM, Ming Lei wrote:
> > It won't be efficient to dequeue request one by one from sw queue,
> > but we have to do that when queue is busy for better merge performance.
> > 
> > This patch takes EWMA to figure out if queue is busy, then only dequeue
> > request one by one from sw queue when queue is busy.
> > 
> > Kashyap verified that this patch basically brings back rand IO perf
> > on megasas_raid in case of none io scheduler. Meantime I tried this
> > patch on HDD, and not see obvious performance loss on sequential IO
> > test too.
> 
> Outside of the comments of others, please also export ->busy from
> the blk-mq debugfs code.

Good idea!

> 
> > diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> > index e3147eb74222..a5113e22d720 100644
> > --- a/include/linux/blk-mq.h
> > +++ b/include/linux/blk-mq.h
> > @@ -34,6 +34,7 @@ struct blk_mq_hw_ctx {
> >  
> >  	struct sbitmap		ctx_map;
> >  
> > +	unsigned int		busy;
> >  	struct blk_mq_ctx	*dispatch_from;
> >  
> >  	struct blk_mq_ctx	**ctxs;
> 
> This adds another hole. Consider swapping it a bit, ala:
> 
> 	struct blk_mq_ctx       *dispatch_from;
> 	unsigned int            busy;
> 
> 	unsigned int            nr_ctx;
> 	struct blk_mq_ctx       **ctxs;
> 
> to eliminate a hole, instead of adding one more.

OK

Thanks,
Ming
