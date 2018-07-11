Return-Path: <hch@lst.de>
Date: Wed, 11 Jul 2018 08:37:16 +0200
From: Christoph Hellwig <hch@lst.de>
To: Tony Battersby <tonyb@cybernetics.com>
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	linux-scsi <linux-scsi@vger.kernel.org>,
	linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH] bsg: fix bogus EINVAL on non-data commands
Message-ID: <20180711063716.GA7934@lst.de>
References: <7730dcb2-7e69-3fc5-7eeb-4bbcf5091f14@cybernetics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7730dcb2-7e69-3fc5-7eeb-4bbcf5091f14@cybernetics.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Jul 10, 2018 at 12:52:24PM -0400, Tony Battersby wrote:
> Fix a regression introduced in Linux kernel 4.17 where sending a SCSI
> command that does not transfer data (such as TEST UNIT READY) via
> /dev/bsg/* results in EINVAL.
> 
> Fixes: 17cb960f29c2 ("bsg: split handling of SCSI CDBs vs transport requeues")
> Cc: <stable@vger.kernel.org> # 4.17+
> Signed-off-by: Tony Battersby <tonyb@cybernetics.com>
> ---
> diff --git a/block/bsg.c b/block/bsg.c
> index 66602c4..b16ab6f 100644
> --- a/block/bsg.c
> +++ b/block/bsg.c
> @@ -268,7 +268,7 @@ bsg_map_hdr(struct request_queue *q, str
>  		ret = blk_rq_map_user(q, rq, NULL, uptr64(hdr->din_xferp),
>  				hdr->din_xfer_len, GFP_KERNEL);
>  	} else {
> -		ret = blk_rq_map_user(q, rq, NULL, NULL, 0, GFP_KERNEL);
> +		ret = 0;
>  	}

We can remove the else branch entirely as ret already is 0 here.

Otherwise this looks fine and restores the previous behavior:

Reviewed-by: Christoph Hellwig <hch@lst.de>
