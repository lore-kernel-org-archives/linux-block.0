Return-Path: <BATV+6d2c01d9e32a4b323c25+5248+infradead.org+hch@bombadil.srs.infradead.org>
Date: Fri, 5 Jan 2018 18:15:02 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 4.15
Message-ID: <20180105171502.tacdqy5kh3knh4hg@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-block@vger.kernel.org>

Hi Jens,

I have a few more small nvme fixes for you for Linux 4.15:

The following changes since commit 6d0e4827b72afc71349784336d5eb6df4df106e6:

  Revert "bdi: add error handle for bdi_debug_register" (2017-12-21 10:01:30 -0700)

are available in the git repository at:

  git://git.infradead.org/nvme.git nvme-4.15

for you to fetch changes up to 254beb84faccbe2f4eda0b51924857bdfb679969:

  nvme-fcloop: avoid possible uninitialized variable warning (2017-12-29 10:37:21 +0100)

----------------------------------------------------------------
James Smart (1):
      nvme-fcloop: avoid possible uninitialized variable warning

Jeff Lien (1):
      nvme: fix sector units when going between formats

Minwoo Im (1):
      nvme-pci: move use_sgl initialization to nvme_init_iod()

Sagi Grimberg (2):
      nvme-rdma: fix concurrent reset and reconnect
      nvme-mpath: fix last path removal during traffic

 drivers/nvme/host/core.c     |  7 ++++++-
 drivers/nvme/host/nvme.h     | 12 ++++++++++++
 drivers/nvme/host/pci.c      | 42 ++++++++++++++++++++----------------------
 drivers/nvme/host/rdma.c     | 14 +++++++++++++-
 drivers/nvme/target/fcloop.c |  2 +-
 5 files changed, 52 insertions(+), 25 deletions(-)
