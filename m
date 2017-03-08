Return-Path: <Umesh.Patel@wdc.com>
From: Umesh Patel <Umesh.Patel@wdc.com>
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: RE: BIO request larger than our storage device supports in linux
 kernel 4.x
Date: Wed, 8 Mar 2017 18:08:16 +0000
Message-ID: <CY1PR0401MB1353F97FF898FB07AB7E5AD3E12E0@CY1PR0401MB1353.namprd04.prod.outlook.com>
References: <CY1PR0401MB13538108F3DFD6738AFC8A34E12E0@CY1PR0401MB1353.namprd04.prod.outlook.com>
 <CY1PR0401MB1353279ED2A07E69F8ED42B5E12E0@CY1PR0401MB1353.namprd04.prod.outlook.com>
 <04c47362-2e9d-b32a-fb98-14113b45b6f7@kernel.dk>
In-Reply-To: <04c47362-2e9d-b32a-fb98-14113b45b6f7@kernel.dk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>


Yes. This is non-open driver for our Flash based PCI drive for enterprise s=
torage solution.

Some snippet of queue related code is below

struct request_queue *queue;

blk_queue_max_hw_sectors(dev->osdev.queue, (dev->aggr_max_size >> KERNEL_SE=
CTOR_SHIFT));
blk_queue_max_segments(dev->osdev.queue, BLK_MAX_SEGMENTS);
blk_queue_bounce_limit(dev->osdev.queue, BLK_BOUNCE_ANY);
blk_queue_logical_block_size(dev->osdev.queue, dev->hardsect_size);
blk_queue_physical_block_size(dev->osdev.queue, dev->hardsect_size);

dev->osdev.queue =3D blk_alloc_queue(GFP_KERNEL);

blk_queue_make_request(dev->osdev.queue, fmm_bdev_make_request_wrapper);

Here queue is part of our internal structure struct fmm_bdev *dev




-----Original Message-----
From: Jens Axboe [mailto:axboe@kernel.dk] =

Sent: Wednesday, March 8, 2017 8:35 PM
To: Umesh Patel; linux-block@vger.kernel.org
Subject: Re: BIO request larger than our storage device supports in linux k=
ernel 4.x

On 03/08/2017 02:34 AM, Umesh Patel wrote:
> Hello,
> =

> We are registering BIO size of our storage device through linux kernel =

> API blk_queue_max_hw_sectors worth of 104K. So max size of BIO that =

> our block device can handle is 104 KB but kernel block layer is =

> sending 256 KB worth of BIO which is more than we are supporting.
> This issue we are observing in 4.4 and also in latest 4.10.1 kernel =

> release. Until this we had not seen this issue.
> =

> From the kernel source code history I came to below things.  4.1 =

> kernel version onwards "nr_pages =3D min(sdio->pages_in_io, =

> bio_get_nr_vecs(map_bh->b_bdev))" has been removed which
> (bio_get_nr_vecs) was considering max_sectors_kb of queue which was
> 104 KB for our device.
> =

> Presently new code is something like "nr_pages =3D =

> min(sdio->pages_in_io, BIO_MAX_PAGES)" which is sending 256 KB
> (BIO_MAX_PAGES) of BIO size to our device which we are not supporting.
> =

> =

> So from some documentation I found out that 256 KB of bio size is the =

> fix (from 4.x kernel) and that has to support by any drive.  Please =

> let me know is there any way to change BIO size worth of 104 KB from
> 256 KB or any other way to register our BIO size with kernel or any =

> other area to look in to ?.

I'm assuming this is some not-open driver, and I'm also assuming that you a=
re bypassing the proper API and using make_request_fn. In which case you ar=
e missing a call to blk_queue_split().

--
Jens Axboe

Western Digital Corporation (and its subsidiaries) E-mail Confidentiality N=
otice & Disclaimer:

This e-mail and any files transmitted with it may contain confidential or l=
egally privileged information of WDC and/or its affiliates, and are intende=
d solely for the use of the individual or entity to which they are addresse=
d. If you are not the intended recipient, any disclosure, copying, distribu=
tion or any action taken or omitted to be taken in reliance on it, is prohi=
bited. If you have received this e-mail in error, please notify the sender =
immediately and delete the e-mail in its entirety from your system.
