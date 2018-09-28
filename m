Return-Path: <hare@suse.de>
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Bart van Assche <bvanassche@acm.org>,
	Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <keith.busch@intel.com>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCHv4 0/5] genhd: register default groups with device_add_disk()
Date: Fri, 28 Sep 2018 08:17:18 +0200
Message-Id: <20180928061723.13180-1-hare@suse.de>
List-ID: <linux-block@vger.kernel.org>

device_add_disk() doesn't allow to register with default sysfs groups,
which introduces a race with udev as these groups have to be created after
the uevent has been sent.
This patchset updates device_add_disk() to accept a 'groups' argument to
avoid this race and updates the obvious drivers to use it.
There are some more drivers which might benefit from this (eg loop or md),
but the interface is not straightforward so I haven't attempted it.

As usual, comments and reviews are welcome.

Changes to v3:
- Better check in is_visible for lightnvm attributes as suggested
  by hch
  
Changes to v2:
- Fold lightnvm attributes into the generic attribute group as
  suggested by Bart

Changes to v1:
- Drop first patch
- Convert lightnvm sysfs attributes as suggested by Bart

Hannes Reinecke (5):
  block: genhd: add 'groups' argument to device_add_disk
  nvme: register ns_id attributes as default sysfs groups
  aoe: register default groups with device_add_disk()
  zram: register default groups with device_add_disk()
  virtio-blk: modernize sysfs attribute creation

 arch/um/drivers/ubd_kern.c          |   2 +-
 block/genhd.c                       |  19 +++++--
 drivers/block/aoe/aoe.h             |   1 -
 drivers/block/aoe/aoeblk.c          |  21 +++-----
 drivers/block/aoe/aoedev.c          |   1 -
 drivers/block/floppy.c              |   2 +-
 drivers/block/mtip32xx/mtip32xx.c   |   2 +-
 drivers/block/ps3disk.c             |   2 +-
 drivers/block/ps3vram.c             |   2 +-
 drivers/block/rsxx/dev.c            |   2 +-
 drivers/block/skd_main.c            |   2 +-
 drivers/block/sunvdc.c              |   2 +-
 drivers/block/virtio_blk.c          |  68 +++++++++++++----------
 drivers/block/xen-blkfront.c        |   2 +-
 drivers/block/zram/zram_drv.c       |  28 +++-------
 drivers/ide/ide-cd.c                |   2 +-
 drivers/ide/ide-gd.c                |   2 +-
 drivers/memstick/core/ms_block.c    |   2 +-
 drivers/memstick/core/mspro_block.c |   2 +-
 drivers/mmc/core/block.c            |   2 +-
 drivers/mtd/mtd_blkdevs.c           |   2 +-
 drivers/nvdimm/blk.c                |   2 +-
 drivers/nvdimm/btt.c                |   2 +-
 drivers/nvdimm/pmem.c               |   2 +-
 drivers/nvme/host/core.c            |  21 ++++----
 drivers/nvme/host/lightnvm.c        | 105 +++++++++++++++---------------------
 drivers/nvme/host/multipath.c       |  15 ++----
 drivers/nvme/host/nvme.h            |  10 +---
 drivers/s390/block/dasd_genhd.c     |   2 +-
 drivers/s390/block/dcssblk.c        |   2 +-
 drivers/s390/block/scm_blk.c        |   2 +-
 drivers/scsi/sd.c                   |   2 +-
 drivers/scsi/sr.c                   |   2 +-
 include/linux/genhd.h               |   5 +-
 34 files changed, 152 insertions(+), 188 deletions(-)

-- 
2.16.4
