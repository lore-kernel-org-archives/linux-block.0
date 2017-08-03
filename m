Return-Path: <Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>
CC: "brking@linux.vnet.ibm.com" <brking@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/4] blk-mq-tag: check for NULL rq when iterating tags
Date: Thu, 3 Aug 2017 20:29:02 +0000
Message-ID: <1501792140.2922.14.camel@wdc.com>
References: <1501790516-6924-1-git-send-email-axboe@kernel.dk>
	 <1501790516-6924-2-git-send-email-axboe@kernel.dk>
In-Reply-To: <1501790516-6924-2-git-send-email-axboe@kernel.dk>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Thu, 2017-08-03 at 14:01 -0600, Jens Axboe wrote:
> Since we introduced blk-mq-sched, the tags->rqs[] array has been
> dynamically assigned. So we need to check for NULL when iterating,
> since we could be racing with completion.
>=20
> This is perfectly safe, since the memory backing of the request is
> never going away while the device is alive. Only the pointer in
> ->rqs[] may be reset.
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

I agree with what you wrote in the description of this patch. However, sinc=
e
I have not yet found the code that clears tags->rqs[], would it be possible
to show me that code?

Thanks,

Bart.
