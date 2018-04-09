Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blk-mq: Fix recently introduced races in the timeout
 handling code
To: Bart Van Assche <Bart.VanAssche@wdc.com>, "hch@lst.de" <hch@lst.de>
Cc: "tj@kernel.org" <tj@kernel.org>,
 "israelr@mellanox.com" <israelr@mellanox.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "maxg@mellanox.com" <maxg@mellanox.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
References: <20180409052038.5391-1-bart.vanassche@wdc.com>
 <20180409093744.GC10405@lst.de>
 <a7972bb84efa3313b87ecbaf37112b360346bdfe.camel@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <548aa0f5-2e7d-e659-4b25-a7dc69352025@kernel.dk>
Date: Mon, 9 Apr 2018 09:03:05 -0600
MIME-Version: 1.0
In-Reply-To: <a7972bb84efa3313b87ecbaf37112b360346bdfe.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 4/9/18 8:58 AM, Bart Van Assche wrote:
> On Mon, 2018-04-09 at 11:37 +0200, Christoph Hellwig wrote:
>> This looks sensible, but I'm worried about taking a whole spinlock
>> for every request completion, including irq disabling.  However it seems
>> like your new updated pattern would fit use of cmpxchg() very nicely.
> 
> Hello Christoph,
> 
> Thanks for the review. I had a look at the spin lock implementation on
> x86 and apparently on x86 spin locks are implemented as qspinlocks
> (include/asm-generic/qspinlock.h). queued_spin_lock() already uses
> atomic_cmpxchg_acquire(). Are you sure that replacing the spin lock
> by cmpxchg() will yield a performance improvement?

It's definitely worth a shot, especially since this looks like a clear
cut case for cmpxchg(). Additionally, it also kills the local irq
disable.

Conversion should be trivial and we can do some perf testing around
that.

Neither solution really makes me happy though, the prospect of
either kind of synchronization cost isn't appealing at all. I'll
have to ponder this a lot more, but it would be ideal if we could
shift that cost to the extremely unlikely case of a timeout
triggering rather than add the cost upfront to EVERY request.

-- 
Jens Axboe
