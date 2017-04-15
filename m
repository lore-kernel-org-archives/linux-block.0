Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37060 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751955AbdDOMkl (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 15 Apr 2017 08:40:41 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>,
        Omar Sandoval <osandov@fb.com>,
        Jozef Mikovic <jmikovic@redhat.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/4] blk-mq-sched: allow to use hw tag for sched
Date: Sat, 15 Apr 2017 20:38:21 +0800
Message-Id: <20170415123825.32716-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

The 1st patch enhances BLK_MQ_F_NO_SCHED so that we can't change/
show available io schedulers on devices which don't support io
scheduler.

The 2nd patch passes BLK_MQ_F_NO_SCHED for avoiding one regression
on mtip32xx, which is introduced by blk-mq io scheduler.

The last two patches introduce BLK_MQ_F_SCHED_USE_HW_TAG so that
we can allow to use hardware tag for scheduler, then mq-deadline
can work well on mtip32xx. Even though other devices with enough
hardware tag space can benefit from this feature too.

The 1st two patches aims on v4.11, and the last two are for
v4.12.


Thanks,
Ming

Ming Lei (4):
  block: respect BLK_MQ_F_NO_SCHED
  mtip32xx: pass BLK_MQ_F_NO_SCHED
  blk-mq: introduce BLK_MQ_F_SCHED_USE_HW_TAG
  mtip32xx: use BLK_MQ_F_USE_SCHED_TAG

 block/blk-mq-sched.c              | 10 +++++++++-
 block/blk-mq.c                    | 35 +++++++++++++++++++++++++++++------
 block/elevator.c                  | 12 ++++++++++--
 drivers/block/mtip32xx/mtip32xx.c |  2 +-
 include/linux/blk-mq.h            |  1 +
 5 files changed, 50 insertions(+), 10 deletions(-)

-- 
2.9.3
