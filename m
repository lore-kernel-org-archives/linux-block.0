Return-Path: <keith.busch@intel.com>
Date: Thu, 18 May 2017 12:06:24 -0400
From: Keith Busch <keith.busch@intel.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	Zhang Yi <yizhan@redhat.com>, linux-block@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/2] nvme: avoid to hang in remove disk
Message-ID: <20170518160624.GA6015@localhost.localdomain>
References: <20170517012729.13469-1-ming.lei@redhat.com>
 <20170517012729.13469-3-ming.lei@redhat.com>
 <20170518134931.GB31489@lst.de>
 <20170518153542.GC18526@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170518153542.GC18526@ming.t460p>
List-ID: <linux-block@vger.kernel.org>

On Thu, May 18, 2017 at 11:35:43PM +0800, Ming Lei wrote:
> On Thu, May 18, 2017 at 03:49:31PM +0200, Christoph Hellwig wrote:
> > On Wed, May 17, 2017 at 09:27:29AM +0800, Ming Lei wrote:
> > > If some writeback requests are submitted just before queue is killed,
> > > and these requests may not be canceled in nvme_dev_disable() because
> > > they are not started yet, it is still possible for blk-mq to hold
> > > these requests in .requeue list.
> > > 
> > > So we have to abort these requests first before del_gendisk(), because
> > > del_gendisk() may wait for completion of these requests.
> > > 
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > ---
> > >  drivers/nvme/host/core.c | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > > 
> > > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > > index d5e0906262ea..8eaeea86509a 100644
> > > --- a/drivers/nvme/host/core.c
> > > +++ b/drivers/nvme/host/core.c
> > > @@ -2097,6 +2097,14 @@ static void nvme_ns_remove(struct nvme_ns *ns)
> > >  					&nvme_ns_attr_group);
> > >  		if (ns->ndev)
> > >  			nvme_nvm_unregister_sysfs(ns);
> > > +		/*
> > > +		 * If queue is dead, we have to abort requests in
> > > +		 * requeue list because fsync_bdev() in removing disk
> > > +		 * path may wait for these IOs, which can't
> > > +		 * be submitted to hardware too.
> > > +		 */
> > > +		if (blk_queue_dying(ns->queue))
> > > +			blk_mq_abort_requeue_list(ns->queue);
> > >  		del_gendisk(ns->disk);
> > >  		blk_mq_abort_requeue_list(ns->queue);
> > 
> > Why can't we just move the blk_mq_abort_requeue_list call before
> > del_gendisk in general?
> 
> That may cause data loss if queue isn't killed. Normally queue is only killed
> when the controller is dead(such as in reset failure) or !pci_device_is_present()
> (in nvme_remove()).

But in your test, your controller isn't even dead. Why are we killing
it when it's still functional? I think we need to first not consider
this perfectly functional controller to be dead under these conditions,
and second, understand why killing the queues after del_gendisk is called
does not allow forward progress.
