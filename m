Return-Path: <famz@redhat.com>
From: Fam Zheng <famz@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-nvme@lists.infradead.org, Keith Busch <keith.busch@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org, "Michael S. Tsirkin" <mst@redhat.com>,
        linux-block@vger.kernel.org,
        Brian Norris <computersforpeace@gmail.com>,
        Paul Mackerras <paulus@samba.org>, linux-mtd@lists.infradead.org,
        "Ed L. Cashin" <ed.cashin@acm.org>, Jens Axboe <axboe@kernel.dk>,
        Minchan Kim <minchan@kernel.org>,
        virtualization@lists.linux-foundation.org,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Nitin Gupta <ngupta@vflare.org>, David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH 00/15] Fix issue with KOBJ_ADD uevent versus disk attributes
Date: Wed, 17 Aug 2016 15:15:00 +0800
Message-Id: <1471418115-3654-1-git-send-email-famz@redhat.com>
List-ID: <linux-block@vger.kernel.org>

This is an attempt to fix the issue that some disks' sysfs attributes are not
ready at the time its KOBJ_ADD event is sent.

The symptom is during device hotplug, udev may fail to find certain attributes,
such as serial or wwn, of the disk. As a result the /dev/disk/by-id entries are
not created.

The cause is device_add_disk emits the uevent before returning, and the callers
have to create sysfs entries after that.

The fix here is to pass attr_groups from callers to device_add_disk, so it can
be added before KOBJ_ADD.

Also add basic error handling around device_add_disk code, (or add FIXME
comment where work is left).

Fam Zheng (15):
  disk: Drop add_disk in favor of device_add_disk
  genhd: Return error from register_disk()
  genhd: Return error from blk_register_region
  block: Return error from blk_integrity_add
  genhd: Return error from disk_{add,alloc}_events
  genhd: Add return code to device_add_disk
  genhd: Add attribute group parameter to device_add_disk
  nvme: Pass attribute group to device_add_disk
  virtio-blk: Pass attribute group to device_add_disk
  mtd: Pass attribute group to device_add_disk
  zram: Pass attribute group to device_add_disk
  mtip: Pass attribute group to device_add_disk
  aoeblk: Pass attribute group to device_add_disk
  axonram: Pass attribute group to device_add_disk
  block: Add FIXME comment to handle device_add_disk error

 arch/m68k/emu/nfblock.c             |   3 +-
 arch/powerpc/sysdev/axonram.c       |  23 +++++---
 arch/um/drivers/ubd_kern.c          |   3 +-
 arch/xtensa/platforms/iss/simdisk.c |   3 +-
 block/blk-integrity.c               |  12 ++--
 block/genhd.c                       | 112 +++++++++++++++++++++++++-----------
 drivers/block/DAC960.c              |   3 +-
 drivers/block/amiflop.c             |   3 +-
 drivers/block/aoe/aoeblk.c          |  13 ++---
 drivers/block/ataflop.c             |   3 +-
 drivers/block/brd.c                 |   6 +-
 drivers/block/cciss.c               |   3 +-
 drivers/block/drbd/drbd_main.c      |   3 +-
 drivers/block/floppy.c              |   5 +-
 drivers/block/hd.c                  |   3 +-
 drivers/block/loop.c                |   3 +-
 drivers/block/mg_disk.c             |   3 +-
 drivers/block/mtip32xx/mtip32xx.c   |  39 +++----------
 drivers/block/nbd.c                 |   3 +-
 drivers/block/null_blk.c            |   3 +-
 drivers/block/osdblk.c              |   3 +-
 drivers/block/paride/pcd.c          |   3 +-
 drivers/block/paride/pd.c           |   3 +-
 drivers/block/paride/pf.c           |   3 +-
 drivers/block/pktcdvd.c             |   3 +-
 drivers/block/ps3disk.c             |   3 +-
 drivers/block/ps3vram.c             |   3 +-
 drivers/block/rbd.c                 |   3 +-
 drivers/block/rsxx/dev.c            |   3 +-
 drivers/block/skd_main.c            |   5 +-
 drivers/block/sunvdc.c              |   3 +-
 drivers/block/swim.c                |   3 +-
 drivers/block/swim3.c               |   3 +-
 drivers/block/sx8.c                 |   3 +-
 drivers/block/umem.c                |   3 +-
 drivers/block/virtio_blk.c          |  38 ++++++++----
 drivers/block/xen-blkfront.c        |   3 +-
 drivers/block/xsysace.c             |   3 +-
 drivers/block/z2ram.c               |   3 +-
 drivers/block/zram/zram_drv.c       |   7 +--
 drivers/cdrom/gdrom.c               |   3 +-
 drivers/ide/ide-cd.c                |   3 +-
 drivers/ide/ide-gd.c                |   3 +-
 drivers/lightnvm/gennvm.c           |   3 +-
 drivers/md/bcache/super.c           |   6 +-
 drivers/md/dm.c                     |   3 +-
 drivers/md/md.c                     |   5 +-
 drivers/memstick/core/ms_block.c    |   3 +-
 drivers/memstick/core/mspro_block.c |   3 +-
 drivers/mmc/card/block.c            |   3 +-
 drivers/mtd/mtd_blkdevs.c           |   9 +--
 drivers/mtd/ubi/block.c             |   3 +-
 drivers/nvdimm/blk.c                |   3 +-
 drivers/nvdimm/btt.c                |   3 +-
 drivers/nvdimm/pmem.c               |   3 +-
 drivers/nvme/host/core.c            |   7 +--
 drivers/s390/block/dasd_genhd.c     |   3 +-
 drivers/s390/block/dcssblk.c        |   3 +-
 drivers/s390/block/scm_blk.c        |   3 +-
 drivers/s390/block/xpram.c          |   3 +-
 drivers/sbus/char/jsflash.c         |   3 +-
 drivers/scsi/sd.c                   |   3 +-
 drivers/scsi/sr.c                   |   5 +-
 drivers/scsi/st.c                   |   4 +-
 fs/block_dev.c                      |   2 +-
 include/linux/genhd.h               |  21 +++----
 66 files changed, 277 insertions(+), 186 deletions(-)

-- 
2.7.4
