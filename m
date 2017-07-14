Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:21807 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751012AbdGNXQW (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Jul 2017 19:16:22 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Cc: Bart Van Assche <bart.vanassche@sandisk.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/6] blk-mq: cleanup start/stop queue
Date: Sat, 15 Jul 2017 07:15:55 +0800
Message-Id: <20170714231601.14444-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi,

We have replaced most of start/stop queue via quiesce/unquiesce.
And only the usage in case of handling BLK_STS_RESOURCE is kept.
This patch moves this handling into blk-mq for xen-blkfront and
virtio-blk, then we can avoid to let drivers touch the 'stopped'
state, because allowing driver to do that has caused lots of trouble
for us.

Thanks,
Ming

Ming Lei (6):
  xen-blkfront: quiesce/unquiesce queue instead of start/stop queues
  SCSI: use blk_mq_run_hw_queues() in scsi_kick_queue()
  block: don't call blk_mq_delay_run_hw_queue() in case of
    BLK_STS_RESOURCE
  blk-mq: introduce auto restart
  block: use BLK_MQ_F_AUTO_RESTART on virtio-blk and xen-blkfront
  blk-mq: unexport APIs for start/stop queues

 block/blk-mq.c               | 124 +++++++++++++++----------------------------
 block/blk-mq.h               |   1 +
 drivers/block/virtio_blk.c   |   8 +--
 drivers/block/xen-blkfront.c |  31 +++--------
 drivers/md/dm-rq.c           |   1 -
 drivers/nvme/host/fc.c       |   3 --
 drivers/scsi/scsi_lib.c      |   6 +--
 include/linux/blk-mq.h       |   9 +---
 8 files changed, 54 insertions(+), 129 deletions(-)

-- 
2.9.4
