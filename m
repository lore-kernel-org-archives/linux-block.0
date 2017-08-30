Return-Path: <BATV+780813b3d5625c257917+5120+infradead.org+hch@bombadil.srs.infradead.org>
Date: Wed, 30 Aug 2017 17:07:55 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: [GIT PULL] last minute NVMe fixes for 4.13
Message-ID: <20170830150755.r64wwfrawsb4i34w@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-block@vger.kernel.org>

Hi Jens,

three more fixes for 4.13 below:

 - fix the incorrect bit for the doorbell buffer features (Changpeng Liu)
 - always use a 4k MR page size for RDMA, to not get in trouble with
   offset in non-4k page size systems (no-op for x86) (Max Gurtovoy)
 - and a fix for the new nvme host memory buffer support to keep the
   descriptor list DMA mapped when the buffer is enabled (me)

The following changes since commit e9d8a0fdeacd843c85dcef480cdb2ab76bcdb6e4:

  nvme-pci: set cqe_seen on polled completions (2017-08-18 09:19:39 +0200)

are available in the git repository at:

  git://git.infradead.org/nvme.git nvme-4.13

for you to fetch changes up to 223694b9ae8bfba99f3528d49d07a740af6ff95a:

  nvme: fix the definition of the doorbell buffer config support bit (2017-08-30 14:46:32 +0200)

----------------------------------------------------------------
Changpeng Liu (1):
      nvme: fix the definition of the doorbell buffer config support bit

Christoph Hellwig (1):
      nvme-pci: use dma memory for the host memory buffer descriptors

Max Gurtovoy (1):
      nvme-rdma: default MR page size to 4k

 drivers/nvme/host/pci.c  | 22 +++++++++++-----------
 drivers/nvme/host/rdma.c |  8 ++++++--
 include/linux/nvme.h     |  2 +-
 3 files changed, 18 insertions(+), 14 deletions(-)
