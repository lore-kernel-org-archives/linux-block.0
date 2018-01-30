Return-Path: <joseph.qi@linux.alibaba.com>
From: Joseph Qi <joseph.qi@linux.alibaba.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block <linux-block@vger.kernel.org>,
 Gang Deng <gavin.dg@linux.alibaba.com>
Subject: [RFC] hard LOCKUP caused by race between blk_init_queue_node and
 blkcg_print_blkgs
Message-ID: <5ac9562b-b20a-9f5a-90c5-2187552b6f09@linux.alibaba.com>
Date: Tue, 30 Jan 2018 19:21:43 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Jens and Folks,

Recently we've gotten a hard LOCKUP issue. After investigating the issue
we've found a race between blk_init_queue_node and blkcg_print_blkgs.
The race is described below.

blk_init_queue_node                 blkcg_print_blkgs
  blk_alloc_queue_node (1)
    q->queue_lock = &q->__queue_lock (2)
    blkcg_init_queue(q) (3)
                                    spin_lock_irq(blkg->q->queue_lock) (4)
  q->queue_lock = lock (5)
                                    spin_unlock_irq(blkg->q->queue_lock) (6)

(1) allocate an uninitialized queue;
(2) initialize queue_lock to its default internal lock;
(3) initialize blkcg part of request queue, which will create blkg and
then insert it to blkg_list;
(4) traverse blkg_list and find the created blkg, and then take its
queue lock, here it is the default *internal lock*;
(5) *race window*, now queue_lock is overridden with *driver specified
lock*;
(6) now unlock *driver specified lock*, not the locked *internal lock*,
unlock balance breaks.

For the issue above, I think blkcg_init_queue is a bit earlier. We
can't allow a further use before request queue is fully initialized.
Since blk_init_queue_node is a really common path and it allows driver
to override the default internal lock, I'm afraid several other places
may also have the same issue.
Am I missing something here?

Thanks,
Joseph
