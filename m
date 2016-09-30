Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52124 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932839AbcI3NXn (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Sep 2016 09:23:43 -0400
From: Alexander Gordeev <agordeev@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Alexander Gordeev <agordeev@redhat.com>,
        linux-block@vger.kernel.org
Subject: [PATCH v2 0/8] blk-mq: Minor cleanups
Date: Fri, 30 Sep 2016 15:23:22 +0200
Message-Id: <cover.1475241231.git.agordeev@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello,

The series is against:

  git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next

Thanks!

CC: linux-block@vger.kernel.org

Alexander Gordeev (8):
  block: Get rid of unused request_queue::nr_queues member
  blk-mq: Remove a redundant assignment
  blk-mq: Fix hardware context data node selection
  blk-mq: Cleanup a loop exit condition
  blk-mq: Cleanup blk_mq_hw_ctx::cpumask (de-)allocation
  blk-mq: Rework blk_mq_realloc_hw_ctxs()
  blk-mq: Pair blk_mq_hctx_kobj_init() with blk_mq_hctx_kobj_put()
  blk-mq: Cleanup (de-)allocation of blk_mq_hw_ctx::ctxs

 block/blk-mq-sysfs.c   |   5 ++
 block/blk-mq.c         | 129 ++++++++++++++++++++++++-------------------------
 block/blk-mq.h         |   1 +
 include/linux/blkdev.h |   1 -
 4 files changed, 68 insertions(+), 68 deletions(-)

-- 
1.8.3.1

