Return-Path: <jianchao.w.wang@oracle.com>
From: Jianchao Wang <jianchao.w.wang@oracle.com>
To: axboe@kernel.dk
Cc: bart.vanassche@wdc.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] block: fix the lock inversion caused by kobject_del under sysfs_lock
Date: Fri, 22 Jun 2018 15:11:17 +0800
Message-Id: <1529651480-1734-1-git-send-email-jianchao.w.wang@oracle.com>
List-ID: <linux-block@vger.kernel.org>

Hi Jens

Currently, the kobject_del for sysfs mq and hctx entry is invoked
under q->sysfs_lock. lock inversion will came up when someone try
to access the sysfs entries concurrently. The scenario is as below:
  hold q->sysfs_lock    access mq,hctx sysfs entries
  kobject_del
  __kernfs_remove          kernfs_get_active
    kernfs_drain
     wait kn->active       require q->sysfs_lock

To avoid this issue, kobject_del for mq and hctx sysfs entries
mustn't be inovked under sysfs_lock. These patch set is to achieve this.

1st patch introduces blk_queue_registered to test QUEUE_FLAG_REGISTERED
2nd patch remove blk_mq_register_dev which is usesless.
3rd patch fix the issue by changing the sync method, please refer to the
comment.

Jianchao Wang (3)
block: add helper interface blk_queue_registered
blk-mq: cleanup blk_mq_register_dev
block: fix the lock inversion caused by kobject_del under sysfs_lock


 block/blk-mq-sysfs.c   | 80 +++++++++++++++++++++++++++++++-------------------
 block/blk-mq.h         |  3 ++
 block/blk-sysfs.c      | 43 ++++++++++++++-------------
 block/blk-wbt.c        |  4 ---
 block/elevator.c       |  5 ++--
 include/linux/blk-mq.h |  3 --
 include/linux/blkdev.h |  4 ++-
 7 files changed, 82 insertions(+), 60 deletions(-)

Thanks
Jianchao
