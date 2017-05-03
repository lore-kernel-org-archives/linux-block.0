Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44058 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757633AbdECT6x (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 3 May 2017 15:58:53 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: Bart Van Assche <bart.vanassche@sandisk.com>,
        Omar Sandoval <osandov@fb.com>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 0/5] blk-mq: support to use hw tag for scheduling
Date: Thu,  4 May 2017 03:58:34 +0800
Message-Id: <20170503195839.6539-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi,

This patchset introduces flag of BLK_MQ_F_SCHED_USE_HW_TAG and
allows to use hardware tag directly for IO scheduling if the queue's
depth is big enough. In this way, we can avoid to allocate extra tags
and request pool for IO schedule, and the schedule tag allocation/release
can be saved in I/O submit path.

V2:
	- fix oops when kyber is used
	- move dumping the new flag into patch 1
	- support to use hw tag for shared tags
	- update hctx->sched_tag when BLK_MQ_F_SCHED_USE_HW_TAG
	is changed
	- clear the flag in patch of blk_mq_exit_sched()
	- don't update q->nr_requests when updating hw queue's depth
	- fix blk_mq_get_queue_depth()

Thanks reviewing from Bart, Omar, Jens and others.


Thanks,
Ming

Ming Lei (5):
  blk-mq: introduce BLK_MQ_F_SCHED_USE_HW_TAG
  blk-mq: introduce blk_mq_get_queue_depth()
  blk-mq: don't update q->nr_requests when updating hw queue's depth
  blk-mq: use hw tag for scheduling if hw tag space is big enough
  blk-mq: allow to use hw tag for shared tags

 block/blk-mq-debugfs.c |  1 +
 block/blk-mq-sched.c   | 34 ++++++++++++++++-----
 block/blk-mq-sched.h   | 24 +++++++++++++++
 block/blk-mq.c         | 82 +++++++++++++++++++++++++++++++++++++++++++++-----
 block/blk-mq.h         | 12 ++++++++
 block/kyber-iosched.c  |  7 ++++-
 include/linux/blk-mq.h |  1 +
 7 files changed, 144 insertions(+), 17 deletions(-)

-- 
2.9.3
