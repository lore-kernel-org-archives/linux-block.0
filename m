Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:34316 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935955AbdEYR7l (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 May 2017 13:59:41 -0400
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "axboe@fb.com" <axboe@fb.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 0/7] blk-mq: fix queue quiescing
Date: Thu, 25 May 2017 17:59:38 +0000
Message-ID: <1495735177.2615.3.camel@sandisk.com>
References: <20170525042131.13172-1-ming.lei@redhat.com>
         <1495689892.3045.2.camel@sandisk.com> <20170525090917.GB15737@ming.t460p>
         <1495733047.2615.1.camel@sandisk.com>
         <cdfae246-d65e-fc49-69ec-dffe63832605@fb.com>
In-Reply-To: <cdfae246-d65e-fc49-69ec-dffe63832605@fb.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, 2017-05-25 at 11:42 -0600, Jens Axboe wrote:
> Why not make it
>=20
> 	/* Must be the last member - see also blk_mq_hw_ctx_size(). */
> 	struct srcu_struct	queue_rq_srcu[0];
>=20
> and fixup blk_mq_hw_ctx_size()
>=20
> static int blk_mq_hw_ctx_size(struct request_queue *q)
> {
> 	int size =3D sizeof(struct blk_mq_hw_ctx);
>=20
> 	if (q->tag_set->flags & BLK_MQ_F_BLOCKING)
> 		size +=3D sizeof(struct srcu_struct);
>=20
> 	return size;
> }
>=20
> I think that'd be cleaner. Keep the end-of-struct checking, just to be
> on the safe side.
>=20
> Neither one is super pretty though, and still doesn't fix the fact that
> the srcu_struct is _half_ the blk_mq_hw_ctx in total.

Hello Jens,

Making these changes seems like a good idea to me. I will make these change=
s
and post a patch.

Bart.=
