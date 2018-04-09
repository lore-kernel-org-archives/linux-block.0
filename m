Return-Path: <hch@lst.de>
Date: Mon, 9 Apr 2018 12:06:11 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	Stefan Haberland <sth@linux.vnet.ibm.com>
Subject: Re: [PATCH 4/8] blk-mq: introduce blk_mq_hw_queue_first_cpu() to
	figure out first cpu
Message-ID: <20180409100611.GD11144@lst.de>
References: <20180408094814.28953-1-ming.lei@redhat.com> <20180408094814.28953-5-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180408094814.28953-5-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

On Sun, Apr 08, 2018 at 05:48:10PM +0800, Ming Lei wrote:
> This patch introduces helper of blk_mq_hw_queue_first_cpu() for
> figuring out the hctx's first cpu, and code duplication can be
> avoided.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
