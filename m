Return-Path: <jack@suse.cz>
Date: Wed, 7 Feb 2018 12:54:10 +0100
From: Jan Kara <jack@suse.cz>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "jack@suse.cz" <jack@suse.cz>,
	"joseph.qi@linux.alibaba.com" <joseph.qi@linux.alibaba.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] block: Fix a race between the throttling code and
 request queue initialization
Message-ID: <20180207115410.52gatla2obfk5tmx@quack2.suse.cz>
References: <20180131235300.12773-1-bart.vanassche@wdc.com>
 <20180131235300.12773-3-bart.vanassche@wdc.com>
 <1ff1b2fa-ffe1-20f4-6be9-919c6a5b8227@linux.alibaba.com>
 <1517501761.2746.21.camel@wdc.com>
 <26f758cf-430c-aa7f-0d21-75fbad6db260@gmail.com>
 <1517588518.2675.14.camel@wdc.com>
 <63bb4057-d502-69cd-0385-10ae33bd6649@linux.alibaba.com>
 <1517853491.3764.26.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1517853491.3764.26.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Mon 05-02-18 17:58:12, Bart Van Assche wrote:
> On Sat, 2018-02-03 at 10:51 +0800, Joseph Qi wrote:
> > Hi Bart,
> > 
> > On 18/2/3 00:21, Bart Van Assche wrote:
> > > On Fri, 2018-02-02 at 09:02 +0800, Joseph Qi wrote:
> > > > We triggered this race when using single queue. I'm not sure if it
> > > > exists in multi-queue.
> > > 
> > > Regarding the races between modifying the queue_lock pointer and the code that
> > > uses that pointer, I think the following construct in blk_cleanup_queue() is
> > > sufficient to avoid races between the queue_lock pointer assignment and the code
> > > that executes concurrently with blk_cleanup_queue():
> > > 
> > > 	spin_lock_irq(lock);
> > > 	if (q->queue_lock != &q->__queue_lock)
> > > 		q->queue_lock = &q->__queue_lock;
> > > 	spin_unlock_irq(lock);
> > > 
> > 
> > IMO, the race also exists.
> > 
> > blk_cleanup_queue                   blkcg_print_blkgs
> >   spin_lock_irq(lock) (1)           spin_lock_irq(blkg->q->queue_lock) (2,5)
> >     q->queue_lock = &q->__queue_lock (3)
> >   spin_unlock_irq(lock) (4)
> >                                     spin_unlock_irq(blkg->q->queue_lock) (6)
> > 
> > (1) take driver lock;
> > (2) busy loop for driver lock;
> > (3) override driver lock with internal lock;
> > (4) unlock driver lock; 
> > (5) can take driver lock now;
> > (6) but unlock internal lock.
> > 
> > If we get blkg->q->queue_lock to local first like blk_cleanup_queue,
> > it indeed can fix the different lock use in lock/unlock. But since
> > blk_cleanup_queue has overridden queue lock to internal lock now, I'm
> > afraid we couldn't still use driver lock in blkcg_print_blkgs.
> 
> (+ Jan Kara)
> 
> Hello Joseph,
> 
> That's a good catch. Since modifying all code that accesses the queue_lock
> pointer and that can race with blk_cleanup_queue() would be too cumbersome I
> see only one solution, namely making the request queue cgroup and sysfs
> attributes invisible before the queue_lock pointer is restored. Leaving the
> debugfs attributes visible while blk_cleanup_queue() is in progress should
> be fine if the request queue initialization code is modified such that it
> only modifies the queue_lock pointer for legacy queues. Jan, I think some
> time ago you objected when I proposed to move code from __blk_release_queue()
> into blk_cleanup_queue(). Would you be fine with a slightly different
> approach, namely making block cgroup and sysfs attributes invisible earlier,
> namely from inside blk_cleanup_queue() instead of from inside
> __blk_release_queue()?

Making attributes invisible earlier should be fine. But this whole
switching of queue_lock in blk_cleanup_queue() looks error-prone to me.
Generally anyone having access to request_queue can have old value of
q->queue_lock in its CPU caches and can happily use that value after
blk_cleanup_queue() finishes and the driver specific structure storing the
lock is freed. blkcg_print_blkgs() is one such example but I wouldn't bet a
penny that there are no other paths with a similar problem.

Logically, the lifetime of storage for q->queue_lock should be at least as
long as that of the request_queue itself - i.e., released only after
__blk_release_queue(). Otherwise all users of q->queue_lock need a proper
synchronization against lock switch in blk_cleanup_queue(). Either of these
looks like a lot of work. I guess since this involves only a legacy path,
your approach to move removal sysfs attributes earlier might be a
reasonable band aid.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
