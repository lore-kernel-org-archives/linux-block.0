Return-Path: <axboe@kernel.dk>
Subject: Re: BIO request larger than our storage device supports in linux
 kernel 4.x
To: Umesh Patel <Umesh.Patel@wdc.com>, Christoph Hellwig <hch@infradead.org>
References: <CY1PR0401MB13538108F3DFD6738AFC8A34E12E0@CY1PR0401MB1353.namprd04.prod.outlook.com>
 <CY1PR0401MB1353279ED2A07E69F8ED42B5E12E0@CY1PR0401MB1353.namprd04.prod.outlook.com>
 <04c47362-2e9d-b32a-fb98-14113b45b6f7@kernel.dk>
 <CY1PR0401MB1353F97FF898FB07AB7E5AD3E12E0@CY1PR0401MB1353.namprd04.prod.outlook.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <211c3042-5f72-def6-4ede-510fa99ef683@kernel.dk>
Date: Wed, 8 Mar 2017 11:13:36 -0700
MIME-Version: 1.0
In-Reply-To: <CY1PR0401MB1353F97FF898FB07AB7E5AD3E12E0@CY1PR0401MB1353.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 03/08/2017 11:08 AM, Umesh Patel wrote:
> 
> Yes. This is non-open driver for our Flash based PCI drive for enterprise storage solution.

Please don't top post.

> Some snippet of queue related code is below
> 
> struct request_queue *queue;
> 
> blk_queue_max_hw_sectors(dev->osdev.queue, (dev->aggr_max_size >> KERNEL_SECTOR_SHIFT));
> blk_queue_max_segments(dev->osdev.queue, BLK_MAX_SEGMENTS);
> blk_queue_bounce_limit(dev->osdev.queue, BLK_BOUNCE_ANY);
> blk_queue_logical_block_size(dev->osdev.queue, dev->hardsect_size);
> blk_queue_physical_block_size(dev->osdev.queue, dev->hardsect_size);
> 
> dev->osdev.queue = blk_alloc_queue(GFP_KERNEL);
> 
> blk_queue_make_request(dev->osdev.queue, fmm_bdev_make_request_wrapper);
> 
> Here queue is part of our internal structure struct fmm_bdev *dev

You are doing it wrong, you should be writing this as a blk-mq driver.
Not only would that fix your issue, it would also solve a host of other
issues that I'm sure your driver has since it hasn't even been
reviewed.

Generally, I have very little interest in providing support for non
open drivers. Scratch that, no interest.

-- 
Jens Axboe
