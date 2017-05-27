Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43198 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751088AbdE0OVo (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 27 May 2017 10:21:44 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Cc: Bart Van Assche <bart.vanassche@sandisk.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v2 0/8] blk-mq: fix & improve queue quiescing
Date: Sat, 27 May 2017 22:21:18 +0800
Message-Id: <20170527142126.26079-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi,

There are some issues in current blk_mq_quiesce_queue():

    - in case of direct issue or BLK_MQ_S_START_ON_RUN, dispatch won't
    be prevented after blk_mq_quiesce_queue() is returned.
    - in theory, new RCU read-side critical sections may begin while
    synchronize_rcu() was waiting, and end after returning from 
    synchronize_rcu(), then dispatch still may be run after
    synchronize_rcu() returns

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
limits its uses, and easy to casue race, because any queue restart in
other paths may break blk_mq_quiesce_queue(). For example, we sometimes
stops queue when hw can't handle too many ongoing requests and restarts
queue after requests are completed. Meantime when we want to cancel
requests if hardware is dead, quiescing has to be run first, then the
restarting in complete path can break the quiescing. This patch improves
this interface via removing stopping queue, then it can be easier
to use.

V2:
	- split patch "blk-mq: fix blk_mq_quiesce_queue" into two and
  	fix one build issue when only applying the 1st two patches.
	- add kernel oops and hang log into commit log
	- add 'Revert "blk-mq: don't use sync workqueue flushing from drivers"'

 
Ming Lei (8):
  blk-mq: introduce blk_mq_unquiesce_queue
  block: introduce flag of QUEUE_FLAG_QUIESCED
  blk-mq: use the introduced blk_mq_unquiesce_queue()
  blk-mq: fix blk_mq_quiesce_queue
  blk-mq: update comments on blk_mq_quiesce_queue()
  blk-mq: don't stop queue for quiescing
  blk-mq: clarify dispatch may not be drained/blocked by stopping queue
  Revert "blk-mq: don't use sync workqueue flushing from drivers"

 block/blk-mq.c           | 89 +++++++++++++++++++++++++++++++++---------------
 drivers/md/dm-rq.c       |  2 +-
 drivers/nvme/host/core.c |  2 +-
 drivers/scsi/scsi_lib.c  |  5 ++-
 include/linux/blkdev.h   |  3 ++
 5 files changed, 71 insertions(+), 30 deletions(-)

-- 
2.9.4
