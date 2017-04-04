Return-Path: <hch@lst.de>
Date: Tue, 4 Apr 2017 08:42:05 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH v2 3/5] blk-mq: Introduce blk_mq_ops.restart_hctx
Message-ID: <20170404064205.GC9168@lst.de>
References: <20170403232228.11208-1-bart.vanassche@sandisk.com> <20170403232228.11208-4-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170403232228.11208-4-bart.vanassche@sandisk.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Apr 03, 2017 at 04:22:26PM -0700, Bart Van Assche wrote:
> If a tag set is shared among multiple hardware queues, leave
> it to the block driver to rerun hardware queues. Hence remove
> QUEUE_FLAG_RESTART and introduce blk_mq_ops.restart_hctx.
> Remove blk_mq_sched_mark_restart_queue() because this
> function has no callers.

This looks fine, but I think it needs to also actually implement at
least a dummy restart_hctx method for SCSI and NVMe to keep the
existing functionality.
