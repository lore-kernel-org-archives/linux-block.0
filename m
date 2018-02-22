Return-Path: <ming.lei@redhat.com>
Date: Thu, 22 Feb 2018 11:28:50 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Bart Van Assche <bart.vanassche@wdc.com>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Jan Kara <jack@suse.com>
Subject: Re: [PATCH v3 3/3] block: Fix a race between request queue removal
 and the block cgroup controller
Message-ID: <20180222032652.GA3310@ming.t460p>
References: <20180209184405.25835-1-bart.vanassche@wdc.com>
 <20180209184405.25835-4-bart.vanassche@wdc.com>
 <4be27fbf-35a3-034a-f60e-1694393b90e3@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4be27fbf-35a3-034a-f60e-1694393b90e3@linux.alibaba.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Feb 22, 2018 at 10:25:28AM +0800, Joseph Qi wrote:
> Hi Bart,
> 
> Sorry for the delayed response since I was on holiday.
> 
> On 18/2/10 02:44, Bart Van Assche wrote:
> > Avoid that the following race can occur:
> > 
> > blk_cleanup_queue()               blkcg_print_blkgs()
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
> > This change is safe because only the SCSI core and the NVME core keep
> > a reference on a request queue after having called blk_cleanup_queue().
> > Neither driver accesses any of the removed data structures between its
> > blk_cleanup_queue() and blk_put_queue() calls.
> > 
> > Reported-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> > Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
> > Cc: Jan Kara <jack@suse.com>
> > ---
> >  block/blk-core.c  | 31 +++++++++++++++++++++++++++++++
> >  block/blk-sysfs.c |  7 -------
> >  2 files changed, 31 insertions(+), 7 deletions(-)
> > 
> > diff --git a/block/blk-core.c b/block/blk-core.c
> > index 41c74b37be85..6febc69a58aa 100644
> > --- a/block/blk-core.c
> > +++ b/block/blk-core.c
> > @@ -719,6 +719,37 @@ void blk_cleanup_queue(struct request_queue *q)
> >  	del_timer_sync(&q->backing_dev_info->laptop_mode_wb_timer);
> >  	blk_sync_queue(q);
> >  
> > +	/*
> > +	 * I/O scheduler exit is only safe after the sysfs scheduler attribute
> > +	 * has been removed.
> > +	 */
> > +	WARN_ON_ONCE(q->kobj.state_in_sysfs);
> > +
> I notice that several devices such as loop and zram will call
> blk_cleanup_queue before del_gendisk, so it will hit this warning. Is
> this normal?

In theory, it should be a bug to call del_gendisk() after blk_cleanup_queue()
since dirty pages can't be flushed to device any more after queue is
cleaned up.

Thanks,
Ming
