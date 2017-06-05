Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55570 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751077AbdFEQAE (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 5 Jun 2017 12:00:04 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Cc: Bart Van Assche <bart.vanassche@sandisk.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v4 00/11] blk-mq: fix & improve queue quiescing
Date: Mon,  5 Jun 2017 23:59:14 +0800
Message-Id: <20170605155925.7896-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi,

There is one big issue in current blk_mq_quiesce_queue():

    - in case of direct issue or BLK_MQ_S_START_ON_RUN, dispatch won't
    be prevented after blk_mq_quiesce_queue() is returned.

The 1st patch fixes the problem in direct issue, please consider it for v4.12.

The other 10 patches improves blk_mq_quiesce_queue(), and
make is easy to use, and avoid race between queue restart and
quiescing. These 10 patches should be for v4.13.

One typical use case of blk_mq_quiesce_queue() is for canceling
requests when queue is dead. Currently, only NVMe uses this API
for canceling requests. Actually we have to quiesce queue first
before canceling requests in other drivers too, such as NBD and
mtip32xx,

Another use case is for freezing device, for example, virtio-blk
uses stopping queue in virtblk_freeze(), but that way isn't safe
becasue dispatch still may happen after blk_mq_stop_hw_queues()
returns.

Unfortunately blk_mq_quiesce_queue() is implemented via stopping queue,
we can't switch to blk_mq_quiesce_queue() simply in above cases because
any queue restart in other pathes may break blk_mq_quiesce_queue().
For example, we sometimes stops queue when hw can't handle too many
ongoing requests and restarts queue after requests are completed.
Meantime when we want to cancel requests if hardware is dead or need
to suspend, quiescing has to be run first, then the restarting
in complete path can break quiescing easily. This patch improves this
interface via removing stopping queue, then it can be easier to use.

V4:
	- introduce the 1st patch for fixing direct issue
	- take Bart's suggestion to deal with quiescing in SCSI
	- avoid to introduce waitqueue

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

Ming Lei (11):
  blk-mq: fix direct issue
  blk-mq: move blk_mq_quiesce_queue() into include/linux/blk-mq.h
  blk-mq: introduce blk_mq_quiesce_queue_nowait()
  blk-mq: introduce blk_mq_unquiesce_queue
  blk-mq: use the introduced blk_mq_unquiesce_queue()
  nvme: host: unquiesce queue in nvme_kill_queues()
  blk-mq: use QUEUE_FLAG_QUIESCED to quiesce queue
  blk-mq: update comments on blk_mq_quiesce_queue()
  blk-mq: don't stop queue for quiescing
  blk-mq: clarify dispatch may not be drained/blocked by stopping queue
  Revert "blk-mq: don't use sync workqueue flushing from drivers"

 block/blk-mq-sched.c     |  3 +-
 block/blk-mq.c           | 80 ++++++++++++++++++++++++++++++------------------
 drivers/md/dm-rq.c       |  2 +-
 drivers/nvme/host/core.c |  8 ++++-
 drivers/scsi/scsi_lib.c  |  4 +--
 include/linux/blk-mq.h   | 12 ++++++++
 include/linux/blkdev.h   |  3 +-
 7 files changed, 77 insertions(+), 35 deletions(-)

-- 
2.9.4
