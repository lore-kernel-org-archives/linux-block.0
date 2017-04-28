Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:1825 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1426200AbdD1PEm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Apr 2017 11:04:42 -0400
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>
CC: "hch@lst.de" <hch@lst.de>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
Subject: Re: [PATCH 4/7] blk-mq: add and export helper to tell if a request is
 reserved
Date: Fri, 28 Apr 2017 15:04:38 +0000
Message-ID: <1493391878.2767.1.camel@sandisk.com>
References: <1493391340-24629-1-git-send-email-axboe@fb.com>
         <1493391340-24629-5-git-send-email-axboe@fb.com>
In-Reply-To: <1493391340-24629-5-git-send-email-axboe@fb.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, 2017-04-28 at 08:55 -0600, Jens Axboe wrote:
> We only have an internal helper for checking a tag value. Add
> an exported helper that takes a request and hardware queue,
> and check against the driver tags.
>=20
> Signed-off-by: Jens Axboe <axboe@fb.com>
> ---
>  block/blk-mq-tag.c     | 6 ++++++
>  include/linux/blk-mq.h | 1 +
>  2 files changed, 7 insertions(+)
>=20
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index d0be72ccb091..0a04b5c14076 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -476,3 +476,9 @@ u32 blk_mq_unique_tag(struct request *rq)
>  		(rq->tag & BLK_MQ_UNIQUE_TAG_MASK);
>  }
>  EXPORT_SYMBOL(blk_mq_unique_tag);
> +
> +bool blk_mq_rq_is_reserved(struct blk_mq_hw_ctx *hctx, struct request *r=
q)
> +{
> +	return blk_mq_tag_is_reserved(hctx->tags, rq->tag);
> +}
> +EXPORT_SYMBOL_GPL(blk_mq_rq_is_reserved);
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index 32bd8eb5ba67..13e51520fa27 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -224,6 +224,7 @@ static inline u16 blk_mq_unique_tag_to_tag(u32 unique=
_tag)
>  	return unique_tag & BLK_MQ_UNIQUE_TAG_MASK;
>  }
> =20
> +bool blk_mq_rq_is_reserved(struct blk_mq_hw_ctx *hctx, struct request *r=
q);
> =20
>  int blk_mq_request_started(struct request *rq);
>  void blk_mq_start_request(struct request *rq);

Hello Jens,

Have you considered to derive the hctx information from rq->mq_ctx instead =
of
passing hctx as an argument (hctx =3D blk_mq_map_queue(rq->q, rq->mq_ctx->c=
pu))?
Anyway, since otherwise this patch looks fine to me:

Reviewed-by: Bart Van Assche <Bart.VanAssche@sandisk.com>=
