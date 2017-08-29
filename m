Return-Path: <hch@lst.de>
Date: Tue, 29 Aug 2017 16:55:59 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <keith.busch@intel.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 10/10] nvme: implement multipath access to nvme
	subsystems
Message-ID: <20170829145559.GA32760@lst.de>
References: <20170823175815.3646-1-hch@lst.de> <20170823175815.3646-11-hch@lst.de> <20170829145417.GA4428@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170829145417.GA4428@localhost.localdomain>
List-ID: <linux-block@vger.kernel.org>

On Tue, Aug 29, 2017 at 10:54:17AM -0400, Keith Busch wrote:
> On Wed, Aug 23, 2017 at 07:58:15PM +0200, Christoph Hellwig wrote:
> > +	/* Anything else could be a path failure, so should be retried */
> > +	spin_lock_irqsave(&ns->head->requeue_lock, flags);
> > +	blk_steal_bios(&ns->head->requeue_list, req);
> > +	spin_unlock_irqrestore(&ns->head->requeue_lock, flags);
> > +
> > +	nvme_reset_ctrl(ns->ctrl);
> > +	kblockd_schedule_work(&ns->head->requeue_work);
> > +	return true;
> > +}
> 
> It appears this isn't going to cause the path selection to failover for
> the requeued work. The bio's bi_disk is unchanged from the failed path when the
> requeue_work submits the bio again so it will use the same path, right? 

Oh.  This did indeed break with the bi_bdev -> bi_disk refactoring
I did just before sending this out.

> It also looks like new submissions will get a new path only from the
> fact that the original/primary is being reset. The controller reset
> itself seems a bit heavy-handed. Can we just set head->current_path to
> the next active controller in the list?

For ANA we'll have to do that anyway, but if we got a failure
that clearly indicates a path failure what benefit is there in not
resetting the controller?  But yeah, maybe we can just switch the
path for non-ANA controllers and wait for timeouts to do their work.

> 
> > +static void nvme_requeue_work(struct work_struct *work)
> > +{
> > +	struct nvme_ns_head *head =
> > +		container_of(work, struct nvme_ns_head, requeue_work);
> > +	struct bio *bio, *next;
> > +
> > +	spin_lock_irq(&head->requeue_lock);
> > +	next = bio_list_get(&head->requeue_list);
> > +	spin_unlock_irq(&head->requeue_lock);
> > +
> > +	while ((bio = next) != NULL) {
> > +		next = bio->bi_next;
> > +		bio->bi_next = NULL;
> > +		generic_make_request_fast(bio);
> > +	}
> > +}
> 
> Here, I think we need to reevaluate the path (nvme_find_path) and set
> bio->bi_disk accordingly.

Yes.  Previously this was opencoded and always used head->disk, but
I messed it up last minute.  In the end it still worked for my cases
because the controller would either already be reset or fail all
I/O, but this behavior clearly is not intended and suboptimal.
