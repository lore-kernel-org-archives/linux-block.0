Return-Path: <hch@lst.de>
Date: Mon, 9 Apr 2018 12:04:05 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	Stefan Haberland <sth@linux.vnet.ibm.com>, stable@vger.kernel.org
Subject: Re: [PATCH 1/8] blk-mq: make sure that correct hctx->next_cpu is
	set
Message-ID: <20180409100405.GA11144@lst.de>
References: <20180408094814.28953-1-ming.lei@redhat.com> <20180408094814.28953-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180408094814.28953-2-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

On Sun, Apr 08, 2018 at 05:48:07PM +0800, Ming Lei wrote:
> >From commit 20e4d81393196 (blk-mq: simplify queue mapping & schedule
> with each possisble CPU), one hctx can be mapped from all offline CPUs,
> then hctx->next_cpu can be set as wrong.
> 
> This patch fixes this issue by making hctx->next_cpu pointing to the
> first CPU in hctx->cpumask if all CPUs in hctx->cpumask are offline.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
