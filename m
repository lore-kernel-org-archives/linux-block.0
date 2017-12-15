Return-Path: <BATV+f9b51a8ca15fdac5c6a2+5227+infradead.org+hch@bombadil.srs.infradead.org>
Date: Fri, 15 Dec 2017 17:48:28 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@intel.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [GIT PULLL] nvme fixes for Linux 4.15
Message-ID: <20171215164828.ztoycqf5wettwkkg@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-block@vger.kernel.org>

Hi Jens,

below are a couple important one or two liners fixes for Linux 4.15:


The following changes since commit fcf38cdf332a81b20a59e3ebaea81f6b316bbe0c:

  kyber: fix another domain token wait queue hang (2017-12-06 12:33:07 -0700)

are available in the git repository at:

  git://git.infradead.org/nvme.git nvme-4.15

for you to fetch changes up to 654b4a4acd8b52a4272114b95896e9a10d382cde:

  nvme: setup streams after initializing namespace head (2017-12-15 15:18:07 +0100)

----------------------------------------------------------------
David Disseldorp (1):
      nvme: set discard_alignment to zero

James Smart (1):
      nvme-fc: remove double put reference if admin connect fails

Keith Busch (2):
      nvme: check hw sectors before setting chunk sectors
      nvme: setup streams after initializing namespace head

Ming Lei (1):
      nvme: call blk_integrity_unregister after queue is cleaned up

 drivers/nvme/host/core.c | 11 ++++++-----
 drivers/nvme/host/fc.c   |  1 -
 2 files changed, 6 insertions(+), 6 deletions(-)
