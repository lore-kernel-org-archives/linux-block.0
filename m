Return-Path: <hch@lst.de>
Date: Thu, 24 Aug 2017 10:59:54 +0200
From: "hch@lst.de" <hch@lst.de>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@lst.de" <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"keith.busch@intel.com" <keith.busch@intel.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH 10/10] nvme: implement multipath access to nvme
	subsystems
Message-ID: <20170824085954.GD19504@lst.de>
References: <20170823175815.3646-1-hch@lst.de> <20170823175815.3646-11-hch@lst.de> <1503512512.2484.16.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1503512512.2484.16.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Aug 23, 2017 at 06:21:55PM +0000, Bart Van Assche wrote:
> On Wed, 2017-08-23 at 19:58 +0200, Christoph Hellwig wrote:
> > +static blk_qc_t nvme_make_request(struct request_queue *q, struct bio *bio)
> > +{
> > +	struct nvme_ns_head *head = q->queuedata;
> > +	struct nvme_ns *ns;
> > +	blk_qc_t ret = BLK_QC_T_NONE;
> > +	int srcu_idx;
> > +
> > +	srcu_idx = srcu_read_lock(&head->srcu);
> > +	ns = srcu_dereference(head->current_path, &head->srcu);
> > +	if (unlikely(!ns || ns->ctrl->state != NVME_CTRL_LIVE))
> > +		ns = nvme_find_path(head);
> > +	if (likely(ns)) {
> > +		bio->bi_disk = ns->disk;
> > +		bio->bi_opf |= REQ_FAILFAST_TRANSPORT;
> > +		ret = generic_make_request_fast(bio);
> > +	} else if (!list_empty_careful(&head->list)) {
> > +		printk_ratelimited("no path available - requeing I/O\n");
> > +
> > +		spin_lock_irq(&head->requeue_lock);
> > +		bio_list_add(&head->requeue_list, bio);
> > +		spin_unlock_irq(&head->requeue_lock);
> > +	} else {
> > +		printk_ratelimited("no path - failing I/O\n");
> > +
> > +		bio->bi_status = BLK_STS_IOERR;
> > +		bio_endio(bio);
> > +	}
> > +
> > +	srcu_read_unlock(&head->srcu, srcu_idx);
> > +	return ret;
> > +}
> 
> Hello Christoph,
> 
> Since generic_make_request_fast() returns BLK_STS_AGAIN for a dying path:
> can the same kind of soft lockups occur with the NVMe multipathing code as
> with the current upstream device mapper multipathing code? See e.g.
> "[PATCH 3/7] dm-mpath: Do not lock up a CPU with requeuing activity"
> (https://www.redhat.com/archives/dm-devel/2017-August/msg00124.html).

I suspect the code is not going to hit it because we check the controller
state before trying to queue I/O on the lower queue.  But if you point
me to a good reproducer test case I'd like to check.

Also does the "single queue" case in your mail refer to the old
request code?  nvme only uses blk-mq so it would not hit that.
But either way I think get_request should be fixed to return
BLK_STS_IOERR if the queue is dying instead of BLK_STS_AGAIN.

> Another question about this code is what will happen if
> generic_make_request_fast() returns BLK_STS_AGAIN and the submit_bio() or
> generic_make_request() caller ignores the return value of the called
> function? A quick grep revealed that there is plenty of code that ignores
> the return value of these last two functions.

generic_make_request and generic_make_request_fast only return
the polling cookie (blk_qc_t), not a block status.  Note that we do
not use blk_get_request / blk_mq_alloc_request for the request allocation
of the request on the lower device, so unless the caller passed REQ_NOWAIT
and is able to handle BLK_STS_AGAIN we won't ever return it.
