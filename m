Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "hare@suse.com" <hare@suse.com>, "axboe@kernel.dk" <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH v4 09/10] blk-mq: Add blk_mq_ops.show_rq()
Date: Mon, 24 Apr 2017 21:51:46 +0000
Message-ID: <1493070705.3394.21.camel@sandisk.com>
References: <20170421234026.18970-1-bart.vanassche@sandisk.com>
	 <20170421234026.18970-10-bart.vanassche@sandisk.com>
	 <1e88d065-5a98-1edc-658e-c0194e471994@suse.com>
In-Reply-To: <1e88d065-5a98-1edc-658e-c0194e471994@suse.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Mon, 2017-04-24 at 09:32 +0200, Hannes Reinecke wrote:
> On 04/22/2017 01:40 AM, Bart Van Assche wrote:
> > --- a/include/linux/blk-mq.h
> > +++ b/include/linux/blk-mq.h
> > @@ -121,6 +121,12 @@ struct blk_mq_ops {
> >  	softirq_done_fn		*complete;
> > =20
> >  	/*
> > +	 * Used by the debugfs implementation to show driver-specific
> > +	 * information about a request.
> > +	 */
> > +	void (*show_rq)(struct seq_file *m, struct request *rq);
> > +
> > +	/*
> >  	 * Called when the block layer side of a hardware queue has been
> >  	 * set up, allowing the driver to allocate/init matching structures.
> >  	 * Ditto for exit/teardown.
> >=20
>=20
> I don't really like this; what does happen if someone disabled
> CONFIG_BLK_DEBUGFS? Won't we end up with a stale callback?

Hello Hannes,

How about surrounding (*show_rq)() function pointer with #ifdef CONFIG_BLK_=
DEBUGFS /
#endif?

Bart.=
