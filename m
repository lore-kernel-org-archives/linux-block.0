Return-Path: <efault@gmx.de>
Message-ID: <1513305570.893.7.camel@gmx.de>
Subject: Re: [PATCH 2/6] blk-mq: replace timeout synchronization with a RCU
 and generation based scheme
From: Mike Galbraith <efault@gmx.de>
To: Peter Zijlstra <peterz@infradead.org>, Bart Van Assche
	 <Bart.VanAssche@wdc.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "kernel-team@fb.com" <kernel-team@fb.com>,  "oleg@redhat.com"
 <oleg@redhat.com>, "hch@lst.de" <hch@lst.de>, "axboe@kernel.dk"
 <axboe@kernel.dk>,  "jianchao.w.wang@oracle.com"
 <jianchao.w.wang@oracle.com>, "osandov@fb.com" <osandov@fb.com>,
 "tj@kernel.org" <tj@kernel.org>
Date: Fri, 15 Dec 2017 03:39:30 +0100
In-Reply-To: <20171214215404.GK3326@worktop>
References: <20171212190134.535941-1-tj@kernel.org>
	 <20171212190134.535941-3-tj@kernel.org> <1513277469.2475.43.camel@wdc.com>
	 <20171214202042.GG3326@worktop> <1513287766.2475.73.camel@wdc.com>
	 <20171214215404.GK3326@worktop>
Content-Type: text/plain; charset="ISO-8859-15"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Thu, 2017-12-14 at 22:54 +0100, Peter Zijlstra wrote:
> On Thu, Dec 14, 2017 at 09:42:48PM +0000, Bart Van Assche wrote:
> 
> > Some time ago the block layer was changed to handle timeouts in thread context
> > instead of interrupt context. See also commit 287922eb0b18 ("block: defer
> > timeouts to a workqueue").
> 
> That only makes it a little better:
> 
> 	Task-A					Worker
> 
> 	write_seqcount_begin()
> 	blk_mq_rw_update_state(rq, IN_FLIGHT)
> 	blk_add_timer(rq)
> 	<timer>
> 		schedule_work()
> 	</timer>
> 	<context-switch to worker>
> 						read_seqcount_begin()
> 							while(seq & 1)
> 								cpu_relax();
> 
> 
> Now normally this isn't fatal because Worker will simply spin its entire
> time slice away and we'll eventually schedule our Task-A back in, which
> will complete the seqcount and things will work.
> 
> But if, for some reason, our Worker was to have RT priority higher than
> our Task-A we'd be up some creek without no paddles.

Most kthreads, including kworkers, are very frequently SCHED_FIFO here.

	-Mike
