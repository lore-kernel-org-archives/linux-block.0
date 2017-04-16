Return-Path: <axboe@kernel.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] A few small fixes for 4.11-rc
Message-ID: <a1fa499a-d95f-f8b1-4d97-2d6144279c2c@kernel.dk>
Date: Sun, 16 Apr 2017 10:04:10 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Linus,

Four small fixes. Three of them fix the same error in NVMe, in loop, fc,
and rdma respectively. The last one fix from Ming fixes a regression in
this series, where our bvec gap logic was wrong and causes an oops on
NVMe for certain conditions.

Please pull!


  git://git.kernel.dk/linux-block.git for-linus


----------------------------------------------------------------
Ming Lei (1):
      block: fix bio_will_gap() for first bvec with offset

Sagi Grimberg (3):
      nvme-loop: Fix sqsize wrong assignment based on ctrl MQES capability
      nvme-rdma: Fix sqsize wrong assignment based on ctrl MQES capability
      nvme-fc: Fix sqsize wrong assignment based on ctrl MQES capability

 drivers/nvme/host/fc.c     |  2 +-
 drivers/nvme/host/rdma.c   |  2 +-
 drivers/nvme/target/loop.c |  2 +-
 include/linux/blkdev.h     | 32 ++++++++++++++++++++++++++++----
 4 files changed, 31 insertions(+), 7 deletions(-)

-- 
Jens Axboe
