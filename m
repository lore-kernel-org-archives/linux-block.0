Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:31857 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933878AbdDESgC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Apr 2017 14:36:02 -0400
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "osandov@osandov.com" <osandov@osandov.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>
CC: "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH v2 8/8] blk-mq: clean up direct issue blk_mq_queue_data
 initialization
Date: Wed, 5 Apr 2017 18:35:58 +0000
Message-ID: <1491417357.2787.13.camel@sandisk.com>
References: <cover.1491416593.git.osandov@fb.com>
         <e0eac74e541e9f85403fd4cf887a7f288768f00e.1491416593.git.osandov@fb.com>
In-Reply-To: <e0eac74e541e9f85403fd4cf887a7f288768f00e.1491416593.git.osandov@fb.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, 2017-04-05 at 11:28 -0700, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
>=20
> Trivial cleanup.
>=20
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>  block/blk-mq.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 71dc8608f3a8..779249a5999b 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1451,8 +1451,7 @@ static void __blk_mq_try_issue_directly(struct requ=
est *rq, blk_qc_t *cookie,
>  	struct request_queue *q =3D rq->q;
>  	struct blk_mq_queue_data bd =3D {
>  		.rq =3D rq,
> -		.list =3D NULL,
> -		.last =3D 1
> +		.last =3D true,
>  	};
>  	struct blk_mq_hw_ctx *hctx;
>  	blk_qc_t new_cookie;

Hello Omar,

Although this patch looks fine to me I'm afraid that since this morning
it no longer applies to Jens' for-next branch.

Bart.=
