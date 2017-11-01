Return-Path: <axboe@kernel.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 4.14-rc
Message-ID: <18177e72-0fe2-6f26-835b-3509b4fadffc@kernel.dk>
Date: Wed, 1 Nov 2017 15:45:45 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Linus,

A few fixes that should go into this series. This pull request contains:

- Regression fix for ide-cd, ensuring that a request is fully
  initialized. From Hongxu.

- Ditto fix for virtio_blk, from Bart.

- NVMe fix from Keith, ensuring that we set the right block size on
  revalidation. If the block size changed, we'd be in trouble without
  it.

- NVMe rdma fix from Sagi, fixing a potential hang while the controller
  is being removed.

Please pull!


  git://git.kernel.dk/linux-block.git for-linus


----------------------------------------------------------------
Bart Van Assche (1):
      virtio_blk: Fix an SG_IO regression

Hongxu Jia (1):
      ide:ide-cd: fix kernel panic resulting from missing scsi_req_init

Jens Axboe (1):
      Merge branch 'nvme-4.14' of git://git.infradead.org/nvme into for-linus

Keith Busch (1):
      nvme: Fix setting logical block format when revalidating

Sagi Grimberg (1):
      nvme-rdma: fix possible hang when issuing commands during ctrl removal

 drivers/block/virtio_blk.c | 12 ++++++++++++
 drivers/ide/ide-cd.c       |  1 +
 drivers/nvme/host/core.c   |  1 +
 drivers/nvme/host/rdma.c   | 11 +++++++----
 4 files changed, 21 insertions(+), 4 deletions(-)

-- 
Jens Axboe
