Return-Path: <BATV+b05e9fb8710da454cfb6+5260+infradead.org+hch@bombadil.srs.infradead.org>
Date: Wed, 17 Jan 2018 19:36:22 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] two more nvme fixes for Linux 4.15
Message-ID: <20180117183622.3nrboga4prjeck5i@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-block@vger.kernel.org>

Hi Jens,

two more last minute fixes for regressions due to the SGL support that
is new in Linux 4.15.

The following changes since commit 32835a074171e7b83c1cefbbf9d681bb9518bbd5:

  Merge branch 'nvme-4.15' of git://git.infradead.org/nvme into for-linus (2018-01-12 10:42:36 -0700)

are available in the git repository at:

  git://git.infradead.org/nvme.git nvme-4.15

for you to fetch changes up to 0eb89a5061873dcb69570b1571e12eb6f00f4ae6:

  nvme-pci: take sglist coalescing in dma_map_sg into account (2018-01-17 17:41:28 +0100)

----------------------------------------------------------------
Christoph Hellwig (1):
      nvme-pci: take sglist coalescing in dma_map_sg into account

Keith Busch (1):
      nvme-pci: check segement valid for SGL use

 drivers/nvme/host/pci.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)
