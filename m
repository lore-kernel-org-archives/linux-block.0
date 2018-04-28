Return-Path: <ming.lei@redhat.com>
Date: Sat, 28 Apr 2018 11:28:54 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <keith.busch@intel.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/2] nvme: pci: guarantee EH can make progress
Message-ID: <20180428032848.GA5657@ming.t460p>
References: <20180426123956.26039-1-ming.lei@redhat.com>
 <20180426123956.26039-3-ming.lei@redhat.com>
 <20180426162442.GB2624@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180426162442.GB2624@localhost.localdomain>
List-ID: <linux-block@vger.kernel.org>

On Thu, Apr 26, 2018 at 10:24:43AM -0600, Keith Busch wrote:
> On Thu, Apr 26, 2018 at 08:39:56PM +0800, Ming Lei wrote:
> > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > index 5d05a04f8e72..1e058deb4718 100644
> > --- a/drivers/nvme/host/pci.c
> > +++ b/drivers/nvme/host/pci.c
> > @@ -1265,6 +1265,20 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
> >  	struct nvme_command cmd;
> >  	u32 csts = readl(dev->bar + NVME_REG_CSTS);
> >  
> > +	/*
> > +	 * If error recovery is in-progress and this request needn't to
> > +	 * be retried, return BLK_EH_HANDLED immediately, so that error
> > +	 * handler kthread can always make progress since we still need
> > +	 * to send FAILFAST request to admin queue for handling error.
> > +	 */
> > +	spin_lock(&dev->eh_lock);
> > +	if (dev->eh_in_recovery && blk_noretry_request(req)) {
> > +		spin_unlock(&dev->eh_lock);
> > +		nvme_req(req)->status |= NVME_SC_DNR;
> > +		return BLK_EH_HANDLED;
> > +	}
> > +	spin_unlock(&dev->eh_lock);
> 
> This doesn't really look safe. Even if a command times out, the
> controller still owns that command, and calling it done while pci bus
> master enable is still set can cause memory corruption.

OK, that is one point I missed.

This issue can be handled by sending 'set host mem' in async way in
nvme_dev_disable() path, just like nvme_disable_io_queues().

Thanks,
Ming
