Return-Path: <BATV+0eb41a859d58214bb3da+5409+infradead.org+hch@bombadil.srs.infradead.org>
Date: Fri, 15 Jun 2018 00:30:35 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Hannes Reinecke <hare@suse.de>, linux-block@vger.kernel.org,
	Mel Gorman <mgorman@suse.com>, Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH] brd: Allow ramdisk to be allocated on selected NUMA node
Message-ID: <20180615073035.GA15535@infradead.org>
References: <20180614133832.110947-1-hare@suse.de>
 <08318d74-d81c-29e5-5350-525df96eaacb@kernel.dk>
 <20180614172954.79965d13@pentland.suse.de>
 <656e4ab7-7c5c-41af-5596-2e155ffb28e4@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <656e4ab7-7c5c-41af-5596-2e155ffb28e4@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Thu, Jun 14, 2018 at 09:33:35AM -0600, Jens Axboe wrote:
> Next question - what does the memory allocator do if we run out of
> memory on the given node? Should we punt to a different node if that
> happens? Slower, but functional, seems preferable to not being able
> to get memory.

When using alloc_pages_node the passed in node id is just a hint, the
allocator will use all avaiable memory if nedeed.
