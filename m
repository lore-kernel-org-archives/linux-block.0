Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:54774 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932837AbdGKVCS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Jul 2017 17:02:18 -0400
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH 4/6] blk-mq: use EWMA to estimate congestion threshold
Date: Tue, 11 Jul 2017 21:02:13 +0000
Message-ID: <1499806931.2586.40.camel@wdc.com>
References: <20170711182103.11461-1-ming.lei@redhat.com>
         <20170711182103.11461-5-ming.lei@redhat.com>
In-Reply-To: <20170711182103.11461-5-ming.lei@redhat.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, 2017-07-12 at 02:21 +0800, Ming Lei wrote:
> When .queue_rq() returns BLK_STS_RESOURCE(BUSY), we can
> consider that there is congestion in either low level
> driver or hardware.
>=20
> This patch uses EWMA to estimate this congestion threshold,
> then this threshold can be used to detect/avoid congestion.

Hello Ming,

Does EWMA stand for "exponentially weighted moving average" in the context =
of
this patch? If so, please mention this.

> +static void blk_mq_update_req_dispatch_busy(struct blk_mq_hw_ctx *hctx)
> +{
> +	struct sbitmap_queue *sbq;
> +	unsigned depth;
> +
> +	sbq =3D &hctx->tags->bitmap_tags;
> +	depth =3D sbitmap_weight(&sbq->sb);
> +
> +	/* use EWMA to estimate a threshold for detecting congestion */
> +	ewma_add(hctx->avg_busy_threshold, depth, 8, 0);
> +}

This function has been named after the context it is called from. Wouldn't =
it
be more clear to change the name of this function into something that refer=
s to
what this function does, e.g. blk_mq_update_avg_busy_threshold()?

Additionally, I think that the behavior of e.g. the SCSI and dm-mpath drive=
rs
is too complicated for this approach to be effective. If you want to procee=
d
with this approach I think it should be possible for block drivers to opt o=
ut
of the mechanism introduced in the next patch.

> diff --git a/block/blk-mq.h b/block/blk-mq.h
> index 60b01c0309bc..c4516d2a2d2c 100644
> --- a/block/blk-mq.h
> +++ b/block/blk-mq.h
> @@ -133,4 +133,13 @@ static inline bool blk_mq_hw_queue_mapped(struct blk=
_mq_hw_ctx *hctx)
>  	return hctx->nr_ctx && hctx->tags;
>  }
> =20
> +/* borrowed from bcache */
> +#define ewma_add(ewma, val, weight, factor)                             =
\
> +({                                                                      =
\
> +        (ewma) *=3D (weight) - 1;                                       =
  \
> +        (ewma) +=3D (val) << factor;                                    =
  \
> +        (ewma) /=3D (weight);                                           =
  \
> +        (ewma) >> factor;                                               =
\
> +})

Sorry but this does not match how others define an exponentially weighted m=
oving
average. As far as I know the ewma values should be updated as follows:

   new_ewma =3D w * val + (1 - w) * current_ewma

where 0 < w <=3D 1 is a rational number (typically 0.05 <=3D w <=3D 0.3). S=
ee also
https://en.wikipedia.org/wiki/EWMA_chart.

Bart.=
