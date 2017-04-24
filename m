Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "osandov@osandov.com" <osandov@osandov.com>
CC: "hare@suse.com" <hare@suse.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "osandov@fb.com" <osandov@fb.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH v4 05/10] blk-mq: Unregister debugfs attributes earlier
Date: Mon, 24 Apr 2017 17:34:46 +0000
Message-ID: <1493055284.3394.12.camel@sandisk.com>
References: <20170421234026.18970-1-bart.vanassche@sandisk.com>
	 <20170421234026.18970-6-bart.vanassche@sandisk.com>
	 <20170424165549.GC28510@vader.DHCP.thefacebook.com>
	 <1493053923.3394.8.camel@sandisk.com>
	 <20170424171746.GF28510@vader.DHCP.thefacebook.com>
	 <1493054652.3394.10.camel@sandisk.com>
	 <20170424172615.GG28510@vader.DHCP.thefacebook.com>
	 <20170424172905.GH28510@vader.DHCP.thefacebook.com>
In-Reply-To: <20170424172905.GH28510@vader.DHCP.thefacebook.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Mon, 2017-04-24 at 10:29 -0700, Omar Sandoval wrote:
> On Mon, Apr 24, 2017 at 10:26:15AM -0700, Omar Sandoval wrote:
> > On Mon, Apr 24, 2017 at 05:24:13PM +0000, Bart Van Assche wrote:
> > > On Mon, 2017-04-24 at 10:17 -0700, Omar Sandoval wrote:
> > > > On Mon, Apr 24, 2017 at 05:12:05PM +0000, Bart Van Assche wrote:
> > > > > On Mon, 2017-04-24 at 09:55 -0700, Omar Sandoval wrote:
> > > > > > On Fri, Apr 21, 2017 at 04:40:21PM -0700, Bart Van Assche wrote=
:
> > > > > > > @@ -566,6 +566,11 @@ void blk_cleanup_queue(struct request_qu=
eue *q)
> > > > > > >  	spin_lock_irq(lock);
> > > > > > >  	if (!q->mq_ops)
> > > > > > >  		__blk_drain_queue(q, true);
> > > > > > > +	spin_unlock_irq(lock);
> > > > > > > +
> > > > > > > +	blk_mq_debugfs_unregister_mq(q);
> > > > > > > +
> > > > > > > +	spin_lock_irq(lock);
> > > > > > >  	queue_flag_set(QUEUE_FLAG_DEAD, q);
> > > > > > >  	spin_unlock_irq(lock);
> > > > > >=20
> > > > > > Do we actually have to hold the queue lock when we set QUEUE_FL=
AG_DEAD?
> > > > >=20
> > > > > It's way easier to keep that spin_lock()/spin_unlock() pair than =
to analyze
> > > > > the block driver core and all block drivers to see whether or not=
 any
> > > > > concurrent queue flag changes could occur.
> > > >=20
> > > > Ah, I didn't realize that queue_flag_set() did a non-atomic set. I'=
m
> > > > wondering if anything bad could happen if something raced between w=
hen
> > > > we drop the lock and regrab it. Maybe just move the
> > > > blk_mq_debugfs_unregister_mq() before we grab the lock the first ti=
me
> > > > instead?
> > >=20
> > > That would have the disadvantage that debugfs attributes would be unr=
egistered
> > > before __blk_drain_queue() is called and hence that these debugfs att=
ributes
> > > would not be available to debug hangs in queue draining for tradition=
al block
> > > layer queues ...
> >=20
> > True, this is probably fine, then.
>=20
> Actually, if we drop this lock, then for non-mq, can't we end up with
> some I/O's sneaking in between when we drain the queue and mark it dead
> while the lock is dropped?

That's a good question but I don't think so. Queuing new I/O after a queue
has been marked as "dying" is not allowed. For both blk-sq and blk-mq queue=
s
blk_get_request() returns -ENODEV if that function is called after the "dyi=
ng"
flag has been set.

Bart.=
