Return-Path: <hch@lst.de>
Date: Mon, 9 Apr 2018 12:08:02 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	Stefan Haberland <sth@linux.vnet.ibm.com>
Subject: Re: [PATCH 7/8] blk-mq: reimplement blk_mq_hw_queue_mapped
Message-ID: <20180409100802.GG11144@lst.de>
References: <20180408094814.28953-1-ming.lei@redhat.com> <20180408094814.28953-8-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180408094814.28953-8-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

On Sun, Apr 08, 2018 at 05:48:13PM +0800, Ming Lei wrote:
> Now the actual meaning of queue mapped is that if there is any online
> CPU mapped to this hctx, so implement blk_mq_hw_queue_mapped() in this
> way.

Reviewed-by: Christoph Hellwig <hch@lst.de>
