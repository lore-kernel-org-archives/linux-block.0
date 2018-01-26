Return-Path: <BATV+04abeec6fb12371d1ccc+5269+infradead.org+hch@bombadil.srs.infradead.org>
Date: Fri, 26 Jan 2018 19:09:44 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] additional nvme updates for 4.16
Message-ID: <20180126180944.lrdh4dqwntz7pk27@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-block@vger.kernel.org>

The additional week before the 4.15 release gave us time for a few more
nvme fixes, as well as the nifty trace points from Johannes:


The following changes since commit 475a055e62a1eb92f4358ad8a9059df973c190ac:

  blk-throttle: use queue_is_rq_based (2018-01-19 21:10:20 -0700)

are available in the git repository at:

  git://git.infradead.org/nvme.git nvme-4.16

for you to fetch changes up to ca5554a696dce37852f6d6721520b4f13fc295c3:

  nvme: add tracepoint for nvme_complete_rq (2018-01-26 12:34:40 +0100)

----------------------------------------------------------------
Jianchao Wang (1):
      nvme-pci: introduce RECONNECTING state to mark initializing procedure

Johannes Thumshirn (3):
      nvme: don't free uuid pointer before printing it
      nvme: add tracepoint for nvme_setup_cmd
      nvme: add tracepoint for nvme_complete_rq

Keith Busch (2):
      nvme-pci: Fix queue double allocations
      nvme-pci: Suspend queues after deleting them

Max Gurtovoy (1):
      nvme-rdma: remove redundant boolean for inline_data

 drivers/nvme/host/Makefile  |   4 ++
 drivers/nvme/host/core.c    |  11 ++-
 drivers/nvme/host/fabrics.c |   3 +-
 drivers/nvme/host/pci.c     |  49 +++++++------
 drivers/nvme/host/rdma.c    |   3 -
 drivers/nvme/host/trace.c   | 130 ++++++++++++++++++++++++++++++++++
 drivers/nvme/host/trace.h   | 165 ++++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 339 insertions(+), 26 deletions(-)
 create mode 100644 drivers/nvme/host/trace.c
 create mode 100644 drivers/nvme/host/trace.h
