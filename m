Return-Path: <axboe@kernel.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block IO fixes for 4.16-rc2
Message-ID: <ead665ed-73db-8a9d-6bdd-50f8aad17ebe@kernel.dk>
Date: Sat, 17 Feb 2018 07:02:36 -1000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Linus,

A collection of fixes for this series. This pull request contains:

- NVMe pull request from Keith, with fixes all over the map for nvme.
  From various folks.

- Classic polling fix, that avoids a latency issue where we still end up
  waiting for an interrupt in some cases. From Nitesh Shetty.

- Comment typo fix from Minwoo Im.

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-linus-20180217


----------------------------------------------------------------
for-linus-20180217

----------------------------------------------------------------
Israel Rukshin (1):
      nvmet: Change return code of discard command if not supported

James Smart (2):
      nvme_fc: correct abort race condition on resets
      nvme_fc: cleanup io completion

Jens Axboe (1):
      Merge branch 'nvme-4.16-rc' of git://git.infradead.org/nvme into for-linus

Jianchao Wang (1):
      nvme: fix the deadlock in nvme_update_formats

Keith Busch (3):
      nvme: Fix discard buffer overrun
      nvme-pci: Remap CMB SQ entries on every controller reset
      nvme-pci: Fix timeouts in connecting state

Max Gurtovoy (3):
      nvme: rename NVME_CTRL_RECONNECTING state to NVME_CTRL_CONNECTING
      nvme-rdma: use NVME_CTRL_CONNECTING state to mark init process
      nvme: delete NVME_CTRL_LIVE --> NVME_CTRL_CONNECTING transition

Minwoo Im (1):
      block: fix a typo in comment of BLK_MQ_POLL_STATS_BKTS

Nitesh Shetty (1):
      blk: optimization for classic polling

Nitzan Carmi (1):
      nvme-rdma: fix sysfs invoked reset_ctrl error flow

Roland Dreier (1):
      nvme: Don't use a stack buffer for keep-alive command

 block/blk-mq.c               |   1 +
 drivers/nvme/host/core.c     |  45 ++++++++-----
 drivers/nvme/host/fabrics.h  |   9 +--
 drivers/nvme/host/fc.c       | 157 ++++++++++---------------------------------
 drivers/nvme/host/nvme.h     |   3 +-
 drivers/nvme/host/pci.c      |  39 ++++++-----
 drivers/nvme/host/rdma.c     |  16 ++---
 drivers/nvme/target/io-cmd.c |   7 +-
 include/linux/blkdev.h       |   2 +-
 9 files changed, 108 insertions(+), 171 deletions(-)

-- 
Jens Axboe
