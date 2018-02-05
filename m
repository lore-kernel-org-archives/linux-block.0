Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 5 Feb 2018 13:37:49 -0800
From: "tj@kernel.org" <tj@kernel.org>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@lst.de" <hch@lst.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH] blk-mq: Fix a race between resetting the timer and
 completion handling
Message-ID: <20180205213749.GQ1121507@devbig577.frc2.facebook.com>
References: <20180201224930.17918-1-bart.vanassche@wdc.com>
 <20180205210601.GP1121507@devbig577.frc2.facebook.com>
 <1517866382.3764.43.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1517866382.3764.43.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Hello, Bart.

On Mon, Feb 05, 2018 at 09:33:03PM +0000, Bart Van Assche wrote:
> My goal with this patch is to fix the race between resetting the timer and
> the completion path. Hence change (3). Changes (1) and (2) are needed to
> make the changes in blk_mq_rq_timed_out() work.

Ah, I see.  That makes sense.  Can I ask you to elaborate the scenario
you were fixing?

> > > @@ -831,13 +834,12 @@ static void blk_mq_rq_timed_out(struct request *req, bool reserved)
> > >  		__blk_mq_complete_request(req);
> > >  		break;
> > >  	case BLK_EH_RESET_TIMER:
> > > -		/*
> > > -		 * As nothing prevents from completion happening while
> > > -		 * ->aborted_gstate is set, this may lead to ignored
> > > -		 * completions and further spurious timeouts.
> > > -		 */
> > > -		blk_mq_rq_update_aborted_gstate(req, 0);
> > > +		local_irq_disable();
> > > +		write_seqcount_begin(&req->gstate_seq);
> > >  		blk_add_timer(req);
> > > +		req->aborted_gstate = 0;
> > > +		write_seqcount_end(&req->gstate_seq);
> > > +		local_irq_enable();
> > >  		break;
> > 
> > So, this is #3 and I'm not sure how adding gstate_seq protection gets
> > rid of the race condition mentioned in the comment.  It's still the
> > same that nothing is protecting against racing w/ completion.
> 
> I think you are right. I will see whether I can rework this patch to address
> that race.

That race is harmless and has always been there tho.  It only happens
when the actual completion coincides with timeout expiring, which is
very unlikely, and the only downside is that the completion gets lost
and the request will get timed out down the line.  It'd of course be
better to close the race window but code simplicity likely is an
important trade-off factor here.

Thanks.

-- 
tejun
