Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:31330 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752487AbcGYUUH (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Mon, 25 Jul 2016 16:20:07 -0400
Date: Mon, 25 Jul 2016 14:20:01 -0600
From: Jens Axboe <axboe@fb.com>
To: <torvalds@linuxfoundation.org>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Core block changes for 4.8-rc
Message-ID: <20160725202001.GA3885@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Linus,

Trying to flush out my two branches early this round, since particularly
one change is bound to cause merge conflicts with others. Since staging
is already merged, the lloop.c will conflict with the deleted file.
Apart from that, two minor conflicts that should be easy enough to
resolve.

This pull request contains:

- The big change is the cleanup from Mike Christie, cleaning up our uses
  of command types and modified flags. This is what will throw some
  merge conflicts.

- Regression fix for the above for btrfs, from Vincent.

- Following up to the above, better packing of struct request from
  Christoph.

- A 2038 fix for blktrace from Arnd.

- A few trivial/spelling fixes from Bart Van Assche.

- A front merge check fix from Damien, which could cause issues on SMR
  drives.

- Atari partition fix from Gabriel.

- Convert cfq to highres timers, since jiffies isn't granular enough for
  some devices these days. From Jan and Jeff.

- CFQ priority boost fix idle classes, from me.

- Cleanup series from Ming, improving our bio/bvec iteration.

- A direct issue fix for blk-mq from Omar.

- Fix for plug merging not involving the IO scheduler, like we do for
  other types of merges. From Tahsin.

- Expose DAX type internally and through sysfs. From Toshi and Yigal.


Please pull!


  git://git.kernel.dk/linux-block.git for-4.8/core


----------------------------------------------------------------
Arnd Bergmann (1):
      blktrace: avoid using timespec

Bart Van Assche (4):
      block/partition-generic.c: Remove a set-but-not-used variable
      block/bio-integrity.c: Add #include "blk.h"
      block/blk-cgroup.c: Declare local symbols static
      block: Fix spelling in a source code comment

Christoph Hellwig (1):
      block: better packing for struct request

Damien Le Moal (1):
      block: Fix front merge check

Gabriel Krisman Bertazi (1):
      block: atari: Return early for unsupported sector size

Jan Kara (5):
      cfq-iosched: Convert to use highres timers
      block: Convert fifo_time from ulong to u64
      cfq-iosched: Convert slice_resid from u64 to s64
      cfq-iosched: Fix regression in bonnie++ rewrite performance
      cfq-iosched: Charge at least 1 jiffie instead of 1 ns

Jeff Moyer (2):
      cfq-iosched: Convert from jiffies to nanoseconds
      cfq-iosched: Expose microsecond interfaces

Jens Axboe (1):
      cfq-iosched: temporarily boost queue priority for idle classes

Masanari Iida (1):
      Doc: block: Fix a typo in queue-sysfs.txt

Mike Christie (46):
      block/fs/drivers: remove rw argument from submit_bio
      block: add REQ_OP definitions and helpers
      fs: have submit_bh users pass in op and flags separately
      fs: have ll_rw_block users pass in op and flags separately
      block, drivers, cgroup: use op_is_write helper instead of checking for REQ_WRITE
      dm: use op_is_write instead of checking for REQ_WRITE
      bcache: use op_is_write instead of checking for REQ_WRITE
      block, fs, mm, drivers: use bio set/get op accessors
      block discard: use bio set op accessor
      direct-io: use bio set/get op accessors
      btrfs: have submit_one_bio users use bio op accessors
      btrfs: use bio op accessors
      btrfs: update __btrfs_map_block for REQ_OP transition
      btrfs: use bio fields for op and flags
      f2fs: use bio op accessors
      gfs2: use bio op accessors
      xfs: use bio op accessors
      hfsplus: use bio op accessors
      mpage: use bio op accessors
      nilfs: use bio op accessors
      ocfs2: use bio op accessors
      pm: use bio op accessors
      dm: pass dm stats data dir instead of bi_rw
      dm: use bio op accessors
      bcache: use bio op accessors
      drbd: use bio op accessors
      md: use bio op accessors
      target: use bio op accessors
      xen: use bio op accessors
      block: copy bio op to request op
      block: prepare request creation/destruction code to use REQ_OPs
      block: prepare mq request creation to use REQ_OPs
      block: prepare elevator to use REQ_OPs.
      blkg_rwstat: separate op from flags
      block: convert merge/insert code to check for REQ_OPs.
      block: convert is_sync helpers to use REQ_OPs.
      drivers: use req op accessor
      blktrace: use op accessors
      ide cd: do not set REQ_WRITE on requests.
      block: move bio io prio to a new field
      block, drivers, fs: shrink bi_rw from long to int
      block, fs, drivers: remove REQ_OP compat defs and related code
      block, drivers: add REQ_OP_FLUSH operation
      block: do not use REQ_FLUSH for tracking flush support
      block, drivers, fs: rename REQ_FLUSH to REQ_PREFLUSH
      ext4: use bio op helprs in ext4 crypto code

Ming Lei (8):
      block: move bvec iterator into include/linux/bvec.h
      block: move two bvec structure into bvec.h
      block: mark 1st parameter of bvec_iter_advance as const
      iov_iter: use bvec iterator to implement iterate_bvec()
      fs: xfs: replace BIO_MAX_SECTORS with BIO_MAX_PAGES
      block: bio: remove BIO_MAX_SECTORS
      block: drbd: avoid to use BIO_MAX_SIZE
      block: bio: kill BIO_MAX_SIZE

Omar Sandoval (1):
      blk-mq: actually hook up defer list when running requests

Tahsin Erdogan (1):
      block: do not merge requests without consulting with io scheduler

Toshi Kani (1):
      block: add QUEUE_FLAG_DAX for devices to advertise their DAX support

Vincent Stehl� (1):
      Btrfs: fix comparison in __btrfs_map_block()

Yigal Korman (1):
      block: expose QUEUE_FLAG_DAX in sysfs

 Documentation/block/queue-sysfs.txt             |   2 +-
 Documentation/block/writeback_cache_control.txt |  28 +-
 Documentation/device-mapper/log-writes.txt      |  10 +-
 arch/um/drivers/ubd_kern.c                      |   2 +-
 block/bio-integrity.c                           |   1 +
 block/bio.c                                     |  20 +-
 block/blk-cgroup.c                              |   4 +-
 block/blk-core.c                                |  96 +++---
 block/blk-exec.c                                |   2 +-
 block/blk-flush.c                               |  23 +-
 block/blk-lib.c                                 |  31 +-
 block/blk-map.c                                 |   2 +-
 block/blk-merge.c                               |  36 +-
 block/blk-mq.c                                  |  42 +--
 block/blk-sysfs.c                               |  11 +
 block/cfq-iosched.c                             | 432 ++++++++++++++----------
 block/deadline-iosched.c                        |   7 +-
 block/elevator.c                                |  29 +-
 block/partition-generic.c                       |   3 -
 block/partitions/atari.c                        |   7 +
 drivers/ata/libata-scsi.c                       |   2 +-
 drivers/block/brd.c                             |   6 +-
 drivers/block/drbd/drbd_actlog.c                |  32 +-
 drivers/block/drbd/drbd_bitmap.c                |   8 +-
 drivers/block/drbd/drbd_int.h                   |   8 +-
 drivers/block/drbd/drbd_main.c                  |  20 +-
 drivers/block/drbd/drbd_protocol.h              |   2 +-
 drivers/block/drbd/drbd_receiver.c              |  36 +-
 drivers/block/drbd/drbd_req.c                   |   2 +-
 drivers/block/drbd/drbd_worker.c                |   7 +-
 drivers/block/floppy.c                          |   3 +-
 drivers/block/loop.c                            |  14 +-
 drivers/block/mtip32xx/mtip32xx.c               |   2 +-
 drivers/block/nbd.c                             |   4 +-
 drivers/block/osdblk.c                          |   2 +-
 drivers/block/pktcdvd.c                         |   4 +-
 drivers/block/ps3disk.c                         |   4 +-
 drivers/block/rbd.c                             |   4 +-
 drivers/block/rsxx/dma.c                        |   2 +-
 drivers/block/skd_main.c                        |   2 +-
 drivers/block/umem.c                            |   2 +-
 drivers/block/virtio_blk.c                      |   2 +-
 drivers/block/xen-blkback/blkback.c             |  27 +-
 drivers/block/xen-blkfront.c                    |  65 ++--
 drivers/block/zram/zram_drv.c                   |   2 +-
 drivers/ide/ide-cd_ioctl.c                      |   3 -
 drivers/ide/ide-disk.c                          |   2 +-
 drivers/ide/ide-floppy.c                        |   2 +-
 drivers/lightnvm/rrpc.c                         |   6 +-
 drivers/md/bcache/btree.c                       |   4 +-
 drivers/md/bcache/debug.c                       |   6 +-
 drivers/md/bcache/io.c                          |   2 +-
 drivers/md/bcache/journal.c                     |   9 +-
 drivers/md/bcache/movinggc.c                    |   2 +-
 drivers/md/bcache/request.c                     |  28 +-
 drivers/md/bcache/super.c                       |  26 +-
 drivers/md/bcache/writeback.c                   |   4 +-
 drivers/md/bitmap.c                             |   6 +-
 drivers/md/dm-bufio.c                           |   9 +-
 drivers/md/dm-cache-target.c                    |  18 +-
 drivers/md/dm-crypt.c                           |  11 +-
 drivers/md/dm-era-target.c                      |   4 +-
 drivers/md/dm-flakey.c                          |   2 +-
 drivers/md/dm-io.c                              |  57 ++--
 drivers/md/dm-kcopyd.c                          |  11 +-
 drivers/md/dm-log-writes.c                      |  13 +-
 drivers/md/dm-log.c                             |   5 +-
 drivers/md/dm-raid.c                            |   5 +-
 drivers/md/dm-raid1.c                           |  22 +-
 drivers/md/dm-region-hash.c                     |   6 +-
 drivers/md/dm-snap-persistent.c                 |  24 +-
 drivers/md/dm-snap.c                            |   6 +-
 drivers/md/dm-stats.c                           |   9 +-
 drivers/md/dm-stripe.c                          |   6 +-
 drivers/md/dm-thin.c                            |  22 +-
 drivers/md/dm.c                                 |  45 +--
 drivers/md/linear.c                             |   4 +-
 drivers/md/md.c                                 |  18 +-
 drivers/md/md.h                                 |   5 +-
 drivers/md/multipath.c                          |   2 +-
 drivers/md/raid0.c                              |   4 +-
 drivers/md/raid1.c                              |  38 +--
 drivers/md/raid10.c                             |  52 +--
 drivers/md/raid5-cache.c                        |  33 +-
 drivers/md/raid5.c                              |  48 +--
 drivers/mmc/card/block.c                        |  11 +-
 drivers/mmc/card/queue.c                        |   6 +-
 drivers/mmc/card/queue.h                        |   6 +-
 drivers/mtd/mtd_blkdevs.c                       |   4 +-
 drivers/nvdimm/pmem.c                           |   1 +
 drivers/nvme/host/core.c                        |   4 +-
 drivers/nvme/host/nvme.h                        |   4 +-
 drivers/s390/block/dcssblk.c                    |   1 +
 drivers/scsi/osd/osd_initiator.c                |  12 +-
 drivers/scsi/sd.c                               |  20 +-
 drivers/staging/lustre/lustre/llite/lloop.c     |   6 +-
 drivers/target/target_core_iblock.c             |  41 +--
 drivers/target/target_core_pscsi.c              |   2 +-
 fs/block_dev.c                                  |   5 +-
 fs/btrfs/check-integrity.c                      |  61 ++--
 fs/btrfs/check-integrity.h                      |   6 +-
 fs/btrfs/compression.c                          |  17 +-
 fs/btrfs/ctree.h                                |   2 +-
 fs/btrfs/disk-io.c                              |  43 ++-
 fs/btrfs/disk-io.h                              |   2 +-
 fs/btrfs/extent-tree.c                          |   2 +-
 fs/btrfs/extent_io.c                            |  91 +++--
 fs/btrfs/extent_io.h                            |   8 +-
 fs/btrfs/inode.c                                |  70 ++--
 fs/btrfs/raid56.c                               |  17 +-
 fs/btrfs/scrub.c                                |  15 +-
 fs/btrfs/volumes.c                              |  91 ++---
 fs/btrfs/volumes.h                              |   6 +-
 fs/buffer.c                                     |  69 ++--
 fs/crypto/crypto.c                              |   3 +-
 fs/direct-io.c                                  |  35 +-
 fs/exofs/ore.c                                  |   2 +-
 fs/ext4/balloc.c                                |   2 +-
 fs/ext4/crypto.c                                |   3 +-
 fs/ext4/ialloc.c                                |   2 +-
 fs/ext4/inode.c                                 |   8 +-
 fs/ext4/mmp.c                                   |   4 +-
 fs/ext4/namei.c                                 |   3 +-
 fs/ext4/page-io.c                               |   7 +-
 fs/ext4/readpage.c                              |   9 +-
 fs/ext4/super.c                                 |   2 +-
 fs/f2fs/checkpoint.c                            |  10 +-
 fs/f2fs/data.c                                  |  47 +--
 fs/f2fs/f2fs.h                                  |   5 +-
 fs/f2fs/gc.c                                    |   9 +-
 fs/f2fs/inline.c                                |   3 +-
 fs/f2fs/node.c                                  |   8 +-
 fs/f2fs/segment.c                               |  14 +-
 fs/f2fs/trace.c                                 |   7 +-
 fs/fat/misc.c                                   |   2 +-
 fs/gfs2/bmap.c                                  |   4 +-
 fs/gfs2/dir.c                                   |   2 +-
 fs/gfs2/log.c                                   |   8 +-
 fs/gfs2/lops.c                                  |  12 +-
 fs/gfs2/lops.h                                  |   2 +-
 fs/gfs2/meta_io.c                               |  18 +-
 fs/gfs2/ops_fstype.c                            |   3 +-
 fs/gfs2/quota.c                                 |   2 +-
 fs/hfsplus/hfsplus_fs.h                         |   2 +-
 fs/hfsplus/part_tbl.c                           |   5 +-
 fs/hfsplus/super.c                              |   6 +-
 fs/hfsplus/wrapper.c                            |  15 +-
 fs/isofs/compress.c                             |   2 +-
 fs/jbd2/commit.c                                |   6 +-
 fs/jbd2/journal.c                               |  10 +-
 fs/jbd2/recovery.c                              |   4 +-
 fs/jfs/jfs_logmgr.c                             |   6 +-
 fs/jfs/jfs_metapage.c                           |  10 +-
 fs/logfs/dev_bdev.c                             |  17 +-
 fs/mpage.c                                      |  41 +--
 fs/nfs/blocklayout/blocklayout.c                |  22 +-
 fs/nilfs2/btnode.c                              |   6 +-
 fs/nilfs2/btnode.h                              |   2 +-
 fs/nilfs2/btree.c                               |   6 +-
 fs/nilfs2/gcinode.c                             |   5 +-
 fs/nilfs2/mdt.c                                 |  11 +-
 fs/nilfs2/segbuf.c                              |  18 +-
 fs/ntfs/aops.c                                  |   6 +-
 fs/ntfs/compress.c                              |   2 +-
 fs/ntfs/file.c                                  |   2 +-
 fs/ntfs/logfile.c                               |   2 +-
 fs/ntfs/mft.c                                   |   4 +-
 fs/ocfs2/aops.c                                 |   2 +-
 fs/ocfs2/buffer_head_io.c                       |   8 +-
 fs/ocfs2/cluster/heartbeat.c                    |  14 +-
 fs/ocfs2/super.c                                |   2 +-
 fs/reiserfs/inode.c                             |   4 +-
 fs/reiserfs/journal.c                           |  14 +-
 fs/reiserfs/stree.c                             |   4 +-
 fs/reiserfs/super.c                             |   2 +-
 fs/squashfs/block.c                             |   4 +-
 fs/udf/dir.c                                    |   2 +-
 fs/udf/directory.c                              |   2 +-
 fs/udf/inode.c                                  |   2 +-
 fs/ufs/balloc.c                                 |   2 +-
 fs/ufs/util.c                                   |   2 +-
 fs/xfs/xfs_aops.c                               |  11 +-
 fs/xfs/xfs_buf.c                                |  32 +-
 include/linux/bio.h                             |  83 +----
 include/linux/blk-cgroup.h                      |  13 +-
 include/linux/blk_types.h                       |  68 ++--
 include/linux/blkdev.h                          |  62 ++--
 include/linux/blktrace_api.h                    |   2 +-
 include/linux/buffer_head.h                     |  11 +-
 include/linux/bvec.h                            |  96 ++++++
 include/linux/dm-io.h                           |   3 +-
 include/linux/elevator.h                        |  15 +-
 include/linux/fs.h                              |  43 ++-
 include/trace/events/bcache.h                   |  12 +-
 include/trace/events/block.h                    |  31 +-
 include/trace/events/f2fs.h                     |  37 +-
 kernel/power/swap.c                             |  33 +-
 kernel/trace/blktrace.c                         |  77 +++--
 lib/iov_iter.c                                  |  45 +--
 mm/page_io.c                                    |  10 +-
 200 files changed, 1920 insertions(+), 1526 deletions(-)
 create mode 100644 include/linux/bvec.h

-- 
Jens Axboe

