Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] brd: Allow ramdisk to be allocated on selected NUMA node
To: Christoph Hellwig <hch@infradead.org>
Cc: Hannes Reinecke <hare@suse.de>, linux-block@vger.kernel.org,
 Mel Gorman <mgorman@suse.com>, Hannes Reinecke <hare@suse.com>
References: <20180614133832.110947-1-hare@suse.de>
 <08318d74-d81c-29e5-5350-525df96eaacb@kernel.dk>
 <20180614172954.79965d13@pentland.suse.de>
 <656e4ab7-7c5c-41af-5596-2e155ffb28e4@kernel.dk>
 <20180615073035.GA15535@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <697e4c1a-3858-d14a-5c01-1ccd0cfd3c00@kernel.dk>
Date: Fri, 15 Jun 2018 08:12:29 -0600
MIME-Version: 1.0
In-Reply-To: <20180615073035.GA15535@infradead.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 6/15/18 1:30 AM, Christoph Hellwig wrote:
> On Thu, Jun 14, 2018 at 09:33:35AM -0600, Jens Axboe wrote:
>> Next question - what does the memory allocator do if we run out of
>> memory on the given node? Should we punt to a different node if that
>> happens? Slower, but functional, seems preferable to not being able
>> to get memory.
> 
> When using alloc_pages_node the passed in node id is just a hint, the
> allocator will use all avaiable memory if nedeed.

OK good, that's not a concern then.

-- 
Jens Axboe
