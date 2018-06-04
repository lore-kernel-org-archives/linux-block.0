Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block changes for 4.18-rc
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Message-ID: <11b01169-8e11-34ed-8137-aa5cd50a39c2@kernel.dk>
Date: Sun, 3 Jun 2018 18:42:33 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Linus,

This is the main pull request for the 4.18 merge window. This pull
request contains:

- Series from Christoph, cleaning up how we pass around gfp_t and
  blk_mq_req_flags_t.

- Series from Christoph, preparing us to defer scheduler attach.

- Series from Christoph, cleaing up drivers handling of bounce buffers

- Series from Christoph/Bart/Keith, fixing timeout handling corner
  cases.

- Series of bcache fixes, by way of Coly.

- Series from Kent, with both some prep work for bcachefs and some
  block layer optimizations.

- Series from Kent, converting users of bio_sets to using embedded
  structs.

- Patches from Paolo/Davide/Filippo, with fixes for the BFQ io
  scheduler.

- Set of lightnvm fixes and improvements. By way of Matias,
  contributions from Hans and Javier.

- Series from me, adding discard throttling to blk-wbt.

- Series from me/Omar/Ming on sbitmap blk-mq-tag handling.

- Removal of the sparc jsflash block driver, acked by DaveM.

- Kyber scheduler improvement from Jianchao, making it more
  friendly wrt merging.

- Conversion of symbolic proc permissions to octal, from Joe
  Perches. Previously the block parts were a mix of both.

- Series of nbd fixes from Josef and Kevin Vigor.

- Series from Omar, unifying how we handle the various kinds of
  timestamps that the block core and utility code uses.

- Three NVMe pull requests from Keith and Christoph, bringing
  AEN to feature completeness, file backed namespaces, cq/sq
  lock split, and various fixes.

- Various little fixes and improvements all over the map.


  git://git.kernel.dk/linux-block.git tags/for-4.18/block-20180603


----------------------------------------------------------------
Andy Shevchenko (3):
      bcache: Move couple of string arrays to sysfs.c
      bcache: Move couple of functions to sysfs.c
      bcache: Replace bch_read_string_list() by __sysfs_match_string()

Anna-Maria Gleixner (1):
      block: Remove redundant WARN_ON()

Bart Van Assche (1):
      blkdev_report_zones_ioctl(): Use vmalloc() to allocate large buffers

Chaitanya Kulkarni (4):
      nvmet: make a few error messages more generic
      nvmet: remove duplicate NULL initialization for req->ns
      nvmet: add simple file backed ns support
      nvmet-loop: use nr_phys_segments when map rq to sgl

Chengguang Xu (1):
      blk-throttle: return proper bool type to caller instead of 0/1

Christoph Hellwig (49):
      mtip32xx: don't use block layer bounce buffers
      DAC960: don't use block layer bounce buffers
      memstick: don't call blk_queue_bounce_limit
      mtd_blkdevs: handle highmem pages
      aoe: handle highmem pages
      jsflash: handle highmem pages
      ps3disk: handle highmem pages
      memstick: remove unused variables
      scsi/osd: remove the gfp argument to osd_start_request
      block: fix __get_request documentation
      block: sanitize blk_get_request calling conventions
      block: pass an explicit gfp_t to get_request
      block: use GFP_NOIO instead of __GFP_DIRECT_RECLAIM
      block: consistently use GFP_NOIO instead of __GFP_NORECLAIM
      nvme: mark the result argument to nvme_complete_async_event volatile
      nvme-pci: simplify nvme_cqe_valid
      libata: remove ata_scsi_timed_out
      block: rename BLK_EH_NOT_HANDLED to BLK_EH_DONE
      nvme: return BLK_EH_DONE from ->timeout
      nbd: complete requests from ->timeout
      mtip32xx: complete requests from ->timeout
      null_blk: complete requests from ->timeout
      scsi_transport_fc: complete requests from ->timeout
      mmc: complete requests from ->timeout
      libiscsi: don't try to bypass SCSI EH
      block: remove BLK_EH_HANDLED
      block: document the blk_eh_timer_return values
      blk-mq: simplify blk_mq_rq_timed_out
      block: unexport check_disk_size_change
      block: don't print a message when the device went away
      block: remove parent device reference from struct bsg_class_device
      nvme-pci: simplify __nvme_submit_cmd
      nvme-loop: add support for multiple ports
      blk-mq: only iterate over inflight requests in blk_mq_tagset_busy_iter
      nvme-fabrics: allow internal passthrough command on deleting controllers
      nvme.h: untangle AEN notice definitions
      nvme.h: add the changed namespace list log
      nvmet: add a new nvmet_zero_sgl helper
      nvmet: split log page implementation
      nvmet: implement the changed namespaces log
      nvmet: add AEN configuration support
      nvmet: mask pending AENs
      nvme: mark nvme_queue_scan static
      nvme: use the changed namespaces list log to clear ns data changed AENs
      block: move initialization of elevator-related fields to blk_alloc_queue_node
      block: unexport elevator_init/exit
      block: remove the always unused name argument to elevator_init
      block: move sysfs_lock into elevator_init
      block: split the blk-mq case from elevator_init

Christophe JAILLET (1):
      mtip32xx: Fix an error handling path in 'mtip_pci_probe()'

Coly Li (1):
      bcache: stop bcache device when backing device is offline

Dan Melnic (1):
      block/ndb: add WQ_UNBOUND to the knbd-recv workqueue

Davide Sapienza (2):
      block, bfq: increase weight-raising duration for interactive apps
      block, bfq: prevent soft_rt_next_start from being stuck at infinity

Filippo Muzzini (2):
      block, bfq: remove wrong lock in bfq_requests_merged
      block, bfq: remove the removal of 'next' rq in bfq_requests_merged

Hannes Reinecke (6):
      nvme-fabrics: centralize discovery controller defaults
      nvme-fabrics: allow duplicate connections to the discovery controller
      nvme: fix KASAN warning when parsing host nqn
      nvme: fixup memory leak in nvme_init_identify()
      nvme.h: add AEN configuration symbols
      nvme: submit AEN event configuration on startup

Hans Holmberg (5):
      lightnvm: pblk: rework write error recovery path
      lightnvm: pblk: garbage collect lines with failed writes
      lightnvm: pblk: fix smeta write error path
      lightnvm: pblk: only try to recover lines with written smeta
      lightnvm: pblk: kick writer on new flush points

Igor Konopko (2):
      lightnvm: proper error handling for pblk_bio_add_pages
      lightnvm: fix partial read error path

Ivan Bornyakov (1):
      nvme: host: core: fix precedence of ternary operator

James Smart (4):
      nvme-fc: remove setting DNR on exception conditions
      nvme-fabrics: remove unnecessary controller subnqn validation
      nvmet-fc: increase LS buffer count per fc port
      nvme: allow duplicate controller if prior controller being deleted

Javier González (13):
      lightnvm: pblk: fail gracefully on line alloc. failure
      lightnvm: pblk: recheck for bad lines at runtime
      lightnvm: pblk: check read lba on gc path
      lightnvm: pblk: improve error msg on corrupted LBAs
      lightnvm: pblk: warn in case of corrupted write buffer
      lightnvm: pblk: return NVM_ error on failed submission
      lightnvm: pblk: remove unnecessary indirection
      lightnvm: pblk: remove unnecessary argument
      lightnvm: pblk: check for chunk size before allocating it
      lightnvm: pass flag on graceful teardown to targets
      lightnvm: pblk: remove dead function
      lightnvm: pblk: remove unnecessary bio_get/put
      lightnvm: pblk: take bitmap alloc. out of critical section

Jens Axboe (26):
      nvme: only reconfigure discard if necessary
      block: break discard submissions into the user defined size
      blk-wbt: account any writing command as a write
      blk-wbt: pass in enum wbt_flags to get_rq_wait()
      blk-wbt: throttle discards like background writes
      blk-mq: don't call into depth limiting for reserved tags
      bfq-iosched: don't worry about reserved tags in limit_depth
      bfq: calculate shallow depths at init time
      bfq-iosched: remove unused variable
      bfq-iosched: update shallow depth to smallest one used
      kyber-iosched: update shallow depth when setting up hardware queue
      sbitmap: fix race in wait batch accounting
      Remove jsflash driver
      nvme-pci: remove cq check after submission
      nvme-pci: move ->cq_vector == -1 check outside of ->q_lock
      nvme-pci: handle completions outside of the queue lock
      nvme-pci: split the nvme queue lock into submission and completion locks
      nvme-pci: drop IRQ disabling on submission queue lock
      Merge branch 'nvme-4.18' of git://git.infradead.org/nvme into for-4.18/block
      nvme-pci: fix race between poll and IRQ completions
      block: move ->timeout request member
      Merge branch 'nvme-4.18-2' of git://git.infradead.org/nvme into for-4.18/block
      blk-mq: abstract out blk-mq-sched rq list iteration bio merge helper
      block: fixup bioset_integrity_create() call
      Merge branch 'nvme-4.18' of git://git.infradead.org/nvme into for-4.18/block
      block: don't use blocking queue entered for recursive bio submits

Jianchao Wang (3):
      nvme-pci: set nvmeq->cq_vector after alloc cq/sq
      nvme-rdma: stop admin queue before freeing it
      block: kyber: make kyber more friendly with merging

Joe Perches (1):
      block drivers/block: Use octal not symbolic permissions

Johannes Thumshirn (3):
      nvme: fc: provide a descriptive error
      nvme: change order of qid and cmdid in completion trace
      nvme: fix lockdep warning in nvme_mpath_clear_current_path

Josef Bacik (8):
      block: fix MAINTAINERS email for nbd
      nbd: fix nbd device deletion
      nbd: update size when connected
      nbd: use bd_set_size when updating disk size
      nbd: clear_sock on netlink disconnect
      nbd: fix how we set bd_invalidated
      nbd: call nbd_bdev_reset instead of bd_set_size on disconnect
      nbd: set discard granularity properly

Keith Busch (7):
      nvme/pci: Use async_schedule for initial reset work
      nvme/pci: Hold controller reference during async probe
      nvme/pci: Sync controller reset for AER slot_reset
      nvme-pci: Fix AER reset handling
      blk-mq: Fix timeout and state order
      blk-mq: Remove generation seqeunce
      nvme-pci: Rate limit the nvme timeout warnings

Kent Overstreet (23):
      mempool: Add mempool_init()/mempool_exit()
      block: Convert bio_set to mempool_init()
      block: Add bioset_init()/bioset_exit()
      block: Use bioset_init() for fs_bio_set
      block: Add bio_copy_data_iter(), zero_fill_bio_iter()
      block: Split out bio_list_copy_data()
      block: Add missing flush_dcache_page() call
      block: Add warning for bi_next not NULL in bio_endio()
      block: Export bio check/set pages_dirty
      block: Add sysfs entry for fua support
      block: convert bounce, q->bio_split to bioset_init()/mempool_init()
      drbd: convert to bioset_init()/mempool_init()
      pktcdvd: convert to bioset_init()/mempool_init()
      lightnvm: convert to bioset_init()/mempool_init()
      bcache: convert to bioset_init()/mempool_init()
      md: convert to bioset_init()/mempool_init()
      dm: convert to bioset_init()/mempool_init()
      target: convert to bioset_init()/mempool_init()
      fs: convert block_dev.c to bioset_init()
      btrfs: convert to bioset_init()/mempool_init()
      xfs: convert to bioset_init()/mempool_init()
      block: Drop bioset_create()
      dm-crypt: fix warning in shutdown path

Kevin Vigor (1):
      nbd: clear DISCONNECT_REQUESTED flag once disconnection occurs.

Liu Bo (2):
      null_blk: add blocking description and remove lightnvm
      blk-throttle: fix potential NULL pointer dereference in throtl_select_dispatch

Marcin Dziegielewski (1):
      lightnvm: pblk: add possibility to set write buffer size manually

Micah Parrish (1):
      NVMe: Add Quirk Delay before CHK RDY for Seagate Nytro Flash Storage

Ming Lei (2):
      blk-mq: avoid starving tag allocation after allocating process migrates
      blk-mq: update nr_requests when switching to 'none' scheduler

Omar Sandoval (9):
      block: move some wbt helpers to blk-wbt.c
      block: pass struct request instead of struct blk_issue_stat to wbt
      block: replace bio->bi_issue_stat with bio-specific type
      block: get rid of struct blk_issue_stat
      block: use ktime_get_ns() instead of sched_clock() for cfq and bfq
      block: move blk_stat_add() to __blk_mq_end_request()
      block: consolidate struct request timestamp fields
      sbitmap: fix missed wakeups caused by sbitmap_queue_get_shallow()
      sbitmap: warn if using smaller shallow depth than was setup

Paolo Valente (4):
      block, bfq: postpone rq preparation to insert or merge
      block, bfq: remove wrong check in bfq_requests_merged
      block, bfq: add description of weight-raising heuristics
      block, bfq: remove slow-system class

Sebastian Andrzej Siewior (1):
      block: don't disable interrupts during kmap_atomic()

SeongJae Park (1):
      brd: Mark as non-rotational

Tejun Heo (1):
      bdi: Move cgroup bdi_writeback to a dedicated low concurrency workqueue

Tetsuo Handa (1):
      loop: remember whether sysfs_create_group() was done

Thomas Gleixner (1):
      block: Shorten interrupt disabled regions

Wei Xu (1):
      nvme: lightnvm: add granby support

Wei Yongjun (2):
      nvmet: fix a typo in nvmet_file_ns_enable()
      nvmet: fix error return code in nvmet_file_ns_enable()

huhai (3):
      blk-mq: remove redundant insert case in blk_mq_make_request()
      blk-mq: clear hctx->dispatch_from when mappings change
      blk-mq: remove wrong 'unlikely' check

 Documentation/block/null_blk.txt                |   9 +-
 Documentation/scsi/scsi_eh.txt                  |  15 +-
 MAINTAINERS                                     |   2 +-
 arch/sparc/include/uapi/asm/jsflash.h           |  40 --
 block/bfq-cgroup.c                              |  40 +-
 block/bfq-iosched.c                             | 478 +++++++++--------
 block/bfq-iosched.h                             |  30 +-
 block/bio-integrity.c                           |  29 +-
 block/bio.c                                     | 189 ++++---
 block/blk-core.c                                | 120 ++---
 block/blk-integrity.c                           |  12 +-
 block/blk-lib.c                                 |  12 +-
 block/blk-merge.c                               |  29 +-
 block/blk-mq-debugfs.c                          |   1 -
 block/blk-mq-sched.c                            |  46 +-
 block/blk-mq-sched.h                            |   2 -
 block/blk-mq-sysfs.c                            |   6 +-
 block/blk-mq-tag.c                              |  14 +-
 block/blk-mq.c                                  | 340 ++++--------
 block/blk-mq.h                                  |  42 +-
 block/blk-stat.c                                |  10 +-
 block/blk-stat.h                                |  45 +-
 block/blk-sysfs.c                               |  80 +--
 block/blk-throttle.c                            |  35 +-
 block/blk-timeout.c                             |   6 +-
 block/blk-wbt.c                                 | 129 +++--
 block/blk-wbt.h                                 |  55 +-
 block/blk-zoned.c                               |   8 +-
 block/blk.h                                     |   5 +-
 block/bounce.c                                  |  52 +-
 block/bsg-lib.c                                 |   6 +-
 block/bsg.c                                     |  44 +-
 block/cfq-iosched.c                             |  66 ++-
 block/deadline-iosched.c                        |   3 +-
 block/elevator.c                                | 101 ++--
 block/genhd.c                                   |  37 +-
 block/kyber-iosched.c                           | 199 +++++--
 block/mq-deadline.c                             |   3 +-
 block/partition-generic.c                       |  26 +-
 block/scsi_ioctl.c                              |  10 +-
 drivers/ata/libata-eh.c                         |  51 --
 drivers/block/DAC960.c                          |  11 +-
 drivers/block/DAC960.h                          |   1 -
 drivers/block/aoe/aoeblk.c                      |  11 +-
 drivers/block/aoe/aoecmd.c                      |   3 +-
 drivers/block/brd.c                             |  10 +-
 drivers/block/drbd/drbd_bitmap.c                |   5 +-
 drivers/block/drbd/drbd_debugfs.c               |  20 +-
 drivers/block/drbd/drbd_int.h                   |  10 +-
 drivers/block/drbd/drbd_main.c                  |  73 +--
 drivers/block/drbd/drbd_receiver.c              |   6 +-
 drivers/block/drbd/drbd_req.c                   |   4 +-
 drivers/block/drbd/drbd_req.h                   |   2 +-
 drivers/block/floppy.c                          |   2 +-
 drivers/block/loop.c                            |  17 +-
 drivers/block/loop.h                            |   1 +
 drivers/block/mtip32xx/mtip32xx.c               |  29 +-
 drivers/block/nbd.c                             |  77 ++-
 drivers/block/null_blk.c                        |  36 +-
 drivers/block/paride/pd.c                       |   2 +-
 drivers/block/pktcdvd.c                         |  60 +--
 drivers/block/ps3disk.c                         |   2 -
 drivers/block/rbd.c                             |  44 +-
 drivers/block/rsxx/core.c                       |   6 +-
 drivers/block/sx8.c                             |   2 +-
 drivers/block/virtio_blk.c                      |   8 +-
 drivers/block/xen-blkback/blkback.c             |   2 +-
 drivers/block/xen-blkback/xenbus.c              |   4 +-
 drivers/block/xen-blkfront.c                    |   7 +-
 drivers/cdrom/cdrom.c                           |   2 +-
 drivers/ide/ide-atapi.c                         |   2 +-
 drivers/ide/ide-cd.c                            |   2 +-
 drivers/ide/ide-cd_ioctl.c                      |   2 +-
 drivers/ide/ide-devsets.c                       |   2 +-
 drivers/ide/ide-disk.c                          |   2 +-
 drivers/ide/ide-ioctls.c                        |   4 +-
 drivers/ide/ide-park.c                          |   4 +-
 drivers/ide/ide-pm.c                            |   5 +-
 drivers/ide/ide-tape.c                          |   4 +-
 drivers/ide/ide-taskfile.c                      |   4 +-
 drivers/lightnvm/core.c                         |  10 +-
 drivers/lightnvm/pblk-cache.c                   |  10 +-
 drivers/lightnvm/pblk-core.c                    | 233 ++++++---
 drivers/lightnvm/pblk-gc.c                      | 112 ++--
 drivers/lightnvm/pblk-init.c                    | 172 ++++---
 drivers/lightnvm/pblk-map.c                     |  33 +-
 drivers/lightnvm/pblk-rb.c                      |  48 +-
 drivers/lightnvm/pblk-read.c                    | 146 +++---
 drivers/lightnvm/pblk-recovery.c                | 121 +----
 drivers/lightnvm/pblk-rl.c                      |  29 +-
 drivers/lightnvm/pblk-sysfs.c                   |  15 +-
 drivers/lightnvm/pblk-write.c                   | 269 ++++++----
 drivers/lightnvm/pblk.h                         |  58 ++-
 drivers/md/bcache/bcache.h                      |  14 +-
 drivers/md/bcache/bset.c                        |  13 +-
 drivers/md/bcache/bset.h                        |   2 +-
 drivers/md/bcache/btree.c                       |   4 +-
 drivers/md/bcache/io.c                          |   4 +-
 drivers/md/bcache/request.c                     |  18 +-
 drivers/md/bcache/super.c                       | 109 ++--
 drivers/md/bcache/sysfs.c                       |  51 +-
 drivers/md/bcache/util.c                        |  35 --
 drivers/md/bcache/util.h                        |   5 -
 drivers/md/dm-bio-prison-v1.c                   |  13 +-
 drivers/md/dm-bio-prison-v2.c                   |  13 +-
 drivers/md/dm-cache-target.c                    |  25 +-
 drivers/md/dm-core.h                            |   4 +-
 drivers/md/dm-crypt.c                           |  58 +--
 drivers/md/dm-integrity.c                       |  15 +-
 drivers/md/dm-io.c                              |  29 +-
 drivers/md/dm-kcopyd.c                          |  22 +-
 drivers/md/dm-log-userspace-base.c              |  19 +-
 drivers/md/dm-mpath.c                           |   3 +-
 drivers/md/dm-region-hash.c                     |  23 +-
 drivers/md/dm-rq.c                              |   4 +-
 drivers/md/dm-snap.c                            |  17 +-
 drivers/md/dm-thin.c                            |  32 +-
 drivers/md/dm-verity-fec.c                      |  55 +-
 drivers/md/dm-verity-fec.h                      |   8 +-
 drivers/md/dm-zoned-target.c                    |  13 +-
 drivers/md/dm.c                                 |  55 +-
 drivers/md/md-faulty.c                          |   2 +-
 drivers/md/md-linear.c                          |   2 +-
 drivers/md/md-multipath.c                       |  17 +-
 drivers/md/md-multipath.h                       |   2 +-
 drivers/md/md.c                                 |  61 +--
 drivers/md/md.h                                 |   4 +-
 drivers/md/raid0.c                              |   5 +-
 drivers/md/raid1.c                              |  76 ++-
 drivers/md/raid1.h                              |   6 +-
 drivers/md/raid10.c                             |  60 ++-
 drivers/md/raid10.h                             |   6 +-
 drivers/md/raid5-cache.c                        |  43 +-
 drivers/md/raid5-ppl.c                          |  42 +-
 drivers/md/raid5.c                              |  12 +-
 drivers/md/raid5.h                              |   2 +-
 drivers/memstick/core/ms_block.c                |   6 -
 drivers/memstick/core/mspro_block.c             |   6 -
 drivers/message/fusion/mptsas.c                 |   2 +-
 drivers/mmc/core/block.c                        |  12 +-
 drivers/mmc/core/queue.c                        |   5 +-
 drivers/mtd/mtd_blkdevs.c                       |  20 +-
 drivers/nvme/host/core.c                        | 157 ++++--
 drivers/nvme/host/fabrics.c                     | 100 ++--
 drivers/nvme/host/fabrics.h                     |   4 +-
 drivers/nvme/host/fc.c                          |  15 +-
 drivers/nvme/host/nvme.h                        |   9 +-
 drivers/nvme/host/pci.c                         | 258 ++++++----
 drivers/nvme/host/rdma.c                        |  12 +-
 drivers/nvme/host/trace.h                       |   4 +-
 drivers/nvme/target/Makefile                    |   4 +-
 drivers/nvme/target/admin-cmd.c                 | 143 ++---
 drivers/nvme/target/core.c                      | 128 +++--
 drivers/nvme/target/discovery.c                 |   2 -
 drivers/nvme/target/fabrics-cmd.c               |   4 -
 drivers/nvme/target/fc.c                        |   2 +-
 drivers/nvme/target/{io-cmd.c => io-cmd-bdev.c} |  77 +--
 drivers/nvme/target/io-cmd-file.c               | 304 +++++++++++
 drivers/nvme/target/loop.c                      |  52 +-
 drivers/nvme/target/nvmet.h                     |  51 +-
 drivers/s390/block/dasd.c                       |   6 +-
 drivers/sbus/char/Kconfig                       |   7 -
 drivers/sbus/char/Makefile                      |   1 -
 drivers/sbus/char/jsflash.c                     | 658 ------------------------
 drivers/scsi/gdth.c                             |   2 +-
 drivers/scsi/libiscsi.c                         |   6 +-
 drivers/scsi/megaraid/megaraid_sas_base.c       |   2 +-
 drivers/scsi/mvumi.c                            |   2 +-
 drivers/scsi/osd/osd_initiator.c                |  24 +-
 drivers/scsi/osst.c                             |   2 +-
 drivers/scsi/qla4xxx/ql4_os.c                   |   2 +-
 drivers/scsi/scsi_error.c                       |  10 +-
 drivers/scsi/scsi_lib.c                         |   4 +-
 drivers/scsi/scsi_transport_fc.c                |  16 +-
 drivers/scsi/scsi_transport_iscsi.c             |   2 +-
 drivers/scsi/scsi_transport_sas.c               |  19 +-
 drivers/scsi/scsi_transport_srp.c               |   4 +-
 drivers/scsi/sg.c                               |   2 +-
 drivers/scsi/st.c                               |   2 +-
 drivers/scsi/ufs/ufshcd.c                       |   6 +-
 drivers/target/target_core_iblock.c             |  16 +-
 drivers/target/target_core_iblock.h             |   2 +-
 drivers/target/target_core_pscsi.c              |   3 +-
 fs/block_dev.c                                  |  24 +-
 fs/btrfs/extent_io.c                            |  25 +-
 fs/direct-io.c                                  |   4 +-
 fs/exofs/ore.c                                  |  10 +-
 fs/exofs/super.c                                |   2 +-
 fs/nfsd/blocklayout.c                           |   2 +-
 fs/xfs/xfs_aops.c                               |   2 +-
 fs/xfs/xfs_aops.h                               |   2 +-
 fs/xfs/xfs_super.c                              |  11 +-
 include/linux/bio.h                             |  42 +-
 include/linux/blk-mq.h                          |   3 +-
 include/linux/blk_types.h                       |  51 +-
 include/linux/blkdev.h                          | 110 ++--
 include/linux/bsg-lib.h                         |   3 +-
 include/linux/bsg.h                             |   6 +-
 include/linux/elevator.h                        |   2 -
 include/linux/fs.h                              |   2 +-
 include/linux/libata.h                          |   2 -
 include/linux/lightnvm.h                        |   2 +-
 include/linux/mempool.h                         |  34 ++
 include/linux/nvme.h                            |  16 +-
 include/linux/pktcdvd.h                         |   2 +-
 include/linux/sbitmap.h                         |  36 ++
 include/scsi/osd_initiator.h                    |   6 +-
 include/scsi/scsi_host.h                        |   2 +-
 kernel/power/swap.c                             |  14 +-
 lib/sbitmap.c                                   | 113 ++--
 mm/backing-dev.c                                |  18 +-
 mm/mempool.c                                    | 108 +++-
 212 files changed, 4020 insertions(+), 3983 deletions(-)
 delete mode 100644 arch/sparc/include/uapi/asm/jsflash.h
 rename drivers/nvme/target/{io-cmd.c => io-cmd-bdev.c} (76%)
 create mode 100644 drivers/nvme/target/io-cmd-file.c
 delete mode 100644 drivers/sbus/char/jsflash.c

-- 
Jens Axboe
