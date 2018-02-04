Return-Path: <axboe@kernel.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 4.16-rc
Message-ID: <aaea812d-08f0-39a2-04d8-e1356c6b5f3e@kernel.dk>
Date: Sun, 4 Feb 2018 09:38:29 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Linus,

A followup pull request for this merge window, though most of this is
fixes and not new code/features. This pull request contains:

- skd fix from Arnd, fixing a build error dependent on sla allocator
  type.

- blk-mq scheduler discard merging fixes, one from me and one from
  Keith. This fixes a segment miscalculation for blk-mq-sched, where we
  mistakenly think two segments are physically contigious even though
  the request isn't carrying real data. Also fixes a bio-to-rq merge
  case.

- Don't re-set a bit on the buffer_head flags, if it's already set. This
  can cause scalability concerns on bigger machines and workloads. From
  Kemi Wang.

- Add BLK_STS_DEV_RESOURCE return value to blk-mq, allowing us to
  distuingish between a local (device related) resource starvation and a
  global one. The latter might happen without IO being in flight, so it
  has to be handled a bit differently. From Ming.

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-linus-20180204


----------------------------------------------------------------
Arnd Bergmann (1):
      block: skd: fix incorrect linux/slab_def.h inclusion

Jens Axboe (1):
      blk-mq: fix discard merge with scheduler attached

Keith Busch (1):
      blk-mq-sched: Enable merging discard bio into request

Kemi Wang (1):
      buffer: Avoid setting buffer bits that are already set

Ming Lei (1):
      blk-mq: introduce BLK_STS_DEV_RESOURCE

 block/blk-core.c             |  3 +++
 block/blk-merge.c            | 29 ++++++++++++++++++++++++++---
 block/blk-mq-sched.c         |  2 ++
 block/blk-mq.c               | 20 ++++++++++++++++----
 drivers/block/null_blk.c     |  2 +-
 drivers/block/skd_main.c     |  7 ++++---
 drivers/block/virtio_blk.c   |  2 +-
 drivers/block/xen-blkfront.c |  2 +-
 drivers/md/dm-rq.c           |  5 ++---
 drivers/nvme/host/fc.c       | 12 ++----------
 drivers/scsi/scsi_lib.c      |  6 +++---
 include/linux/blk_types.h    | 18 ++++++++++++++++++
 include/linux/buffer_head.h  |  5 ++++-
 13 files changed, 83 insertions(+), 30 deletions(-)

-- 
Jens Axboe
