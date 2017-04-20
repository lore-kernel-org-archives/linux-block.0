Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:11505 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031654AbdDTW5R (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Apr 2017 18:57:17 -0400
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH] blk-mq-sched: add might_sleep() check for flush/fua
 insert
Date: Thu, 20 Apr 2017 22:57:13 +0000
Message-ID: <1492729028.2642.16.camel@sandisk.com>
References: <cd6d3a9a-8f6d-1cf8-6379-51de69544c1d@kernel.dk>
In-Reply-To: <cd6d3a9a-8f6d-1cf8-6379-51de69544c1d@kernel.dk>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, 2017-04-20 at 16:45 -0600, Jens Axboe wrote:
> If we're doing a flush/fua insert, insertion might block on getting
> a driver tag, if can_block =3D=3D true. Add a might_sleep check for that,
> since we just had a bug like that. This will help us catch a similar
> issue quicker in the future.
>=20
> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> index 9e3c0f92851b..57aec8462e93 100644
> --- a/block/blk-mq-sched.c
> +++ b/block/blk-mq-sched.c
> @@ -372,6 +372,7 @@ void blk_mq_sched_insert_request(struct request *rq, =
bool at_head,
>  	struct blk_mq_hw_ctx *hctx =3D blk_mq_map_queue(q, ctx->cpu);
> =20
>  	if (rq->tag =3D=3D -1 && op_is_flush(rq->cmd_flags)) {
> +		might_sleep_if(can_block);
>  		blk_mq_sched_insert_flush(hctx, rq, can_block);
>  		return;
>  	}

Hello Jens,

The above patch looks fine to me. But seeing that patch made me wonder
whether it would be useful to move that might_sleep_if() call into
blk_mq_get_driver_tag() such that if ever an additional call to
blk_mq_get_driver_tag() is added that might sleep would also be covered?

Bart.=
