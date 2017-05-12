Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44954 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751266AbdELKay (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 May 2017 06:30:54 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: Bart Van Assche <bart.vanassche@sandisk.com>,
        Omar Sandoval <osandov@fb.com>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v4 0/4] blk-mq: support to use hw tag for scheduling
Date: Fri, 12 May 2017 18:30:37 +0800
Message-Id: <20170512103037.24422-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi,

This patchset introduces flag of BLK_MQ_F_SCHED_USE_HW_TAG and
allows to use hardware tag directly for IO scheduling if the queue's
depth is big enough. In this way, we can avoid to allocate extra tags
and request pool for IO schedule, and the schedule tag allocation/release
can be saved in I/O submit path.

V4:
	- fix build failue in patch4
	- fix tag leak issue in patch1, when tag is released before dispatching

V3:
	- respect q->nr_requests by resizing hw tags, as suggested by Omar

V2:
	- fix oops when kyber is used
	- move dumping the new flag into patch 1
	- support to use hw tag for shared tags
	- update hctx->sched_tag when BLK_MQ_F_SCHED_USE_HW_TAG is changed
	- clear the flag in patch of blk_mq_exit_sched()
	- don't update q->nr_requests when updating hw queue's depth
	- fix blk_mq_get_queue_depth()

Ming Lei (4):
  blk-mq: introduce BLK_MQ_F_SCHED_USE_HW_TAG
  blk-mq: introduce blk_mq_get_queue_depth()
  blk-mq: use hw tag for scheduling if hw tag space is big enough
  blk-mq: allow to use hw tag for shared tags

 block/blk-mq-debugfs.c |   1 +
 block/blk-mq-sched.c   |  84 ++++++++++++++++++++++++++++++++++----
 block/blk-mq-sched.h   |  18 +++++++++
 block/blk-mq.c         | 108 +++++++++++++++++++++++++++++++++++++++++++++----
 block/blk-mq.h         |  24 +++++++++++
 block/kyber-iosched.c  |   7 +++-
 include/linux/blk-mq.h |   1 +
 include/linux/blkdev.h |   8 ++++
 8 files changed, 234 insertions(+), 17 deletions(-)

-- 
2.9.3
