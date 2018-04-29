Return-Path: <ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <keith.busch@intel.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: [PATCH V2 0/5] nvme: pci: fix & improve timeout handling
Date: Sun, 29 Apr 2018 23:41:47 +0800
Message-Id: <20180429154152.16656-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

Hi,

The 1st patch introduces blk_quiesce_timeout() and blk_unquiesce_timeout()
for NVMe, meantime fixes blk_sync_queue().

The 2nd patch covers timeout for admin commands for recovering controller
for avoiding possible deadlock.

The other 3 patches fixes several races wrt. NVMe timeout handler, and
finally can make blktests block/011 passed.


Ming Lei (5):
  block: introduce blk_quiesce_timeout() and blk_unquiesce_timeout()
  nvme: pci: cover timeout for admin commands running in EH
  nvme: pci: only wait freezing if queue is frozen
  nvme: fix race between freeze queues and unfreeze queues
  nvme: pci: simplify timeout handling

V2:
	- fix draining timeout work, so no need to change return value from
	.timeout()
	- fix race between nvme_start_freeze() and nvme_unfreeze()
	- cover timeout for admin commands running in EH

 block/blk-core.c         |  34 +++++++-
 block/blk-mq.c           |   9 ++
 block/blk-timeout.c      |   5 +-
 drivers/nvme/host/core.c |  47 ++++++++--
 drivers/nvme/host/nvme.h |   6 ++
 drivers/nvme/host/pci.c  | 222 ++++++++++++++++++++++++++++++++++++++++++-----
 include/linux/blkdev.h   |   4 +
 7 files changed, 296 insertions(+), 31 deletions(-)

Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org

-- 
2.9.5
