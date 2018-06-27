Return-Path: <ming.lei@redhat.com>
Date: Thu, 28 Jun 2018 07:27:06 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Omar Sandoval <osandov@fb.com>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH v2] blk-mq: Fix a race condition in blk_mq_mark_tag_wait()
Message-ID: <20180627232705.GC7583@ming.t460p>
References: <20180627200212.14435-1-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180627200212.14435-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Jun 27, 2018 at 01:02:12PM -0700, Bart Van Assche wrote:
> Because the hctx lock is not held around the only
> blk_mq_tag_wakeup_all() call in the block layer, the wait queue
> entry removal in blk_mq_dispatch_wake() is protected by the wait
> queue lock only. Since the hctx->dispatch_wait entry can occur on
> any of the SBQ_WAIT_QUEUES, the wait queue presence check, adding
> .dispatch_wait to a wait queue and removing the wait queue entry
> must all be protected by both the hctx lock and the wait queue
> lock.

Actually we don't need to use hctx->lock for protecting
hctx->dispatch_wait, and one new lock of hctx->dispatch_wait_lock is
enough, please see the following patch:

	https://marc.info/?l=linux-block&m=152998658713265&w=2

Then we can avoid to disable irq when acquiring hctx->lock.


Thanks,
Ming
