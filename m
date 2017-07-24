Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] xen-blkfront: Fix handling of non-supported operations
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
 xen-devel@lists.xenproject.org, stable@vger.kernel.org
References: <20170721171110.824-1-bart.vanassche@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <f744ebdd-654c-1d6e-d977-28d2a4ce7be9@kernel.dk>
Date: Mon, 24 Jul 2017 08:46:08 -0600
MIME-Version: 1.0
In-Reply-To: <20170721171110.824-1-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 07/21/2017 11:11 AM, Bart Van Assche wrote:
> This patch fixes the following sparse warnings:
> 
> drivers/block/xen-blkfront.c:916:45: warning: incorrect type in argument 2 (different base types)
> drivers/block/xen-blkfront.c:916:45:    expected restricted blk_status_t [usertype] error
> drivers/block/xen-blkfront.c:916:45:    got int [signed] error
> drivers/block/xen-blkfront.c:1599:47: warning: incorrect type in assignment (different base types)
> drivers/block/xen-blkfront.c:1599:47:    expected int [signed] error
> drivers/block/xen-blkfront.c:1599:47:    got restricted blk_status_t [usertype] <noident>
> drivers/block/xen-blkfront.c:1607:55: warning: incorrect type in assignment (different base types)
> drivers/block/xen-blkfront.c:1607:55:    expected int [signed] error
> drivers/block/xen-blkfront.c:1607:55:    got restricted blk_status_t [usertype] <noident>
> drivers/block/xen-blkfront.c:1625:55: warning: incorrect type in assignment (different base types)
> drivers/block/xen-blkfront.c:1625:55:    expected int [signed] error
> drivers/block/xen-blkfront.c:1625:55:    got restricted blk_status_t [usertype] <noident>
> drivers/block/xen-blkfront.c:1628:62: warning: restricted blk_status_t degrades to integer
> 
> Compile-tested only.

Applied, but I killed your stable tag. Why did you add that?

-- 
Jens Axboe
