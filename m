Return-Path: <axboe@kernel.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 4.10-rc
Message-ID: <f91e953a-dfa8-b0e5-ba27-3618c8d36932@kernel.dk>
Date: Sat, 14 Jan 2017 17:28:57 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Linus,

Here's a set of fixes for the current series. This pull request
contains:

- The virtio_blk stack DMA corruption fix from Christoph, fixing and
  issue with VMAP stacks.

- O_DIRECT blkbits calculation fix from Chandan.

- Discard regression fix from Christoph.

- Queue init error handling fixes for nbd and virtio_blk, from Omar and
  Jeff.

- Two small nvme fixes, from Christoph and Guilherme.

- Rename of blk_queue_zone_size and bdev_zone_size to _sectors instead,
  to more closely follow what we do in other places in the block layer.
  This interface is new for this series, so let's get the naming right
  before releasing a kernel with this feature. From Damien.

Please pull!


  git://git.kernel.dk/linux-block.git for-linus


----------------------------------------------------------------
Chandan Rajendra (1):
      do_direct_IO: Use inode->i_blkbits to compute block count to be cleaned

Christoph Hellwig (7):
      virtio_blk: avoid DMA to stack for the sense buffer
      nvme-rdma: fix nvme_rdma_queue_is_ready
      block: add blk_rq_payload_bytes
      scsi: use blk_rq_payload_bytes
      nvme: use blk_rq_payload_bytes
      sd: remove __data_len hack for WRITE SAME
      block: don't try to discard from __blkdev_issue_zeroout

Damien Le Moal (1):
      block: Rename blk_queue_zone_size and bdev_zone_size

Guilherme G. Piccoli (1):
      nvme: apply DELAY_BEFORE_CHK_RDY quirk at probe time too

Jeff Moyer (1):
      nbd: blk_mq_init_queue returns an error code on failure, not NULL

Omar Sandoval (1):
      virtio_blk: fix panic in initialization error path

 block/blk-lib.c            | 13 ++++++-------
 block/blk-zoned.c          |  4 ++--
 block/partition-generic.c  | 14 +++++++-------
 drivers/block/nbd.c        |  6 ++++--
 drivers/block/virtio_blk.c |  7 +++++--
 drivers/nvme/host/core.c   |  7 +------
 drivers/nvme/host/fc.c     |  5 ++---
 drivers/nvme/host/nvme.h   |  8 --------
 drivers/nvme/host/pci.c    | 19 ++++++++-----------
 drivers/nvme/host/rdma.c   | 15 ++++++---------
 drivers/scsi/scsi_lib.c    |  2 +-
 drivers/scsi/sd.c          | 17 +----------------
 fs/direct-io.c             |  3 ++-
 fs/f2fs/segment.c          |  4 ++--
 fs/f2fs/super.c            |  6 +++---
 include/linux/blkdev.h     | 19 ++++++++++++++++---
 16 files changed, 66 insertions(+), 83 deletions(-)

-- 
Jens Axboe
