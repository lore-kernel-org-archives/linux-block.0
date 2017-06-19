Return-Path: <Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "axboe@kernel.dk" <axboe@kernel.dk>
CC: "hch@lst.de" <hch@lst.de>, Bart Van Assche <Bart.VanAssche@wdc.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "hare@suse.com"
	<hare@suse.com>, "osandov@fb.com" <osandov@fb.com>, "ming.lei@redhat.com"
	<ming.lei@redhat.com>
Subject: Re: [PATCH v4 12/12] blk-mq: Warn when attempting to run a hardware
 queue that is not mapped
Date: Mon, 19 Jun 2017 23:10:28 +0000
Message-ID: <1497913827.2989.4.camel@wdc.com>
References: <20170619220801.12557-1-bart.vanassche@wdc.com>
	 <20170619220801.12557-13-bart.vanassche@wdc.com>
	 <f8454b86-b7d2-1f9c-69f6-0e191cea1bef@kernel.dk>
In-Reply-To: <f8454b86-b7d2-1f9c-69f6-0e191cea1bef@kernel.dk>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Mon, 2017-06-19 at 17:06 -0600, Jens Axboe wrote:
> On 06/19/2017 04:08 PM, Bart Van Assche wrote:
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -1140,8 +1140,9 @@ static int blk_mq_hctx_next_cpu(struct blk_mq_hw_=
ctx *hctx)
> >  static void __blk_mq_delay_run_hw_queue(struct blk_mq_hw_ctx *hctx, bo=
ol async,
> >  					unsigned long msecs)
> >  {
> > -	if (unlikely(blk_mq_hctx_stopped(hctx) ||
> > -		     !blk_mq_hw_queue_mapped(hctx)))
> > +	WARN_ON_ONCE(!blk_mq_hw_queue_mapped(hctx));
> > +
>=20
> 	if (WARN_ON_ONCE(!blk_mq_hw_queue_mapped(hctx)))
> 		return;

Hello Jens,

Thanks for having reviewed this patch series. I will make the requested
changes, retest and repost this patch series.

Bart.=
