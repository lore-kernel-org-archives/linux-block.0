Return-Path: <ming.lei@redhat.com>
Date: Wed, 23 May 2018 08:34:48 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@kernel.dk>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	Bart Van Assche <bart.vanassche@wdc.com>
Subject: Re: [RFC PATCH 3/3] blk-mq: Remove generation seqeunce
Message-ID: <20180523003446.GC31196@ming.t460p>
References: <20180521231131.6685-1-keith.busch@intel.com>
 <20180521231131.6685-4-keith.busch@intel.com>
 <20180522161704.GA20000@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180522161704.GA20000@lst.de>
List-ID: <linux-block@vger.kernel.org>

On Tue, May 22, 2018 at 06:17:04PM +0200, Christoph Hellwig wrote:
> Hi Keith,
> 
> I like this series a lot.  One comment that is probably close
> to the big discussion in the thread:
> 
> >  	switch (ret) {
> >  	case BLK_EH_HANDLED:
> >  		/*
> > +		 * If the request is still in flight, the driver is requesting
> > +		 * blk-mq complete it.
> >  		 */
> > +		if (blk_mq_rq_state(req) == MQ_RQ_IN_FLIGHT)
> > +			__blk_mq_complete_request(req);
> > +		break;
> 
> The state check here really irked me, and from the thread it seems like
> I'm not the only one.  At least for the NVMe case I think it is perfectly
> safe, although I agree I'd rather audit what other drivers do carefully.

Let's consider the normal NVMe timeout code path:

1) one request is timed out;

2) controller is shutdown, this timed-out request is requeued from
nvme_cancel_request(), but can't dispatch because queues are quiesced

3) reset is done from another context, and this request is dispatched
again, and completed exactly before returning EH_HANDLED to blk-mq, but
its state isn't updated to COMPLETE yet.

4) then double completions are done from both normal completion and timeout
path.

Seems same issue exists on poll path.

Thanks,
Ming
