Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42130 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756250AbdGKSVZ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Jul 2017 14:21:25 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Cc: Bart Van Assche <bart.vanassche@sandisk.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/6] blk-mq: introduce congestion control
Date: Wed, 12 Jul 2017 02:20:57 +0800
Message-Id: <20170711182103.11461-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi,

The 1st patch converts two start/stop queue into quiesce/unquiesce
in xen-blkfront.

The 2nd patch uses blk_mq_run_hw_queues() in SCSI becasue the queue
won't be stopped at all. 

The 3rd patch prepares for introducing congestion control for blk-mq.

The 4th patch uses EWMA to estimate congestion threshold.

The 5th patch uses the estimated congestion threshold to dectect
congestion. Once the congestion is found, queue is stopped, and will
be restarted if the condition is invalid.

The 6th patch unexports several APIs for starting/stopping queue,
then the STOPPED state of queue becomes a internal state, and it
is invisible to drivers now.

This patchset is against on Sagi Grimberg's patchset of "[PATCH v3 0/8]
correct quiescing in several block drivers", which can be found
in:
	http://marc.info/?t=149927415900006&r=1&w=2

Any comments are welcome!

Ming Lei (6):
  xen-blkfront: avoid to use start/stop queue
  SCSI: use blk_mq_run_hw_queues() in scsi_kick_queue()
  blk-mq: send the request to dispatch list if direct issue returns busy
  blk-mq: use EWMA to estimate congestion threshold
  blk-mq: introduce basic congestion control
  blk-mq: unexport APIs for start/stop queues

 block/blk-mq.c               | 143 ++++++++++++++++++-------------------------
 block/blk-mq.h               |  11 ++++
 drivers/block/virtio_blk.c   |   7 ---
 drivers/block/xen-blkfront.c |  28 ++-------
 drivers/md/dm-rq.c           |   1 -
 drivers/nvme/host/fc.c       |   4 --
 drivers/scsi/scsi_lib.c      |   5 +-
 include/linux/blk-mq.h       |  10 +--
 8 files changed, 79 insertions(+), 130 deletions(-)

-- 
2.9.4
