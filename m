Return-Path: <jianchao.w.wang@oracle.com>
From: Jianchao Wang <jianchao.w.wang@oracle.com>
To: axboe@kernel.dk, ming.lei@redhat.com, bart.vanassche@wdc.com,
        sagi@grimberg.me, keith.busch@intel.com, jthumshirn@suse.de,
        jsmart2021@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Subject: [PATCH 0/3] Introduce a light-weight queue close feature
Date: Wed,  5 Sep 2018 12:09:43 +0800
Message-Id: <1536120586-3378-1-git-send-email-jianchao.w.wang@oracle.com>
List-ID: <linux-block@vger.kernel.org>

Dear all

As we know, queue freeze is used to stop new IO comming in and drain
the request queue. And the draining queue here is necessary, because
queue freeze kills the percpu-ref q_usage_counter and need to drain
the q_usage_counter before switch it back to percpu mode. This could
be a trouble when we just want to prevent new IO.

In nvme-pci, nvme_dev_disable freezes queues to prevent new IO.
nvme_reset_work will unfreeze and wait to drain the queues. However,
if IO timeout at the moment, no body could do recovery as nvme_reset_work
is waiting. We will encounter IO hang.

So introduce a light-weight queue close feature in this patch set
which could prevent new IO and needn't drain the queue.

The 1st patch introduces a queue_gate into request queue and migrate
preempt only from queue flags on it.

The 2nd patch introduces queue close feature.

The 3rd patch apply the queue close in nvme-pci to avoid the IO hang
issue above.

Jianchao Wang (3)
blk-core: migrate preempt-only mode to queue_gate
blk-core: introduce queue close feature
nvme-pci: use queue close instead of queue freeze

 block/blk-core.c         | 82 +++++++++++++++++++++++++++++++++---------------
 block/blk-mq-debugfs.c   |  1 -
 block/blk.h              |  5 +++
 drivers/nvme/host/core.c | 22 +++++++++++++
 drivers/nvme/host/nvme.h |  3 ++
 drivers/nvme/host/pci.c  | 27 ++++++++--------
 drivers/scsi/scsi_lib.c  | 10 ------
 include/linux/blkdev.h   |  7 +++--
 8 files changed, 104 insertions(+), 53 deletions(-)


Thanks
Jianchao
