Return-Path: <ming.lei@redhat.com>
Date: Mon, 22 May 2017 09:35:58 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	linux-nvme@lists.infradead.org, Keith Busch <keith.busch@intel.com>,
	stable@vger.kernel.org, Zhang Yi <yizhan@redhat.com>
Subject: Re: [PATCH v2 1/3] nvme: use blk_mq_start_hw_queues() in
 nvme_kill_queues()
Message-ID: <20170522013557.GD15872@ming.t460p>
References: <20170520035605.21785-1-ming.lei@redhat.com>
 <20170520035605.21785-2-ming.lei@redhat.com>
 <20170521062002.GB12287@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170521062002.GB12287@lst.de>
List-ID: <linux-block@vger.kernel.org>

On Sun, May 21, 2017 at 08:20:02AM +0200, Christoph Hellwig wrote:
> > index d5e0906262ea..ce0d96913ee6 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -2437,7 +2437,13 @@ void nvme_kill_queues(struct nvme_ctrl *ctrl)
> >  		revalidate_disk(ns->disk);
> >  		blk_set_queue_dying(ns->queue);
> >  		blk_mq_abort_requeue_list(ns->queue);
> > -		blk_mq_start_stopped_hw_queues(ns->queue, true);
> > +
> > +		/*
> > +		 * We have to force to start queues for avoiding hang
> > +		 * forever, and we have to make sure that queues won't
> > +		 * be stopped forever from now on.
> > +		 */
> 
> 		/*
> 		 * Forcibly start all queues to avoid having stuck requests.

The above is better.

> 		 * Note: We must make sure to not stop the queues from
> 		 * now until the final removal.

In theory, it should be OK to stop and start queues again before the final
removal, so how about the following:

 		 * Note: We must make sure to not put the queues into being stopped
		 forever from now until the final removal.

Thanks,
Ming
