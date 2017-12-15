Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 15 Dec 2017 05:50:59 -0800
From: "tj@kernel.org" <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Bart Van Assche <Bart.VanAssche@wdc.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"kernel-team@fb.com" <kernel-team@fb.com>,
	"oleg@redhat.com" <oleg@redhat.com>, "hch@lst.de" <hch@lst.de>,
	"jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>,
	"osandov@fb.com" <osandov@fb.com>
Subject: Re: [PATCH 2/6] blk-mq: replace timeout synchronization with a RCU
 and generation based scheme
Message-ID: <20171215135059.GJ3919388@devbig577.frc2.facebook.com>
References: <20171212190134.535941-1-tj@kernel.org>
 <20171212190134.535941-3-tj@kernel.org>
 <1513277469.2475.43.camel@wdc.com>
 <20171214202042.GG3326@worktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171214202042.GG3326@worktop>
List-ID: <linux-block@vger.kernel.org>

Hello, Peter.

On Thu, Dec 14, 2017 at 09:20:42PM +0100, Peter Zijlstra wrote:
> But now that I look at this again, TJ, why can't the below happen?
> 
> 	write_seqlock_begin();
> 	blk_mq_rq_update_state(rq, IN_FLIGHT);
> 	blk_add_timer(rq);
> 	<timer-irq>
> 		read_seqcount_begin()
> 			while (seq & 1)
> 				cpurelax();
> 		// life-lock
> 	</timer-irq>
> 	write_seqlock_end();

Ah, you're right.  For both gstate_seq and aborted_gstate_sync, we can
push all synchronization to the timeout side - ie. gstate_seq read can
yield, pause or synchronize_rcu and hte aborted_gstate_sync can
disable irq around update.

Thanks.

-- 
tejun
