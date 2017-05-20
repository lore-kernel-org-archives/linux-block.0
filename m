Return-Path: <BATV+b4fbce47cc06aa9bd228+5018+infradead.org+hch@bombadil.srs.infradead.org>
Date: Sat, 20 May 2017 15:10:48 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: [GIT PULL] nvme fixes for 4.12-rc2
Message-ID: <20170520131048.cjmpq2dnttritszb@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-block@vger.kernel.org>

Hi Jens,

a few fixes for 4.12-rc2.  There are a few more that we need to get into
4.12, but I'd rather get the current queue to you ASAP.


The following changes since commit 56868a460b83c0f93d339256a81064d89aadae8e:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/ide (2017-05-09 15:56:58 -0700)

are available in the git repository at:

  git://git.infradead.org/nvme.git nvme-4.12

for you to fetch changes up to 3d5d1207d61b522b6aac24f896e53401e876b26e:

  nvmet: release the sq ref on rdma read errors (2017-05-11 12:52:46 +0200)

----------------------------------------------------------------
James Smart (4):
      nvme-fc: correct port role bits
      nvme-fc: require target or discovery role for fc-nvme targets
      nvme-fc: stop queues on error detection
      nvmet-fc: remove target cpu scheduling flag

Jon Derrick (1):
      nvme: unmap CMB and remove sysfs file in reset path

Vijay Immanuel (1):
      nvmet: release the sq ref on rdma read errors

 drivers/nvme/host/fc.c         | 10 ++++++++++
 drivers/nvme/host/pci.c        |  7 ++++++-
 drivers/nvme/target/core.c     |  6 ++++++
 drivers/nvme/target/fc.c       |  4 +---
 drivers/nvme/target/fcloop.c   |  1 -
 drivers/nvme/target/nvmet.h    |  1 +
 drivers/nvme/target/rdma.c     |  1 +
 drivers/scsi/lpfc/lpfc_nvmet.c |  1 -
 include/linux/nvme-fc-driver.h | 16 ++++------------
 9 files changed, 29 insertions(+), 18 deletions(-)
