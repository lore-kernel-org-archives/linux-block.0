Return-Path: <axboe@kernel.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 4.18-rc3
Message-ID: <9e799234-aaa8-4f29-71e8-7531faa28b0e@kernel.dk>
Date: Fri, 29 Jun 2018 15:15:59 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Linus,

Small set of fixes for this series. Mostly just minor fixes, the only
oddball in here is the sg change. This came out of the stall fix for
NVMe, where we added a mempool and limited us to a single page
allocation. CONFIG_SG_DEBUG sort-of ruins that, since we'd need to
account for that. That's actually a generic problem, since lots of
drivers need to allocate SG lists. I actually added this debug magic
check back in 2007:

commit d6ec084200c37683278c821338f74ddf21ab80f5
Author: Jens Axboe <jens.axboe@oracle.com>
Date:   Mon Oct 22 20:01:06 2007 +0200

    Add CONFIG_DEBUG_SG sg validation

when I did the chaining code, to my knowledge it was never useful. Hence
I'd suggest that we go this route as it'll benefit other drivers too,
even though this _technically_ should go into the next release. If you
strongly object, then I can drop it and we'll just have to shrink the
nvme sg count further for this release.

Anyway, outside of that, this pull contains:

- Clone of request with special payload fix (Bart)

- drbd discard handling fix (Bart)

- SATA blk-mq stall fix (me)

- Chunk size fix (Keith)

- Double free nvme rdma fix (Sagi)

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-linus-20180629


----------------------------------------------------------------
Bart Van Assche (2):
      block: Fix cloning of requests with a special payload
      drbd: Fix drbd_request_prepare() discard handling

Jens Axboe (3):
      blk-mq: don't queue more if we get a busy return
      Merge branch 'nvme-4.18' of git://git.infradead.org/nvme into for-linus
      sg: remove ->sg_magic member

Keith Busch (1):
      block: Fix transfer when chunk sectors exceeds max

Sagi Grimberg (1):
      nvme-rdma: fix possible double free of controller async event buffer

 block/blk-core.c                 |  4 ++++
 block/blk-mq.c                   | 12 ++++++++++++
 drivers/block/drbd/drbd_req.c    |  4 ++--
 drivers/gpu/drm/i915/i915_drv.h  |  3 ---
 drivers/nvme/host/rdma.c         |  7 +++++--
 include/linux/blkdev.h           |  4 ++--
 include/linux/scatterlist.h      | 18 ------------------
 lib/scatterlist.c                |  6 ------
 tools/virtio/linux/scatterlist.h | 18 ------------------
 9 files changed, 25 insertions(+), 51 deletions(-)

-- 
Jens Axboe
