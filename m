Return-Path: <axboe@kernel.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 4.19-rc4
Message-ID: <fe8e2fd1-571e-062e-dd19-d217b5c2f232@kernel.dk>
Date: Thu, 13 Sep 2018 20:04:46 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Linus,

Three fixes that should go into this series. This pull request contains:

- Increase number of policies supported by blk-cgroup. With
  blk-iolatency, we now have 4 in kernel, but we had a hard limit of 3.

- Fix regression in null_blk, where the zoned supported broke
  queue_mode=0 (bio based).

- NVMe pull request, with a single fix for an issue in the rdma code.

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-linus-20180913


----------------------------------------------------------------
Jens Axboe (3):
      Merge branch 'nvme-4.19' of git://git.infradead.org/nvme into for-linus
      blk-cgroup: increase number of supported policies
      null_blk: fix zoned support for non-rq based operation

Sagi Grimberg (1):
      nvmet-rdma: fix possible bogus dereference under heavy load

 block/blk-cgroup.c             |  4 +++-
 drivers/block/null_blk.h       | 17 +++++++++-------
 drivers/block/null_blk_main.c  | 45 +++++++++++++++++++++++++++++++++++-------
 drivers/block/null_blk_zoned.c | 34 +++++++++++++------------------
 drivers/nvme/target/rdma.c     | 27 +++++++++++++++++++++++--
 include/linux/blkdev.h         |  2 +-
 6 files changed, 91 insertions(+), 38 deletions(-)

-- 
Jens Axboe
