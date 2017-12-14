Return-Path: <peterz@infradead.org>
Date: Thu, 14 Dec 2017 21:20:42 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "tj@kernel.org" <tj@kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"kernel-team@fb.com" <kernel-team@fb.com>,
	"oleg@redhat.com" <oleg@redhat.com>, "hch@lst.de" <hch@lst.de>,
	"jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>,
	"osandov@fb.com" <osandov@fb.com>
Subject: Re: [PATCH 2/6] blk-mq: replace timeout synchronization with a RCU
 and generation based scheme
Message-ID: <20171214202042.GG3326@worktop>
References: <20171212190134.535941-1-tj@kernel.org>
 <20171212190134.535941-3-tj@kernel.org>
 <1513277469.2475.43.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1513277469.2475.43.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Dec 14, 2017 at 06:51:11PM +0000, Bart Van Assche wrote:
> On Tue, 2017-12-12 at 11:01 -0800, Tejun Heo wrote:
> > +	write_seqcount_begin(&rq->gstate_seq);
> > +	blk_mq_rq_update_state(rq, MQ_RQ_IN_FLIGHT);
> > +	blk_add_timer(rq);
> > +	write_seqcount_end(&rq->gstate_seq);
> 
> My understanding is that both write_seqcount_begin() and write_seqcount_end()
> trigger a write memory barrier. Is a seqcount really faster than a spinlock?

Yes lots, no atomic operations and no waiting.

The only constraint for write_seqlock is that there must not be any
concurrency.

But now that I look at this again, TJ, why can't the below happen?

	write_seqlock_begin();
	blk_mq_rq_update_state(rq, IN_FLIGHT);
	blk_add_timer(rq);
	<timer-irq>
		read_seqcount_begin()
			while (seq & 1)
				cpurelax();
		// life-lock
	</timer-irq>
	write_seqlock_end();
