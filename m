Return-Path: <ming.lei@redhat.com>
Date: Fri, 13 Jul 2018 07:15:49 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <tom.leiming@gmail.com>,
	linux-block <linux-block@vger.kernel.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Alan Stern <stern@rowland.harvard.edu>,
	Linux PM List <linux-pm@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	"James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Linux SCSI List <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH RFC 3/4] blk-mq: prepare for supporting runtime PM
Message-ID: <20180712231547.GB30631@ming.t460p>
References: <20180711162906.14271-1-ming.lei@redhat.com>
 <20180711162906.14271-4-ming.lei@redhat.com>
 <20180712095828.GA2422@ming.t460p>
 <20180712122836.GC2422@ming.t460p>
 <a0be8ebf-e556-34c9-5985-6cda8992cd61@kernel.dk>
 <CACVXFVMQq5FnE-Z28H5GF1gD-rc7Khk=vFuyMZePgxBji_AAuw@mail.gmail.com>
 <df8eddc5-d2e0-3532-afbd-c40fa1d09890@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <df8eddc5-d2e0-3532-afbd-c40fa1d09890@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Thu, Jul 12, 2018 at 03:44:05PM -0600, Jens Axboe wrote:
> On 7/12/18 3:32 PM, Ming Lei wrote:
> > On Thu, Jul 12, 2018 at 10:00 PM, Jens Axboe <axboe@kernel.dk> wrote:
> >> On 7/12/18 6:28 AM, Ming Lei wrote:
> >>> On Thu, Jul 12, 2018 at 05:58:28PM +0800, Ming Lei wrote:
> >>>> On Thu, Jul 12, 2018 at 12:29:05AM +0800, Ming Lei wrote:
> >>>>> This patch introduces blk_mq_pm_add_request() which is called after
> >>>>> allocating one request. Also blk_mq_pm_put_request() is introduced
> >>>>> and called after one request is freed.
> >>>>>
> >>>>> For blk-mq, it can be quite expensive to accounting in-flight IOs,
> >>>>> so this patch calls pm_runtime_mark_last_busy() simply after each IO
> >>>>> is done, instead of doing that only after the last in-flight IO is done.
> >>>>> This way is still workable, since the active non-PM IO will be checked
> >>>>> in blk_pre_runtime_suspend(), and runtime suspend will be prevented
> >>>>> if there is any active non-PM IO.
> >>>>>
> >>>>> Also makes blk_post_runtime_resume() to cover blk-mq.
> >>>>>
> >>>>> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> >>>>> Cc: Alan Stern <stern@rowland.harvard.edu>
> >>>>> Cc: linux-pm@vger.kernel.org
> >>>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >>>>> Cc: Christoph Hellwig <hch@lst.de>
> >>>>> Cc: Bart Van Assche <bart.vanassche@wdc.com>
> >>>>> Cc: "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>
> >>>>> Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
> >>>>> Cc: linux-scsi@vger.kernel.org
> >>>>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> >>>>> ---
> >>>>>  block/blk-core.c | 12 ++++++++++--
> >>>>>  block/blk-mq.c   | 24 ++++++++++++++++++++++++
> >>>>>  2 files changed, 34 insertions(+), 2 deletions(-)
> >>>>>
> >>>>> diff --git a/block/blk-core.c b/block/blk-core.c
> >>>>> index c4b57d8806fe..bf66d561980d 100644
> >>>>> --- a/block/blk-core.c
> >>>>> +++ b/block/blk-core.c
> >>>>> @@ -3804,12 +3804,17 @@ EXPORT_SYMBOL(blk_pm_runtime_init);
> >>>>>  int blk_pre_runtime_suspend(struct request_queue *q)
> >>>>>  {
> >>>>>     int ret = 0;
> >>>>> +   bool active;
> >>>>>
> >>>>>     if (!q->dev)
> >>>>>             return ret;
> >>>>>
> >>>>>     spin_lock_irq(q->queue_lock);
> >>>>> -   if (q->nr_pending) {
> >>>>> +   if (!q->mq_ops)
> >>>>> +           active = !!q->nr_pending;
> >>>>> +   else
> >>>>> +           active = !blk_mq_pm_queue_idle(q);
> >>>>> +   if (active) {
> >>>>>             ret = -EBUSY;
> >>>>>             pm_runtime_mark_last_busy(q->dev);
> >>>>>     } else {
> >>>>
> >>>> Looks there is one big issue, one new IO may come just after reading
> >>>> 'active' and before writing RPM_SUSPENDING to q->rpm_status, and both
> >>>> the suspending and the new IO may be in-progress at the same time.
> >>>
> >>> One idea I thought of is to use seqlock to sync changing & reading q->rpm_status,
> >>> and looks read lock(read_seqcount_begin/read_seqcount_retry) shouldn't introduce
> >>> big cost in fast path.
> >>
> >> Let's please keep in mind that this is runtime pm stuff. Better to
> >> make the rules relaxed around it, instead of adding synchronization.
> > 
> > But the race has to be avoided, otherwise IO may be failed. I don't
> > find any simple solution yet for avoiding the race without adding sync.
> > 
> > Any idea for avoiding the race without using sync like seqlock or others?
> 
> I just don't want anything like this in the hot path. Why can't we
> handle this similarly to how we handle request timeouts? It'll
> potentially delay the suspend by a few seconds, but surely that can't be
> a big deal. I don't see why we need to track this on a per-request
> basis.

For legacy path, there is the queue lock, so no the race mentioned.

I guess you mean why we can't use RCU style to deal with this issue, so
we don't introduce cost in fast path, but the problem is that IO has
to be submitted to one active hardware, that is one invariant of runtime
PM.

So RCU/SRCU won't fix this issue because the rcu_read_lock sync nothing,
and we have to make sure that hardware is ready before dispatching IO to
hardware/driver. That is why I think sort of sync is required in IO path.

Thanks,
Ming
