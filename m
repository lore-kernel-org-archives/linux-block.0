Return-Path: <sergey.senozhatsky.work@gmail.com>
Return-Path: <sergey.senozhatsky.work@gmail.com>
Date: Thu, 15 Mar 2018 16:59:46 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Mike Snitzer <snitzer@redhat.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>
Subject: Re: [PATCH v3, resend] block: Move SECTOR_SIZE and SECTOR_SHIFT
 definitions into <linux/blkdev.h>
Message-ID: <20180315075946.GE3628@jagdpanzerIV>
References: <20180314224806.22833-1-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180314224806.22833-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On (03/14/18 15:48), Bart Van Assche wrote:
> Note: the SECTOR_SIZE / SECTOR_SHIFT / SECTOR_BITS definitions have
> not been removed from uapi header files nor from NAND drivers in
> which these constants are used for another purpose than converting
> block layer offsets and sizes into a number of sectors.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
> Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>

FWIW,
Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
