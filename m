Return-Path: <ming.lei@redhat.com>
Date: Fri, 29 Jun 2018 23:24:50 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Laurence Oberman <loberman@redhat.com>,
	Omar Sandoval <osandov@fb.com>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH V2 3/3] blk-mq: dequeue request one by one from sw queue
 iff hctx is busy
Message-ID: <20180629152449.GB14410@ming.t460p>
References: <20180629081252.13836-1-ming.lei@redhat.com>
 <20180629081252.13836-4-ming.lei@redhat.com>
 <20180629083944.GE15870@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180629083944.GE15870@lst.de>
List-ID: <linux-block@vger.kernel.org>

On Fri, Jun 29, 2018 at 10:39:44AM +0200, Christoph Hellwig wrote:
> > +/* update queue busy with EWMA (7/8 * ewma(t)  + 1/8 * busy(t + 1)) */
> > +static void blk_mq_update_hctx_busy(struct blk_mq_hw_ctx *hctx, unsigned int busy)
> 
> Overly long line.  Also busy really is a bool, so I think we should
> pass it as such.

OK.

> 
> Also I think this needs a much better comment describing why we
> are using this algorith.  Also expanding the EWMA acronym would help,
> I had to look it up first.

EWMA(exponentially weighted moving average)[1] is used here to compute
if queue is busy, because it is one simple way to compute the 'average'
value of queue busy. Also weight is applied here so that it can decrease
exponentially.

In this patch, the weight is 7/8 for history busy, and 1/8 for current
busy.

[1] https://en.wikipedia.org/wiki/Moving_average#cite_note-5

> 
> > +	const unsigned weight = 8;
> > +	const unsigned factor = 4;
> 
> Where do these magic constants come from?

As mentioned above, 'weight' is for the weight in EWMA, and factor is
applied for not computing busy as zero.

> 
> > +	unsigned int ewma;
> > +
> > +	if (hctx->queue->elevator)
> > +		return;
> > +
> > +	ewma = READ_ONCE(hctx->busy);
> > +
> > +	ewma *= weight - 1;
> > +	ewma += busy << factor;
> 
> With the bool parameter and expanding the "factor" which really is
> a shift value this would be:
> 
> 	if (busy)
> 		ewma += 16;
> 
> which at least is a little more understandable, although still not
> great.

Now we just use 1 as busy, 0 as non-busy, in theory it may be possible
to describe how busy the queue is by passing a integer value.

Thanks,
Ming
