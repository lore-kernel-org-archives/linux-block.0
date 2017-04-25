Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "hare@suse.de" <hare@suse.de>, "hare@suse.com" <hare@suse.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH v4 09/10] blk-mq: Add blk_mq_ops.show_rq()
Date: Tue, 25 Apr 2017 15:35:42 +0000
Message-ID: <1493134541.2628.1.camel@sandisk.com>
References: <20170421234026.18970-1-bart.vanassche@sandisk.com>
	 <20170421234026.18970-10-bart.vanassche@sandisk.com>
	 <1e88d065-5a98-1edc-658e-c0194e471994@suse.com>
	 <1493070705.3394.21.camel@sandisk.com>
	 <43f3d07e-610e-f5a1-8d3a-bdd06213764f@suse.de>
In-Reply-To: <43f3d07e-610e-f5a1-8d3a-bdd06213764f@suse.de>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Tue, 2017-04-25 at 17:16 +0200, Hannes Reinecke wrote:
> On 04/24/2017 11:51 PM, Bart Van Assche wrote:
> > On Mon, 2017-04-24 at 09:32 +0200, Hannes Reinecke wrote:
> > > On 04/22/2017 01:40 AM, Bart Van Assche wrote:
> > > > --- a/include/linux/blk-mq.h
> > > > +++ b/include/linux/blk-mq.h
> > > > @@ -121,6 +121,12 @@ struct blk_mq_ops {
> > > >  	softirq_done_fn		*complete;
> > > > =20
> > > >  	/*
> > > > +	 * Used by the debugfs implementation to show driver-specific
> > > > +	 * information about a request.
> > > > +	 */
> > > > +	void (*show_rq)(struct seq_file *m, struct request *rq);
> > > > +
> > > > +	/*
> > > >  	 * Called when the block layer side of a hardware queue has been
> > > >  	 * set up, allowing the driver to allocate/init matching structur=
es.
> > > >  	 * Ditto for exit/teardown.
> > > >=20
> > >=20
> > > I don't really like this; what does happen if someone disabled
> > > CONFIG_BLK_DEBUGFS? Won't we end up with a stale callback?
> >=20
> > How about surrounding (*show_rq)() function pointer with #ifdef CONFIG_=
BLK_DEBUGFS /
> > #endif?
>=20
> Then you'll end up with different offsets in the structures, depending
> on how the kernel is compiled. Making debugging a nightmare.

Hello Hannes,

How about moving the .show_rq function pointer to the end such that the
offset of other members of struct blk_mq_ops does not depend on whether or
not CONFIG_BLK_DEBUGFS has been defined?

Bart.=
