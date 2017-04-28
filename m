Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39398 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S938067AbdD1PQS (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Apr 2017 11:16:18 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>,
        Omar Sandoval <osandov@fb.com>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/4] blk-mq: support to use hw tag for scheduling
Date: Fri, 28 Apr 2017 23:15:35 +0800
Message-Id: <20170428151539.25514-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi,

This patchset introduces flag of BLK_MQ_F_SCHED_USE_HW_TAG and
allows to use hardware tag directly for IO scheduling if the queue's
depth is big enough. In this way, we can avoid to allocate extra tags
and request pool for IO schedule, and the schedule tag allocation/release
can be saved in I/O submit path.

Thanks,
Ming

Ming Lei (4):
  blk-mq: introduce BLK_MQ_F_SCHED_USE_HW_TAG
  blk-mq: introduce blk_mq_get_queue_depth()
  blk-mq: use hw tag for scheduling if hw tag space is big enough
  blk-mq: dump new introduced flag of BLK_MQ_F_SCHED_USE_HW_TAG

 block/blk-mq-debugfs.c |  1 +
 block/blk-mq-sched.c   | 18 +++++++++++++-
 block/blk-mq-sched.h   | 15 ++++++++++++
 block/blk-mq.c         | 65 ++++++++++++++++++++++++++++++++++++++++++++------
 block/blk-mq.h         |  1 +
 include/linux/blk-mq.h |  1 +
 6 files changed, 93 insertions(+), 8 deletions(-)

-- 
2.9.3
