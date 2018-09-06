Return-Path: <axboe@kernel.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 4..19-rc3
Message-ID: <2c80ff97-47fc-23bb-0ba7-d81e863a8ba1@kernel.dk>
Date: Thu, 6 Sep 2018 14:54:00 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Linus,

Small collection of fixes that should go into this release. This pull
request contains:

- Small series that fixes a race between blkcg teardown and writeback
  (Dennis Zhou)

- Fix disallowing invalid block size settings from the nbd ioctl (me)

- BFQ fix for a use-after-free on last release of a bfqg (Konstantin
  Khlebnikov)

- Fix for the "don't warn for flush" fix (Mikulas)

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-linus-20180906


----------------------------------------------------------------
Dennis Zhou (Facebook) (3):
      Revert "blk-throttle: fix race between blkcg_bio_issue_check() and cgroup_rmdir()"
      blkcg: delay blkg destruction until after writeback has finished
      blkcg: use tryget logic when associating a blkg with a bio

Jens Axboe (1):
      nbd: don't allow invalid blocksize settings

Konstantin Khlebnikov (1):
      block: bfq: swap puts in bfqg_and_blkg_put

Mikulas Patocka (1):
      block: don't warn when doing fsync on read-only devices

 block/bfq-cgroup.c         |   4 +-
 block/bio.c                |   3 +-
 block/blk-cgroup.c         | 105 +++++++++++++++++++++------------------------
 block/blk-core.c           |   5 ++-
 block/blk-throttle.c       |   5 ++-
 drivers/block/nbd.c        |   3 ++
 include/linux/blk-cgroup.h |  45 ++++++++++++++++++-
 mm/backing-dev.c           |   5 +++
 8 files changed, 111 insertions(+), 64 deletions(-)

-- 
Jens Axboe
