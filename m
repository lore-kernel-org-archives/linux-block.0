Return-Path: <BATV+f549808562659eaf3d0e+5464+infradead.org+hch@bombadil.srs.infradead.org>
Date: Thu, 9 Aug 2018 10:07:34 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] last round of nvme updates for 4.19
Message-ID: <20180809080734.GA1527@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-block@vger.kernel.org>

Hi Jens,

this should be the last round of NVMe updates before the 4.19 merge
window opens.  It conains support for write protected (aka read-only)
namespaces from Chaitanya, two ANA fixes from Hannes and a fabrics
fix from Tal Shorer.


The following changes since commit f10fe9d85dc0802b54519c917716e6f0092b4ce7:

  lightnvm: remove minor version check for 2.0 (2018-08-05 19:36:09 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-4.19

for you to fetch changes up to 66414e80245e1e73222f67ee711951c7f4bdedab:

  nvme-fabrics: fix ctrl_loss_tmo < 0 to reconnect forever (2018-08-08 12:01:49 +0200)

----------------------------------------------------------------
Chaitanya Kulkarni (3):
      nvme.h: add support for ns write protect definitions
      nvme: set gendisk read only based on nsattr
      nvmet: add ns write protect support

Hannes Reinecke (2):
      nvme: fixup crash on failed discovery
      nvme.h: fixup ANA group descriptor format

Tal Shorer (1):
      nvme-fabrics: fix ctrl_loss_tmo < 0 to reconnect forever

 drivers/nvme/host/core.c          |  6 ++++
 drivers/nvme/host/fabrics.c       |  2 +-
 drivers/nvme/host/multipath.c     |  2 +-
 drivers/nvme/target/admin-cmd.c   | 76 +++++++++++++++++++++++++++++++++++++++
 drivers/nvme/target/core.c        | 20 ++++++++++-
 drivers/nvme/target/io-cmd-bdev.c |  7 ++++
 drivers/nvme/target/io-cmd-file.c | 12 ++++---
 drivers/nvme/target/nvmet.h       |  4 +++
 include/linux/nvme.h              | 19 ++++++++--
 9 files changed, 138 insertions(+), 10 deletions(-)
