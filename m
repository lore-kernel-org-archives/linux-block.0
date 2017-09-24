Return-Path: <hch@lst.de>
Date: Sun, 24 Sep 2017 16:48:31 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <keith.busch@intel.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 9/9] nvme: implement multipath access to nvme subsystems
Message-ID: <20170924144831.GC13681@lst.de>
References: <20170918231453.27128-1-hch@lst.de> <20170918231453.27128-10-hch@lst.de> <20170922150915.GA1294@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170922150915.GA1294@localhost.localdomain>
List-ID: <linux-block@vger.kernel.org>

On Fri, Sep 22, 2017 at 11:09:16AM -0400, Keith Busch wrote:
> On Mon, Sep 18, 2017 at 04:14:53PM -0700, Christoph Hellwig wrote:
> > +static void nvme_failover_req(struct request *req)
> > +{
> > +	struct nvme_ns *ns = req->q->queuedata;
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&ns->head->requeue_lock, flags);
> > +	blk_steal_bios(&ns->head->requeue_list, req);
> > +	spin_unlock_irqrestore(&ns->head->requeue_lock, flags);
> > +
> > +	nvme_reset_ctrl(ns->ctrl);
> > +	kblockd_schedule_work(&ns->head->requeue_work);
> > +}
> 
> Need to call blk_mq_free_req after stealing all its bios to prevent
> leaking that entered request.

I think this should be a blk_mq_end_request actually.  The difference
is that blk_mq_end_request will get the I/O accounting right, and
treats the case of having and ->end_io handler correctly as well.
