Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 0/5] blk-mq: dispatch related cleanup, fix and
 optimization
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
 Andrew Jones <drjones@redhat.com>, Bart Van Assche <bart.vanassche@wdc.com>,
 linux-scsi@vger.kernel.org, "Martin K. Petersen"
 <martin.petersen@oracle.com>, Christoph Hellwig <hch@lst.de>
References: <20180625113149.29449-1-ming.lei@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <33a6764d-7fc8-fc46-65ae-33310a627abd@kernel.dk>
Date: Thu, 28 Jun 2018 13:21:16 -0600
MIME-Version: 1.0
In-Reply-To: <20180625113149.29449-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 6/25/18 5:31 AM, Ming Lei wrote:
> Hi,
> 
> The 1st two patches cleanes up blk_mq_get_driver_tag() and
> blk_mq_mark_tag_wait().
> 
> The 3rd patch fixes one race between adding hctx->dispatch_wait to
> wq and removing it from wq.
> 
> The 4th patch avoids to iterate on all queues which share same tags
> after completing one request, so that we can kill the synchronize_rcu()
> in patch of queue cleanup, then long delay can be avoided during SCSI LUN
> probe. Meantime IO performance can be improved.
> 
> The 5th patch avoids to synchronizing rcu in blk_cleanup_queue() when
> queue isn't initialized, so long delay can be avoided during SCSI LUN
> probe too.

Looks good to me, applied for 4.19.

-- 
Jens Axboe
