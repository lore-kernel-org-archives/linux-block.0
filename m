Return-Path: <BATV+f91223e0de2c9036fbc6+5086+infradead.org+hch@bombadil.srs.infradead.org>
Date: Thu, 27 Jul 2017 15:30:11 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@intel.com>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: [GIT PULL] nvme updates for 4.13-rc3
Message-ID: <20170727133011.2vyqepblk2oboit4@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-block@vger.kernel.org>

Just a couple small fixes all over.

The following changes since commit 76451d79bde6bed17e113f057e58e1fa5fb79e78:

  blk-mq: map queues to all present CPUs (2017-07-24 10:01:31 -0600)

are available in the git repository at:

  git://git.infradead.org/nvme.git nvme-4.13

for you to fetch changes up to 7dd1ab163c17e11473a65b11f7e748db30618ebb:

  nvme: validate admin queue before unquiesce (2017-07-26 17:41:41 +0200)

----------------------------------------------------------------
Christoph Hellwig (1):
      nvme-pci: fix HMB size calculation

James Smart (2):
      nvme-fc: address target disconnect race conditions in fcp io submit
      nvme-fc: revise TRADDR parsing

Johannes Thumshirn (1):
      nvme: also provide a UUID in the WWID sysfs attribute

Jon Derrick (1):
      nvme: fabrics commands should use the fctype field for data direction

Scott Bauer (1):
      nvme: validate admin queue before unquiesce

 drivers/nvme/host/core.c |   6 ++-
 drivers/nvme/host/fc.c   | 121 +++++++++++++++++++++++++----------------------
 drivers/nvme/host/pci.c  |   6 +--
 drivers/nvme/target/fc.c | 101 ++++++++++++++++++++-------------------
 include/linux/nvme-fc.h  |  19 ++++++++
 include/linux/nvme.h     |   2 +-
 6 files changed, 145 insertions(+), 110 deletions(-)
