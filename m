Return-Path: <hch@lst.de>
Date: Mon, 9 Apr 2018 12:07:32 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	Stefan Haberland <sth@linux.vnet.ibm.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 6/8] blk-mq: don't check queue mapped in
	__blk_mq_delay_run_hw_queue()
Message-ID: <20180409100732.GF11144@lst.de>
References: <20180408094814.28953-1-ming.lei@redhat.com> <20180408094814.28953-7-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180408094814.28953-7-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

On Sun, Apr 08, 2018 at 05:48:12PM +0800, Ming Lei wrote:
> There are several reasons for removing the check:
> 
> 1) blk_mq_hw_queue_mapped() returns true always now since each hctx
> may be mapped by one CPU at least

Sounds like we should remove it, then..

The patch looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
