Return-Path: <keith.busch@linux.intel.com>
Date: Tue, 22 May 2018 08:20:30 -0600
From: Keith Busch <keith.busch@linux.intel.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Subject: Re: [RFC PATCH 3/3] blk-mq: Remove generation seqeunce
Message-ID: <20180522142030.GR5528@localhost.localdomain>
References: <20180521231131.6685-1-keith.busch@intel.com>
 <20180521231131.6685-4-keith.busch@intel.com>
 <20180522024910.GD20430@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180522024910.GD20430@ming.t460p>
List-ID: <linux-block@vger.kernel.org>

On Tue, May 22, 2018 at 10:49:11AM +0800, Ming Lei wrote:
> On Mon, May 21, 2018 at 05:11:31PM -0600, Keith Busch wrote:
> > -static void blk_mq_terminate_expired(struct blk_mq_hw_ctx *hctx,
> > +static void blk_mq_check_expired(struct blk_mq_hw_ctx *hctx,
> >  		struct request *rq, void *priv, bool reserved)
> >  {
> > +	unsigned long *next = priv;
> > +
> >  	/*
> > -	 * We marked @rq->aborted_gstate and waited for RCU.  If there were
> > -	 * completions that we lost to, they would have finished and
> > -	 * updated @rq->gstate by now; otherwise, the completion path is
> > -	 * now guaranteed to see @rq->aborted_gstate and yield.  If
> > -	 * @rq->aborted_gstate still matches @rq->gstate, @rq is ours.
> > +	 * Just do a quick check if it is expired before locking the request in
> > +	 * so we're not unnecessarilly synchronizing across CPUs.
> >  	 */
> > -	if (!(rq->rq_flags & RQF_MQ_TIMEOUT_EXPIRED) &&
> > -	    READ_ONCE(rq->gstate) == rq->aborted_gstate)
> > +	if (!blk_mq_req_expired(rq, next))
> > +		return;
> > +
> > +	/*
> > +	 * We have reason to believe the request may be expired. Take a
> > +	 * reference on the request to lock this request lifetime into its
> > +	 * currently allocated context to prevent it from being reallocated in
> > +	 * the event the completion by-passes this timeout handler.
> > +	 * 
> > +	 * If the reference was already released, then the driver beat the
> > +	 * timeout handler to posting a natural completion.
> > +	 */
> > +	if (!kref_get_unless_zero(&rq->ref))
> > +		return;
> 
> If this request is just completed in normal path and its state isn't
> updated yet, timeout will hold the request, and may complete this
> request again, then this req can be completed two times.

Hi Ming,

In the event the driver requests a normal completion, the timeout work
releasing the last reference doesn't do a second completion: it only
releases the request's tag back for re-allocation.

Thanks,
Keith
