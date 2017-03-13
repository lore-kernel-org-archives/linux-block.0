Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "hch@lst.de" <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 1/4] blk-mq: remove BLK_MQ_F_DEFER_ISSUE
Date: Mon, 13 Mar 2017 20:52:54 +0000
Message-ID: <1489438361.2658.21.camel@sandisk.com>
References: <20170313154833.14165-1-hch@lst.de>
	 <20170313154833.14165-2-hch@lst.de>
In-Reply-To: <20170313154833.14165-2-hch@lst.de>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

On Mon, 2017-03-13 at 09:48 -0600, Christoph Hellwig wrote:
> This flag was never used since it was introduced.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-mq.c         | 8 +-------
>  include/linux/blk-mq.h | 1 -
>  2 files changed, 1 insertion(+), 8 deletions(-)
>=20
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 159187a28d66..acf0ddf4af52 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1534,13 +1534,7 @@ static blk_qc_t blk_mq_make_request(struct request=
_queue *q, struct bio *bio)
>  	}
> =20
>  	plug =3D current->plug;
> -	/*
> -	 * If the driver supports defer issued based on 'last', then
> -	 * queue it up like normal since we can potentially save some
> -	 * CPU this way.
> -	 */
> -	if (((plug && !blk_queue_nomerges(q)) || is_sync) &&
> -	    !(data.hctx->flags & BLK_MQ_F_DEFER_ISSUE)) {
> +	if (((plug && !blk_queue_nomerges(q)) || is_sync)) {

A minor comment: due to this change the outer pair of parentheses
became superfluous. Please consider removing these.

Thanks,

Bart.=
