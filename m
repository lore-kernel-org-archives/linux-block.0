Return-Path: <axboe@kernel.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block core changes for 4.10
Message-ID: <6176de36-7f4f-040b-f277-e872cc98eb5e@kernel.dk>
Date: Sun, 11 Dec 2016 18:52:29 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Linus,

This is the main block pull request this series. Contrary to previous
release, I've kept the core and driver changes in the same branch. We
always ended up having dependencies between the two for obvious reasons,
so makes more sense to keep them together. That said, I'll probably try
and keep more topical branches going forward, especially for cycles that
end up being as busy as this one.

The major parts of this pull request is:

- Improved support for O_DIRECT on block devices, with a small private
  implementation instead of using the pig that is fs/direct-io.c. From
  Christoph.

- Request completion tracking in a scalable fashion. This is utilized by
  two components in this pull, the new hybrid polling and the writeback
  queue throttling code.

- Improved support for polling with O_DIRECT, adding a hybrid mode that
  combines pure polling with an initial sleep. From me.

- Support for automatic throttling of writeback queues on the block
  side. This uses feedback from the device completion latencies to scale
  the queue on the block side up or down. From me.

- Support from SMR drives in the block layer and for SD. From Hannes and
  Shaun.

- Multi-connection support for nbd. From Josef.

- Cleanup of request and bio flags, so we have a clear split between
  which are bio (or rq) private, and which ones are shared. From
  Christoph.

- A set of patches from Bart, that improve how we handle queue stopping
  and starting in blk-mq.

- Support for WRITE_ZEROES from Chaitanya.

- Lightnvm updates from Javier/Matias.

- Supoort for FC for the nvme-over-fabrics code. From James Smart.

- A bunch of fixes from a whole slew of people, too many to name here.

Note that this pull will throw 3 trivial merge conflicts, since we had
patches that went into mainline after 4.9-rc1 (upon which this branch is
based), and one that will not show up in block/blk-flush.c. The latter
is due to a fix that went in for the flush code using an old request
flag that is now changed to a per-request one. To ensure that this all
goes smoothly, I just merged 4.9 with this branch and provide that as a
reference:

  git://git.kernel.dk/linux-block.git for-4.10/merge

But really, the only one you to watch for is this line in
block/blk-flush.c:

        /* for avoiding double accounting */
	rq->cmd_flags &= ~REQ_STARTED;

which should now be:

        rq->rq_flags &= ~RQF_STARTED;

and the three merge conflicts that do show up are trivially resolvable.

Please pull!


  git://git.kernel.dk/linux-block.git for-4.10/block


----------------------------------------------------------------
Andy Shevchenko (1):
      skd_main: use %*ph to dump small buffers

Arnd Bergmann (5):
      block: zoned: fix harmless maybe-uninitialized warning
      sd: fix uninitialized variable access in error handling
      skd: fix msix error handling
      skd: fix function prototype
      blk-wbt: fix old-style function declaration

Bart Van Assche (18):
      blk-mq: Do not invoke .queue_rq() for a stopped queue
      blk-mq: Introduce blk_mq_hctx_stopped()
      blk-mq: Introduce blk_mq_queue_stopped()
      blk-mq: Move more code into blk_mq_direct_issue_request()
      blk-mq: Avoid that requeueing starts stopped queues
      blk-mq: Remove blk_mq_cancel_requeue_work()
      blk-mq: Introduce blk_mq_quiesce_queue()
      blk-mq: Add a kick_requeue_list argument to blk_mq_requeue_request()
      dm: Use BLK_MQ_S_STOPPED instead of QUEUE_FLAG_STOPPED in blk-mq code
      dm: Fix a race condition related to stopping and starting queues
      nvme: Fix a race condition related to stopping queues
      nvme: Use BLK_MQ_S_STOPPED instead of QUEUE_FLAG_STOPPED in blk-mq code
      bsg: Add sparse annotations to bsg_request_fn()
      nvmet-rdma: Fix REJ status code
      nvme-fabrics: Fix memory leaks in nvmf_parse_options()
      nvme-fabrics: Fix a memory leak in an nvmf_create_ctrl() error path
      nvme/scsi: Remove set-but-not-used variables
      nvme-fabrics: Adjust source code indentation

Chaitanya Kulkarni (5):
      block: add async variant of blkdev_issue_zeroout
      block: add support for REQ_OP_WRITE_ZEROES
      nvme.h: add Write Zeroes definitions
      nvme: add support for the Write Zeroes command
      nvmet: add support for the Write Zeroes command

Christoph Hellwig (32):
      block: remove bio_is_rw
      block: REQ_NOMERGE is common to the bio and request
      block: move REQ_RAHEAD to common flags
      block: replace REQ_THROTTLED with a bio flag
      block: split out request-only flags into a new namespace
      block: better op and flags encoding
      block: add a proper block layer data direction encoding
      cfq-iosched: use op_is_sync instead of opencoding it
      blk-cgroup: use op_is_sync to check for synchronous requests
      umem: use op_is_sync to check for synchronous requests
      bcache: use op_is_sync to check for synchronous requests
      btrfs: use op_is_sync to check for synchronous requests
      block: don't use REQ_SYNC in the READ_SYNC definition
      block: treat REQ_FUA and REQ_PREFLUSH as synchronous
      block: replace REQ_NOIDLE with REQ_IDLE
      block,fs: use REQ_* flags directly
      fs: decouple READ and WRITE from the block layer ops
      block, fs: move submit_bio to bio.h
      block,fs: untangle fs.h and blk_types.h
      arm, arm64: don't include blk_types.h in <asm/io.h>
      ceph: don't include blk_types.h in messenger.h
      mm: only include blk_types in swap.h if CONFIG_SWAP is enabled
      block: remove the CONFIG_BLOCK ifdef in blk_types.h
      pktcdvd: don't scribble over the bvec array
      skd: use pci_alloc_irq_vectors
      nvme: introduce struct nvme_request
      nvme: don't pass the full CQE to nvme_complete_async_event
      block: fast-path for small and simple direct I/O requests
      block: new direct I/O implementation
      block: clear all of bi_opf in bio_set_op_attrs
      blk-wbt: don't throttle discard or write zeroes
      block: improve handling of the magic discard payload

Damien Le Moal (4):
      block: Add 'zoned' queue limit
      sd_zbc: Force use of READ16/WRITE16
      block_dev: Fixed direct I/O bio sector calculation
      block: Check partition alignment on zoned block devices

Gabriel Krisman Bertazi (2):
      blk-mq: Always schedule hctx->next_cpu
      blk-mq: Drop explicit timeout sync in hotplug

Geliang Tang (1):
      skd_main: drop duplicate header scatterlist.h

Hannes Reinecke (4):
      blk-sysfs: Add 'chunk_sectors' to sysfs attributes
      block: update chunk_sectors in blk_stack_limits()
      block: Implement support for zoned block devices
      sd: Implement support for ZBC devices

James Smart (10):
      parser: add u64 number parser
      nvme-fabrics: set sqe.command_id in core not transports
      nvme-fabrics: patch target code in prep for FC transport support
      Add type 0x28 NVME type code to scsi fc headers
      nvme-fabrics: Add FC transport error codes to nvme.h
      nvme-fabrics: Add FC transport FC-NVME definitions
      nvme-fabrics: Add FC transport LLDD api definitions
      nvme-fabrics: Add host support for FC transport
      nvme-fabrics: Add target support for FC transport
      nvme-fabrics: Add FC LLDD loopback driver to test FC-NVME

Jan Kara (1):
      brd: Switch rd_size to unsigned long

Javier González (21):
      lightnvm: enable to send hint to erase command
      lightnvm: do not protect block 0
      lightnvm: export set bad block table
      lightnvm: add ECC error codes
      lightnvm: rrpc: split bios of size > 256kb
      lightnvm: remove sysfs configuration interface
      lightnvm: cleanup unused target operations
      lightnvm: make address conversion functions global
      lightnvm: remove unnecessary variables in rrpc
      lightnvm: use constant name instead of value
      lightnvm: remove gen_lun abstraction
      lightnvm: manage lun partitions internally in mm
      lightnvm: move block provisioning to targets
      lightnvm: remove get_lun operation on gennvm
      lightnvm: remove debug lun statistics from gennvm
      lightnvm: eliminate nvm_block abstraction on mm
      lightnvm: eliminate nvm_lun abstraction in mm
      lightnvm: introduce helpers for generic ops in rrpc
      lightnvm: introduce max_phys_sects helper function
      lightnvm: use target nvm on target-specific ops.
      lightnvm: transform target get/set bad block

Jens Axboe (36):
      blk-mq: get rid of confusing blk_map_ctx structure
      block: add REQ_BACKGROUND
      writeback: add wbc_to_write_flags()
      writeback: mark background writeback as such
      block: add code to track actual device queue depth
      writeback: track if we're sleeping on progress in balance_dirty_pages()
      block: set REQ_SYNC if we clear REQ_FUA|REQ_PREFLUSH
      block: add scalable completion tracking of requests
      blk-wbt: add general throttling mechanism
      block: hook up writeback throttling
      blk-mq: blk_mq_try_issue_directly() should lookup hardware queue
      block: move poll code to blk-mq
      blk-wbt: store queue instead of bdi
      blk-wbt: remove stat ops
      blk-wbt: use BLK_STAT_{READ,WRITE} instead of 0/1
      nbd: fix use-after-free of rq/bio in the xmit path
      blk-mq: implement hybrid poll mode for sync O_DIRECT
      blk-mq: make the polling code adaptive
      block: support a full bio worth of IO for simplified bdev direct-io
      block: make __blkdev_direct_IO_sync() support O_SYNC/DSYNC
      block: document the 'io_poll_delay' queue sysfs file
      pktcdvd: mark as unmaintained and deprecated
      block_dev: get rid of blksize bits calculation
      nbd: move multi-connection bit to unused value
      nbd: fix setting of 'error' in NBD_DO_IT ioctl
      blk-wbt: allow reset of default latency through sysfs
      blk-wbt: cleanup disable-by-default for CFQ
      blk-wbt: allow wbt to be enabled always through sysfs
      nbd: fix 64-bit division
      blk-mq: blk_account_io_start() takes a bool
      Merge branch 'nvmf-4.10' of git://git.infradead.org/nvme-fabrics into for-4.10/block
      blk-mq: add blk_mq_start_stopped_hw_queue()
      blk-mq: abstract out blk_mq_dispatch_rq_list() helper
      elevator: make the rqhash helpers exported
      blk-flush: run the queue when inserting blk-mq flush
      blk-stat: fix a few cases of missing batch flushing

Johannes Thumshirn (1):
      block: drop q argument from bsg_validate_sgv4_hdr

Josef Bacik (4):
      nbd: add multi-connection support
      nbd: use loff_t for blocksize and nbd_set_size args
      nbd: reset the setup task for NBD_CLEAR_SOCK
      nbd: use dev_err_ratelimited in io path

Kent Overstreet (1):
      block: add bio_iov_iter_get_pages()

Matias Bjørling (2):
      nvme: lightnvm: frees wrong cmd structure
      nvme: lightnvm: attach lightnvm sysfs to nvme block device

Max Gurtovoy (2):
      nvmet-rdma: align to generic ib_event logging helper
      nvme-rdma: align to generic ib_event logging helper

Mike Snitzer (1):
      brd: remove support for BLKFLSBUF

Ming Lei (10):
      block: deal with stale req count of plug list
      block: bio: pass bvec table to bio_init()
      block: drbd: remove impossible failure handling
      block: floppy: use bio_add_page()
      target: avoid accessing .bi_vcnt directly
      bcache: debug: avoid accessing .bi_io_vec directly
      fs: logfs: convert to bio_add_page() in sync_request()
      fs: logfs: use bio_add_page() in __bdev_writeseg()
      fs: logfs: use bio_add_page() in do_erase()
      fs: logfs: remove unnecesary check

Nicolai Stange (1):
      block: fix unintended fallthrough in generic_make_request_checks()

Omar Sandoval (3):
      loop: return proper error from loop_queue_rq()
      nvme: untangle 0 and BLK_MQ_RQ_QUEUE_OK
      scsi_lib: untangle 0 and BLK_MQ_RQ_QUEUE_OK

Pan Bian (1):
      block: mtip32xx: set error code on failure

Rabin Vincent (1):
      block: protect iterate_bdevs() against concurrent close

Ritesh Harjani (1):
      block: factor out req_set_nomerge

Sachin Shukla (1):
      Block: mtip32xx: Improvement in code readability when memdup_user() fails.

Sagi Grimberg (1):
      nvme-rdma: remove redundant define

Samuel Jones (1):
      nvme-rdma: force queue size to respect controller capability

Shaohua Li (3):
      block: immediately dispatch big size request
      blk-mq: immediately dispatch big size request
      blk-stat: fix a typo

Shaun Tancheff (3):
      block: Define zoned block device operations
      blk-zoned: implement ioctls
      block: apply blk_partition_remap to REQ_OP_ZONE_RESET

Solganik Alexander (1):
      nvmet: Fix possible infinite loop triggered on hot namespace removal

Tejun Heo (2):
      block: cfq_cpd_alloc() should use @gfp
      block,blkcg: use __GFP_NOWARN for best-effort allocations in blkcg

Tobias Klauser (1):
      block: Change extern inline to static inline

Yasuaki Ishimatsu (1):
      null_blk: add usage hints for NVM

 Documentation/ABI/testing/sysfs-block             |   42 +
 Documentation/block/biodoc.txt                    |    6 +-
 Documentation/block/cfq-iosched.txt               |   32 +-
 Documentation/block/null_blk.txt                  |    2 +-
 Documentation/block/queue-sysfs.txt               |   23 +
 MAINTAINERS                                       |   14 +-
 arch/arm/include/asm/io.h                         |    1 -
 arch/arm64/include/asm/io.h                       |    1 -
 block/Kconfig                                     |   35 +
 block/Makefile                                    |    4 +-
 block/bio-integrity.c                             |    2 +-
 block/bio.c                                       |   68 +-
 block/blk-cgroup.c                                |    9 +-
 block/blk-core.c                                  |  261 +--
 block/blk-exec.c                                  |    2 +-
 block/blk-flush.c                                 |   25 +-
 block/blk-lib.c                                   |  177 +-
 block/blk-map.c                                   |    6 +-
 block/blk-merge.c                                 |   89 +-
 block/blk-mq-sysfs.c                              |   47 +
 block/blk-mq.c                                    |  545 ++++-
 block/blk-mq.h                                    |    9 +
 block/blk-settings.c                              |   38 +
 block/blk-stat.c                                  |  256 ++
 block/blk-stat.h                                  |   42 +
 block/blk-sysfs.c                                 |  190 ++
 block/blk-tag.c                                   |    6 +-
 block/blk-throttle.c                              |   10 +-
 block/blk-wbt.c                                   |  750 ++++++
 block/blk-wbt.h                                   |  171 ++
 block/blk-zoned.c                                 |  348 +++
 block/blk.h                                       |    5 +-
 block/bsg-lib.c                                   |    2 +
 block/bsg.c                                       |    4 +-
 block/cfq-iosched.c                               |  109 +-
 block/elevator.c                                  |   44 +-
 block/ioctl.c                                     |    4 +
 block/partition-generic.c                         |   65 +
 drivers/block/Kconfig                             |    5 +-
 drivers/block/brd.c                               |   39 +-
 drivers/block/drbd/drbd_actlog.c                  |    2 +-
 drivers/block/drbd/drbd_receiver.c                |   16 +-
 drivers/block/floppy.c                            |   10 +-
 drivers/block/loop.c                              |    2 +-
 drivers/block/mtip32xx/mtip32xx.c                 |   18 +-
 drivers/block/nbd.c                               |  443 ++--
 drivers/block/null_blk.c                          |    1 +
 drivers/block/pktcdvd.c                           |   49 +-
 drivers/block/skd_main.c                          |  238 +-
 drivers/block/umem.c                              |    2 +-
 drivers/block/xen-blkback/blkback.c               |   10 +-
 drivers/block/xen-blkfront.c                      |    3 +-
 drivers/ide/ide-atapi.c                           |    6 +-
 drivers/ide/ide-cd.c                              |   46 +-
 drivers/ide/ide-cd.h                              |    2 +-
 drivers/ide/ide-cd_ioctl.c                        |    6 +-
 drivers/ide/ide-io.c                              |    6 +-
 drivers/ide/ide-pm.c                              |    4 +-
 drivers/lightnvm/Makefile                         |    2 +-
 drivers/lightnvm/core.c                           |  377 ++-
 drivers/lightnvm/gennvm.c                         |  645 +++--
 drivers/lightnvm/gennvm.h                         |   34 +-
 drivers/lightnvm/lightnvm.h                       |   35 -
 drivers/lightnvm/rrpc.c                           |  514 ++--
 drivers/lightnvm/rrpc.h                           |   65 +-
 drivers/lightnvm/sysblk.c                         |   98 +-
 drivers/lightnvm/sysfs.c                          |  198 --
 drivers/md/bcache/btree.c                         |    4 +-
 drivers/md/bcache/debug.c                         |   15 +-
 drivers/md/bcache/io.c                            |    4 +-
 drivers/md/bcache/journal.c                       |    4 +-
 drivers/md/bcache/movinggc.c                      |    6 +-
 drivers/md/bcache/request.c                       |    8 +-
 drivers/md/bcache/super.c                         |   16 +-
 drivers/md/bcache/writeback.c                     |    5 +-
 drivers/md/bcache/writeback.h                     |    3 +-
 drivers/md/dm-bufio.c                             |    6 +-
 drivers/md/dm-crypt.c                             |    2 +-
 drivers/md/dm-log.c                               |    2 +-
 drivers/md/dm-raid1.c                             |    4 +-
 drivers/md/dm-rq.c                                |   52 +-
 drivers/md/dm-snap-persistent.c                   |    4 +-
 drivers/md/dm.c                                   |    4 +-
 drivers/md/md.c                                   |    4 +-
 drivers/md/multipath.c                            |    2 +-
 drivers/md/raid5-cache.c                          |    6 +-
 drivers/md/raid5.c                                |   11 +-
 drivers/memstick/core/ms_block.c                  |    2 +-
 drivers/memstick/core/mspro_block.c               |    2 +-
 drivers/mmc/card/block.c                          |    4 +-
 drivers/mmc/card/queue.c                          |    4 +-
 drivers/nvme/host/Kconfig                         |   17 +
 drivers/nvme/host/Makefile                        |    3 +
 drivers/nvme/host/core.c                          |  150 +-
 drivers/nvme/host/fabrics.c                       |   33 +-
 drivers/nvme/host/fc.c                            | 2586 +++++++++++++++++++++
 drivers/nvme/host/lightnvm.c                      |  223 +-
 drivers/nvme/host/nvme.h                          |   51 +-
 drivers/nvme/host/pci.c                           |   47 +-
 drivers/nvme/host/rdma.c                          |   43 +-
 drivers/nvme/host/scsi.c                          |   11 +-
 drivers/nvme/target/Kconfig                       |   24 +
 drivers/nvme/target/Makefile                      |    4 +
 drivers/nvme/target/admin-cmd.c                   |    3 +-
 drivers/nvme/target/configfs.c                    |   20 +-
 drivers/nvme/target/core.c                        |   22 +-
 drivers/nvme/target/fabrics-cmd.c                 |   14 +-
 drivers/nvme/target/fc.c                          | 2288 ++++++++++++++++++
 drivers/nvme/target/fcloop.c                      | 1148 +++++++++
 drivers/nvme/target/io-cmd.c                      |   39 +-
 drivers/nvme/target/loop.c                        |   26 +-
 drivers/nvme/target/nvmet.h                       |    8 +-
 drivers/nvme/target/rdma.c                        |    8 +-
 drivers/scsi/Makefile                             |    1 +
 drivers/scsi/device_handler/scsi_dh_alua.c        |    8 +-
 drivers/scsi/device_handler/scsi_dh_emc.c         |    2 +-
 drivers/scsi/device_handler/scsi_dh_hp_sw.c       |    2 +-
 drivers/scsi/device_handler/scsi_dh_rdac.c        |    2 +-
 drivers/scsi/osd/osd_initiator.c                  |    2 +-
 drivers/scsi/osst.c                               |    2 +-
 drivers/scsi/scsi.c                               |    3 +
 drivers/scsi/scsi_error.c                         |    2 +-
 drivers/scsi/scsi_lib.c                           |   92 +-
 drivers/scsi/sd.c                                 |  181 +-
 drivers/scsi/sd.h                                 |   70 +
 drivers/scsi/sd_zbc.c                             |  648 ++++++
 drivers/scsi/st.c                                 |    2 +-
 drivers/scsi/ufs/ufshcd.c                         |    6 +-
 drivers/staging/lustre/include/linux/lnet/types.h |    1 +
 drivers/staging/lustre/lustre/llite/rw.c          |    1 +
 drivers/target/target_core_iblock.c               |    8 +-
 drivers/target/target_core_pscsi.c                |    8 +-
 fs/9p/vfs_addr.c                                  |    1 +
 fs/block_dev.c                                    |  272 ++-
 fs/btrfs/disk-io.c                                |    8 +-
 fs/btrfs/extent_io.c                              |   16 +-
 fs/btrfs/inode.c                                  |   11 +-
 fs/btrfs/scrub.c                                  |    2 +-
 fs/btrfs/volumes.c                                |    4 +-
 fs/btrfs/volumes.h                                |    2 +-
 fs/buffer.c                                       |   10 +-
 fs/cifs/connect.c                                 |    1 +
 fs/cifs/transport.c                               |    1 +
 fs/direct-io.c                                    |    4 +-
 fs/ext4/mmp.c                                     |    6 +-
 fs/ext4/page-io.c                                 |    2 +-
 fs/ext4/super.c                                   |    2 +-
 fs/f2fs/checkpoint.c                              |    4 +-
 fs/f2fs/data.c                                    |   16 +-
 fs/f2fs/f2fs.h                                    |    2 +-
 fs/f2fs/gc.c                                      |    6 +-
 fs/f2fs/inline.c                                  |    2 +-
 fs/f2fs/node.c                                    |    4 +-
 fs/f2fs/segment.c                                 |    8 +-
 fs/f2fs/super.c                                   |    2 +-
 fs/gfs2/dir.c                                     |    1 +
 fs/gfs2/log.c                                     |    4 +-
 fs/gfs2/lops.c                                    |    2 +-
 fs/gfs2/meta_io.c                                 |    7 +-
 fs/gfs2/ops_fstype.c                              |    2 +-
 fs/hfsplus/super.c                                |    4 +-
 fs/isofs/compress.c                               |    1 +
 fs/jbd2/checkpoint.c                              |    2 +-
 fs/jbd2/commit.c                                  |    9 +-
 fs/jbd2/journal.c                                 |   15 +-
 fs/jbd2/revoke.c                                  |    2 +-
 fs/jfs/jfs_logmgr.c                               |    4 +-
 fs/logfs/dev_bdev.c                               |  106 +-
 fs/mpage.c                                        |    6 +-
 fs/nilfs2/super.c                                 |    2 +-
 fs/ntfs/aops.c                                    |    1 +
 fs/ntfs/logfile.c                                 |    1 +
 fs/ntfs/mft.c                                     |    1 +
 fs/ocfs2/buffer_head_io.c                         |    1 +
 fs/ocfs2/cluster/heartbeat.c                      |    2 +-
 fs/orangefs/inode.c                               |    1 +
 fs/reiserfs/inode.c                               |    1 +
 fs/reiserfs/journal.c                             |    6 +-
 fs/reiserfs/stree.c                               |    1 +
 fs/splice.c                                       |    1 +
 fs/squashfs/block.c                               |    1 +
 fs/udf/dir.c                                      |    1 +
 fs/udf/directory.c                                |    1 +
 fs/udf/inode.c                                    |    1 +
 fs/ufs/balloc.c                                   |    1 +
 fs/xfs/xfs_aops.c                                 |    7 +-
 fs/xfs/xfs_buf.c                                  |    2 +-
 include/linux/backing-dev-defs.h                  |    2 +
 include/linux/bio.h                               |   49 +-
 include/linux/blk-cgroup.h                        |   11 +-
 include/linux/blk-mq.h                            |   11 +-
 include/linux/blk_types.h                         |  188 +-
 include/linux/blkdev.h                            |  231 +-
 include/linux/blktrace_api.h                      |    2 +-
 include/linux/ceph/messenger.h                    |    2 +-
 include/linux/dm-io.h                             |    2 +-
 include/linux/elevator.h                          |    9 +-
 include/linux/fs.h                                |   68 +-
 include/linux/kernel.h                            |    4 +
 include/linux/lightnvm.h                          |  244 +-
 include/linux/nvme-fc-driver.h                    |  851 +++++++
 include/linux/nvme-fc.h                           |  268 +++
 include/linux/nvme.h                              |   43 +-
 include/linux/parser.h                            |    1 +
 include/linux/swap.h                              |    3 +
 include/linux/uio.h                               |    2 +-
 include/linux/writeback.h                         |   13 +
 include/scsi/scsi_device.h                        |    4 +-
 include/scsi/scsi_proto.h                         |   17 +
 include/trace/events/bcache.h                     |   12 +-
 include/trace/events/block.h                      |   31 +-
 include/trace/events/f2fs.h                       |   12 +-
 include/trace/events/wbt.h                        |  153 ++
 include/uapi/linux/Kbuild                         |    1 +
 include/uapi/linux/blkzoned.h                     |  143 ++
 include/uapi/linux/fs.h                           |    4 +
 include/uapi/linux/nbd.h                          |    9 +-
 include/uapi/scsi/fc/fc_fs.h                      |    2 +
 kernel/power/swap.c                               |   19 +-
 kernel/trace/blktrace.c                           |   14 +-
 lib/iov_iter.c                                    |    1 +
 lib/parser.c                                      |   47 +
 mm/backing-dev.c                                  |    1 +
 mm/page-writeback.c                               |    1 +
 mm/page_io.c                                      |    5 +-
 225 files changed, 14275 insertions(+), 3091 deletions(-)
 create mode 100644 block/blk-stat.c
 create mode 100644 block/blk-stat.h
 create mode 100644 block/blk-wbt.c
 create mode 100644 block/blk-wbt.h
 create mode 100644 block/blk-zoned.c
 delete mode 100644 drivers/lightnvm/lightnvm.h
 delete mode 100644 drivers/lightnvm/sysfs.c
 create mode 100644 drivers/nvme/host/fc.c
 create mode 100644 drivers/nvme/target/fc.c
 create mode 100644 drivers/nvme/target/fcloop.c
 create mode 100644 drivers/scsi/sd_zbc.c
 create mode 100644 include/linux/nvme-fc-driver.h
 create mode 100644 include/linux/nvme-fc.h
 create mode 100644 include/trace/events/wbt.h
 create mode 100644 include/uapi/linux/blkzoned.h

-- 
Jens Axboe
