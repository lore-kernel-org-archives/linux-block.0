Return-Path: <keith.busch@linux.intel.com>
Date: Tue, 22 May 2018 08:15:07 -0600
From: Keith Busch <keith.busch@linux.intel.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@lst.de" <hch@lst.de>,
	"keith.busch@intel.com" <keith.busch@intel.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"ming.lei@redhat.com" <ming.lei@redhat.com>
Subject: Re: [RFC PATCH 3/3] blk-mq: Remove generation seqeunce
Message-ID: <20180522141507.GQ5528@localhost.localdomain>
References: <20180521231131.6685-1-keith.busch@intel.com>
 <20180521231131.6685-4-keith.busch@intel.com>
 <e7a287827b4c00151bb7714deca7ea6453177504.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e7a287827b4c00151bb7714deca7ea6453177504.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, May 21, 2018 at 11:29:06PM +0000, Bart Van Assche wrote:
> On Mon, 2018-05-21 at 17:11 -0600, Keith Busch wrote:
> >  	switch (ret) {
> >  	case BLK_EH_HANDLED:
> > -		__blk_mq_complete_request(req);
> > -		break;
> > -	case BLK_EH_RESET_TIMER:
> >  		/*
> > -		 * As nothing prevents from completion happening while
> > -		 * ->aborted_gstate is set, this may lead to ignored
> > -		 * completions and further spurious timeouts.
> > +		 * If the request is still in flight, the driver is requesting
> > +		 * blk-mq complete it.
> >  		 */
> > -		blk_mq_rq_update_aborted_gstate(req, 0);
> > +		if (blk_mq_rq_state(req) == MQ_RQ_IN_FLIGHT)
> > +			__blk_mq_complete_request(req);
> > +		break;
> > +	case BLK_EH_RESET_TIMER:
> >  		blk_add_timer(req);
> >  		break;
> >  	case BLK_EH_NOT_HANDLED:
> > @@ -880,64 +782,64 @@ static void blk_mq_rq_timed_out(struct request *req, bool reserved)
> >  	}
> >  }
> 
> I think the above changes can lead to concurrent calls of
> __blk_mq_complete_request() from the regular completion path and the timeout
> path. That's wrong: the __blk_mq_complete_request() caller should guarantee
> that no concurrent calls from another context to that function can occur.

Hi Bart,

This shouldn't be introducing any new concorrent calls to
__blk_mq_complete_request if they don't already exist. The timeout work
calls it only if the driver's timeout returns BLK_EH_HANDLED, which means
the driver is claiming the command is now done, but the driver didn't call
blk_mq_complete_request as indicated by the request's IN_FLIGHT state.

In order to get a second call to __blk_mq_complete_request(), then,
the driver would have to end up calling blk_mq_complete_request()
in another context. But there's nothing stopping that from happening
today, and would be bad if any driver actually did that: the request
may have been re-allocated and issued as a new command, and calling
blk_mq_complete_request() the second time introduces data corruption.

Thanks,
Keith
