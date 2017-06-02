Return-Path: <axboe@kernel.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 4.12-rc4
Message-ID: <e4ef7879-8df1-33ce-c04a-e419ea4b4269@kernel.dk>
Date: Fri, 2 Jun 2017 08:35:57 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Linus,

A set of fixes that should go into the next -rc. This pull request
contains:

- A use-after-free in the request_list exit for the legacy IO path, from
  Bart.

- A fix for CFQ, fixing a recent regression with the conversion to
  higher resolution timing for iops mode. From Hou Tao.

- A single fix for nbd, split in two patches, fixing a leak of a data
  structure.

- A regression fix from Keith, ensuring that callers of
  blk_mq_update_nr_hw_queues() hold the right lock.

Please pull!


  git://git.kernel.dk/linux-block.git for-linus


----------------------------------------------------------------
Bart Van Assche (1):
      block: Avoid that blk_exit_rl() triggers a use-after-free

Hou Tao (1):
      cfq-iosched: fix the delay of cfq_group's vdisktime under iops mode

Ilya Dryomov (2):
      nbd: nbd_reset() call in nbd_dev_add() is redundant
      nbd: don't leak nbd_config

Keith Busch (1):
      blk-mq: Take tagset lock when updating hw queues

 block/blk-cgroup.c  |  2 +-
 block/blk-core.c    | 10 ++++++++--
 block/blk-mq.c      | 10 +++++++++-
 block/blk-sysfs.c   |  2 +-
 block/blk.h         |  2 +-
 block/cfq-iosched.c | 17 +++++++++++++++--
 drivers/block/nbd.c | 15 +++++----------
 7 files changed, 40 insertions(+), 18 deletions(-)

-- 
Jens Axboe
