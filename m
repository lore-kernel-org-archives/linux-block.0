Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 11 Apr 2018 10:00:18 -0700
From: "tj@kernel.org" <tj@kernel.org>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "00moses.alexander00@gmail.com" <00moses.alexander00@gmail.com>,
	"joseph.qi@linux.alibaba.com" <joseph.qi@linux.alibaba.com>,
	"nborisov@suse.com" <nborisov@suse.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"arnd@arndb.de" <arnd@arndb.de>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "shli@fb.com" <shli@fb.com>
Subject: Re: [PATCH v2] blk-cgroup: remove entries in blkg_tree before queue
 release
Message-ID: <20180411170018.GL793541@devbig577.frc2.facebook.com>
References: <20180407102148.GA9729@gmail.com>
 <20180409220938.GI3126663@devbig577.frc2.facebook.com>
 <20180411101242.GA2322@gmail.com>
 <20180411142019.GG793541@devbig577.frc2.facebook.com>
 <20180411142859.GB2322@gmail.com>
 <20180411144616.GI793541@devbig577.frc2.facebook.com>
 <20180411145123.GJ793541@devbig577.frc2.facebook.com>
 <20180411145632.GK793541@devbig577.frc2.facebook.com>
 <bd60302129cb89bdc3b4f402ce4e061f41851729.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <bd60302129cb89bdc3b4f402ce4e061f41851729.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Hello,

On Wed, Apr 11, 2018 at 04:42:55PM +0000, Bart Van Assche wrote:
> On Wed, 2018-04-11 at 07:56 -0700, Tejun Heo wrote:
> > And looking at the change, it looks like the right thing we should
> > have done is caching @lock on the print_blkg side and when switching
> > locks make sure both locks are held.  IOW, do the following in
> > blk_cleanup_queue()
> > 
> > 	spin_lock_irq(lock);
> > 	if (q->queue_lock != &q->__queue_lock) {
> > 		spin_lock(&q->__queue_lock);
> > 		q->queue_lock = &q->__queue_lock;
> > 		spin_unlock(&q->__queue_lock);
> > 	}
> > 	spin_unlock_irq(lock);
> > 
> > Otherwise, there can be two lock holders thinking they have exclusive
> > access to the request_queue.
> 
> I think that's a bad idea. A block driver is allowed to destroy the
> spinlock it associated with the request queue as soon as blk_cleanup_queue()
> has finished. If the block cgroup controller would cache a pointer to the
> block driver spinlock then that could cause the cgroup code to attempt to
> lock a spinlock after it has been destroyed. I don't think we need that kind
> of race conditions.

I see, but that problem is there with or without caching as long as we
have queu_lock usage which reach beyond cleanup_queue, right?  Whether
that user caches the lock for matching unlocking or not doesn't really
change the situation.

Short of adding protection around queue_lock switching, I can't think
of a solution tho.  Probably the right thing to do is adding queue
lock/unlock helpers which are safe to use beyond cleanup_queue.

Thanks.

-- 
tejun
