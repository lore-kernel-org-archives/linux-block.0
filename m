Return-Path: <keith.busch@linux.intel.com>
Date: Thu, 12 Jul 2018 13:24:37 -0600
From: Keith Busch <keith.busch@linux.intel.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@lst.de" <hch@lst.de>,
	"keith.busch@intel.com" <keith.busch@intel.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"ming.lei@redhat.com" <ming.lei@redhat.com>
Subject: Re: [RFC PATCH 3/3] blk-mq: Remove generation seqeunce
Message-ID: <20180712192437.GA16839@localhost.localdomain>
References: <20180521231131.6685-1-keith.busch@intel.com>
 <20180521231131.6685-4-keith.busch@intel.com>
 <c42d13289e38df93bb35e9876b803420e40b03d3.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c42d13289e38df93bb35e9876b803420e40b03d3.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Jul 12, 2018 at 06:16:12PM +0000, Bart Van Assche wrote:
> On Mon, 2018-05-21 at 17:11 -0600, Keith Busch wrote:
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
> > +
> > +	/*
> > +	 * The request is now locked and cannot be reallocated underneath the
> > +	 * timeout handler's processing. Re-verify this exact request is truly
> > +	 * expired; if it is not expired, then the request was completed and
> > +	 * reallocated as a new request.
> > +	 */
> > +	if (blk_mq_req_expired(rq, next))
> >  		blk_mq_rq_timed_out(rq, reserved);
> > +	blk_mq_put_request(rq);
> >  }
> 
> Hello Keith and Christoph,
> 
> What prevents that a request finishes and gets reused after the
> blk_mq_req_expired() call has finished and before kref_get_unless_zero() is
> called? Is this perhaps a race condition that has not yet been triggered by
> any existing block layer test? Please note that there is no such race
> condition in the patch I had posted ("blk-mq: Rework blk-mq timeout handling
> again" - https://www.spinics.net/lists/linux-block/msg26489.html).

I don't think there's any such race in the merged implementation
either. If the request is reallocated, then the kref check may succeed,
but the blk_mq_req_expired() check would surely fail, allowing the
request to proceed as normal. The code comments at least say as much.
