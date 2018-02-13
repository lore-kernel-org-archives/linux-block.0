Return-Path: <jthumshirn@suse.de>
Message-ID: <1518511392.3592.4.camel@suse.de>
Subject: Re: [PATCH] block: Move SECTOR_SIZE and SECTOR_SHIFT definitions
 into <linux/blkdev.h>
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Bart Van Assche <bart.vanassche@wdc.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>, "David S .
 Miller" <davem@davemloft.net>, "Martin K . Petersen"
 <martin.petersen@oracle.com>, Mike Snitzer <snitzer@redhat.com>, Dan
 Williams <dan.j.williams@intel.com>, Minchan Kim <minchan@kernel.org>,
 Nitin Gupta <ngupta@vflare.org>, Sergey Senozhatsky
 <sergey.senozhatsky.work@gmail.com>
Date: Tue, 13 Feb 2018 09:43:12 +0100
In-Reply-To: <20180212190535.30057-1-bart.vanassche@wdc.com>
References: <20180212190535.30057-1-bart.vanassche@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Mon, 2018-02-12 at 11:05 -0800, Bart Van Assche wrote:
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index ac4740cf74be..cf17626604c2 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1026,14 +1026,25 @@ static inline int blk_rq_cur_bytes(const
> struct request *rq)
>  
>  extern unsigned int blk_rq_err_bytes(const struct request *rq);
>  
> +/*
> + * Variables of type sector_t represent an offset or size that is a
> multiple of
> + * 2**9 bytes. Hence these two constants.
> + */
> +#ifndef SECTOR_SHIFT
> +enum { SECTOR_SHIFT = 9 };
> +#endif
> +#ifndef SECTOR_SIZE
> +enum { SECTOR_SIZE = 512 };
> +#endif

Can you please make a #define out of these enums? I know gdb can cope
better with enums than defines but IIRC adding -ggdb3 to the CFLAGS
solves this issue.

Apart from that:
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>

-- 
Johannes Thumshirn                                          Storage
jthu
mshirn@suse.de                                +49 911 74053 689
SUSE
LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Jane
Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38
9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
