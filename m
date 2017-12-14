Return-Path: <peterz@infradead.org>
Date: Thu, 14 Dec 2017 22:54:04 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"kernel-team@fb.com" <kernel-team@fb.com>,
	"oleg@redhat.com" <oleg@redhat.com>, "hch@lst.de" <hch@lst.de>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>,
	"osandov@fb.com" <osandov@fb.com>, "tj@kernel.org" <tj@kernel.org>
Subject: Re: [PATCH 2/6] blk-mq: replace timeout synchronization with a RCU
 and generation based scheme
Message-ID: <20171214215404.GK3326@worktop>
References: <20171212190134.535941-1-tj@kernel.org>
 <20171212190134.535941-3-tj@kernel.org>
 <1513277469.2475.43.camel@wdc.com>
 <20171214202042.GG3326@worktop>
 <1513287766.2475.73.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1513287766.2475.73.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Dec 14, 2017 at 09:42:48PM +0000, Bart Van Assche wrote:
> On Thu, 2017-12-14 at 21:20 +0100, Peter Zijlstra wrote:
> > On Thu, Dec 14, 2017 at 06:51:11PM +0000, Bart Van Assche wrote:
> > > On Tue, 2017-12-12 at 11:01 -0800, Tejun Heo wrote:
> > > > +	write_seqcount_begin(&rq->gstate_seq);
> > > > +	blk_mq_rq_update_state(rq, MQ_RQ_IN_FLIGHT);
> > > > +	blk_add_timer(rq);
> > > > +	write_seqcount_end(&rq->gstate_seq);
> > > 
> > > My understanding is that both write_seqcount_begin() and write_seqcount_end()
> > > trigger a write memory barrier. Is a seqcount really faster than a spinlock?
> > 
> > Yes lots, no atomic operations and no waiting.
> > 
> > The only constraint for write_seqlock is that there must not be any
> > concurrency.
> > 
> > But now that I look at this again, TJ, why can't the below happen?
> > 
> > 	write_seqlock_begin();
> > 	blk_mq_rq_update_state(rq, IN_FLIGHT);
> > 	blk_add_timer(rq);
> > 	<timer-irq>
> > 		read_seqcount_begin()
> > 			while (seq & 1)
> > 				cpurelax();
> > 		// life-lock
> > 	</timer-irq>
> > 	write_seqlock_end();
> 
> Hello Peter,
> 
> Some time ago the block layer was changed to handle timeouts in thread context
> instead of interrupt context. See also commit 287922eb0b18 ("block: defer
> timeouts to a workqueue").

That only makes it a little better:

	Task-A					Worker

	write_seqcount_begin()
	blk_mq_rw_update_state(rq, IN_FLIGHT)
	blk_add_timer(rq)
	<timer>
		schedule_work()
	</timer>
	<context-switch to worker>
						read_seqcount_begin()
							while(seq & 1)
								cpu_relax();


Now normally this isn't fatal because Worker will simply spin its entire
time slice away and we'll eventually schedule our Task-A back in, which
will complete the seqcount and things will work.

But if, for some reason, our Worker was to have RT priority higher than
our Task-A we'd be up some creek without no paddles.

We don't happen to have preemption of IRQs off here? That would fix
things nicely.
