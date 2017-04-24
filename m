Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Mon, 24 Apr 2017 10:29:05 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
Cc: "hare@suse.com" <hare@suse.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"osandov@fb.com" <osandov@fb.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH v4 05/10] blk-mq: Unregister debugfs attributes earlier
Message-ID: <20170424172905.GH28510@vader.DHCP.thefacebook.com>
References: <20170421234026.18970-1-bart.vanassche@sandisk.com>
 <20170421234026.18970-6-bart.vanassche@sandisk.com>
 <20170424165549.GC28510@vader.DHCP.thefacebook.com>
 <1493053923.3394.8.camel@sandisk.com>
 <20170424171746.GF28510@vader.DHCP.thefacebook.com>
 <1493054652.3394.10.camel@sandisk.com>
 <20170424172615.GG28510@vader.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170424172615.GG28510@vader.DHCP.thefacebook.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Apr 24, 2017 at 10:26:15AM -0700, Omar Sandoval wrote:
> On Mon, Apr 24, 2017 at 05:24:13PM +0000, Bart Van Assche wrote:
> > On Mon, 2017-04-24 at 10:17 -0700, Omar Sandoval wrote:
> > > On Mon, Apr 24, 2017 at 05:12:05PM +0000, Bart Van Assche wrote:
> > > > On Mon, 2017-04-24 at 09:55 -0700, Omar Sandoval wrote:
> > > > > On Fri, Apr 21, 2017 at 04:40:21PM -0700, Bart Van Assche wrote:
> > > > > > @@ -566,6 +566,11 @@ void blk_cleanup_queue(struct request_queue *q)
> > > > > >  	spin_lock_irq(lock);
> > > > > >  	if (!q->mq_ops)
> > > > > >  		__blk_drain_queue(q, true);
> > > > > > +	spin_unlock_irq(lock);
> > > > > > +
> > > > > > +	blk_mq_debugfs_unregister_mq(q);
> > > > > > +
> > > > > > +	spin_lock_irq(lock);
> > > > > >  	queue_flag_set(QUEUE_FLAG_DEAD, q);
> > > > > >  	spin_unlock_irq(lock);
> > > > > 
> > > > > Do we actually have to hold the queue lock when we set QUEUE_FLAG_DEAD?
> > > > 
> > > > It's way easier to keep that spin_lock()/spin_unlock() pair than to analyze
> > > > the block driver core and all block drivers to see whether or not any
> > > > concurrent queue flag changes could occur.
> > > 
> > > Ah, I didn't realize that queue_flag_set() did a non-atomic set. I'm
> > > wondering if anything bad could happen if something raced between when
> > > we drop the lock and regrab it. Maybe just move the
> > > blk_mq_debugfs_unregister_mq() before we grab the lock the first time
> > > instead?
> > 
> > That would have the disadvantage that debugfs attributes would be unregistered
> > before __blk_drain_queue() is called and hence that these debugfs attributes
> > would not be available to debug hangs in queue draining for traditional block
> > layer queues ...
> 
> True, this is probably fine, then.

Actually, if we drop this lock, then for non-mq, can't we end up with
some I/O's sneaking in between when we drain the queue and mark it dead
while the lock is dropped?
