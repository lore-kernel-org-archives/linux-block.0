Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v3] block: bio_check_eod() needs to consider partitions
To: Christoph Hellwig <hch@lst.de>
Cc: jiufei.xue@linux.alibaba.com, Bart.VanAssche@wdc.com,
 linux-block@vger.kernel.org
References: <20180314155653.14861-1-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <1c71fb44-85a3-1d44-9818-e89efda15fad@kernel.dk>
Date: Sat, 17 Mar 2018 13:48:37 -0700
MIME-Version: 1.0
In-Reply-To: <20180314155653.14861-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 3/14/18 8:56 AM, Christoph Hellwig wrote:
> bio_check_eod() should check partiton size not the whole disk if
> bio->bi_partno is non-zero.  Does this by taking the call to bio_check_eod
> into blk_partition_remap.

Applied, thanks. I re-wrote your changelog again, it has typos and grammar
errors.

-- 
Jens Axboe
