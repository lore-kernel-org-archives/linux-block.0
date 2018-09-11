Return-Path: <jianchao.w.wang@oracle.com>
From: Jianchao Wang <jianchao.w.wang@oracle.com>
To: axboe@kernel.dk, ming.lei@redhat.com, bart.vanassche@wdc.com,
        sagi@grimberg.me, keith.busch@intel.com, hch@lst.de
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: [RFC PATCH 0/4] blk-mq: introduce bio retrieve mechanism
Date: Tue, 11 Sep 2018 17:48:10 +0800
Message-Id: <1536659294-2321-1-git-send-email-jianchao.w.wang@oracle.com>
List-ID: <linux-block@vger.kernel.org>

Hi all

This patchset introduces a new bio retrieve mechanism. It  will
flush all the requests on queue, take the bios down from them and
end them, then the bios will be submied again later. Then we could
avoid:
 - fail requests on the dying hw queues
 - depend on storage device to drain the queue
This 1st case could be fatal for filesystem and the 2nd case could
cause IO hang in nvme_reset_work.

The 1st patch introduces this feature.
The 2nd patch apply it in the updating nr_hw_queues
The 3rd patch unquiesces the queues after updating nr_hw_queues
The 4th patch discards the cq_vector checking in nvme_queue_rq

Jianchao Wang(4)
blk-mq: introduce bio retrieve mechanism
blk-mq: retrieve bios before update nr_hw_queues
nvme-pci: unquiesce queues after update nr_hw_queues
nvme-pci: discard the cq_vector checking in nvme_queue_rq


 block/blk-mq-sched.c    | 78 +++++++++++++++++++++++++++++++++++++++++++++++++
 block/blk-mq.c          | 50 ++++++++++++++++++++++++++++++-
 drivers/nvme/host/pci.c | 13 +++------
 include/linux/blk-mq.h  |  4 +++
 include/linux/blkdev.h  |  2 ++
 5 files changed, 137 insertions(+), 10 deletions(-)

Thanks
Jianchao
