Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-sn1nam02on0089.outbound.protection.outlook.com ([104.47.36.89]:36146
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750923AbdAMQj3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Jan 2017 11:39:29 -0500
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hare@suse.de" <hare@suse.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>
CC: "osandov@osandov.com" <osandov@osandov.com>
Subject: Re: [PATCH 08/10] blk-mq-sched: add framework for MQ capable IO
 schedulers
Date: Fri, 13 Jan 2017 16:39:21 +0000
Message-ID: <1484325542.2679.3.camel@sandisk.com>
References: <1484170803-9311-1-git-send-email-axboe@fb.com>
         <1484170803-9311-9-git-send-email-axboe@fb.com>
         <a4c0edfa-7cb1-2b0d-141d-2ea9e0fb07ca@suse.de>
In-Reply-To: <a4c0edfa-7cb1-2b0d-141d-2ea9e0fb07ca@suse.de>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, 2017-01-13 at 12:15 +0100, Hannes Reinecke wrote:
> On 01/11/2017 10:40 PM, Jens Axboe wrote:
> > This adds a set of hooks that intercepts the blk-mq path of
> > allocating/inserting/issuing/completing requests, allowing
> > us to develop a scheduler within that framework.
> >=20
> > We reuse the existing elevator scheduler API on the registration
> > side, but augment that with the scheduler flagging support for
> > the blk-mq interfce, and with a separate set of ops hooks for MQ
> > devices.
> >=20
> > We split driver and scheduler tags, so we can run the scheduling
> > independent of device queue depth.
> >=20
> > Signed-off-by: Jens Axboe <axboe@fb.com>
>=20
> [ .. ]
> > @@ -823,6 +847,35 @@ static inline unsigned int queued_to_index(unsigne=
d int queued)
> >  	return min(BLK_MQ_MAX_DISPATCH_ORDER - 1, ilog2(queued) + 1);
> >  }
> > =20
> > +static bool blk_mq_get_driver_tag(struct request *rq,
> > +				  struct blk_mq_hw_ctx **hctx, bool wait)
> > +{
> > +	struct blk_mq_alloc_data data =3D {
> > +		.q =3D rq->q,
> > +		.ctx =3D rq->mq_ctx,
> > +		.hctx =3D blk_mq_map_queue(rq->q, rq->mq_ctx->cpu),
> > +		.flags =3D wait ? 0 : BLK_MQ_REQ_NOWAIT,
> > +	};
> > +
> > +	if (blk_mq_hctx_stopped(data.hctx))
> > +		return false;
> > +
> > +	if (rq->tag !=3D -1) {
> > +done:
> > +		if (hctx)
> > +			*hctx =3D data.hctx;
> > +		return true;
> > +	}
> > +
> > +	rq->tag =3D blk_mq_get_tag(&data);
> > +	if (rq->tag >=3D 0) {
> > +		data.hctx->tags->rqs[rq->tag] =3D rq;
> > +		goto done;
> > +	}
> > +
> > +	return false;
> > +}
> > +
>=20
> What happens with the existing request at 'rqs[rq->tag]' ?
> Surely there is one already, right?
> Things like '->init_request' assume a fully populated array, so moving
> one entry to another location is ... interesting.
>=20
> I would have thought we need to do a request cloning here,
> otherwise this would introduce a memory leak, right?
> (Not to mention a potential double completion, as the request is now at
> two positions in the array)

Hello Hannes,

Have you noticed that there are two .rqs[] arrays - tags->rqs and
sched_tags->rqs[]? .init_request() loops over sched_tags->rqs[]. The
above assignment applies to tags->rqs[].

Bart.=
