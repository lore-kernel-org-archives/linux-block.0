Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: fix unintended fallthrough in
 generic_make_request_checks()
To: Nicolai Stange <nicstange@gmail.com>
References: <20161204135639.7016-1-nicstange@gmail.com>
Cc: Chaitanya Kulkarni <chaitanya.kulkarni@hgst.com>,
 Shaun Tancheff <shaun.tancheff@seagate.com>,
 Damien Le Moal <damien.lemoal@hgst.com>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <23525ed3-2a62-7d61-954c-084b891daced@kernel.dk>
Date: Mon, 5 Dec 2016 07:55:09 -0700
MIME-Version: 1.0
In-Reply-To: <20161204135639.7016-1-nicstange@gmail.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 12/04/2016 06:56 AM, Nicolai Stange wrote:
> Since commit e73c23ff736e ("block: add async variant of
> blkdev_issue_zeroout") messages like the following show up:
> 
>   EXT4-fs (dm-1): Delayed block allocation failed for inode 2368848 at
>                   logical offset 0 with max blocks 1 with error 95
>   EXT4-fs (dm-1): This should not happen!! Data will be lost
> 
> Due to the following fallthrough introduced with
> commit 2d253440b5af ("block: Define zoned block device operations"),
> generic_make_request_checks() would accept a REQ_OP_WRITE_SAME bio only
> if the block device supports "write same" *and* is a zoned one:
> 
>   switch (bio_op(bio)) {
>   [...]
>   case REQ_OP_WRITE_SAME:
>         if (!bdev_write_same(bio->bi_bdev))
>                 goto not_supported;
>   case REQ_OP_ZONE_REPORT:
>   case REQ_OP_ZONE_RESET:
>                 if (!bdev_is_zoned(bio->bi_bdev))
>                         goto not_supported;
>                 break;
>   [...]
>   }
> 
> Thus, although the bio setup as done by __blkdev_issue_write_same() from
> commit e73c23ff736e ("block: add async variant of blkdev_issue_zeroout")
> would succeed, its actual submission would not, resulting in the
> EOPNOTSUPP == 95.
> 
> Fix this by removing the fallthrough which, due to the lack of an explicit
> comment, seems to be unintended anyway.
> 
> Fixes: e73c23ff736e ("block: add async variant of blkdev_issue_zeroout")
> Fixes: 2d253440b5af ("block: Define zoned block device operations")
> Signed-off-by: Nicolai Stange <nicstange@gmail.com>

Added, thanks.

-- 
Jens Axboe
