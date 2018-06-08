Return-Path: <BATV+f5bbbbcfc715f881e6bf+5402+infradead.org+hch@bombadil.srs.infradead.org>
Date: Fri, 8 Jun 2018 07:58:11 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for 4.18
Message-ID: <20180608055811.24xz3qfvf3gsvuef@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-block@vger.kernel.org>

Hi Jens,

a few more small fixes for NVMe for this merge window:

The following changes since commit af6c5d5e01ad9f2c9ca38cccaae6b5d67ddd241f:

  Merge branch 'for-4.18' of git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq (2018-06-05 17:31:33 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-4.18

for you to fetch changes up to 9ce44fde233fcbe5eca34f97f2a68b97d3ca833b:

  nvme: cleanup double shift issue (2018-06-07 16:27:08 +0200)

----------------------------------------------------------------
Christoph Hellwig (1):
      nvmet: return all zeroed buffer when we can't find an active namespace

Dan Carpenter (1):
      nvme: cleanup double shift issue

Johannes Thumshirn (1):
      nvme: don't hold nvmf_transports_rwsem for more than transport lookups

Keith Busch (6):
      nvme-pci: remove unnecessary nested locking
      nvme-pci: remove unnecessary completion doorbell check
      nvme-pci: queue creation fixes
      nvme-pci: remove HMB teardown on reset
      nvme-pci: unquiesce dead controller queues
      nvme-pci: make CMB SQ mod-param read-only

Sagi Grimberg (1):
      nvmet: filter newlines from user input

Steve Wise (1):
      nvme-rdma: correctly check for target keyed sgl support

 drivers/nvme/host/core.c        |  4 ++--
 drivers/nvme/host/fabrics.c     |  3 ++-
 drivers/nvme/host/fabrics.h     |  3 +++
 drivers/nvme/host/nvme.h        |  1 -
 drivers/nvme/host/pci.c         | 35 ++++++++++-------------------------
 drivers/nvme/host/rdma.c        |  5 +++--
 drivers/nvme/target/admin-cmd.c | 15 +++++++++------
 drivers/nvme/target/configfs.c  | 14 +++++++++-----
 8 files changed, 38 insertions(+), 42 deletions(-)
