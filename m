Return-Path: <keith.busch@intel.com>
Date: Fri, 27 Jul 2018 10:57:19 -0600
From: Keith Busch <keith.busch@intel.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@lst.de" <hch@lst.de>, "ming.lei@redhat.com" <ming.lei@redhat.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH 5/5] blk-mq: Rework blk-mq timeout handling again
Message-ID: <20180727165718.GC20829@localhost.localdomain>
References: <20180727162042.13425-1-bart.vanassche@wdc.com>
 <20180727162042.13425-6-bart.vanassche@wdc.com>
 <20180727164627.GB20829@localhost.localdomain>
 <08bd5d1c691e2c8f9950f7ebcf04716507a02675.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <08bd5d1c691e2c8f9950f7ebcf04716507a02675.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Fri, Jul 27, 2018 at 04:51:05PM +0000, Bart Van Assche wrote:
> On Fri, 2018-07-27 at 10:46 -0600, Keith Busch wrote:
> > On Fri, Jul 27, 2018 at 09:20:42AM -0700, Bart Van Assche wrote:
> > > +	ret = req->q->mq_ops->timeout(req, reserved);
> > > +	/*
> > > +	 * BLK_EH_DONT_RESET_TIMER means that the block driver either
> > > +	 * completed the request or still owns the request and will
> > > +	 * continue processing the timeout asynchronously. In the
> > > +	 * latter case, if blk_mq_complete_request() was called while
> > > +	 * the timeout handler was in progress, ignore that call.
> > > +	 */
> > > +	if (ret == BLK_EH_DONT_RESET_TIMER)
> > > +		return;
> > 
> > This is how completions get lost.
> 
> The new approach for handling completions that occur while the .timeout()
> callback in progress is as follows:
> * blk_mq_complete_request() executes the following code:
>        if (blk_mq_change_rq_state(rq, MQ_RQ_TIMED_OUT, MQ_RQ_COMPLETE))
>                return;
> * blk_mq_rq_timed_out() executes the following code:
>        if (blk_mq_rq_state(req) == MQ_RQ_COMPLETE) {
>                __blk_mq_complete_request(req);
>                return;
>        }
> 
> As one can see __blk_mq_complete_request() gets called if this race occurs.

You skip that code if the driver returns BLK_EH_DONT_RESET_TIMER.
