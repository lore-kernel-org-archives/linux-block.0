Return-Path: <BATV+022390e92e97e3285508+5450+infradead.org+hch@bombadil.srs.infradead.org>
Date: Thu, 26 Jul 2018 16:16:40 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for 4.18
Message-ID: <20180726141640.GA7156@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-block@vger.kernel.org>

Two small fixes each for the FC code and the target.


The following changes since commit 8f3ea35929a0806ad1397db99a89ffee0140822a:

  nbd: handle unexpected replies better (2018-07-16 10:14:40 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-4.18

for you to fetch changes up to 405a7519607e7a364114896264440c0f87b325c0:

  nvmet: only check for filebacking on -ENOTBLK (2018-07-25 13:14:04 +0200)

----------------------------------------------------------------
Hannes Reinecke (2):
      nvmet: fixup crash on NULL device path
      nvmet: only check for filebacking on -ENOTBLK

James Smart (2):
      nvmet-fc: fix target sgl list on large transfers
      nvme: if_ready checks to fail io to deleting controller

 drivers/nvme/host/fabrics.c    | 10 +++++++---
 drivers/nvme/host/fabrics.h    |  3 ++-
 drivers/nvme/host/fc.c         |  2 +-
 drivers/nvme/host/rdma.c       |  2 +-
 drivers/nvme/target/configfs.c |  9 +++++++--
 drivers/nvme/target/core.c     |  2 +-
 drivers/nvme/target/fc.c       | 44 +++++++++++++++++++++++++++++++++---------
 drivers/nvme/target/loop.c     |  2 +-
 8 files changed, 55 insertions(+), 19 deletions(-)
