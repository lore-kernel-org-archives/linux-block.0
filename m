Return-Path: <hch@lst.de>
Date: Mon, 9 Apr 2018 12:05:17 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	Stefan Haberland <sth@linux.vnet.ibm.com>
Subject: Re: [PATCH 3/8] blk-mq: avoid to write intermediate result to
	hctx->next_cpu
Message-ID: <20180409100517.GC11144@lst.de>
References: <20180408094814.28953-1-ming.lei@redhat.com> <20180408094814.28953-4-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180408094814.28953-4-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

On Sun, Apr 08, 2018 at 05:48:09PM +0800, Ming Lei wrote:
> This patch figures out the final selected CPU, then writes
> it to hctx->next_cpu once, then we can avoid to intermediate
> next cpu observed from other dispatch paths.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
