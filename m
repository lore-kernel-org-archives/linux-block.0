Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56686 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752758AbdLSPaR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Dec 2017 10:30:17 -0500
Date: Tue, 19 Dec 2017 10:30:16 -0500 (EST)
From: Yi Zhang <yi.zhang@redhat.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <keith.busch@intel.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Bart Van Assche <bart.vanassche@sandisk.com>
Message-ID: <1119473730.1189848.1513697416782.JavaMail.zimbra@redhat.com>
In-Reply-To: <20171214023103.18272-1-ming.lei@redhat.com>
References: <20171214023103.18272-1-ming.lei@redhat.com>
Subject: Re: [PATCH V2 0/6] blk-mq: fix race related with device
 deletion/reset/switching sched
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Thanks ming.

Tested-by: Yi Zhang <yi.zhang@redhat.com>

Best Regards,
  Yi Zhang


----- Original Message -----
From: "Ming Lei" <ming.lei@redhat.com>
To: linux-nvme@lists.infradead.org, "Christoph Hellwig" <hch@lst.de>, "Jens Axboe" <axboe@fb.com>, linux-block@vger.kernel.org
Cc: "Yi Zhang" <yi.zhang@redhat.com>, "Sagi Grimberg" <sagi@grimberg.me>, "Ming Lei" <ming.lei@redhat.com>, "Keith Busch" <keith.busch@intel.com>, "Johannes Thumshirn" <jthumshirn@suse.de>, "Bart Van Assche" <bart.vanassche@sandisk.com>
Sent: Thursday, December 14, 2017 10:30:57 AM
Subject: [PATCH V2 0/6] blk-mq: fix race related with device deletion/reset/switching sched

Hi,

The 1st patch fixes one kernel oops triggered by IOs vs. deleting SCSI
device, and this issue can be triggered easily on scsi_debug.

The other 5 patch fixes recent Yi Zhang's reports about his NVMe stress
tests, most of them are related with switching io sched, NVMe reset or
updating nr_hw_queues.

V2:
	- address stale queue mapping in blk_mq_update_queue_map(), instead
	of PCI transport, since such issue exists on other transport too,
	as suggested by Christoph
	- avoid to introduce nvme_admin_queue_rq() since the nvme queue can
	be got from hctx->driver_data, which is reliable


Thanks,
Ming

Ming Lei (6):
  blk-mq: quiesce queue before freeing queue
  blk-mq: support concurrent blk_mq_quiesce_queue()
  blk-mq: quiesce queue during switching io sched and updating
    nr_requests
  blk-mq: avoid to map CPU into stale hw queue
  blk-mq: fix race between updating nr_hw_queues and switching io sched
  nvme-pci: remove .init_request callback

 block/blk-core.c         |  9 ++++++
 block/blk-mq.c           | 74 ++++++++++++++++++++++++++++++++++++++++++------
 block/elevator.c         |  2 ++
 drivers/nvme/host/core.c |  4 +--
 drivers/nvme/host/pci.c  | 21 +++-----------
 include/linux/blk-mq.h   |  7 ++++-
 include/linux/blkdev.h   |  2 ++
 7 files changed, 91 insertions(+), 28 deletions(-)

-- 
2.9.5


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
