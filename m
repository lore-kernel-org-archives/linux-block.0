Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Wed, 5 Apr 2017 13:41:20 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH v2 3/5] blk-mq: Introduce blk_mq_ops.restart_hctx
Message-ID: <20170405204120.GC22645@vader.DHCP.thefacebook.com>
References: <20170403232228.11208-1-bart.vanassche@sandisk.com>
 <20170403232228.11208-4-bart.vanassche@sandisk.com>
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

Hi, Bart,

Kyber uses blk_mq_sched_mark_restart_queue() and the QUEUE_FLAG_RESTART
bit. If it's not too much trouble, it'd make things easier for me if you
left it in place. If it's a pain, it's fine if you get rid of it, I can
reintroduce it in my series.
