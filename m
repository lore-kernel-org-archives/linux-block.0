Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 2 Apr 2018 14:39:53 -0700
From: "tj@kernel.org" <tj@kernel.org>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "kernel-team@fb.com" <kernel-team@fb.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH 2/2] blk-mq: Fix request handover from timeout path to
 normal execution
Message-ID: <20180402213953.GG388343@devbig577.frc2.facebook.com>
References: <20180402190053.GC388343@devbig577.frc2.facebook.com>
 <20180402190120.GD388343@devbig577.frc2.facebook.com>
 <b52fa22c-c7fa-5ebd-35cb-527786e6d08e@wdc.com>
 <20180402211047.GF388343@devbig577.frc2.facebook.com>
 <e23487ab30cfe5337a4321ad10ddbd6514be9ab9.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e23487ab30cfe5337a4321ad10ddbd6514be9ab9.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Hello,

On Mon, Apr 02, 2018 at 09:31:34PM +0000, Bart Van Assche wrote:
> > > > +	 * As nothing prevents from completion happening while
> > > > +	 * ->aborted_gstate is set, this may lead to ignored completions
> > > > +	 * and further spurious timeouts.
> > > > +	 */
> > > > +	if (rq->rq_flags & RQF_MQ_TIMEOUT_RESET)
> > > > +		blk_mq_rq_update_aborted_gstate(rq, 0);
...
> I think it can happen that the above code sees that (rq->rq_flags &
> RQF_MQ_TIMEOUT_RESET) != 0, that blk_mq_start_request() executes the
> following code:
> 
> 	blk_mq_rq_update_state(rq, MQ_RQ_IN_FLIGHT);
> 	blk_add_timer(rq);
> 
> and that subsequently blk_mq_rq_update_aborted_gstate(rq, 0) is called,
> which will cause the next completion to be lost. Is fixing one occurrence
> of a race and reintroducing it in another code path really an improvement?

I'm not following at all.  How would blk_mq_start_request() get called
on the request while it's still owned by the timeout handler?  That
gstate clearing is what transfers the ownership back to the
non-timeout path.

Thanks.

-- 
tejun
