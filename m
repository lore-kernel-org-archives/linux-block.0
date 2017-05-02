Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "osandov@osandov.com" <osandov@osandov.com>
CC: "hare@suse.com" <hare@suse.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "osandov@fb.com" <osandov@fb.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH 5/6] blk-mq-debugfs: Show busy requests
Date: Tue, 2 May 2017 16:13:15 +0000
Message-ID: <1493741594.2552.4.camel@sandisk.com>
References: <20170427155437.23228-1-bart.vanassche@sandisk.com>
	 <20170427155437.23228-6-bart.vanassche@sandisk.com>
	 <20170502001741.GA2894@vader>
In-Reply-To: <20170502001741.GA2894@vader>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Mon, 2017-05-01 at 17:17 -0700, Omar Sandoval wrote:
> On Thu, Apr 27, 2017 at 08:54:36AM -0700, Bart Van Assche wrote:
> > +	if (q->queue_hw_ctx[rq->mq_ctx->index_hw] =3D=3D ctx->hctx &&
>=20
> This doesn't look right. ctx->index_hw is the index into hctx->ctxs for
> this ctx. I think you mean blk_mq_map_queue(q, rq->mq_ctx->cpu).

Hello Omar,

Thanks for the feedback. I will integrate this fix when I repost this patch=
 series
(after the merge window has closed).

Bart.=
