Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: bvec_nr_vecs() returns value for wrong slab
To: Greg Edwards <gedwards@ddn.com>, linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
References: <20180808192753.817-1-gedwards@ddn.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <744cd24e-de0b-30b4-e0e2-e1570d0f80e1@kernel.dk>
Date: Thu, 9 Aug 2018 08:28:29 -0600
MIME-Version: 1.0
In-Reply-To: <20180808192753.817-1-gedwards@ddn.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 8/8/18 1:27 PM, Greg Edwards wrote:
> In commit ed996a52c868 ("block: simplify and cleanup bvec pool
> handling"), the value of the slab index is incremented by one in
> bvec_alloc() after the allocation is done to indicate an index value of
> 0 does not need to be later freed.
> 
> bvec_nr_vecs() was not updated accordingly, and thus returns the wrong
> value.  Decrement idx before performing the lookup.

Applied, thanks.

-- 
Jens Axboe
