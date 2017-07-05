Return-Path: <sagi@grimberg.me>
From: Sagi Grimberg <sagi@grimberg.me>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <keith.busch@intel.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v2 0/8] correct quiescing in several block drivers
Date: Wed,  5 Jul 2017 09:53:03 +0300
Message-Id: <1499237591-15861-1-git-send-email-sagi@grimberg.me>
List-ID: <linux-block@vger.kernel.org>

Before we either iterate on tags we must guarantee that the
hw queues are stopped and no inflight .queue_rq is active.
Thats what blk_mq_quiesce_queue is for, so use it where appropriate.

Note that before we cleanup the request queue, we must unquiesce in
order to guarantee to not block on requests queued during quiescing.

Changes from v1:
- dropped the xen_blockfront patch, not sure if it was helpful at all
- Removed the requeue kick in nvme drivers while making nvme unconditionally
  kick the requeue list when requeuing a request instead of doing so when
  unquiescing the queues. Note that this change was a two step change to
  keep bisection possible.
- Fixed possible hangs with unquiescing before cleanup of the request queue
  in mtip32xx and nvme drivers.
- Added check that the request started in mtip32xx itration callouts.
- collected review tags.

Sagi Grimberg (8):
  nvme-rdma: quiesce/unquiesce admin_q instead of start/stop its hw
    queues
  nvme-fc: quiesce/unquiesce admin_q instead of start/stop its hw queues
  nvme-loop: quiesce/unquiesce admin_q instead of start/stop its hw
    queues
  nvme-pci: quiesce/unquiesce admin_q instead of start/stop its hw
    queues
  nvme: kick requeue list when requeueing a request instead of when
    starting the queues
  nbd: quiesce request queues to make sure no submissions are inflight
  mtip32xx: quiesce request queues to make sure no submissions are
    inflight
  virtio_blk: quiesce/unquiesce live IO when entering PM states

 drivers/block/mtip32xx/mtip32xx.c | 19 +++++++++++++++----
 drivers/block/nbd.c               |  4 ++--
 drivers/block/virtio_blk.c        |  4 ++--
 drivers/nvme/host/core.c          | 19 ++-----------------
 drivers/nvme/host/fc.c            |  5 +++--
 drivers/nvme/host/pci.c           |  9 +++++----
 drivers/nvme/host/rdma.c          |  7 ++++---
 drivers/nvme/target/loop.c        |  3 ++-
 8 files changed, 35 insertions(+), 35 deletions(-)

-- 
2.7.4
