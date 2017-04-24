Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "osandov@osandov.com" <osandov@osandov.com>
CC: "hare@suse.com" <hare@suse.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "osandov@fb.com" <osandov@fb.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH v4 05/10] blk-mq: Unregister debugfs attributes earlier
Date: Mon, 24 Apr 2017 17:12:05 +0000
Message-ID: <1493053923.3394.8.camel@sandisk.com>
References: <20170421234026.18970-1-bart.vanassche@sandisk.com>
	 <20170421234026.18970-6-bart.vanassche@sandisk.com>
	 <20170424165549.GC28510@vader.DHCP.thefacebook.com>
In-Reply-To: <20170424165549.GC28510@vader.DHCP.thefacebook.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Mon, 2017-04-24 at 09:55 -0700, Omar Sandoval wrote:
> On Fri, Apr 21, 2017 at 04:40:21PM -0700, Bart Van Assche wrote:
> > One of the debugfs attributes allows to run a queue. Since running
> > a queue after a queue has entered the "dead" state is not allowed
> > and even can cause a kernel crash, unregister the debugfs attributes
> > before a queue reaches the "dead" state.
>=20
> More important than this case, I think, is that blk_cleanup_queue()
> calls blk_mq_free_queue(q), so most of the debugfs entries would lead to
> use-after-frees. If you add that to the commit message and address my
> comment below,
>=20
> Reviewed-by: Omar Sandoval <osandov@fb.com>

Thanks! I will update the commit message.

> > --- a/block/blk-core.c
> > +++ b/block/blk-core.c
> > @@ -566,6 +566,11 @@ void blk_cleanup_queue(struct request_queue *q)
> >  	spin_lock_irq(lock);
> >  	if (!q->mq_ops)
> >  		__blk_drain_queue(q, true);
> > +	spin_unlock_irq(lock);
> > +
> > +	blk_mq_debugfs_unregister_mq(q);
> > +
> > +	spin_lock_irq(lock);
> >  	queue_flag_set(QUEUE_FLAG_DEAD, q);
> >  	spin_unlock_irq(lock);
>=20
> Do we actually have to hold the queue lock when we set QUEUE_FLAG_DEAD?

It's way easier to keep that spin_lock()/spin_unlock() pair than to analyze
the block driver core and all block drivers to see whether or not any
concurrent queue flag changes could occur.

Bart.=
