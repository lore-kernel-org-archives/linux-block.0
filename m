Return-Path: <keith.busch@intel.com>
Date: Tue, 29 Aug 2017 10:54:17 -0400
From: Keith Busch <keith.busch@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 10/10] nvme: implement multipath access to nvme subsystems
Message-ID: <20170829145417.GA4428@localhost.localdomain>
References: <20170823175815.3646-1-hch@lst.de>
 <20170823175815.3646-11-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170823175815.3646-11-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

On Wed, Aug 23, 2017 at 07:58:15PM +0200, Christoph Hellwig wrote:
> +	/* Anything else could be a path failure, so should be retried */
> +	spin_lock_irqsave(&ns->head->requeue_lock, flags);
> +	blk_steal_bios(&ns->head->requeue_list, req);
> +	spin_unlock_irqrestore(&ns->head->requeue_lock, flags);
> +
> +	nvme_reset_ctrl(ns->ctrl);
> +	kblockd_schedule_work(&ns->head->requeue_work);
> +	return true;
> +}

It appears this isn't going to cause the path selection to failover for
the requeued work. The bio's bi_disk is unchanged from the failed path when the
requeue_work submits the bio again so it will use the same path, right? 

It also looks like new submissions will get a new path only from the
fact that the original/primary is being reset. The controller reset
itself seems a bit heavy-handed. Can we just set head->current_path to
the next active controller in the list?


> +static void nvme_requeue_work(struct work_struct *work)
> +{
> +	struct nvme_ns_head *head =
> +		container_of(work, struct nvme_ns_head, requeue_work);
> +	struct bio *bio, *next;
> +
> +	spin_lock_irq(&head->requeue_lock);
> +	next = bio_list_get(&head->requeue_list);
> +	spin_unlock_irq(&head->requeue_lock);
> +
> +	while ((bio = next) != NULL) {
> +		next = bio->bi_next;
> +		bio->bi_next = NULL;
> +		generic_make_request_fast(bio);
> +	}
> +}

Here, I think we need to reevaluate the path (nvme_find_path) and set
bio->bi_disk accordingly.
