Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH] blk-mq-sched: add might_sleep() check for flush/fua
 insert
Date: Thu, 20 Apr 2017 23:20:53 +0000
Message-ID: <1492730452.2642.17.camel@sandisk.com>
References: <cd6d3a9a-8f6d-1cf8-6379-51de69544c1d@kernel.dk>
	 <1492729028.2642.16.camel@sandisk.com>
	 <a31e70b9-0a9a-44bc-fefa-ac317b4e095b@kernel.dk>
In-Reply-To: <a31e70b9-0a9a-44bc-fefa-ac317b4e095b@kernel.dk>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Thu, 2017-04-20 at 17:09 -0600, Jens Axboe wrote:
> From: Jens Axboe <axboe@fb.com>
> Subject: [PATCH] blk-mq: add might_sleep check to blk_mq_get_driver_tag()
>=20
> If the caller passes in wait=3Dtrue, it has to be able to block
> for a driver tag. We just had a bug where flush insertion
> would block on tag allocation, while we had preempt disabled.
> Ensure that we catch cases like that earlier next time.
>=20
> Signed-off-by: Jens Axboe <axboe@fb.com>
>=20
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 992f09772f8a..dd6e5dd62804 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -866,6 +866,8 @@ bool blk_mq_get_driver_tag(struct request *rq, struct=
 blk_mq_hw_ctx **hctx,
>  		.flags =3D wait ? 0 : BLK_MQ_REQ_NOWAIT,
>  	};
> =20
> +	might_sleep_if(wait);
> +
>  	if (rq->tag !=3D -1)
>  		goto done;
> =20
>=20

Thanks!

Reviewed-by: Bart Van Assche <Bart.VanAssche@sandisk.com>=
