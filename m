Return-Path: <ming.lei@redhat.com>
Date: Tue, 10 Oct 2017 17:50:13 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "jthumshirn@suse.de" <jthumshirn@suse.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"hch@lst.de" <hch@lst.de>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"oleksandr@natalenko.name" <oleksandr@natalenko.name>,
	"hare@suse.com" <hare@suse.com>,
	"mcgrof@kernel.org" <mcgrof@kernel.org>
Subject: Re: [PATCH v6 9/9] block, scsi: Make SCSI device suspend and resume
 work reliably
Message-ID: <20171010095007.GA18664@ming.t460p>
References: <20171005000110.15904-1-bart.vanassche@wdc.com>
 <20171005000110.15904-10-bart.vanassche@wdc.com>
 <20171007043314.GA16732@ming.t460p>
 <1507583812.2674.52.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1507583812.2674.52.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Oct 09, 2017 at 09:16:53PM +0000, Bart Van Assche wrote:
> On Sat, 2017-10-07 at 12:33 +0800, Ming Lei wrote:
> > On Wed, Oct 04, 2017 at 05:01:10PM -0700, Bart Van Assche wrote:
> > > It is essential during suspend and resume that neither the filesystem
> > > state nor the filesystem metadata in RAM changes. This is why while
> > > the hibernation image is being written or restored that SCSI devices
> > 
> > quiesce isn't used only for suspend and resume, And the issue isn't
> > suspend/resume specific too. So please change the title/commit log
> > as sort of 'make SCSI quiesce more reliable/safe'. 
> 
> OK, I will modify the patch title.
> 
> > > -		if (percpu_ref_tryget_live(&q->q_usage_counter))
> > > -			return 0;
> > > +		if (percpu_ref_tryget_live(&q->q_usage_counter)) {
> > > +			/*
> > > +			 * The code that sets the PREEMPT_ONLY flag is
> > > +			 * responsible for ensuring that that flag is globally
> > > +			 * visible before the queue is unfrozen.
> > > +			 */
> > > +			if (preempt || !blk_queue_preempt_only(q)) {
> > 
> > PREEMPT_ONLY flag is checked without RCU read lock held, so the
> > synchronize_rcu() may just wait for completion of pre-exit
> > percpu_ref_tryget_live(), which can be reordered with the
> > reading on blk_queue_preempt_only().
> 
> OK, I will add rcu_read_lock_sched/unlock_sched() calls around this code.
> 
> > >  int
> > >  scsi_device_quiesce(struct scsi_device *sdev)
> > >  {
> > > +	struct request_queue *q = sdev->request_queue;
> > >  	int err;
> > >  
> > > +	blk_mq_freeze_queue(q);
> > > +	if (blk_set_preempt_only(q)) {
> > > +		blk_mq_unfreeze_queue(q);
> > > +		return -EINVAL;
> > > +	}
> > 
> > This way is wrong, if blk_set_preempt_only() returns true
> > it means the queue has been in PREEMPT_ONLY already,
> > and failing scsi_device_quiesce() can break suspend/resume or
> > sending SCSI domain validation command.
> 
> That's an interesting comment but I propose that what you suggest is implemented
> through a separate patch. The above code preserves the existing behavior, namely
> that scsi_device_quiesce() returns an error code if called when a SCSI device has
> already been quiesced. See also scsi_device_set_state(). BTW, I don't think that

Please see scsi_device_set_state():

        if (state == oldstate)
                return 0;

And believe it or not, there is one real nested calling of scsi_device_quiesce()
in transport_spi.

> it is likely that this will occur. The only code other than the power management
> code I know of that sets the SCSI QUIESCE state is the SCSI sysfs state store
> method and the SCSI parallel code. I don't know any software that sets the SCSI
> QUIESCE state through sysfs. And I'm not sure the SCSI parallel code has a
> significant number of users.

As I know, one famous VM uses that, and the original report is that
this VM may hang after running I/O for days by our customer.
The revalidate path can trigger QUIESCE, and udev should cause that.

> 
> > > +	/*
> > > +	 * Ensure that the effect of blk_set_preempt_only() will be visible
> > > +	 * for percpu_ref_tryget() callers that occur after the queue
> > > +	 * unfreeze. See also https://lwn.net/Articles/573497/.
> > > +	 */
> > > +	synchronize_rcu();
> > 
> > This synchronize_rcu may be saved if we set the PREEMPT_ONLY flag
> > before freezing queue since blk_mq_freeze_queue() may implicate
> > one synchronize_rcu().
> 
> That's an interesting comment. I will look further into this.
> 
> > > @@ -2961,8 +2970,10 @@ void scsi_device_resume(struct scsi_device *sdev)
> > >  	 */
> > >  	mutex_lock(&sdev->state_mutex);
> > >  	if (sdev->sdev_state == SDEV_QUIESCE &&
> > > -	    scsi_device_set_state(sdev, SDEV_RUNNING) == 0)
> > > +	    scsi_device_set_state(sdev, SDEV_RUNNING) == 0) {
> > > +		blk_clear_preempt_only(sdev->request_queue);
> > >  		scsi_run_queue(sdev->request_queue);
> > > +	}
> > >  	mutex_unlock(&sdev->state_mutex);
> > 
> > scsi_run_queue() can be removed, and blk_clear_preempt_only() needn't
> > to be run with holding sdev->state_mutex, just like in quiesce path.
> 
> I will look into removing the scsi_run_queue() call. But I prefer to keep
> the blk_clear_preempt_only() inside the critical section because that call
> doesn't sleep and because it changes state information that is related to
> the SCSI state.

The thing is that the same state change in blk_set_preempt_only() can't
be protected by the lock, and this way may confuse people wrt. inconsistent
lock usage on same state protection.

-- 
Ming
