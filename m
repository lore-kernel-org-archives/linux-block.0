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
Subject: [PATCH V4 0/7] nvme: pci: fix & improve timeout handling
Date: Sat,  5 May 2018 21:58:58 +0800
Message-Id: <20180505135905.18815-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

Hi,

The 1st patch introduces blk_quiesce_timeout() and blk_unquiesce_timeout()
for NVMe, meantime fixes blk_sync_queue().

The 2nd patch covers timeout for admin commands for recovering controller
for avoiding possible deadlock.

The 3rd and 4th patches avoid to wait_freeze on queues which aren't frozen.

The last 4 patches fixes several races wrt. NVMe timeout handler, and
finally can make blktests block/011 passed. Meantime the NVMe PCI timeout
mecanism become much more rebost than before.

gitweb:
	https://github.com/ming1/linux/commits/v4.17-rc-nvme-timeout.V4

V4:
	- fixe nvme_init_set_host_mem_cmd()
	- use nested EH model, and run both nvme_dev_disable() and
	resetting in one same context

V3:
	- fix one new race related freezing in patch 4, nvme_reset_work()
	may hang forever without this patch
	- rewrite the last 3 patches, and avoid to break nvme_reset_ctrl*()

V2:
	- fix draining timeout work, so no need to change return value from
	.timeout()
	- fix race between nvme_start_freeze() and nvme_unfreeze()
	- cover timeout for admin commands running in EH

Ming Lei (7):
  block: introduce blk_quiesce_timeout() and blk_unquiesce_timeout()
  nvme: pci: cover timeout for admin commands running in EH
  nvme: pci: only wait freezing if queue is frozen
  nvme: pci: freeze queue in nvme_dev_disable() in case of error
    recovery
  nvme: core: introduce 'reset_lock' for sync reset state and reset
    activities
  nvme: pci: prepare for supporting error recovery from resetting
    context
  nvme: pci: support nested EH

 block/blk-core.c         |  21 +++-
 block/blk-mq.c           |   9 ++
 block/blk-timeout.c      |   5 +-
 drivers/nvme/host/core.c |  46 ++++++-
 drivers/nvme/host/nvme.h |   5 +
 drivers/nvme/host/pci.c  | 304 ++++++++++++++++++++++++++++++++++++++++-------
 include/linux/blkdev.h   |  13 ++
 7 files changed, 356 insertions(+), 47 deletions(-)

Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
Cc: Laurence Oberman <loberman@redhat.com>
-- 
2.9.5
