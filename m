Return-Path: <BATV+1ef63fdb319281f35549+5556+infradead.org+hch@bombadil.srs.infradead.org>
Date: Fri, 9 Nov 2018 07:56:54 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for 4.20
Message-ID: <20181109065654.GA12805@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-block@vger.kernel.org>

 - revert an RDMA commit that didn't help but caused problems
 - fix another minor P2P fallout
 - make sure the multipath device inherits the devices limits of
   the controllers below

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-4.20

for you to fetch changes up to 72e43e497b07d607142f07a8c56794261fbe089b:

  Revert "nvmet-rdma: use a private workqueue for delete" (2018-11-07 09:27:22 +0100)

----------------------------------------------------------------
Christoph Hellwig (1):
      Revert "nvmet-rdma: use a private workqueue for delete"

Sagi Grimberg (2):
      nvmet: don't try to add ns to p2p map unless it actually uses it
      nvme: make sure ns head inherits underlying device limits

 drivers/nvme/host/core.c      |  4 +++-
 drivers/nvme/host/multipath.c |  1 +
 drivers/nvme/target/core.c    |  2 +-
 drivers/nvme/target/rdma.c    | 19 ++++---------------
 4 files changed, 9 insertions(+), 17 deletions(-)
