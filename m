Return-Path: <tom.leiming@gmail.com>
MIME-Version: 1.0
In-Reply-To: <tencent_47349987636D0D2B620828E0@qq.com>
References: <tencent_47349987636D0D2B620828E0@qq.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Fri, 18 May 2018 22:00:51 +0800
Message-ID: <CACVXFVNK2WZkhXpXX4yEzZMgMf5hB8d4Umqd8j6XShp9iBvTqA@mail.gmail.com>
Subject: Re: blk-mq: make sure that correct hctx->dispatch_from is set
To: =?UTF-8?B?6IOh5rW3?= <huhai@kylinos.cn>
Cc: axboe <axboe@kernel.dk>, "ming.lei" <ming.lei@redhat.com>,
	linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Fri, May 18, 2018 at 9:42 PM, =E8=83=A1=E6=B5=B7 <huhai@kylinos.cn> wrot=
e:
> Author: huhai <huhai@kylinos.cn>
> Date:   Fri May 18 17:09:56 2018 +0800
>
>     blk-mq: make sure that correct hctx->dispatch_from is set
>
>     When the number of hardware queues is changed, the drivers will call
>     blk_mq_update_nr_hw_queues() to remap hardware queues, and then
>     the ctx mapped on hctx will also change, but the current code forgets=
 to
>     make sure that correct hctx->dispatch_from is set, and hctx->dispatch=
_from
>     may point to a ctx that does not belong to the current hctx.
>
>     Signed-off-by: huhai <huhai@kylinos.cn>
>
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 2545081..55d8a3d 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2214,6 +2214,8 @@ static void blk_mq_map_swqueue(struct request_queue=
 *q)
>                 hctx->tags =3D set->tags[i];
>                 WARN_ON(!hctx->tags);
>
> +               hctx->dispatch_from =3D NULL;
> +
>                 /*
>                  * Set the map size to the number of mapped software queu=
es.
>                  * This is more accurate and more efficient than looping

Good catch,

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming Lei
