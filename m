Return-Path: <ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <keith.busch@intel.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	James Smart <james.smart@broadcom.com>,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Laurence Oberman <loberman@redhat.com>
Subject: [PATCH V6 00/11] nvme: pci: fix & improve timeout handling
Date: Wed, 16 May 2018 12:03:02 +0800
Message-Id: <20180516040313.13596-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

Hi,

The 1st patch introduces blk_quiesce_timeout() and blk_unquiesce_timeout()
for NVMe, meantime fixes blk_sync_queue().

The 2nd and 3rd patches fix race between nvme_dev_disable() and
controller reset, and avoids double irq freeing and IO hang after
queues are killed.

The 4th patch covers timeout for admin commands for recovering controller
for avoiding possible deadlock.

The 5rd and 6th patches avoid to wait_freeze on queues which aren't frozen.

The last 5 patches fixes several races wrt. NVMe timeout handler. Meantime
the NVMe PCI timeout mecanism become much more rebost than before.

With this patchset, block/011 can be passed.

Also run block 019, it still passed.

Please reivew, ack and test!

gitweb:
	https://github.com/ming1/linux/commits/v4.17-rc-nvme-timeout.V6

V6:
	- fix EH seq number so that correct EH name can be shown in log
	- avoid NULL pointer dereference of admin queue
	- avoid request leak in nvme_set_host_mem_timeout
	- cover races between nvme_dev_disable() and reset wrt. cq_vector
	- think EH as done when its state is updated as ADMIN_ONLY

V5:
	- avoid to remove controller in case of reset failure in inner EHs
	- make sure that nvme_unfreeze and nvme_start_freeze are paired

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

Ming Lei (10):
  block: introduce blk_quiesce_timeout() and blk_unquiesce_timeout()
  nvme: pci: cover timeout for admin commands running in EH
  nvme: pci: unquiesce admin queue after controller is shutdown
  nvme: pci: only wait freezing if queue is frozen
  nvme: pci: freeze queue in nvme_dev_disable() in case of error
    recovery
  nvme: pci: prepare for supporting error recovery from resetting
    context
  nvme: pci: move error handling out of nvme_reset_dev()
  nvme: pci: don't unfreeze queue until controller state updating
    succeeds
  nvme: core: introduce nvme_force_change_ctrl_state()
  nvme: pci: support nested EH

jianchao.wang (1):
  nvme: pci: set nvmeq->cq_vector after alloc cq/sq

 block/blk-core.c         |  21 ++-
 block/blk-mq.c           |   9 +
 block/blk-timeout.c      |   5 +-
 drivers/nvme/host/core.c |  57 ++++++
 drivers/nvme/host/nvme.h |   7 +
 drivers/nvme/host/pci.c  | 450 ++++++++++++++++++++++++++++++++++++++++-------
 include/linux/blkdev.h   |  13 ++
 7 files changed, 499 insertions(+), 63 deletions(-)

Cc: James Smart <james.smart@broadcom.com>
Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
Cc: Laurence Oberman <loberman@redhat.com>
-- 
2.9.5
