Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:33324 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S975932AbdDXRRt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Apr 2017 13:17:49 -0400
Received: by mail-pf0-f179.google.com with SMTP id a188so15363080pfa.0
        for <linux-block@vger.kernel.org>; Mon, 24 Apr 2017 10:17:49 -0700 (PDT)
Date: Mon, 24 Apr 2017 10:17:46 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
Cc: "hare@suse.com" <hare@suse.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "osandov@fb.com" <osandov@fb.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH v4 05/10] blk-mq: Unregister debugfs attributes earlier
Message-ID: <20170424171746.GF28510@vader.DHCP.thefacebook.com>
References: <20170421234026.18970-1-bart.vanassche@sandisk.com>
 <20170421234026.18970-6-bart.vanassche@sandisk.com>
 <20170424165549.GC28510@vader.DHCP.thefacebook.com>
 <1493053923.3394.8.camel@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1493053923.3394.8.camel@sandisk.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Apr 24, 2017 at 05:12:05PM +0000, Bart Van Assche wrote:
> On Mon, 2017-04-24 at 09:55 -0700, Omar Sandoval wrote:
> > On Fri, Apr 21, 2017 at 04:40:21PM -0700, Bart Van Assche wrote:
> > > One of the debugfs attributes allows to run a queue. Since running
> > > a queue after a queue has entered the "dead" state is not allowed
> > > and even can cause a kernel crash, unregister the debugfs attributes
> > > before a queue reaches the "dead" state.
> > 
> > More important than this case, I think, is that blk_cleanup_queue()
> > calls blk_mq_free_queue(q), so most of the debugfs entries would lead to
> > use-after-frees. If you add that to the commit message and address my
> > comment below,
> > 
> > Reviewed-by: Omar Sandoval <osandov@fb.com>
> 
> Thanks! I will update the commit message.
> 
> > > --- a/block/blk-core.c
> > > +++ b/block/blk-core.c
> > > @@ -566,6 +566,11 @@ void blk_cleanup_queue(struct request_queue *q)
> > >  	spin_lock_irq(lock);
> > >  	if (!q->mq_ops)
> > >  		__blk_drain_queue(q, true);
> > > +	spin_unlock_irq(lock);
> > > +
> > > +	blk_mq_debugfs_unregister_mq(q);
> > > +
> > > +	spin_lock_irq(lock);
> > >  	queue_flag_set(QUEUE_FLAG_DEAD, q);
> > >  	spin_unlock_irq(lock);
> > 
> > Do we actually have to hold the queue lock when we set QUEUE_FLAG_DEAD?
> 
> It's way easier to keep that spin_lock()/spin_unlock() pair than to analyze
> the block driver core and all block drivers to see whether or not any
> concurrent queue flag changes could occur.

Ah, I didn't realize that queue_flag_set() did a non-atomic set. I'm
wondering if anything bad could happen if something raced between when
we drop the lock and regrab it. Maybe just move the
blk_mq_debugfs_unregister_mq() before we grab the lock the first time
instead?
