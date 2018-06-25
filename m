Return-Path: <ming.lei@redhat.com>
Date: Mon, 25 Jun 2018 15:24:35 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@lst.de" <hch@lst.de>, "drjones@redhat.com" <drjones@redhat.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"osandov@fb.com" <osandov@fb.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>
Subject: Re: [blk-mq Bug] race on removing hctx->dispatch_wait from wait queue
Message-ID: <20180625072433.GA23016@ming.t460p>
References: <20180624101605.GA32610@ming.t460p>
 <da4a45a9d7764ffee5eea2c6c355dc4b7c23265a.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <da4a45a9d7764ffee5eea2c6c355dc4b7c23265a.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Sun, Jun 24, 2018 at 04:33:21PM +0000, Bart Van Assche wrote:
> On Sun, 2018-06-24 at 18:16 +0800, Ming Lei wrote:
> > Now I am revisiting 'TAG_SHARED in restart' again for the long delay issue
> > of SCSI LUN probe. And found there is one bug in blk_mq_mark_tag_wait():
> > 
> > - hctx->dispatch_wait is added to wait queue by holding hctx->lock and
> > the wait queue's lock
> > 
> > - no hctx->lock is held when removing hctx->dispatch_wait from wait
> >   queue.
> > 
> > - so the two actions(add, remove) may happen meantime since
> >   hctx->dispatch_wait can be added to different wait queues.
> > 
> > Turns out this issue can be observed easily by applying the patches[2],
> > which is for removing 'TAG_SHARED in restart', then run simple shared-tag
> > null_blk test[4].
> > 
> > But if the hctx->lock is held in blk_mq_dispatch_wake(), as done in
> > patch [3], there isn't such issue at all, so it shows this issue is
> > related with hctx->lock, and adding/removing hctx->dispatch_wait to
> > wait queue. But the way of holding hctx->lock in irq context may not
> > be one accepted solution, since it has been avoided from the beginning
> > of blk-mq.
> > 
> > So does anyone have better ideas for this issue?
> > 
> > So far, follows what I thought of:
> > 
> > 1) fix the mechanism of blk_mq_mark_tag_wait(), and removing
> > 'TAG_SHARED in restart', then we can fix the long delay issue of
> > SCSI LUN probe, meantime performance can got improved, as I observed,
> > this way may improve IOPS by 20~30% in multi-LUN scsi_debug test.
> > But the issue is how to fix?
> > 
> > 2) keep 'TAG_SHARED in restart' and let it cover the issue of
> > blk_mq_mark_tag_wait() as now, then try to improve 'TAG_SHARED in restart'
> > in another way, so that performance can be better, and synchronize_rcu()
> > can be removed from blk_mq_del_queue_tag_set(), then SCSI LUN probe long
> > delay can be fixed. I had wrote patches to do that last year. If anyone
> > is interested, I may post it out.
> > 
> > Or other ideas, any comments & ideas are welcome!
> 
> Please have a look at [PATCH] blk-mq: Fix a race condition in blk_mq_mark_tag_wait(),
> 16 Jan 2018 (https://www.mail-archive.com/linux-block@vger.kernel.org/msg17474.html).

Thanks for sharing it, looks I miss your findings.

Your commit log describes the issue exactly, but unfortunately the patch
isn't correct, because hctx->lock isn't held in the removing path of
blk_mq_dispatch_wake(). Given 'hctx->dispatch_wait' may be added to
different wait queues, it isn't enough to hold wait queue lock and
hctx->lock in add path only. Otherwise, removing path can be seen as
'lockless' from the view point of add path.

If you apply the patch[1] and the patch of '[PATCH] blk-mq: Fix a race condition
in blk_mq_mark_tag_wait()', and run test script in [2], you will see
that IO hang can still be triggered easily.

I have cooked one patch of 'blk-mq: holding hctx->lock when removing
hctx->dispatch_wait from wai'[3], which can fix the issue, but need to
change all current pin_lock(hctx->lock) into spin_lock_irq() since
blk_mq_dispatch_wake() is usually done in irq context. This kind of
change might not be an accepted way, that is why I report it out
and start the discussion.


[1] https://github.com/ming1/linux/commit/36a0ff197531e02a955472059acfc436b8ed97e7
[2] http://people.redhat.com/minlei/tests/tools/null_blk_test-restart
[2] https://github.com/ming1/linux/commit/cb7c822d663552da62479942458444c5081149a1

Thanks,
Ming
