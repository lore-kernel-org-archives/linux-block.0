Return-Path: <ming.lei@redhat.com>
Date: Tue, 17 Jul 2018 09:12:06 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "axboe@kernel.dk" <axboe@kernel.dk>,
	"jthumshirn@suse.de" <jthumshirn@suse.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"hch@lst.de" <hch@lst.de>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"hare@suse.de" <hare@suse.de>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"rjw@rjwysocki.net" <rjw@rjwysocki.net>,
	"stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
	"adrian.hunter@intel.com" <adrian.hunter@intel.com>
Subject: Re: [PATCH RFC V2 0/3] blk-mq: support runtime PM
Message-ID: <20180717011204.GA22593@ming.t460p>
References: <20180713080602.31602-1-ming.lei@redhat.com>
 <c4147a47-876f-0ced-6c9d-1c3792d09858@kernel.dk>
 <20180714023740.GA8402@ming.t460p>
 <9acf7af08c9a517d0783277c655fa29a0fc07573.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9acf7af08c9a517d0783277c655fa29a0fc07573.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Jul 16, 2018 at 04:03:04PM +0000, Bart Van Assche wrote:
> On Sat, 2018-07-14 at 10:37 +0800, Ming Lei wrote:
> > OK, I am thinking another idea for addressing this issue.
> > 
> > We may introduce one logical admin(pm) request queue for each scsi_device,
> > and this queue shares tag with IO queue, with NO_SCHED set, and always
> > use atomic mode of the queue usage refcounter. Then we may send PM
> > command to device after the IO queue is frozen.
> > 
> > Also PREEMPT_ONLY can be removed too in this way.
> > 
> > Even in future, all pass-through commands may be sent to this admin queue.
> > 
> > If no one objects, I will cook patches towards this direction.
> 
> Wouldn't it be overkill to introduce a separate admin queue for SCSI devices?
> Will that new queue be visible under /sys/block as a request queue? If so,

The admin queue won't be visible under /sys/block because there isn't
disk attached to it.

> how many scripts will break due to that sysfs change? If the new queue won't
> be visible under /sys/block, how many changes will have to be made to the
> block layer to avoid that it becomes visible?

That is easy enough, please see NVMe's admin queue. And the concept is
actually from NVMe. The difference is just that NVMe's admin queue has
standalone tags, but it is easy to solve with TAG_SHARED for scsi.

> 
> Regarding the device_busy, device_blocked, cmd_list and other attributes in
> struct scsi_device: will the SCSI commands submitted to the admin queue affect
> these attributes? If not, which assumptions in the SCSI core will break? And
> if SCSI commands submitted to the admin queue will affect these attributes,
> how will these attributes be shared between the regular and the admin request
> queues?

Per my current design, requests submitted to one scsi_device via admin
queue will share this scsi_device attributes just for sake of easy
implementation.

Sharing won't be very difficult, and one way is to pass 'scsi_device'
via scsi_request from scsi_execute().

BTW, I am trying to make the admin queue per-host first.

> 
> Since the power management core guarantees that runtime PM operations do not
> occur during suspend nor during resume operations: has it been considered to
> drop the RQF_PM flag and to use the RQF_PREEMPT flag instead and also to
> set and reset QUEUE_FLAG_PREEMPT_ONLY as needed?

That can't work on runtime PM which requires new IO to wakeup queue, if
we add this to blk_queue_enter(), which will become quite complicated:

1) queue freeze has to be done before runtime suspending

2) when any new IO comes, the queue has to be unfrozen.

3) when any RQF_PM request comes, the queue has to be kept in freezing,
and allows this request to be crossed.


There are at least two benefits with this suggested approach:

1) simplifying blk_queue_enter() for using freezing IO queue before
runtime suspend. We can simply freeze IO queue before suspend.

2) solve the RQF_PM request starvation issue in simple way
Now blk_pm_add_request() is called from __elv_add_request(), but at
that time, the request pool may have been consumed up already.

Also separating admin requests from IO queue may cause make chance to
simplify & optimize IO path in future too.

Thanks,
Ming
