Return-Path: <axboe@kernel.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 4.10-rc
Message-ID: <f2b98fde-700c-e5ee-f1f8-c766606965df@kernel.dk>
Date: Fri, 27 Jan 2017 12:41:51 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Linus,

A set of fixes for this series. This pull request contains:

- Set of fixes for the nvme target code

- A revert of patch from this merge window, causing a regression with
  WRITE_SAME on iSCSI targets at least.

- A fix for a use-after-free in the new O_DIRECT bdev code.

- Two fixes for the xen-blkfront driver.

Please pull!


  git://git.kernel.dk/linux-block.git for-linus


----------------------------------------------------------------
Bart Van Assche (1):
      Revert "sd: remove __data_len hack for WRITE SAME"

Christoph Hellwig (2):
      block: fix use after free in __blkdev_direct_IO
      nvme-fc: use blk_rq_nr_phys_segments

James Smart (1):
      nvmet_fc: correct logic in disconnect queue LS handling

Jan Beulich (2):
      xen-blkfront: feature flags handling adjustments
      xen-blkfront: correct maximum segment accounting

Jens Axboe (2):
      Merge branch 'nvme-4.10-fixes' of git://git.infradead.org/nvme into for-linus
      Merge branch 'stable/for-jens-4.10' of git://git.kernel.org/.../konrad/xen into for-linus

Parav Pandit (1):
      nvmet-rdma: Fix missing dma sync to nvme data structures

Sagi Grimberg (3):
      nvmet: delete controllers deletion upon subsystem release
      nvmet: cancel fatal error and flush async work before free controller
      nvmet: Call fatal_error from keep-alive timout expiration

 drivers/block/xen-blkfront.c   | 22 ++++++++++++++--------
 drivers/nvme/host/fc.c         |  6 +++---
 drivers/nvme/target/configfs.c |  1 +
 drivers/nvme/target/core.c     | 15 ++++++++++++++-
 drivers/nvme/target/fc.c       | 36 ++++++++++++++++++++++--------------
 drivers/nvme/target/nvmet.h    |  1 +
 drivers/nvme/target/rdma.c     | 17 +++++++++++++++++
 drivers/scsi/sd.c              | 17 ++++++++++++++++-
 fs/block_dev.c                 |  6 +++---
 9 files changed, 91 insertions(+), 30 deletions(-)

-- 
Jens Axboe
