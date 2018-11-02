Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Final block merge window changes/fixes
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Message-ID: <dc6c712a-57c4-81cd-0d6e-072973bb52ce@kernel.dk>
Date: Fri, 2 Nov 2018 11:08:25 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Linus,

The biggest part of this pull request is the revert of the blkcg cleanup
series. It had one fix earlier for a stacked device issue, but another
one was reported. Rather than play whack-a-mole with this, revert the
entire series and try again for the next kernel release.

Apart from that, only small fixes/changes. This pull request contains:

- Indentation fixup for mtip32xx (Colin Ian King)

- The blkcg cleanup series revert (Dennis Zhou)

- Two NVMe fixes. One fixing a regression in the nvme request
  initialization in this merge window, causing nvme-fc to not work. The
  other is a suspend/resume p2p resource issue (James, Keith)

- Fix sg discard merge, allowing us to merge in cases where we didn't
  before (Jianchao Wang)

- Call rq_qos_exit() after the queue is frozen, preventing a hang (Ming)

- Fix brd queue setup, fixing an oops if we fail setting up all devices
  (Ming)

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-linus-20181102


----------------------------------------------------------------
Colin Ian King (1):
      mtip32xx: clean an indentation issue, remove extraneous tabs

Dennis Zhou (1):
      blkcg: revert blkcg cleanups series

James Smart (1):
      nvme-fc: fix request private initialization

Jianchao Wang (1):
      block: fix the DISCARD request merge

Keith Busch (1):
      nvme-pci: fix conflicting p2p resource adds

Ming Lei (2):
      block: call rq_qos_exit() after queue is frozen
      block: brd: associate with queue until adding disk

 Documentation/admin-guide/cgroup-v2.rst |   8 +-
 block/bfq-cgroup.c                      |   4 +-
 block/bfq-iosched.c                     |   2 +-
 block/bio.c                             | 174 +++++++++-----------------------
 block/blk-cgroup.c                      | 123 +++++++---------------
 block/blk-core.c                        |   4 +-
 block/blk-iolatency.c                   |  26 ++++-
 block/blk-merge.c                       |  46 +++++++--
 block/blk-sysfs.c                       |   2 -
 block/blk-throttle.c                    |  13 ++-
 block/bounce.c                          |   4 +-
 block/cfq-iosched.c                     |   4 +-
 drivers/block/brd.c                     |  16 ++-
 drivers/block/loop.c                    |   5 +-
 drivers/block/mtip32xx/mtip32xx.c       |   4 +-
 drivers/md/raid0.c                      |   2 +-
 drivers/nvme/host/fc.c                  |   2 +-
 drivers/nvme/host/pci.c                 |   5 +-
 fs/buffer.c                             |  10 +-
 fs/ext4/page-io.c                       |   2 +-
 include/linux/bio.h                     |  26 ++---
 include/linux/blk-cgroup.h              | 145 +++++++++-----------------
 include/linux/blk_types.h               |   1 +
 include/linux/cgroup.h                  |   2 -
 include/linux/writeback.h               |   5 +-
 kernel/cgroup/cgroup.c                  |  48 ++-------
 kernel/trace/blktrace.c                 |   4 +-
 mm/page_io.c                            |   2 +-
 28 files changed, 265 insertions(+), 424 deletions(-)

-- 
Jens Axboe
