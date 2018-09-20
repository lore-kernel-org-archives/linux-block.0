Return-Path: <jianchao.w.wang@oracle.com>
From: Jianchao Wang <jianchao.w.wang@oracle.com>
To: axboe@kernel.dk, tj@kernel.org, kent.overstreet@gmail.com,
        ming.lei@redhat.com, bart.vanassche@wdc.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/3] blk-mq: rework queue freeze and preempt-only
Date: Thu, 20 Sep 2018 18:18:20 +0800
Message-Id: <1537438703-25217-1-git-send-email-jianchao.w.wang@oracle.com>
List-ID: <linux-block@vger.kernel.org>

Hi all

The current queue freeze depending on percpu_ref_kil/reinit has a limit that
we have drain the requests before unfreeze the queue.

Let's rework the queue freeze feature as following:
1. introduce __percpu_ref_get_many.
   It is same with original percpu_ref_get_many, but just need callers to provide
   sched rcu critical section. We will put the __percpu_ref_get_many and our own
   condition checking under rcu_read_lock_sched. With this new helper interface,
   we could save an extra rcu_read_lock_sched.
2. rework the blk_queue_enter as:
   
   rcu_read_lock_sched()
   if condition check true
     __percpu_ref_get_many(&q->q_usage_counter, 1)
   else
     goto wait
   rcu_read_unlock_sched()
3. use percpu_ref_switch_to_atomic/percpu to switch mode directly.

Then we could unfreeze the queue w/o draining requests.
In addition, preempt-only mode code could be simplified.

Jianchao Wang (3)
percpu_ref: add a new helper interface
blk-core: rework the queue freeze
block, scsi: rework the preempt only mode

d16c830226a0ac15cb5947479030b
 block/blk-core.c                | 58 ++++++++++++++++++++++++++--------------------------------
 block/blk-mq-debugfs.c          |  1 -
 block/blk-mq.c                  |  8 ++++++--
 block/blk.h                     |  5 +++++
 drivers/scsi/scsi_lib.c         | 12 ++++--------
 include/linux/blkdev.h          |  5 ++---
 include/linux/percpu-refcount.h | 23 +++++++++++++++++------
 7 files changed, 60 insertions(+), 52 deletions(-)

Thanks
Jianchao 
