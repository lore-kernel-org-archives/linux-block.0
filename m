Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41232 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752450AbeAFI16 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 6 Jan 2018 03:27:58 -0500
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Cc: Bart Van Assche <bart.vanassche@sandisk.com>,
        Yi Zhang <yi.zhang@redhat.com>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 0/4] blk-mq: fix race related with device deletion/reset/switching sched
Date: Sat,  6 Jan 2018 16:27:36 +0800
Message-Id: <20180106082740.26442-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi,

The 1st patch fixes one kernel oops triggered by IOs vs. deleting SCSI
device, and this issue can be triggered easily on scsi_debug.

The other 3 patch fixes recent Yi Zhang's reports about his NVMe stress
tests, most of them are related with switching io sched, NVMe reset or
updating nr_hw_queues.

V3:
	- fix 'blk-mq: support concurrent blk_mq_quiesce_queue' on SCSI,
	  which calls quiesce two times, and split blk_quiesce_queue into
	  two parts and fix this issue
	- remove previous patch 6, and Sagi provides one better patch to
	fix that, see '[PATCH v2] nvme-pci: allocate device queues storage space at probe'
	- remove patch 2 of 'blk-mq: support concurrent blk_mq_quiesce_queue()'
	  which need a bit much more work, especially we need to cleanup
	  NVMe's usage on quiesce & unquiesce first, so delay it for V4.17.

V2:
	- address stale queue mapping in blk_mq_update_queue_map(), instead
	of PCI transport, since such issue exists on other transport too,
	as suggested by Christoph
	- avoid to introduce nvme_admin_queue_rq() since the nvme queue can
	be got from hctx->driver_data, which is reliable


Thanks,
Ming

Ming Lei (4):
  blk-mq: quiesce queue before freeing queue
  blk-mq: quiesce queue during switching io sched and updating
    nr_requests
  blk-mq: avoid to map CPU into stale hw queue
  blk-mq: fix race between updating nr_hw_queues and switching io sched

 block/blk-core.c |  9 +++++++++
 block/blk-mq.c   | 53 ++++++++++++++++++++++++++++++++++++++++++++++++++---
 block/elevator.c |  2 ++
 3 files changed, 61 insertions(+), 3 deletions(-)

-- 
2.9.5
