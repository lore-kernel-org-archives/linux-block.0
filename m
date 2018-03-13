Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v2] block: bio_check_eod() needs to consider partition
To: Christoph Hellwig <hch@lst.de>
Cc: jiufei.xue@linux.alibaba.com, linux-block@vger.kernel.org
References: <20180313091819.26881-1-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <7c4181b7-788f-bf90-8397-c09beceedcb7@kernel.dk>
Date: Tue, 13 Mar 2018 07:49:06 -0700
MIME-Version: 1.0
In-Reply-To: <20180313091819.26881-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 3/13/18 2:18 AM, Christoph Hellwig wrote:
> bio_check_eod() should check partiton size not the whole disk if
> bio->bi_partno is non-zero.  Does this by taking the call to bio_check_eod
> into blk_partition_remap.

Applied, thanks.

-- 
Jens Axboe
