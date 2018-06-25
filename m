Return-Path: <tom.leiming@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20180624101605.GA32610@ming.t460p>
References: <20180624101605.GA32610@ming.t460p>
From: Ming Lei <tom.leiming@gmail.com>
Date: Mon, 25 Jun 2018 19:15:24 +0800
Message-ID: <CACVXFVPxnGhFQQEm7F_QNav9mr+ZDd4EsRSdSyKFAg06p5sEqQ@mail.gmail.com>
Subject: Re: [blk-mq Bug] race on removing hctx->dispatch_wait from wait queue
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bart.vanassche@wdc.com>,
	Christoph Hellwig <hch@lst.de>, linux-block <linux-block@vger.kernel.org>, Omar Sandoval <osandov@fb.com>,
	Andrew Jones <drjones@redhat.com>, "Martin K. Petersen" <martin.petersen@oracle.com>,
	Linux SCSI List <linux-scsi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Sun, Jun 24, 2018 at 6:16 PM, Ming Lei <ming.lei@redhat.com> wrote:
> Hi Guys,
>
> Recently, I am figuring out solutions for removing synchronize_rcu() from
> blk_cleanup_queue() so that no long delay is caused during SCSI lun probe[1],
> especially from blk_mq_del_queue_tag_set(). This synchronize_rcu() is added
> by commit 705cda97ee3abb6ea(blk-mq: Make it safe to use RCU to iterate over
> blk_mq_tag_set.tag_list), and commit 6d8c6c0f97ad ("blk-mq: Restart a single
> queue if tag sets are shared"), and call this as 'TAG_SHARED in restart'.
>
> Basically speaking, the synchronize_rcu() can't be removed if we have
> to restart all tags-shared queues in current way('TAG_SHARED in restart')
> when one request is completed. Meantime blk-mq has used blk_mq_mark_tag_wait()
> to deal with cross-queue driver tag allocation, which means the two mechanism
> are  highly overlapped. Also SCSI has built-in RESTART, and not need
> 'TAG_SHARED in restart'.
>
> We tried to remove shared-tag restart in 358a3a6bccb7 (blk-mq: don't handle
> TAG_SHARED in restart) before, but it is reverted in commit 05b79413946d
> (Revert "blk-mq: don't handle TAG_SHARED in restart") because it causes
> regression in Bart's SRP test.
>
> Now I am revisiting 'TAG_SHARED in restart' again for the long delay issue
> of SCSI LUN probe. And found there is one bug in blk_mq_mark_tag_wait():
>
> - hctx->dispatch_wait is added to wait queue by holding hctx->lock and
> the wait queue's lock
>
> - no hctx->lock is held when removing hctx->dispatch_wait from wait
>   queue.
>
> - so the two actions(add, remove) may happen meantime since
>   hctx->dispatch_wait can be added to different wait queues.
>
> Turns out this issue can be observed easily by applying the patches[2],
> which is for removing 'TAG_SHARED in restart', then run simple shared-tag
> null_blk test[4].
>
> But if the hctx->lock is held in blk_mq_dispatch_wake(), as done in
> patch [3], there isn't such issue at all, so it shows this issue is
> related with hctx->lock, and adding/removing hctx->dispatch_wait to
> wait queue. But the way of holding hctx->lock in irq context may not
> be one accepted solution, since it has been avoided from the beginning
> of blk-mq.
>
> So does anyone have better ideas for this issue?
>
> So far, follows what I thought of:
>
> 1) fix the mechanism of blk_mq_mark_tag_wait(), and removing
> 'TAG_SHARED in restart', then we can fix the long delay issue of
> SCSI LUN probe, meantime performance can got improved, as I observed,
> this way may improve IOPS by 20~30% in multi-LUN scsi_debug test.
> But the issue is how to fix?
>
> 2) keep 'TAG_SHARED in restart' and let it cover the issue of
> blk_mq_mark_tag_wait() as now, then try to improve 'TAG_SHARED in restart'
> in another way, so that performance can be better, and synchronize_rcu()
> can be removed from blk_mq_del_queue_tag_set(), then SCSI LUN probe long
> delay can be fixed. I had wrote patches to do that last year. If anyone
> is interested, I may post it out.
>
> Or other ideas, any comments & ideas are welcome!

Looks introducing one new lock to protect hctx->dispatch_wait is fine.


Thanks,
Ming Lei
