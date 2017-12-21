Return-Path: <keith.busch@intel.com>
Date: Thu, 21 Dec 2017 14:34:00 -0700
From: Keith Busch <keith.busch@intel.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Scott Bauer <sbauer@eng.utah.edu>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 3/3] block: Polling completion performance optimization
Message-ID: <20171221213400.GB2975@localhost.localdomain>
References: <20171221204636.2924-1-keith.busch@intel.com>
 <20171221204636.2924-4-keith.busch@intel.com>
 <40f03ddc-1f7e-8221-ccb0-d8d311d02870@eng.utah.edu>
 <ce880fba-0663-5b6a-5574-e59914a6af83@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ce880fba-0663-5b6a-5574-e59914a6af83@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Thu, Dec 21, 2017 at 02:00:04PM -0700, Jens Axboe wrote:
> On 12/21/17 1:56 PM, Scott Bauer wrote:
> > On 12/21/2017 01:46 PM, Keith Busch wrote:
> >> @@ -181,7 +181,10 @@ static void blkdev_bio_end_io_simple(struct bio *bio)
> >>  	struct task_struct *waiter = bio->bi_private;
> >>  
> >>  	WRITE_ONCE(bio->bi_private, NULL);
> >> -	wake_up_process(waiter);
> >> +	if (current != waiter)
> >> +		wake_up_process(waiter);
> >> +	else
> >> +		__set_current_state(TASK_RUNNING);
> > 
> > Do we actually need to set this to TASK_RUNNING? If we get here we're already running, right?
> > 
> > Everywhere I see uses of __set_current_state(TASK_RUNNING) it's after we've done a set_current_state(TASK_INTERRUPTIBLE).
> 
> We'd only be TASK_RUNNING if the IRQ got to it first. And that's something that
> should be removed as well - I suspect that'd be a much bigger win, getting rid
> of the IRQ trigger for polled IO, than most of the micro optimizations. For
> Keith's testing, looks like he reduced the cost by turning on coalescing, but
> it'd be cheaper (and better) to not have to rely on that.

It would be nice, but the driver doesn't know a request's completion
is going to be a polled. Even if it did, we don't have a spec defined
way to tell the controller not to send an interrupt with this command's
compeletion, which would be negated anyway if any interrupt driven IO
is mixed in the same queue. We could possibly create a special queue
with interrupts disabled for this purpose if we can pass the HIPRI hint
through the request.
