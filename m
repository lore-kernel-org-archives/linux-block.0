Return-Path: <hch@lst.de>
Date: Mon, 9 Apr 2018 12:09:13 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	Stefan Haberland <sth@linux.vnet.ibm.com>
Subject: Re: [PATCH 8/8] blk-mq: remove code for dealing with remapping
	queue
Message-ID: <20180409100913.GH11144@lst.de>
References: <20180408094814.28953-1-ming.lei@redhat.com> <20180408094814.28953-9-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180408094814.28953-9-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

On Sun, Apr 08, 2018 at 05:48:14PM +0800, Ming Lei wrote:
> Firstly, from commit 4b855ad37194 ("blk-mq: Create hctx for each present CPU),
> blk-mq doesn't remap queue any more after CPU topo is changed.
> 
> Secondly, set->nr_hw_queues can't be bigger than nr_cpu_ids, and now we map
> all possible CPUs to hw queues, so at least one CPU is mapped to each hctx.
> 
> So queue mapping has became static and fixed just like percpu variable, and
> we don't need to handle queue remapping any more.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
