Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v5 05/10] blk-mq: Unregister debugfs attributes earlier
To: Omar Sandoval <osandov@osandov.com>,
 Bart Van Assche <bart.vanassche@sandisk.com>
References: <20170425203745.19946-1-bart.vanassche@sandisk.com>
 <20170425203745.19946-6-bart.vanassche@sandisk.com>
 <20170425213018.GB6361@vader>
Cc: linux-block@vger.kernel.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <0da834e7-f934-9317-509a-455932d837e4@kernel.dk>
Date: Tue, 25 Apr 2017 14:41:46 -0700
MIME-Version: 1.0
In-Reply-To: <20170425213018.GB6361@vader>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 04/25/2017 02:30 PM, Omar Sandoval wrote:
> On Tue, Apr 25, 2017 at 01:37:40PM -0700, Bart Van Assche wrote:
>> One of the debugfs attributes allows to run a queue. Since running
>> a queue after a queue has entered the "dead" state is not allowed
>> and triggers a use-after-free, unregister the debugfs attributes
>> before a queue reaches the "dead" state.
> 
> Still not happy with this commit message. I'd prefer:
> 
> We currently call blk_mq_free_queue() from blk_cleanup_queue() before we
> unregister the debugfs attributes for that queue in blk_release_queue().
> This leaves a window open during which accessing most of the mq debugfs
> attributes would cause a use-after-free. Additionally, the "state"
> attribute allows running the queue, which we should not do after the
> queue has entered the "dead" state. Fix both of these cases by
> unregistering the debugfs attributes before this.
> 
> Jens, could you ack that dropping the lock is okay?

Looks fine to me. However, I think there's room for improvement here.
Why don't we just make it:

	if (!q->mq_ops) {
		spin_lock_irq(lock);
		__blk_drain_queue(q, true);
	} else {
		blk_mq_debugfs_unregister_mq(q);
		spin_lock_irq(lock);
	}

	queue_flag_set(QUEUE_FLAG_DEAD, q);
	[...]

Would seem much more readable to me, and less dropping/acquiring for
cases where we don't need it.

-- 
Jens Axboe
