Return-Path: <BATV+a01a3e67072ae75c0352+5392+infradead.org+hch@bombadil.srs.infradead.org>
Date: Tue, 29 May 2018 20:54:40 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme updates for 4.18
Message-ID: <20180529185440.GA31083@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-block@vger.kernel.org>

Hi Jens,

here is the current batch of nvme updates for 4.18, we have a few more
patches in the queue, but I'd like to get this pile into your tree
and linux-next ASAP.

The biggest item is support for file-backed namespaces in the NVMe target
from Chaitanya, in addition to that we mostly small fixes from all the
usual suspects.

The following changes since commit 327ea4adcfa37194739f1ec7c70568944d292281:

  blkdev_report_zones_ioctl(): Use vmalloc() to allocate large buffers (2018-05-22 11:58:07 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-4.18-2

for you to fetch changes up to 75c8b19a23100455339af947e032f1a221344c68:

  nvme: fixup memory leak in nvme_init_identify() (2018-05-25 16:50:12 +0200)

----------------------------------------------------------------
Chaitanya Kulkarni (4):
      nvmet: make a few error messages more generic
      nvmet: remove duplicate NULL initialization for req->ns
      nvmet: add simple file backed ns support
      nvmet-loop: use nr_phys_segments when map rq to sgl

Hannes Reinecke (4):
      nvme-fabrics: centralize discovery controller defaults
      nvme-fabrics: allow duplicate connections to the discovery controller
      nvme: fix KASAN warning when parsing host nqn
      nvme: fixup memory leak in nvme_init_identify()

Ivan Bornyakov (1):
      nvme: host: core: fix precedence of ternary operator

James Smart (3):
      nvme-fc: remove setting DNR on exception conditions
      nvme-fabrics: remove unnecessary controller subnqn validation
      nvmet-fc: increase LS buffer count per fc port

Jianchao Wang (2):
      nvme-pci: set nvmeq->cq_vector after alloc cq/sq
      nvme-rdma: stop admin queue before freeing it

Johannes Thumshirn (1):
      nvme: fix lockdep warning in nvme_mpath_clear_current_path

Keith Busch (1):
      nvme-pci: Fix AER reset handling

 drivers/nvme/host/core.c                        |   9 +-
 drivers/nvme/host/fabrics.c                     |  21 +-
 drivers/nvme/host/fc.c                          |  10 -
 drivers/nvme/host/nvme.h                        |   3 +-
 drivers/nvme/host/pci.c                         |  39 +--
 drivers/nvme/host/rdma.c                        |  10 +-
 drivers/nvme/target/Makefile                    |   4 +-
 drivers/nvme/target/admin-cmd.c                 |  10 +-
 drivers/nvme/target/core.c                      |  55 +++--
 drivers/nvme/target/discovery.c                 |   2 -
 drivers/nvme/target/fabrics-cmd.c               |   4 -
 drivers/nvme/target/fc.c                        |   2 +-
 drivers/nvme/target/{io-cmd.c => io-cmd-bdev.c} |  77 +++---
 drivers/nvme/target/io-cmd-file.c               | 300 ++++++++++++++++++++++++
 drivers/nvme/target/loop.c                      |   2 +-
 drivers/nvme/target/nvmet.h                     |  28 ++-
 16 files changed, 457 insertions(+), 119 deletions(-)
 rename drivers/nvme/target/{io-cmd.c => io-cmd-bdev.c} (76%)
 create mode 100644 drivers/nvme/target/io-cmd-file.c
