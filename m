Return-Path: <ming.lei@redhat.com>
Date: Wed, 13 Sep 2017 00:10:47 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@lst.de" <hch@lst.de>, "jthumshirn@suse.de" <jthumshirn@suse.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"hare@suse.com" <hare@suse.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH 4/5] block: Make SCSI device suspend work reliably
Message-ID: <20170912161046.GB21349@ming.t460p>
References: <20170908235226.26622-1-bart.vanassche@wdc.com>
 <20170908235226.26622-5-bart.vanassche@wdc.com>
 <20170912022948.GB31533@ming.t460p>
 <1505231149.2537.18.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1505231149.2537.18.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Sep 12, 2017 at 03:45:50PM +0000, Bart Van Assche wrote:
> On Tue, 2017-09-12 at 10:29 +0800, Ming Lei wrote:
> > On Fri, Sep 08, 2017 at 04:52:25PM -0700, Bart Van Assche wrote:
> > > @@ -1350,6 +1368,16 @@ static struct request *get_request(struct request_queue *q, unsigned int op,
> > >  	lockdep_assert_held(q->queue_lock);
> > >  	WARN_ON_ONCE(q->mq_ops);
> > >  
> > > +	WARN_ON_ONCE((op & REQ_PM) && blk_pm_suspended(q));
> > > +
> > > +	/*
> > > +	 * Wait if the request queue is suspended or in the process of
> > > +	 * suspending/resuming and the request being allocated will not be
> > > +	 * used for power management purposes.
> > > +	 */
> > > +	if (!(op & REQ_PM) && !blk_wait_until_active(q, !(op & REQ_NOWAIT)))
> > > +		return ERR_PTR(-EAGAIN);
> > > +
> > 
> > Firstly it is not enough to prevent new allocation only, because
> > requests pool may have been used up and all the allocated requests
> > just stay in block queue when SCSI device is put into quiesce.
> > So you may cause new I/O hang and wait forever here. That is why
> > I take freeze to do that because freezing queue can prevent new
> > allocation and drain in-queue requests both.
> 
> Sorry but I disagree. If all tags are allocated and it is attempted to
> suspend a queue then this patch not only will prevent allocation of new
> non-PM requests but it will also let these previously submitted non-PM
> requests finish. See also the blk_peek_request() changes in patch 4/5.
> Once a previously submitted request finished allocation of the PM request
> will succeed.

You just simply removed blk_pm_peek_request() from blk_peek_request(),
how does that work on blk-mq?

Also that may not work because SCSI quiesce may just happen between
request allocation and run queue, then nothing can be dispatched
to driver.

> 
> > Secondly, all RQF_PREEMPT(not PM) is blocked here too, that may
> > cause regression since we usually need/allow RQF_PREEMPT to run
> > during SCSI quiesce.
> 
> Sorry but I disagree with this comment too. Please keep in mind that my patch
> only affects the SCSI quiesce status if that status has been requested by the
> power management subsystem. After the power management subsystem has
> transitioned a SCSI queue into the quiesce state that queue has reached the
> RPM_SUSPENDED status. No new requests must be submitted against a suspended

No, RPM_SUSPEND only means runtime suspend, you misunderstand it as
system suspend.

Actually the reported issue is during system suspend/resume, which can
happen without runtime PM, such as, runtime PM is disabled via sysfs.

> queue. It is easy to see in the legacy block layer that only PM requests and
> no other RQF_PREEMPT requests are processed once the queue has reached the
> suspended status:
> 
> /*
>  * Don't process normal requests when queue is suspended
>  * or in the process of suspending/resuming
>  */
> static struct request *blk_pm_peek_request(struct request_queue *q,
> 					   struct request *rq)
> {
> 	if (q->dev && (q->rpm_status == RPM_SUSPENDED ||
> 	    (q->rpm_status != RPM_ACTIVE && !(rq->cmd_flags & REQ_PM))))

As I explained, rpm_status represents runtime PM status, nothing to
do with system suspend/resume.

So RRF_PREEMPT can be dispatched to driver during system suspend.

-- 
Ming
