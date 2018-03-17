Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v3, resend] block: Move SECTOR_SIZE and SECTOR_SHIFT
 definitions into <linux/blkdev.h>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, Mike Snitzer <snitzer@redhat.com>,
 Dan Williams <dan.j.williams@intel.com>, Minchan Kim <minchan@kernel.org>,
 Nitin Gupta <ngupta@vflare.org>
References: <20180314224806.22833-1-bart.vanassche@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <47ddf2ad-056f-3cfb-ac04-b4a11251b183@kernel.dk>
Date: Sat, 17 Mar 2018 13:45:54 -0700
MIME-Version: 1.0
In-Reply-To: <20180314224806.22833-1-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 3/14/18 3:48 PM, Bart Van Assche wrote:
> It happens often while I'm preparing a patch for a block driver that
> I'm wondering: is a definition of SECTOR_SIZE and/or SECTOR_SHIFT
> available for this driver? Do I have to introduce definitions of these
> constants before I can use these constants? To avoid this confusion,
> move the existing definitions of SECTOR_SIZE and SECTOR_SHIFT into the
> <linux/blkdev.h> header file such that these become available for all
> block drivers. Make the SECTOR_SIZE definition in the uapi msdos_fs.h
> header file conditional to avoid that including that header file after
> <linux/blkdev.h> causes the compiler to complain about a SECTOR_SIZE
> redefinition.
> 
> Note: the SECTOR_SIZE / SECTOR_SHIFT / SECTOR_BITS definitions have
> not been removed from uapi header files nor from NAND drivers in
> which these constants are used for another purpose than converting
> block layer offsets and sizes into a number of sectors.

Applied, thanks Bart.

-- 
Jens Axboe
