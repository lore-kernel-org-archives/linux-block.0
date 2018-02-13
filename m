Return-Path: <sergey.senozhatsky.work@gmail.com>
Return-Path: <sergey.senozhatsky.work@gmail.com>
Date: Tue, 13 Feb 2018 17:54:15 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	"David S . Miller" <davem@davemloft.net>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Mike Snitzer <snitzer@redhat.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>,
	Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH] block: Move SECTOR_SIZE and SECTOR_SHIFT definitions
 into <linux/blkdev.h>
Message-ID: <20180213085415.GB1953@jagdpanzerIV>
References: <20180212190535.30057-1-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180212190535.30057-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On (02/12/18 11:05), Bart Van Assche wrote:
[..]
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index ac4740cf74be..cf17626604c2 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1026,14 +1026,25 @@ static inline int blk_rq_cur_bytes(const struct request *rq)
>  
>  extern unsigned int blk_rq_err_bytes(const struct request *rq);
>  
> +/*
> + * Variables of type sector_t represent an offset or size that is a multiple of
> + * 2**9 bytes. Hence these two constants.
> + */
> +#ifndef SECTOR_SHIFT
> +enum { SECTOR_SHIFT = 9 };
> +#endif
> +#ifndef SECTOR_SIZE
> +enum { SECTOR_SIZE = 512 };
> +#endif

Shouldn't SECTOR_SIZE depend on SECTOR_SHIFT?

1 << SECTOR_SHIFT

	-ss
