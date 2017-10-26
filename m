Return-Path: <axboe@kernel.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 4.14-rc
Message-ID: <7b276f5c-fd88-c037-5797-d64411951de5@kernel.dk>
Date: Thu, 26 Oct 2017 07:37:47 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Linus,

A few select fixes that should go into this series. Mainly for NVMe, but
also a single stable fix for nbd from Josef.

Please pull!


  git://git.kernel.dk/linux-block.git for-linus


----------------------------------------------------------------
James Smart (3):
      nvme-fc: fix iowait hang
      nvme-fc: retry initial controller connections 3 times
      nvmet: synchronize sqhd update

Jens Axboe (1):
      Merge branch 'nvme-4.14' of git://git.infradead.org/nvme into for-linus

Josef Bacik (1):
      nbd: handle interrupted sendmsg with a sndtimeo set

Sagi Grimberg (2):
      nvme-rdma: Fix possible double free in reconnect flow
      nvme-rdma: Fix error status return in tagset allocation failure

 drivers/block/nbd.c         | 13 +++++++++++--
 drivers/nvme/host/fc.c      | 37 +++++++++++++++++++++++++++++++++----
 drivers/nvme/host/rdma.c    | 16 ++++++++++++----
 drivers/nvme/target/core.c  | 15 ++++++++++++---
 drivers/nvme/target/nvmet.h |  2 +-
 5 files changed, 69 insertions(+), 14 deletions(-)

-- 
Jens Axboe
