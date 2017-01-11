Return-Path: <BATV+5a8954e658fae536ca99+4889+infradead.org+hch@bombadil.srs.infradead.org>
Date: Wed, 11 Jan 2017 19:42:36 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: keith.busch@intel.com, sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: [GIT PULL] NVMe fixes for 4.10-rc4
Message-ID: <20170111184236.GA21620@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-block@vger.kernel.org>

Hi Jens,

below are two small NVMe fixes for this merge window.

The following changes since commit 6bf6b0aa3da84a3d9126919a94c49c0fb7ee2fb3:

  virtio_blk: fix panic in initialization error path (2017-01-10 13:30:50 -0700)

are available in the git repository at:

  git://git.infradead.org/nvme.git nvme-4.10-fixes

for you to fetch changes up to b5a10c5f7532b7473776da87e67f8301bbc32693:

  nvme: apply DELAY_BEFORE_CHK_RDY quirk at probe time too (2017-01-11 17:21:35 +0100)

----------------------------------------------------------------
Christoph Hellwig (1):
      nvme-rdma: fix nvme_rdma_queue_is_ready

Guilherme G. Piccoli (1):
      nvme: apply DELAY_BEFORE_CHK_RDY quirk at probe time too

 drivers/nvme/host/core.c | 7 +------
 drivers/nvme/host/rdma.c | 2 +-
 2 files changed, 2 insertions(+), 7 deletions(-)
