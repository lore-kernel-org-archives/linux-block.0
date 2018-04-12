Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 12 Apr 2018 06:57:12 -0700
From: Tejun Heo <tj@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Israel Rukshin <israelr@mellanox.com>,
	Max Gurtovoy <maxg@mellanox.com>, stable@vger.kernel.org
Subject: Re: [PATCH] blk-mq: fix race between complete and BLK_EH_RESET_TIMER
Message-ID: <20180412135712.GY793541@devbig577.frc2.facebook.com>
References: <20180411205529.31145-1-ming.lei@redhat.com>
 <20180411213007.GR793541@devbig577.frc2.facebook.com>
 <20180411224344.GA31433@ming.t460p>
 <20180411224712.GT793541@devbig577.frc2.facebook.com>
 <20180411230504.GB31433@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180411230504.GB31433@ming.t460p>
List-ID: <linux-block@vger.kernel.org>

On Thu, Apr 12, 2018 at 07:05:13AM +0800, Ming Lei wrote:
> > Not really because aborted_gstate right now doesn't have any memory
> > barrier around it, so nothing ensures blk_add_timer() actually appears
> > before.  We can either add the matching barriers in aborted_gstate
> > update and when it's read in the normal completion path, or we can
> > wait for the update to be visible everywhere by waiting for rcu grace
> > period (because the reader is rcu protected).
> 
> Seems not necessary.
> 
> Suppose it is out of order, the only side-effect is that the new
> recycled request is timed out as a bit late, I think that is what
> we can survive, right?

It at least can mess up the timeout duration for the next recycle
instance because there can be two competing blk_add_timer() instances.
I'm not sure whether there can be other consequences.  When ownership
isn't clear, it becomes really difficult to reason about these things
and can lead to subtle failures.  I think it'd be best to always
establish who owns what.

Thanks.

-- 
tejun
