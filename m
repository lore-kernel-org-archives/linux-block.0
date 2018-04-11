Return-Path: <ming.lei@redhat.com>
Date: Thu, 12 Apr 2018 07:05:13 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Tejun Heo <tj@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Israel Rukshin <israelr@mellanox.com>,
	Max Gurtovoy <maxg@mellanox.com>, stable@vger.kernel.org
Subject: Re: [PATCH] blk-mq: fix race between complete and BLK_EH_RESET_TIMER
Message-ID: <20180411230504.GB31433@ming.t460p>
References: <20180411205529.31145-1-ming.lei@redhat.com>
 <20180411213007.GR793541@devbig577.frc2.facebook.com>
 <20180411224344.GA31433@ming.t460p>
 <20180411224712.GT793541@devbig577.frc2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180411224712.GT793541@devbig577.frc2.facebook.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Apr 11, 2018 at 03:47:12PM -0700, Tejun Heo wrote:
> Hello,
> 
> On Thu, Apr 12, 2018 at 06:43:45AM +0800, Ming Lei wrote:
> > On Wed, Apr 11, 2018 at 02:30:07PM -0700, Tejun Heo wrote:
> > > Hello, Ming.
> > > 
> > > On Thu, Apr 12, 2018 at 04:55:29AM +0800, Ming Lei wrote:
> > > ...
> > > > +		spin_lock_irqsave(req->q->queue_lock, flags);
> > > > +		if (blk_mq_rq_state(req) != MQ_RQ_COMPLETE_IN_RESET) {
> > > > +			blk_mq_rq_update_aborted_gstate(req, 0);
> > > > +			blk_add_timer(req);
> > > 
> > > Nothing prevents the above blk_add_timer() racing against the next
> > > recycle instance of the request, so this still leaves a small race
> > > window.
> > 
> > OK.
> > 
> > But this small race window can be avoided by running blk_add_timer(req)
> > before blk_mq_rq_update_aborted_gstate(req, 0), can't it?
> 
> Not really because aborted_gstate right now doesn't have any memory
> barrier around it, so nothing ensures blk_add_timer() actually appears
> before.  We can either add the matching barriers in aborted_gstate
> update and when it's read in the normal completion path, or we can
> wait for the update to be visible everywhere by waiting for rcu grace
> period (because the reader is rcu protected).

Seems not necessary.

Suppose it is out of order, the only side-effect is that the new
recycled request is timed out as a bit late, I think that is what
we can survive, right?

But it need to be documented.

--
Ming
