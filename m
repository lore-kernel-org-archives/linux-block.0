Return-Path: <jianchao.w.wang@oracle.com>
From: Jianchao Wang <jianchao.w.wang@oracle.com>
To: axboe@kernel.dk
Cc: hch@lst.de, keith.busch@linux.intel.com, ming.lei@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 0/3] blk-mq: introduce bio retrieve mechanism
Date: Wed, 17 Oct 2018 17:07:09 +0800
Message-Id: <1539767232-9389-1-git-send-email-jianchao.w.wang@oracle.com>
List-ID: <linux-block@vger.kernel.org>

Hi Jenss

This patchset introduces a new bio retrieve mechanism. It will
flush all the requests, take the bios down from them and end them,
then submit the bios again later. Then we could
avoid:
 - fail requests on the dying hw queues, this could be fatal for
   filesystem.
 - depend on storage device to drain the queue before update hw queues.
   this could introduce hung into nvme_reset_work.

The 1st patch introduce the bio retrieve mechanism
The 2nd patch apply the bio retrieve mechanism in updating hw queues
The 3rd patch unquiesces the queues after updating hw queues in nvme_reset_work

V2:
 - clear BIO_QUEUE_ENTERED of requeued bios (1/3)
 - sync bio_requeue_work in blk_cleanup_queue (1/3)
 - discard the unnecessary synchronize_sched (2/3)
 - discard the 4th patch which is wrong
 - some misc comment changes

Jianchao Wang(3)
blk-mq: introduce bio retrieve mechanism
blk-mq: retrieve bios before update nr_hw_queues
nvme-pci: unquiesce queues after update hw queues


 block/blk-core.c        |  2 ++
 block/blk-mq-sched.c    | 88 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 block/blk-mq.c          | 47 ++++++++++++++++++++++++++++++++++++++++++++++-
 drivers/nvme/host/pci.c |  4 ++--
 include/linux/blk-mq.h  |  4 ++++
 include/linux/blkdev.h  |  2 ++
 6 files changed, 144 insertions(+), 3 deletions(-)

Thanks
Jianchao
