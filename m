Return-Path: <Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>
CC: "brking@linux.vnet.ibm.com" <brking@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/6] blk-mq-tag: check for NULL rq when iterating tags
Date: Fri, 4 Aug 2017 19:34:38 +0000
Message-ID: <1501875276.2757.23.camel@wdc.com>
References: <1501859062-11120-1-git-send-email-axboe@kernel.dk>
	 <1501859062-11120-2-git-send-email-axboe@kernel.dk>
In-Reply-To: <1501859062-11120-2-git-send-email-axboe@kernel.dk>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Fri, 2017-08-04 at 09:04 -0600, Jens Axboe wrote:
> Since we introduced blk-mq-sched, the tags->rqs[] array has been
> dynamically assigned. So we need to check for NULL when iterating,
> since there's a window of time where the bit is set, but we haven't
> dynamically assigned the tags->rqs[] array position yet.
>=20
> This is perfectly safe, since the memory backing of the request is
> never going away while the device is alive.
>=20
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  block/blk-mq-tag.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index d0be72ccb091..b856b2827157 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -214,7 +214,7 @@ static bool bt_iter(struct sbitmap *bitmap, unsigned =
int bitnr, void *data)
>  		bitnr +=3D tags->nr_reserved_tags;
>  	rq =3D tags->rqs[bitnr];
> =20
> -	if (rq->q =3D=3D hctx->queue)
> +	if (rq && rq->q =3D=3D hctx->queue)
>  		iter_data->fn(hctx, rq, iter_data->data, reserved);
>  	return true;
>  }
> @@ -249,8 +249,8 @@ static bool bt_tags_iter(struct sbitmap *bitmap, unsi=
gned int bitnr, void *data)
>  	if (!reserved)
>  		bitnr +=3D tags->nr_reserved_tags;
>  	rq =3D tags->rqs[bitnr];
> -
> -	iter_data->fn(rq, iter_data->data, reserved);
> +	if (rq)
> +		iter_data->fn(rq, iter_data->data, reserved);
>  	return true;
>  }

Hello Jens,

Should it have been mentioned in the patch description or in a comment that
these functions can read tags->rqs[] after the corresponding bit has been s=
et
in the bitmap but before the tags->rqs[] pointer is updated?

Anyway:

Reviewed-by: Bart Van Assche <bart.vanassche@wdc.com>
