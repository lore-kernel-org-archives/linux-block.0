Return-Path: <ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <keith.busch@intel.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Laurence Oberman <loberman@redhat.com>
Subject: [PATCH V3 0/8] nvme: pci: fix & improve timeout handling
Date: Thu,  3 May 2018 11:17:08 +0800
Message-Id: <20180503031716.31446-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

Hi,

The 1st patch introduces blk_quiesce_timeout() and blk_unquiesce_timeout()
for NVMe, meantime fixes blk_sync_queue().

The 2nd patch covers timeout for admin commands for recovering controller
for avoiding possible deadlock.

The 3~5 patches fixes race between nvme_start_freeze() and
nvme_unfreeze().

The last 3 patches fixes several races wrt. NVMe timeout handler, and
finally can make blktests block/011 passed. Meantime the NVMe timeout
model gets simplified a lot.

gitweb:
	https://github.com/ming1/linux/commits/v4.17-rc-nvme-timeout.V3

V3:
	- fix one new race related freezing in patch 4, nvme_reset_work()
	may hang forever without this patch
	- rewrite the last 3 patches, and avoid to break nvme_reset_ctrl*()

V2:
	- fix draining timeout work, so no need to change return value from
	.timeout()
	- fix race between nvme_start_freeze() and nvme_unfreeze()
	- cover timeout for admin commands running in EH

Ming Lei (8):
  block: introduce blk_quiesce_timeout() and blk_unquiesce_timeout()
  nvme: pci: cover timeout for admin commands running in EH
  nvme: pci: only wait freezing if queue is frozen
  nvme: pci: freeze queue in nvme_dev_disable() in case of error
    recovery
  nvme: fix race between freeze queues and unfreeze queues
  nvme: pci: split controller resetting into two parts
  nvme: pci: recover controller reliably
  nvme: pci: simplify timeout handling

 block/blk-core.c         |  21 ++-
 block/blk-mq.c           |   9 ++
 block/blk-timeout.c      |   5 +-
 drivers/nvme/host/core.c |  47 ++++++-
 drivers/nvme/host/nvme.h |   6 +
 drivers/nvme/host/pci.c  | 344 ++++++++++++++++++++++++++++++++++++++++-------
 include/linux/blkdev.h   |  13 ++
 7 files changed, 391 insertions(+), 54 deletions(-)

Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
Cc: Laurence Oberman <loberman@redhat.com>

-- 
2.9.5
