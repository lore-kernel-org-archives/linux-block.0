Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blk-mq: Revert "blk-mq: reimplement
 blk_mq_hw_queue_mapped"
To: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
Cc: Stefan Haberland <sth@linux.vnet.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
References: <20180411104744.21228-1-ming.lei@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <a508c4f5-92bb-23d4-e6cb-1bdaf1b69869@kernel.dk>
Date: Wed, 11 Apr 2018 07:59:45 -0600
MIME-Version: 1.0
In-Reply-To: <20180411104744.21228-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 4/11/18 4:47 AM, Ming Lei wrote:
> This reverts commit 127276c6ce5a30fcc806b7fe53015f4f89b62956.
> 
> When all CPUs of one hw queue become offline, there still may have IOs
> not completed from this hctx. But blk_mq_hw_queue_mapped() is called in
> blk_mq_queue_tag_busy_iter(), which is used for iterating request in timeout
> handler, timeout event will be missed on the inactive hctx, then request may
> never be completed.
> 
> Also the replementation of blk_mq_hw_queue_mapped() doesn't match the helper's
> name any more, and it should have been named as blk_mq_hw_queue_active().
> 
> Even other callers need further verification about this reimplemenation.
> 
> So revert this patch now, and we can improve hw queue activate/inactivate event
> after adequent researching and test.

Thanks, applied.

-- 
Jens Axboe
