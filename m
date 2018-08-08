Return-Path: <ming.lei@redhat.com>
Date: Wed, 8 Aug 2018 11:50:41 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "axboe@kernel.dk" <axboe@kernel.dk>,
	"jthumshirn@suse.de" <jthumshirn@suse.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"hch@lst.de" <hch@lst.de>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"hare@suse.de" <hare@suse.de>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
	"jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>,
	"jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
	"adrian.hunter@intel.com" <adrian.hunter@intel.com>
Subject: Re: [RFC PATCH 13/14] block: simplify runtime PM support
Message-ID: <20180808035040.GC9523@ming.t460p>
References: <20180807174433.8374-1-ming.lei@redhat.com>
 <20180807174433.8374-14-ming.lei@redhat.com>
 <a1b7afb7e912c84b908342922b2fba12a364fd76.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <a1b7afb7e912c84b908342922b2fba12a364fd76.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Aug 07, 2018 at 07:54:44PM +0000, Bart Van Assche wrote:
> On Wed, 2018-08-08 at 01:44 +0800, Ming Lei wrote:
> > @@ -3772,6 +3764,7 @@ int blk_pre_runtime_suspend(struct request_queue *q)
> >         if (!q->dev)
> >                 return ret;
> >  
> > +       mutex_lock(&q->pm_lock);
> >         spin_lock_irq(q->queue_lock);
> >         if (q->nr_pending) {
> >                 ret = -EBUSY;
> > @@ -3780,6 +3773,13 @@ int blk_pre_runtime_suspend(struct request_queue *q)
> >                 q->rpm_status = RPM_SUSPENDING;
> >         }
> 
> Hello Ming,
> 
> As far as I can see none of the patches in this series adds a call to
> blk_pm_add_request() in the blk-mq code. Does that mean that q->nr_pending
> will always be zero for blk-mq code with your approach and hence that runtime

The counter of q->nr_pending is legacy only, and I just forgot to check
blk-mq queue idle in next patch, but the runtime PM still works in this
way for blk-mq, :-)

> suspend can get triggered while I/O is in progress, e.g. if blk_queue_enter()
> is called concurrently with blk_pre_runtime_suspend()?

In this patchset, for blk-mq, runtime suspend is tried when the auto_suspend
period is expired.

Yes, blk_queue_enter() can run concurrently with blk_pre_runtime_suspend().

	1) if queue isn't frozen, blk_pre_runtime_suspend() will wait for
	completion of the coming request

	2) if queue is frozen, blk_queue_enter() will try to resume the device
	via blk_resume_queue(), and q->pm_lock is use for covering the two paths.

But I should have checked the inflight request counter in blk_pre_runtime_suspend()
like the following way before freezing queue, will add it in V2 if no
one objects this approach.

diff --git a/block/blk-core.c b/block/blk-core.c
index 26f9ceb85318..d1a5cd1da861 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -3730,6 +3730,24 @@ void blk_pm_runtime_init(struct request_queue *q, struct device *dev)
 }
 EXPORT_SYMBOL(blk_pm_runtime_init);
 
+static void blk_mq_pm_check_idle(struct blk_mq_hw_ctx *hctx,
+		struct request *rq, void *priv, bool reserved)
+{
+	unsigned long *cnt = priv;
+
+	(*cnt)++;
+}
+
+static bool blk_mq_pm_queue_idle(struct request_queue *q)
+{
+	unsigned long idle_cnt;
+
+	idle_cnt = 0;
+	blk_mq_queue_tag_busy_iter(q, blk_mq_pm_check_idle, &idle_cnt);
+
+	return idle_cnt == 0;
+}
+
 /**
  * blk_pre_runtime_suspend - Pre runtime suspend check
  * @q: the queue of the device
@@ -3754,13 +3772,18 @@ EXPORT_SYMBOL(blk_pm_runtime_init);
 int blk_pre_runtime_suspend(struct request_queue *q)
 {
 	int ret = 0;
+	bool mq_idle = false;
 
 	if (!q->dev)
 		return ret;
 
 	mutex_lock(&q->pm_lock);
+
+	if (q->mq_ops)
+		mq_idle = blk_mq_pm_queue_idle(q);
+
 	spin_lock_irq(q->queue_lock);
-	if (q->nr_pending) {
+	if (q->nr_pending || !mq_idle) {
 		ret = -EBUSY;
 		pm_runtime_mark_last_busy(q->dev);
 	} else {

Thanks,
Ming
