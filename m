Return-Path: <axboe@kernel.dk>
Subject: Re: BIO request larger than our storage device supports in linux
 kernel 4.x
To: Umesh Patel <Umesh.Patel@wdc.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <CY1PR0401MB13538108F3DFD6738AFC8A34E12E0@CY1PR0401MB1353.namprd04.prod.outlook.com>
 <CY1PR0401MB1353279ED2A07E69F8ED42B5E12E0@CY1PR0401MB1353.namprd04.prod.outlook.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <04c47362-2e9d-b32a-fb98-14113b45b6f7@kernel.dk>
Date: Wed, 8 Mar 2017 08:04:56 -0700
MIME-Version: 1.0
In-Reply-To: <CY1PR0401MB1353279ED2A07E69F8ED42B5E12E0@CY1PR0401MB1353.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 03/08/2017 02:34 AM, Umesh Patel wrote:
> Hello,
> 
> We are registering BIO size of our storage device through linux kernel
> API blk_queue_max_hw_sectors worth of 104K. So max size of BIO that
> our block device can handle is 104 KB but kernel block layer is
> sending 256 KB worth of BIO which is more than we are supporting.
> This issue we are observing in 4.4 and also in latest 4.10.1 kernel
> release. Until this we had not seen this issue.
> 
> From the kernel source code history I came to below things.  4.1
> kernel version onwards "nr_pages = min(sdio->pages_in_io,
> bio_get_nr_vecs(map_bh->b_bdev))" has been removed which
> (bio_get_nr_vecs) was considering max_sectors_kb of queue which was
> 104 KB for our device.
> 
> Presently new code is something like "nr_pages =
> min(sdio->pages_in_io, BIO_MAX_PAGES)" which is sending 256 KB
> (BIO_MAX_PAGES) of BIO size to our device which we are not supporting.
> 
> 
> So from some documentation I found out that 256 KB of bio size is the
> fix (from 4.x kernel) and that has to support by any drive.  Please
> let me know is there any way to change BIO size worth of 104 KB from
> 256 KB or any other way to register our BIO size with kernel or any
> other area to look in to ?. 

I'm assuming this is some not-open driver, and I'm also assuming that
you are bypassing the proper API and using make_request_fn. In which
case you are missing a call to blk_queue_split().

-- 
Jens Axboe
