Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60322 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751009AbdEaMhX (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 May 2017 08:37:23 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Cc: Bart Van Assche <bart.vanassche@sandisk.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v3 0/8] blk-mq: fix & improve queue quiescing
Date: Wed, 31 May 2017 20:36:57 +0800
Message-Id: <20170531123706.20885-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

There is one big issue in current blk_mq_quiesce_queue():

    - in case of direct issue or BLK_MQ_S_START_ON_RUN, dispatch won't
    be prevented after blk_mq_quiesce_queue() is returned.

It is observed that request double-free/use-after-free
can be triggered easily when canceling NVMe requests via
blk_mq_tagset_busy_iter(...nvme_cancel_request) in nvme_dev_disable().
The reason is that blk_mq_quiesce_queue() can't prevent
dispatching from being run during the period.

Actually we have to quiesce queue for canceling dispatched
requests via blk_mq_tagset_busy_iter(), otherwise use-after-free
can be made easily. This way of canceling dispatched requests
has been used in several drivers, only NVMe uses blk_mq_quiesce_queue()
to avoid the issue, and others need to be fixed too. And it
should be a common way for handling dead controller.

blk_mq_quiesce_queue() is implemented via stopping queue, which
limits its uses, and easy to cause race, because any queue restart in
other paths may break blk_mq_quiesce_queue(). For example, we sometimes
stops queue when hw can't handle too many ongoing requests and restarts
queue after requests are completed. Meantime when we want to cancel
requests if hardware is dead or suspend request is received, quiescing
has to be run first, then the restarting in complete path can break the
quiescing. This patch improves this interface via removing stopping queue,
then it can be easier to use.

V3:
	- wait until queue becomes unquiesced in direct issue path, so
	we can avoid to queue the current req into sw queue or scheduler
	queue, then the state of STOPPED needn't to be touched
	- move checking of !blk_queue_quiesced() into blk_mq_sched_dispatch_requests()
	as suggested by Bart
	- NVMe: unquiesce queue in nvme_kill_queues()
	- misc changes(fix grammer issue in commit log or comment, ...)

V2:
	- split patch "blk-mq: fix blk_mq_quiesce_queue" into two and
  	fix one build issue when only applying the 1st two patches.
	- add kernel oops and hang log into commit log
	- add 'Revert "blk-mq: don't use sync workqueue flushing from drivers"'

Ming Lei (9):
  blk-mq: introduce blk_mq_unquiesce_queue
  block: introduce flag of QUEUE_FLAG_QUIESCED
  blk-mq: use the introduced blk_mq_unquiesce_queue()
  nvme: host: unquiesce queue in nvme_kill_queues()
  blk-mq: fix blk_mq_quiesce_queue
  blk-mq: update comments on blk_mq_quiesce_queue()
  blk-mq: don't stop queue for quiescing
  blk-mq: clarify dispatch may not be drained/blocked by stopping queue
  Revert "blk-mq: don't use sync workqueue flushing from drivers"

 block/blk-mq-sched.c     |  3 +-
 block/blk-mq.c           | 78 ++++++++++++++++++++++++++++++++----------------
 drivers/md/dm-rq.c       |  2 +-
 drivers/nvme/host/core.c |  5 +++-
 drivers/scsi/scsi_lib.c  |  5 +++-
 include/linux/blkdev.h   |  6 ++++
 6 files changed, 70 insertions(+), 29 deletions(-)

-- 
2.9.4
