Return-Path: <BATV+47a8f37e9c7a6cd14032+5549+infradead.org+hch@bombadil.srs.infradead.org>
Date: Fri, 2 Nov 2018 08:37:42 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for 4.20
Message-ID: <20181102063742.GA16758@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-block@vger.kernel.org>

The following changes since commit a5185607787e030fcb0009194d3b12f8bcca59d6:

  block: brd: associate with queue until adding disk (2018-10-31 08:43:09 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-4.20

for you to fetch changes up to ae172db3b3f389c363ec7f3683b2cad41091580d:

  nvme-pci: fix conflicting p2p resource adds (2018-11-01 08:44:47 +0200)

----------------------------------------------------------------
James Smart (1):
      nvme-fc: fix request private initialization

Keith Busch (1):
      nvme-pci: fix conflicting p2p resource adds

 drivers/nvme/host/fc.c  | 2 +-
 drivers/nvme/host/pci.c | 5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)
