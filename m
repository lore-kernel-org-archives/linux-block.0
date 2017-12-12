Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37768 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751503AbdLLLC5 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Dec 2017 06:02:57 -0500
From: Ming Lei <ming.lei@redhat.com>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: Bart Van Assche <bart.vanassche@sandisk.com>,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Yi Zhang <yi.zhang@redhat.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/6] blk-mq: fix race related with device deletion/reset/switching sched
Date: Tue, 12 Dec 2017 19:02:26 +0800
Message-Id: <20171212110232.12495-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi,

The 1st patch fixes one kernel oops triggered by IOs vs. deleting SCSI
device, and this issue can be triggered in less than 1min on scsi_debug.

The other 5 patch fixes recent Yi Zhang's reports about his NVMe stress
tests, most of them are related with switching io sched, NVMe reset or
updating nr_hw_queues.

Thanks,
Ming


Ming Lei (6):
  blk-mq: quiesce queue before freeing queue
  blk-mq: support concurrent blk_mq_quiesce_queue()
  blk-mq: quiesce queue during switching io sched and updating
    nr_requests
  blk-mq: avoid to map CPU into stale hw queue
  blk-mq: fix race between updating nr_hw_queues and switching io sched
  nvme: remove .init_request callback

 block/blk-core.c         |  9 +++++++++
 block/blk-mq-pci.c       |  8 ++++++++
 block/blk-mq.c           | 52 ++++++++++++++++++++++++++++++++++++++++++------
 block/elevator.c         |  2 ++
 drivers/nvme/host/core.c |  4 ++--
 drivers/nvme/host/pci.c  | 40 ++++++++++++++++++-------------------
 include/linux/blk-mq.h   |  7 ++++++-
 include/linux/blkdev.h   |  2 ++
 8 files changed, 95 insertions(+), 29 deletions(-)

-- 
2.9.5
