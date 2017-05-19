Return-Path: <ming.lei@redhat.com>
Date: Fri, 19 May 2017 21:19:28 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <keith.busch@intel.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	Zhang Yi <yizhan@redhat.com>, linux-block@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/2] nvme: avoid to hang in remove disk
Message-ID: <20170519131923.GA4019@ming.t460p>
References: <20170517012729.13469-1-ming.lei@redhat.com>
 <20170517012729.13469-3-ming.lei@redhat.com>
 <20170518134931.GB31489@lst.de>
 <20170518153542.GC18526@ming.t460p>
 <20170518160624.GA6015@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170518160624.GA6015@localhost.localdomain>
List-ID: <linux-block@vger.kernel.org>

On Thu, May 18, 2017 at 12:06:24PM -0400, Keith Busch wrote:
> On Thu, May 18, 2017 at 11:35:43PM +0800, Ming Lei wrote:
> > On Thu, May 18, 2017 at 03:49:31PM +0200, Christoph Hellwig wrote:
> > > On Wed, May 17, 2017 at 09:27:29AM +0800, Ming Lei wrote:
> > > > If some writeback requests are submitted just before queue is killed,
> > > > and these requests may not be canceled in nvme_dev_disable() because
> > > > they are not started yet, it is still possible for blk-mq to hold
> > > > these requests in .requeue list.
> > > > 
> > > > So we have to abort these requests first before del_gendisk(), because
> > > > del_gendisk() may wait for completion of these requests.
> > > > 
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > > ---
> > > >  drivers/nvme/host/core.c | 8 ++++++++
> > > >  1 file changed, 8 insertions(+)
> > > > 
> > > > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > > > index d5e0906262ea..8eaeea86509a 100644
> > > > --- a/drivers/nvme/host/core.c
> > > > +++ b/drivers/nvme/host/core.c
> > > > @@ -2097,6 +2097,14 @@ static void nvme_ns_remove(struct nvme_ns *ns)
> > > >  					&nvme_ns_attr_group);
> > > >  		if (ns->ndev)
> > > >  			nvme_nvm_unregister_sysfs(ns);
> > > > +		/*
> > > > +		 * If queue is dead, we have to abort requests in
> > > > +		 * requeue list because fsync_bdev() in removing disk
> > > > +		 * path may wait for these IOs, which can't
> > > > +		 * be submitted to hardware too.
> > > > +		 */
> > > > +		if (blk_queue_dying(ns->queue))
> > > > +			blk_mq_abort_requeue_list(ns->queue);
> > > >  		del_gendisk(ns->disk);
> > > >  		blk_mq_abort_requeue_list(ns->queue);
> > > 
> > > Why can't we just move the blk_mq_abort_requeue_list call before
> > > del_gendisk in general?
> > 
> > That may cause data loss if queue isn't killed. Normally queue is only killed
> > when the controller is dead(such as in reset failure) or !pci_device_is_present()
> > (in nvme_remove()).
> 
> But in your test, your controller isn't even dead. Why are we killing
> it when it's still functional? I think we need to first not consider

Last time, you posted one patch which looks fixes the hang, but the
NVMe device becomes not functional after rebinding later, see
the link:

	http://marc.info/?l=linux-block&m=149430047402103&w=2

Also not sure it is worthy of doing that, because in my case,
nvme_dev_disable() has been called in nvme_reset_notify() before the reset,
that means requests have been canceled already. As I mentioned, the two
directions aren't contradictorily. But thinking controller as live under
this situation need big change, such as, not canceling requests in whole
reset path.

Finally this patch is not only for the case of reset failure vs. remove,
but also for hot-unplug, queues are still killed in path of hot remove.

> this perfectly functional controller to be dead under these conditions,
> and second, understand why killing the queues after del_gendisk is called
> does not allow forward progress.

I have explained this cause in last email, :-)

Thanks,
Ming
