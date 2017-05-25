Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41418 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S941653AbdEYEVi (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 May 2017 00:21:38 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Cc: Bart Van Assche <bart.vanassche@sandisk.com>
Subject: [PATCH 0/7] blk-mq: fix queue quiescing
Date: Thu, 25 May 2017 12:21:24 +0800
Message-Id: <20170525042131.13172-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi,

One big problem of blk_mq_quiesce_queue() is that it
can't prevent .queue_rq() in direct issue path from
being run even though hw queues are stopped by
blk_mq_quiesce_queue().
    
It is observed that request double-free/use-after-free
can be triggered easily when canceling NVMe requests via
blk_mq_tagset_busy_iter(...nvme_cancel_request) in nvme_dev_disable().
The reason is that blk_mq_quiesce_queue() can't prevent
direct issue from being run.
 
This patchset implements queue quiescing via percpu_ref
and fixes the above issue.

Actually we have to quiesce queue for canceling dispatched
requests via blk_mq_tagset_busy_iter(), otherwise use-after-free
can be made easily. This way of canceling dispatched requests
has been used in several drivers, only NVMe uses blk_mq_quiesce_queue()
to avoid the issue, and others need to be fixed too.

Also this patchset cleans up the code much, and the fat 'srcu_struct'
can be removed from 'struct blk_mq_hw_ctx'.

Thanks,
Ming

Ming Lei (7):
  blk-mq: introduce blk_mq_unquiesce_queue
  block: introduce flag of QUEUE_FLAG_QUIESCED
  dm: use the introduced blk_mq_unquiesce_queue()
  nvme: use the introduced blk_mq_unquiesce_queue()
  scsi: use the introduced blk_mq_unquiesce_queue()
  blk-mq: quiesce queue via percpu_ref
  blk-mq: update comments on blk_mq_quiesce_queue()

 block/blk-mq.c           | 131 +++++++++++++++++++++++++++++++----------------
 drivers/md/dm-rq.c       |   2 +-
 drivers/nvme/host/core.c |   2 +-
 drivers/scsi/scsi_lib.c  |   5 +-
 include/linux/blk-mq.h   |   2 -
 include/linux/blkdev.h   |   8 +++
 6 files changed, 102 insertions(+), 48 deletions(-)

-- 
2.9.4
