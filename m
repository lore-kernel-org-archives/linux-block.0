Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36442 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753224AbcIRHhc (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Sep 2016 03:37:32 -0400
From: Alexander Gordeev <agordeev@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Alexander Gordeev <agordeev@redhat.com>,
        linux-block@vger.kernel.org
Subject: [PATCH 00/14] blk-mq: Minor fixes and cleanups
Date: Sun, 18 Sep 2016 09:37:10 +0200
Message-Id: <cover.1474183901.git.agordeev@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Jens!

The series is against:

  git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-4.9/block-irq

Thanks!

CC: linux-block@vger.kernel.org

Alexander Gordeev (14):
  blk-mq: Fix memory leaks on queue cleanup
  blk-mq: Fix a potential NULL pointer assignment to hctx tags
  block: Get rid of unused request_queue::nr_queues member
  blk-mq: Do not limit number of queues to 'nr_cpu_ids' in allocations
  blk-mq: Remove a redundant assignment
  blk-mq: Fix hardware context data node selection
  blk-mq: Cleanup a loop exit condition
  blk-mq: Get rid of unnecessary blk_mq_free_hw_queues()
  blk-mq: Move duplicating code to blk_mq_exit_hctx()
  blk-mq: Uninit hardware context in order reverse to init
  blk-mq: Move hardware context init code into single location
  blk-mq: Rework blk_mq_init_hctx() function
  blk-mq: Pair blk_mq_hctx_kobj_init() with blk_mq_hctx_kobj_put()
  blk-mq: Set flush_start_tag to BLK_MQ_MAX_DEPTH

 block/blk-mq-sysfs.c   |   5 ++
 block/blk-mq.c         | 166 ++++++++++++++++++++++---------------------------
 block/blk-mq.h         |   1 +
 include/linux/blkdev.h |   1 -
 4 files changed, 79 insertions(+), 94 deletions(-)

-- 
1.8.3.1

