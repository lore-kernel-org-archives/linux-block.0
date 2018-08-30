Return-Path: <axboe@kernel.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 4.19-rc2
Message-ID: <888cd3f6-6ef4-07a8-4596-6a6c462df98b@kernel.dk>
Date: Thu, 30 Aug 2018 14:15:41 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Linus,

Small collection of fixes that should go into this series. This pull
request contains:

- NVMe pull request with three small fixes (via Christoph)

- Kill useless NULL check before kmem_cache_destroy (Chengguang Xu)

- Xen block driver pull request with persistent grant flushing fixes
  (Juergen Gross)

- Final wbt fixes, wrapping up the changes for this series. These have
  been heavily tested (me)

- cdrom info leak fix (Scott Bauer)

- ATA dma quirk for SQ201 (Linus Walleij)

- Straight forward bsg refcount_t conversion (John Pittman)

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-linus-20180830


----------------------------------------------------------------
Chaitanya Kulkarni (1):
      nvmet: free workqueue object if module init fails

Chengguang Xu (1):
      block: remove unnecessary condition check

James Smart (1):
      nvme-fcloop: Fix dropped LS's to removed target port

Jens Axboe (5):
      blk-wbt: abstract out end IO completion handler
      blk-wbt: improve waking of tasks
      Merge branch 'stable/for-jens-4.19' of git://git.kernel.org/.../konrad/xen into for-linus
      blk-wbt: remove dead code
      Merge branch 'nvme-4.19' of git://git.infradead.org/nvme into for-linus

John Pittman (1):
      block: bsg: move atomic_t ref_count variable to refcount API

Juergen Gross (5):
      xen/blkback: don't keep persistent grants too long
      xen/blkfront: cleanup stale persistent grants
      xen/blkfront: reorder tests in xlblk_init()
      xen/blkback: move persistent grants flags to bool
      xen/blkback: remove unused pers_gnts_lock from struct xen_blkif_ring

Linus Walleij (1):
      ata: ftide010: Add a quirk for SQ201

Michal Wnukowski (1):
      nvme-pci: add a memory barrier to nvme_dbbuf_update_and_check_event

Scott Bauer (1):
      cdrom: Fix info leak/OOB read in cdrom_ioctl_drive_status

 Documentation/ABI/testing/sysfs-driver-xen-blkback |  10 ++
 block/blk-wbt.c                                    |  89 +++++++++++++----
 block/bsg.c                                        |   8 +-
 block/elevator.c                                   |   3 +-
 drivers/ata/pata_ftide010.c                        |  27 +++--
 drivers/block/xen-blkback/blkback.c                |  99 ++++++++++---------
 drivers/block/xen-blkback/common.h                 |  14 +--
 drivers/block/xen-blkfront.c                       | 110 ++++++++++++++++++---
 drivers/cdrom/cdrom.c                              |   2 +-
 drivers/nvme/host/pci.c                            |   8 ++
 drivers/nvme/target/core.c                         |   4 +-
 drivers/nvme/target/fcloop.c                       |   3 +-
 12 files changed, 269 insertions(+), 108 deletions(-)

-- 
Jens Axboe
