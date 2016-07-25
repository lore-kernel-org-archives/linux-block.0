Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:39823 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752732AbcGYUdj (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Mon, 25 Jul 2016 16:33:39 -0400
Date: Mon, 25 Jul 2016 14:33:34 -0600
From: Jens Axboe <axboe@fb.com>
To: <torvalds@linuxfoundation.org>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Block driver changes for 4.8-rc
Message-ID: <20160725203334.GB3885@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Linus,

This builds on top of the core branch I just sent out. This branch also
contains core changes. I've come to the conclusion that from 4.9 and
forward, I'll be doing just a single branch. We often have dependencies
between core and drivers, and it's hard to always split them up
appropriately without pulling core into drivers when that happens.

This branch will also have a few merge conflicts, primarily around the
missing bio_put() that was fixed in -4.7-rc.

That said, this pull request contains:

- Separate secure erase type for the core block layer, from Christoph.

- Set of discard fixes, from Christoph.

- Bio shrinking fixes from Christoph, as a followup up to the op/flags
  change in the core branch.

- Map and append request fixes from Christoph.

- NVMeF (NVMe over Fabrics) code from Christoph. This is pretty
  exciting!

- nvme-loop fixes from Arnd.

- Removal of ->driverfs_dev from Dan, after providing a
  device_add_disk() helper.

- Bcache fixes from Bhaktipriya and Yijing.

- cdrom subchannel read fix from Vchannaiah.

- Set of lightnvm updates from Wenwei, Matias, Johannes, and Javier.

- Set of drbd updates and fixes from Fabian, Lars, and Philipp.

- mg_disk error path fix from Bart.

- User notification for failed device add for loop, from Minfei.

- NVMe in general:

        - NVMe delay quirk from Guilherme.
        - SR-IOV support and command retry limits from Keith.
        - Fix for memory-less NUMA node from Masayoshi.
        - Use UINT_MAX for discard sectors, from Minfei.
        - Cancel IO fixes from Ming.
        - Don't allocate unused major, from Neil.
        - Error code fixup from Dan.
        - Use constants for PSDT/FUSE from James.
        - Variable init fix from Jay.
        - Fabrics fixes from Ming, Sagi, and Wei.
        - Various fixes.

Please pull!


  git://git.kernel.dk/linux-block.git for-4.8/drivers


----------------------------------------------------------------
Armen Baloyan (1):
      nvme.h: Add get_log_page command strucure

Arnd Bergmann (2):
      nvme-loop: add configfs dependency
      nvme-loop: fix nvme-loop Kconfig dependencies

Bartlomiej Zolnierkiewicz (1):
      mg_disk: fix error path in mg_probe()

Bhaktipriya Shridhar (1):
      bcache: Remove deprecated create_workqueue

Christoph Hellwig (28):
      block: add a separate operation type for secure erase
      nvme.h: add RTD3R, RTD3E and OAES fields
      nvme.h: add NVM command set SQE/CQE size defines
      nvme.h: add AER constants
      nvme: allow for size limitations from transport drivers
      nvme: factor out a add nvme_is_write helper
      nvme: move the workaround for I/O queue-less controllers from PCIe to core
      nvme: allow transitioning from NEW to LIVE state
      nvme: Modify and export sync command submission for fabrics
      nvme.h: add NVMe over Fabrics definitions
      nvme-fabrics: add a generic NVMe over Fabrics library
      nvmet: add a generic NVMe target
      nvme-loop: add a NVMe loopback host driver
      nvme: add new reconnecting controller state
      nvmet-rdma: add a NVMe over Fabrics RDMA target driver
      nvme-rdma: add a NVMe over Fabrics RDMA host driver
      block: introduce BLKDEV_DISCARD_ZERO to fix zeroout
      block: don't ignore -EOPNOTSUPP blkdev_issue_write_same
      block: get rid of bio_rw and READA
      block: simplify and cleanup bvec pool handling
      block: shrink bio size again
      memstick: don't allow REQ_TYPE_BLOCK_PC requests
      virtio_blk: use blk_rq_map_kern
      block: ensure bios return from blk_get_request are properly initialized
      block: simplify and export blk_rq_append_bio
      target: stop using blk_make_request
      scsi/osd: open code blk_make_request
      block: unexport various bio mapping helpers

Dan Carpenter (1):
      nvmet: fix an error code

Dan Williams (5):
      block: introduce device_add_disk()
      mmc: move 'parent' tracking to mmc_blk_data
      um: track 'parent' device in a local variable
      block: convert to device_add_disk()
      block: remove ->driverfs_dev

Fabian Frederick (1):
      drbd: code cleanups without semantic changes

Guilherme G. Piccoli (1):
      nvme/quirk: Add a delay before checking for adapter readiness

James Smart (1):
      nvme.h: add constants for PSDT and FUSE values

Javier Gonz�lez (2):
      lightnvm: add media manager mark_blk helper
      lightnvm: initialize ppa_addr in dev_to_generic_addr()

Jay Freyensee (1):
      nvme: initialize variable before logical OR'ing it

Jens Axboe (1):
      Merge branch 'for-4.8/block' of git://git.kernel.org/.../nvdimm/nvdimm into for-4.8/drivers

Johannes Thumshirn (2):
      nvme: lightnvm: make MLC num_pairs little endian
      lightnvm: Make functions not used by ouside static

Keith Busch (2):
      nvme: Limit command retries
      nvme/pci: Provide SR-IOV support

Lars Ellenberg (24):
      drbd: bitmap bulk IO: do not always suspend IO
      drbd: change bitmap write-out when leaving resync states
      drbd: adjust assert in w_bitmap_io to account for BM_LOCKED_CHANGE_ALLOWED
      drbd: fix regression: protocol A sometimes synchronous, C sometimes double-latency
      drbd: fix for truncated minor number in callback command line
      drbd: allow parallel flushes for multi-volume resources
      drbd: when receiving P_TRIM, zero-out partial unaligned chunks
      drbd: possibly disable discard support, if backend has discard_zeroes_data=0
      drbd: zero-out partial unaligned discards on local backend
      drbd: allow larger max_discard_sectors
      drbd: finish resync on sync source only by notification from sync target
      drbd: introduce unfence-peer handler
      drbd: don't forget error completion when "unsuspending" IO
      drbd: if there is no good data accessible, writes should be IO errors
      drbd: only restart frozen disk io when D_UP_TO_DATE
      drbd: discard_zeroes_if_aligned allows "thin" resync for discard_zeroes_data=0
      drbd: report sizes if rejecting too small peer disk
      drbd: introduce WRITE_SAME support
      drbd: sync_handshake: handle identical uuids with current (frozen) Primary
      drbd: disallow promotion during resync handshake, avoid deadlock and hard reset
      drbd: bump current uuid when resuming IO with diskless peer
      drbd: finally report ms, not jiffies, in log message
      drbd: al_write_transaction: skip re-scanning of bitmap page pointer array
      drbd: correctly handle failed crypto_alloc_hash

Masayoshi Mizuma (1):
      nvme: avoid crashes when node 0 is memoryless node.

Matias Bj�rling (12):
      lightnvm: remove checkpatch warning for unsigned ints
      lightnvm: fix checkpatch terse errors
      lightnvm: remove open/close statistics for gennvm
      lightnvm: rename gennvm and update description
      lightnvm: move target mgmt into media mgr
      lightnvm: remove nested lock conflict with mm
      lightnvm: remove unused lists from struct rrpc_block
      lightnvm: remove _unlocked variant of [get/put]_blk
      lightnvm: make rrpc_map_page call nvm_get_blk outside locks
      lightnvm: fix lun offset calculation for mark blk
      lightnvm: make ppa_list const in nvm_set_rqd_list
      lightnvm: make __nvm_submit_ppa static

Mike Christie (1):
      mg_disk: fix enum REQ_OP_ kbuild error

Minfei Huang (2):
      nvme: use UINT_MAX for max discard sectors
      loop: Make user notify for adding loop device failed

Ming Lin (5):
      nvme: update and rename nvme_cancel_io to nvme_cancel_request
      nvme: move nvme_cancel_request() to common code
      blk-mq: add blk_mq_alloc_request_hctx
      nvme: add fabrics sysfs attributes
      nvme-fabrics: add-remove ctrl repeat fix

NeilBrown (1):
      NVMe: don't allocate unused nvme_major

Philipp Reisner (4):
      drbd: Kill code duplication
      drbd: Implement handling of thinly provisioned storage on resync target nodes
      drbd: Introduce new disk config option rs-discard-granularity
      drbd: Create the protocol feature THIN_RESYNC

Roland Kammerer (1):
      drbd: get rid of empty statement in is_valid_state

Sagi Grimberg (7):
      nvme.h: Add keep-alive opcode and identify controller attribute
      nvme: add keep-alive support
      block: Export blk_poll
      blk-mq: Introduce blk_mq_reinit_tagset
      nvme-rdma.h: Add includes for nvme rdma_cm negotiation
      nvme-rdma: Don't use tl_retry_count
      nvme-fabrics: Remove tl_retry_count

Sunad Bhandary (1):
      NVMe: Fix removal in case of active namespace list scanning method

Wei Yongjun (2):
      nvme-rdma: fix the return value of nvme_rdma_reinit_request()
      nvmet: fix return value check in nvmet_subsys_alloc()

Wenwei Tao (1):
      lightnvm: break the loop when rqd is not null

Yijing Wang (3):
      bcache: Remove redundant parameter for cache_alloc()
      bcache: update document info
      bcache: Remove redundant block_size assignment

vchannaiah (1):
      cdrom: support read sub-channel command in LBA format

 Documentation/ioctl/cdrom.txt               |    3 +-
 MAINTAINERS                                 |    7 +
 arch/powerpc/sysdev/axonram.c               |    3 +-
 arch/um/drivers/ubd_kern.c                  |    5 +-
 block/bio-integrity.c                       |    9 +-
 block/bio.c                                 |   35 +-
 block/blk-core.c                            |   97 +-
 block/blk-lib.c                             |   44 +-
 block/blk-map.c                             |   25 +-
 block/blk-merge.c                           |    6 +-
 block/blk-mq-tag.c                          |   26 +
 block/blk-mq.c                              |   43 +
 block/blk.h                                 |    2 -
 block/genhd.c                               |   18 +-
 drivers/block/brd.c                         |    4 +-
 drivers/block/cciss.c                       |    3 +-
 drivers/block/drbd/drbd_actlog.c            |   29 +-
 drivers/block/drbd/drbd_bitmap.c            |   84 +-
 drivers/block/drbd/drbd_debugfs.c           |   13 +-
 drivers/block/drbd/drbd_int.h               |   49 +-
 drivers/block/drbd/drbd_interval.h          |   14 +-
 drivers/block/drbd/drbd_main.c              |  115 +-
 drivers/block/drbd/drbd_nl.c                |  282 +++-
 drivers/block/drbd/drbd_proc.c              |   30 +-
 drivers/block/drbd/drbd_protocol.h          |   77 +-
 drivers/block/drbd/drbd_receiver.c          |  535 +++++--
 drivers/block/drbd/drbd_req.c               |  118 +-
 drivers/block/drbd/drbd_req.h               |    5 +-
 drivers/block/drbd/drbd_state.c             |   61 +-
 drivers/block/drbd/drbd_state.h             |    2 +-
 drivers/block/drbd/drbd_strings.c           |    8 +-
 drivers/block/drbd/drbd_worker.c            |  115 +-
 drivers/block/floppy.c                      |    3 +-
 drivers/block/loop.c                        |    1 +
 drivers/block/mg_disk.c                     |    9 +-
 drivers/block/mtip32xx/mtip32xx.c           |    5 +-
 drivers/block/null_blk.c                    |    2 +-
 drivers/block/ps3disk.c                     |    3 +-
 drivers/block/ps3vram.c                     |    3 +-
 drivers/block/rsxx/dev.c                    |    4 +-
 drivers/block/skd_main.c                    |    8 +-
 drivers/block/sunvdc.c                      |    3 +-
 drivers/block/umem.c                        |    6 +-
 drivers/block/virtio_blk.c                  |   24 +-
 drivers/block/xen-blkback/xenbus.c          |    2 +-
 drivers/block/xen-blkfront.c                |   17 +-
 drivers/cdrom/cdrom.c                       |   28 +-
 drivers/ide/ide-cd.c                        |    3 +-
 drivers/ide/ide-gd.c                        |    3 +-
 drivers/lightnvm/Kconfig                    |   10 +-
 drivers/lightnvm/core.c                     |  242 +---
 drivers/lightnvm/gennvm.c                   |  385 +++--
 drivers/lightnvm/gennvm.h                   |   10 +-
 drivers/lightnvm/rrpc.c                     |  149 +-
 drivers/lightnvm/rrpc.h                     |   13 +-
 drivers/lightnvm/sysblk.c                   |    8 +-
 drivers/md/bcache/closure.c                 |    2 +-
 drivers/md/bcache/closure.h                 |    3 +-
 drivers/md/bcache/io.c                      |    1 -
 drivers/md/bcache/super.c                   |   10 +-
 drivers/md/dm-raid1.c                       |    8 +-
 drivers/md/dm-snap.c                        |   13 +-
 drivers/md/dm-zero.c                        |   15 +-
 drivers/md/dm.c                             |    2 +-
 drivers/md/raid1.c                          |    5 +-
 drivers/md/raid10.c                         |    5 +-
 drivers/md/raid5.c                          |    2 +-
 drivers/memstick/core/ms_block.c            |    6 +-
 drivers/memstick/core/mspro_block.c         |    6 +-
 drivers/mmc/card/block.c                    |   15 +-
 drivers/mmc/card/queue.c                    |    2 +-
 drivers/mtd/mtd_blkdevs.c                   |    4 +-
 drivers/nvdimm/blk.c                        |    3 +-
 drivers/nvdimm/btt.c                        |    3 +-
 drivers/nvdimm/bus.c                        |    2 +-
 drivers/nvdimm/pmem.c                       |    3 +-
 drivers/nvme/Kconfig                        |    1 +
 drivers/nvme/Makefile                       |    1 +
 drivers/nvme/host/Kconfig                   |   19 +
 drivers/nvme/host/Makefile                  |    6 +
 drivers/nvme/host/core.c                    |  318 ++++-
 drivers/nvme/host/fabrics.c                 |  952 +++++++++++++
 drivers/nvme/host/fabrics.h                 |  132 ++
 drivers/nvme/host/lightnvm.c                |    4 +-
 drivers/nvme/host/nvme.h                    |   48 +-
 drivers/nvme/host/pci.c                     |   68 +-
 drivers/nvme/host/rdma.c                    | 2018 +++++++++++++++++++++++++++
 drivers/nvme/target/Kconfig                 |   36 +
 drivers/nvme/target/Makefile                |    9 +
 drivers/nvme/target/admin-cmd.c             |  465 ++++++
 drivers/nvme/target/configfs.c              |  917 ++++++++++++
 drivers/nvme/target/core.c                  |  964 +++++++++++++
 drivers/nvme/target/discovery.c             |  221 +++
 drivers/nvme/target/fabrics-cmd.c           |  240 ++++
 drivers/nvme/target/io-cmd.c                |  215 +++
 drivers/nvme/target/loop.c                  |  754 ++++++++++
 drivers/nvme/target/nvmet.h                 |  331 +++++
 drivers/nvme/target/rdma.c                  | 1448 +++++++++++++++++++
 drivers/s390/block/dasd_genhd.c             |    3 +-
 drivers/s390/block/dcssblk.c                |    3 +-
 drivers/s390/block/scm_blk.c                |    3 +-
 drivers/scsi/osd/osd_initiator.c            |   25 +-
 drivers/scsi/sd.c                           |    3 +-
 drivers/scsi/sr.c                           |    3 +-
 drivers/staging/lustre/lustre/llite/lloop.c |   13 +-
 drivers/target/target_core_pscsi.c          |   87 +-
 fs/buffer.c                                 |   12 +-
 fs/f2fs/checkpoint.c                        |    2 +-
 fs/f2fs/gc.c                                |    3 +-
 fs/f2fs/node.c                              |    2 +-
 fs/gfs2/bmap.c                              |    3 +-
 fs/gfs2/dir.c                               |    2 +-
 fs/gfs2/meta_io.c                           |    2 +-
 fs/reiserfs/stree.c                         |    2 +-
 fs/udf/dir.c                                |    2 +-
 fs/udf/directory.c                          |    2 +-
 include/linux/bio.h                         |    2 -
 include/linux/blk-mq.h                      |    5 +
 include/linux/blk_types.h                   |   31 +-
 include/linux/blkdev.h                      |   30 +-
 include/linux/drbd.h                        |   10 +-
 include/linux/drbd_genl.h                   |    7 +-
 include/linux/drbd_limits.h                 |   15 +-
 include/linux/fs.h                          |   18 +-
 include/linux/genhd.h                       |    8 +-
 include/linux/lightnvm.h                    |   34 +-
 include/linux/nvme-rdma.h                   |   71 +
 include/linux/nvme.h                        |  406 +++++-
 include/trace/events/f2fs.h                 |    4 +-
 kernel/trace/blktrace.c                     |    6 +-
 130 files changed, 11620 insertions(+), 1284 deletions(-)
 create mode 100644 drivers/nvme/host/fabrics.c
 create mode 100644 drivers/nvme/host/fabrics.h
 create mode 100644 drivers/nvme/host/rdma.c
 create mode 100644 drivers/nvme/target/Kconfig
 create mode 100644 drivers/nvme/target/Makefile
 create mode 100644 drivers/nvme/target/admin-cmd.c
 create mode 100644 drivers/nvme/target/configfs.c
 create mode 100644 drivers/nvme/target/core.c
 create mode 100644 drivers/nvme/target/discovery.c
 create mode 100644 drivers/nvme/target/fabrics-cmd.c
 create mode 100644 drivers/nvme/target/io-cmd.c
 create mode 100644 drivers/nvme/target/loop.c
 create mode 100644 drivers/nvme/target/nvmet.h
 create mode 100644 drivers/nvme/target/rdma.c
 create mode 100644 include/linux/nvme-rdma.h

-- 
Jens Axboe

