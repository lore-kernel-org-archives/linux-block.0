Return-Path: <BATV+16a315d4c50e4aa35f4a+5251+infradead.org+hch@bombadil.srs.infradead.org>
Date: Mon, 8 Jan 2018 19:52:53 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 4.16
Message-ID: <20180108185253.3d4k2wumlm5n4yqd@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-block@vger.kernel.org>

Hi Jens,

below are the pending nvme updates for Linux 4.16.  Just fixes and
cleanups from various contributors this time around.

The following changes since commit fb350e0ad99359768e1e80b4784692031ec340e4:

  blk-mq: fix race between updating nr_hw_queues and switching io sched (2018-01-06 09:25:36 -0700)

are available in the git repository at:

  git://git.infradead.org/nvme.git nvme-4.16

for you to fetch changes up to b837b28394fb76993c28bb242db7061ee0417da6:

  nvme: fix subsystem multiple controllers support check (2018-01-08 16:57:00 +0100)

----------------------------------------------------------------
Israel Rukshin (3):
      nvmet: fix error flow in nvmet_alloc_ctrl()
      nvmet: rearrange nvmet_ctrl_free()
      nvme: fix subsystem multiple controllers support check

James Smart (5):
      nvme_fcloop: fix abort race condition
      nvme_fcloop: disassocate local port structs
      nvme_fcloop: rework to remove xxx_IN_ISR feature flags
      nvme_fcloop: refactor host/target io job access
      nvmet-fc: cleanup nvmet add_port/remove_port

Jianchao Wang (1):
      nvme-pci: fix NULL pointer reference in nvme_alloc_ns

Max Gurtovoy (1):
      nvme: modify the debug level for setting shutdown timeout

Minwoo Im (1):
      nvme-pci: remove an unnecessary initialization in HMB code

Nitzan Carmi (1):
      nvme: take refcount on transport module

Roy Shterman (1):
      nvme-fabrics: protect against module unload during create_ctrl

Sagi Grimberg (4):
      nvmet-rdma: removed queue cleanup from module exit
      nvmet-rdma: lowering log level for chatty debug messages
      nvmet: lower log level for each queue creation
      nvme-pci: don't open-code nvme_reset_ctrl

 drivers/nvme/host/core.c          |  62 ++++++++--
 drivers/nvme/host/fabrics.c       |  17 ++-
 drivers/nvme/host/fabrics.h       |   2 +
 drivers/nvme/host/fc.c            |   1 +
 drivers/nvme/host/nvme.h          |   1 +
 drivers/nvme/host/pci.c           |  38 ++++--
 drivers/nvme/host/rdma.c          |   1 +
 drivers/nvme/target/core.c        |  11 +-
 drivers/nvme/target/fabrics-cmd.c |   2 +-
 drivers/nvme/target/fc.c          |  24 +---
 drivers/nvme/target/fcloop.c      | 244 ++++++++++++++++++++++++++++++--------
 drivers/nvme/target/loop.c        |   1 +
 drivers/nvme/target/rdma.c        |  20 +---
 13 files changed, 307 insertions(+), 117 deletions(-)
