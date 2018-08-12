Return-Path: <axboe@kernel.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block changes for 4.19-rc1
Message-ID: <0ffc9cd2-c6a3-6091-345d-f079c570d497@kernel.dk>
Date: Sun, 12 Aug 2018 17:24:02 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Linus,

First pull request for this merge window, there will also be a
followup request with some stragglers.

This pull request contains:

- Fix for a thundering heard issue in the wbt block code (Anchal
  Agarwal)

- A few NVMe pull requests:

	- Improved tracepoints (Keith)
	- Larger inline data support for RDMA (Steve Wise)
	- RDMA setup/teardown fixes (Sagi)
	- Effects log suppor for NVMe target (Chaitanya Kulkarni)
	- Buffered IO suppor for NVMe target (Chaitanya Kulkarni)
	- TP4004 (ANA) support (Christoph)
	- Various NVMe fixes

- Block io-latency controller support. Much needed support for properly
  containing block devices. (Josef)

- Series improving how we handle sense information on the stack (Kees)

- Lightnvm fixes and updates/improvements (Mathias/Javier et al)

- Zoned device support for null_blk (Matias)

- AIX partition fixes (Mauricio Faria de Oliveira)

- DIF checksum code made generic (Max Gurtovoy)

- Add support for discard in iostats (Michael Callahan / Tejun)

- Set of updates for BFQ (Paolo)

- Removal of async write support for bsg (Christoph)

- Bio page dirtying and clone fixups (Christoph)

- Set of bcache fix/changes (via Coly)

- Series improving blk-mq queue setup/teardown speed (Ming)

- Series improving merging performance on blk-mq (Ming)

- Lots of other fixes and cleanups from a slew of folks.

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-4.19/block-20180812


----------------------------------------------------------------
Anchal Agarwal (1):
      blk-wbt: Avoid lock contention and thundering herd issue in wbt_wait

Andy Shevchenko (1):
      nvmet: don't use uuid_le type

Arnd Bergmann (2):
      block: iolatency: avoid 64-bit division
      bcache: stop using the deprecated get_seconds()

Bart Van Assche (16):
      block: Remove a superfluous cast from blkdev_report_zones()
      include/uapi/linux/blkzoned.h: Remove a superfluous __packed directive
      block: Remove bdev_nr_zones()
      block: Inline blk_queue_nr_zones()
      block: Make struct request_queue smaller for CONFIG_BLK_DEV_ZONED=n
      drbd: Do not redefine __must_hold()
      block: Document how blk_update_request() handles RQF_SPECIAL_PAYLOAD requests
      lightnvm: Remove redundant rq->__data_len initialization
      block: Rename the null_blk_mod kernel module back into null_blk
      cfq: Annotate fall-through in a switch statement
      cfq: Suppress compiler warnings about comparisons
      block: Remove two superfluous #include directives
      blkcg: Introduce blkg_root_lookup()
      block: Introduce blk_exit_queue()
      block: Ensure that a request queue is dissociated from the cgroup controller
      blkcg: Make blkg_root_lookup() work for queues in bypass mode

Chaitanya Kulkarni (6):
      nvmet: add commands supported and effects log page
      nvmet: add buffered I/O support for file backed ns
      nvmet: use Retain Async Event bit to clear AEN
      nvme.h: add support for ns write protect definitions
      nvme: set gendisk read only based on nsattr
      nvmet: add ns write protect support

Christoph Hellwig (20):
      bsg: remove read/write support
      block: simplify bio_check_pages_dirty
      block: bio_set_pages_dirty can't see NULL bv_page in a valid bio_vec
      bcache: don't clone bio in bch_data_verify
      exofs: use bio_clone_fast in _write_mirror
      block: remove bio_clone_kmalloc
      md: remove a bogus comment
      block: unexport bio_clone_bioset
      nvme.h: add support for the log specific field
      nvme.h: add ANA definitions
      nvme: simplify the API for getting log pages
      nvme: remove nvme_req_needs_failover
      nvme: add ANA support
      nvmet: keep a port pointer in nvmet_ctrl
      nvmet: track and limit the number of namespaces per subsystem
      nvmet: add minimal ANA support
      nvmet: support configuring ANA groups
      scsi: build scsi_common.o for all scsi passthrough request users
      target: don't depend on SCSI
      target/loop: depend on SCSI

Colin Ian King (4):
      block/floppy: remove redundant variable dflags
      loop: remove redundant pointer inode
      partitions/ldm: remove redundant pointer dgrp
      paride: remove redundant variable n

Coly Li (9):
      bcache: do not check return value of debugfs_create_dir()
      bcache: display rate debug parameters to 0 when writeback is not running
      bcache: avoid unncessary cache prefetch bch_btree_node_get()
      bcache: add a comment in super.c
      bcache: fix mistaken code comments in bcache.h
      bcache: fix mistaken comments in request.c
      bcache: add code comments for bset.c
      bcache: set max writeback rate when I/O request is idle
      bcache: fix error setting writeback_rate through sysfs interface

Dennis Zhou (Facebook) (1):
      block: make iolatency avg_lat exponentially decay

Florian Schmaus (3):
      bcache: do not assign in if condition register_bcache()
      bcache: do not assign in if condition in bcache_init()
      bcache: do not assign in if condition in bcache_device_init()

Geert Uytterhoeven (1):
      block: Add default switch case to blk_pm_allow_request() to kill warning

Greg Edwards (3):
      block: move bio_integrity_{intervals,bytes} into blkdev.h
      scsi: virtio_scsi: fix pi_bytes{out,in} on 4 KiB block size devices
      block: bvec_nr_vecs() returns value for wrong slab

Gustavo A. R. Silva (7):
      drbd: mark expected switch fall-throughs
      block/loop: mark expected switch fall-through
      lightnvm: pblk: mark expected switch fall-through
      nvme-rdma: mark expected switch fall-through
      aoe: mark expected switch fall-through
      xen-blkfront: use true and false for boolean values
      block: paride: pd: mark expected switch fall-throughs

Hannes Reinecke (2):
      nvme: fixup crash on failed discovery
      nvme.h: fixup ANA group descriptor format

Hans Holmberg (1):
      lightnvm: pblk: assume that chunks are closed on 1.2 devices

Heiner Litz (1):
      lightnvm: pblk: add asynchronous partial read

Helge Deller (1):
      block: skd: Use %pad printk format for dma_addr_t values

James Smart (1):
      nvme: move init of keep_alive work item to controller initialization

Jens Axboe (6):
      Merge branch 'nvme-4.19' of git://git.infradead.org/nvme into for-4.19/block
      t10-pi: provide empty t10_pi_complete() for !CONFIG_BLK_DEV_INTEGRITY
      Merge tag 'v4.18-rc6' into for-4.19/block2
      Merge branch 'nvme-4.19' of git://git.infradead.org/nvme into for-4.19/block2
      Merge branch 'nvme-4.19' of git://git.infradead.org/nvme into for-4.19/block
      null_blk: add lock drop/acquire annotation

Jianchao Wang (1):
      blk-mq: count the hctx as active before allocating tag

Jinbum Park (1):
      pktcdvd: Fix possible Spectre-v1 for pkt_devs

Josef Bacik (20):
      block: add bi_blkg to the bio for cgroups
      block: introduce bio_issue_as_root_blkg
      blk-cgroup: allow controllers to output their own stats
      blk: introduce REQ_SWAP
      blkcg: add generic throttling mechanism
      blk-stat: export helpers for modifying blk_rq_stat
      blk-rq-qos: refactor out common elements of blk-wbt
      block: remove external dependency on wbt_flags
      rq-qos: introduce dio_bio callback
      block: introduce blk-iolatency io controller
      Documentation: add a doc for blk-iolatency
      mm: skip readahead if the cgroup is congested
      blk-iolatency: fix max_depth comparisons
      blk-iolatency: don't change the latency window
      blk-iolatency: truncate our current time
      blk-rq-qos: make depth comparisons unsigned
      block: don't account for split bio's size in cgroup stats
      blk-iolatency: fix blkg leak in timer_fn
      blk-cgroup: hold the queue ref during throttling
      blk-cgroup: clear the throttle queue on fork

Juergen Gross (1):
      xen/blkfront: remove unused macros

Kees Cook (7):
      ide-cd: Drop unused sense buffers
      scsi: cxlflash: Drop unused sense buffers
      block: Switch struct packet_command to use struct scsi_sense_hdr
      ide-cd: Remove redundant sense buffer
      cdrom: Use struct scsi_sense_hdr internally
      libata-scsi: Move sense buffers onto stack
      scsi: Check sense buffer size at build time

Keith Busch (3):
      nvme: use hw qid in trace events
      nvme: add controller name to trace events
      nvme: add disk name to trace events

Liu Bo (4):
      Blktrace: bail out early if block debugfs is not configured
      Block: blk-throttle: set low_valid immediately once one cgroup has io.low configured
      null_blk: remove NULLB_DEV_FL_CONFIGURED on turning off nullb device
      Blk-throttle: reduce tail io latency when iops limit is enforced

Marcin Dziegielewski (1):
      lightnvm: pblk: handle case when mw_cunits equals to 0

Markus Stockhausen (1):
      readahead: stricter check for bdi io_pages

Matias Bjørling (8):
      null_blk: move shared definitions to header file
      null_blk: add zone support
      lightnvm: move NVM_DEBUG to pblk
      lightnvm: pblk: enable line minor version detection
      lightnvm: pblk: fix read_bitmap for 32bit archs
      lightnvm: limit get chunk meta request size
      lightnvm: pblk: expose generic disk name on pr_* msgs
      lightnvm: remove minor version check for 2.0

Mauricio Faria de Oliveira (2):
      partitions/aix: fix usage of uninitialized lv_info and lvname structures
      partitions/aix: append null character to print data from disk

Max Gurtovoy (5):
      nvmet-rdma: add unlikely check in the fast path
      nvmet-rdma: add an error flow for post_recv failures
      block: move ref_tag calculation func to the block layer
      block: move dif_prepare/dif_complete functions to block layer
      nvme: use blk API to remap ref tags for IOs with metadata

Michael Callahan (4):
      block: Add part_stat_read_accum to read across field entries.
      block: Define and use STAT_READ and STAT_WRITE
      block: Add and use op_stat_group() for indexing disk_stat fields.
      block: Track DISCARD statistics and output them in stat and diskstat

Mike Snitzer (1):
      block: allow max_discard_segments to be stacked

Mikulas Patocka (1):
      block: fix infinite loop if the device loses discard capability

Ming Lei (12):
      blk-mq: cleanup blk_mq_get_driver_tag()
      blk-mq: don't pass **hctx to blk_mq_mark_tag_wait()
      blk-mq: introduce new lock for protecting hctx->dispatch_wait
      blk-mq: remove synchronize_rcu() from blk_mq_del_queue_tag_set()
      blk-mq: avoid to synchronize rcu inside blk_cleanup_queue()
      blk-mq: use list_splice_tail_init() to insert requests
      blk-mq: only attempt to merge bio if there is rq in sw queue
      blk-mq: dequeue request one by one from sw queue if hctx is busy
      blk-mq: issue directly if hw queue isn't busy in case of 'none'
      blk-mq: fail the request in case issue failure
      block: really disable runtime-pm for blk-mq
      blk-mq: fix updating tags depth

Minwoo Im (2):
      blk-mq: code clean-up by adding an API to clear set->mq_map
      blk-mq: fix typo in a function comment

Paolo Valente (4):
      block, bfq: add/remove entity weights correctly
      block, bfq: do not expire a queue that will deserve dispatch plugging
      block, bfq: fix service being wrongly set to zero in case of preemption
      block, bfq: give a better name to bfq_bfqq_may_idle

RAGHU Halharvi (1):
      pktcdvd: remove assignment in if condition

Randy Dunlap (1):
      block/DAC960.c: fix defined but not used build warnings

Revanth Rajashekar (1):
      nvme.h: resync with nvme-cli

Sagi Grimberg (6):
      nvme: cache struct nvme_ctrl reference to struct nvme_request
      nvme-rdma: unquiesce queues when deleting the controller
      nvme-rdma: centralize controller setup sequence
      nvme-rdma: centralize admin/io queue teardown sequence
      nvmet: fix file discard return status
      nvmet: check fileio lba range access boundaries

Shakeel Butt (1):
      block, mm: remove unnecessary __GFP_HIGH flag

Shenghui Wang (3):
      bcache: free heap cache_set->flush_btree in bch_journal_free
      bcache: make the pr_err statement used for ENOENT only in sysfs_attatch section
      bcache: trivial - remove tailing backslash in macro BTREE_FLAG

Steve Wise (2):
      nvme-rdma: support up to 4 segments of inline data
      nvmet-rdma: support max(16KB, PAGE_SIZE) inline data

Tal Shorer (1):
      nvme-fabrics: fix ctrl_loss_tmo < 0 to reconnect forever

Tang Junhui (4):
      bcache: simplify the calculation of the total amount of flash dirty data
      bcache: finish incremental GC
      bcache: calculate the number of incremental GC nodes according to the total of btree nodes
      bcache: fix I/O significant decline while backend devices registering

Tejun Heo (4):
      swap,blkcg: issue swap io with the appropriate context
      memcontrol: schedule throttling if we are congested
      block: make bdev_ops->rw_page() take a REQ_OP instead of bool
      blkcg: Track DISCARD statistics and output them in cgroup io.stat

Vladimir Zapolskiy (1):
      block: remove blkdev_entry_to_request() macro

xiao jin (1):
      block: blk_init_allocated_queue() set q->fq as NULL in the fail case

zhong jiang (4):
      block/bsg-lib: use PTR_ERR_OR_ZERO to simplify the flow path
      drivers/block/mtip32xx: remove the null check for debugfs_remove_recursive
      drivers/block/aoe/aoedev: NULL check is not needed for mempool_destroy
      drivers/block/drbd: remove the null check for kmem_cache_destroy

 Documentation/ABI/testing/procfs-diskstats    |  10 +
 Documentation/admin-guide/cgroup-v2.rst       |  92 ++-
 Documentation/block/null_blk.txt              |   7 +
 Documentation/block/stat.txt                  |  28 +-
 Documentation/iostats.txt                     |  15 +
 block/Kconfig                                 |  16 +
 block/Makefile                                |   4 +-
 block/bfq-iosched.c                           | 131 +++-
 block/bfq-iosched.h                           |   7 +-
 block/bfq-wf2q.c                              |  30 +-
 block/bio-integrity.c                         |  22 -
 block/bio.c                                   | 208 +++---
 block/blk-cgroup.c                            | 284 +++++++-
 block/blk-core.c                              | 106 +--
 block/blk-ioc.c                               |   2 +-
 block/blk-iolatency.c                         | 955 ++++++++++++++++++++++++++
 block/blk-lib.c                               |  10 +
 block/blk-mq-debugfs-zoned.c                  |  24 +
 block/blk-mq-debugfs.c                        |  24 +-
 block/blk-mq-debugfs.h                        |   9 +
 block/blk-mq-pci.c                            |   5 +-
 block/blk-mq-sched.c                          | 112 +--
 block/blk-mq-tag.c                            |  11 +-
 block/blk-mq.c                                | 173 +++--
 block/blk-mq.h                                |  13 +-
 block/blk-rq-qos.c                            | 194 ++++++
 block/blk-rq-qos.h                            | 109 +++
 block/blk-settings.c                          |   6 +-
 block/blk-stat.c                              |  16 +-
 block/blk-stat.h                              |   4 +
 block/blk-sysfs.c                             |  37 +-
 block/blk-throttle.c                          |  32 +-
 block/blk-wbt.c                               | 425 ++++++------
 block/blk-wbt.h                               |  68 +-
 block/blk-zoned.c                             |   2 +-
 block/blk.h                                   |   7 +
 block/bounce.c                                |  69 +-
 block/bsg-lib.c                               |   5 +-
 block/bsg.c                                   | 460 +------------
 block/cfq-iosched.c                           |  23 +-
 block/genhd.c                                 |  29 +-
 block/partition-generic.c                     |  25 +-
 block/partitions/aix.c                        |  13 +-
 block/partitions/ldm.c                        |   3 -
 block/t10-pi.c                                | 110 +++
 drivers/Makefile                              |   2 +-
 drivers/ata/libata-scsi.c                     |  18 +-
 drivers/block/DAC960.c                        |   9 +-
 drivers/block/Kconfig                         |   2 +-
 drivers/block/Makefile                        |   5 +-
 drivers/block/aoe/aoecmd.c                    |   1 +
 drivers/block/aoe/aoedev.c                    |   4 +-
 drivers/block/brd.c                           |  14 +-
 drivers/block/drbd/drbd_int.h                 |   2 -
 drivers/block/drbd/drbd_main.c                |  12 +-
 drivers/block/drbd/drbd_receiver.c            |   6 +-
 drivers/block/drbd/drbd_req.c                 |   4 +-
 drivers/block/drbd/drbd_worker.c              |   4 +-
 drivers/block/floppy.c                        |   3 -
 drivers/block/loop.c                          |   3 +-
 drivers/block/mtip32xx/mtip32xx.c             |   3 +-
 drivers/block/null_blk.h                      | 108 +++
 drivers/block/{null_blk.c => null_blk_main.c} | 129 ++--
 drivers/block/null_blk_zoned.c                | 149 ++++
 drivers/block/paride/bpck.c                   |   3 +-
 drivers/block/paride/pd.c                     |   2 +
 drivers/block/pktcdvd.c                       | 109 +--
 drivers/block/rsxx/dev.c                      |   6 +-
 drivers/block/skd_main.c                      |  16 +-
 drivers/block/xen-blkfront.c                  |   9 +-
 drivers/block/zram/zram_drv.c                 |  19 +-
 drivers/cdrom/cdrom.c                         |  30 +-
 drivers/ide/ide-cd.c                          |  58 +-
 drivers/ide/ide-cd.h                          |   6 +-
 drivers/ide/ide-cd_ioctl.c                    |  62 +-
 drivers/infiniband/ulp/iser/iser_memory.c     |   2 +-
 drivers/lightnvm/Kconfig                      |  30 +-
 drivers/lightnvm/pblk-cache.c                 |   9 +-
 drivers/lightnvm/pblk-core.c                  |  78 ++-
 drivers/lightnvm/pblk-gc.c                    |  34 +-
 drivers/lightnvm/pblk-init.c                  |  98 +--
 drivers/lightnvm/pblk-rb.c                    |  24 +-
 drivers/lightnvm/pblk-read.c                  | 247 ++++---
 drivers/lightnvm/pblk-recovery.c              |  47 +-
 drivers/lightnvm/pblk-sysfs.c                 |  13 +-
 drivers/lightnvm/pblk-write.c                 |  35 +-
 drivers/lightnvm/pblk.h                       |  48 +-
 drivers/md/bcache/bcache.h                    |  24 +-
 drivers/md/bcache/bset.c                      |  63 ++
 drivers/md/bcache/btree.c                     |  63 +-
 drivers/md/bcache/btree.h                     |   2 +-
 drivers/md/bcache/closure.c                   |  13 +-
 drivers/md/bcache/closure.h                   |   4 +-
 drivers/md/bcache/debug.c                     |  17 +-
 drivers/md/bcache/journal.c                   |   1 +
 drivers/md/bcache/request.c                   |  75 +-
 drivers/md/bcache/super.c                     |  59 +-
 drivers/md/bcache/sysfs.c                     |  48 +-
 drivers/md/bcache/util.c                      |   2 +-
 drivers/md/bcache/util.h                      |   2 +-
 drivers/md/bcache/writeback.c                 | 125 +++-
 drivers/md/bcache/writeback.h                 |  19 -
 drivers/md/dm.c                               |   6 +-
 drivers/md/md.c                               |  12 +-
 drivers/nvdimm/btt.c                          |  12 +-
 drivers/nvdimm/nd.h                           |   7 +-
 drivers/nvdimm/pmem.c                         |  13 +-
 drivers/nvme/host/core.c                      | 108 ++-
 drivers/nvme/host/fabrics.c                   |   2 +-
 drivers/nvme/host/fc.c                        |   1 +
 drivers/nvme/host/lightnvm.c                  |  27 +-
 drivers/nvme/host/multipath.c                 | 349 +++++++++-
 drivers/nvme/host/nvme.h                      |  78 ++-
 drivers/nvme/host/pci.c                       |  77 +--
 drivers/nvme/host/rdma.c                      | 234 +++----
 drivers/nvme/host/trace.c                     |  11 +
 drivers/nvme/host/trace.h                     | 142 ++--
 drivers/nvme/target/admin-cmd.c               | 221 +++++-
 drivers/nvme/target/configfs.c                | 250 +++++++
 drivers/nvme/target/core.c                    | 104 ++-
 drivers/nvme/target/discovery.c               |   2 +-
 drivers/nvme/target/io-cmd-bdev.c             |   7 +
 drivers/nvme/target/io-cmd-file.c             |  80 ++-
 drivers/nvme/target/loop.c                    |   1 +
 drivers/nvme/target/nvmet.h                   |  62 +-
 drivers/nvme/target/rdma.c                    | 197 ++++--
 drivers/scsi/Makefile                         |   2 +-
 drivers/scsi/cxlflash/superpipe.c             |   8 +-
 drivers/scsi/cxlflash/vlun.c                  |   7 +-
 drivers/scsi/mpt3sas/mpt3sas_scsih.c          |   2 +-
 drivers/scsi/scsi_lib.c                       |   6 +-
 drivers/scsi/sd.c                             |   8 +-
 drivers/scsi/sd.h                             |   9 -
 drivers/scsi/sd_dif.c                         | 113 ---
 drivers/scsi/sr_ioctl.c                       |  22 +-
 drivers/scsi/virtio_scsi.c                    |   8 +-
 drivers/target/Kconfig                        |   5 +-
 drivers/target/loopback/Kconfig               |   1 +
 fs/block_dev.c                                |   6 +-
 fs/exofs/ore.c                                |   4 +-
 fs/ext4/super.c                               |   5 +-
 fs/ext4/sysfs.c                               |   6 +-
 fs/f2fs/f2fs.h                                |   2 +-
 fs/f2fs/super.c                               |   3 +-
 fs/mpage.c                                    |   4 +-
 include/linux/bio.h                           |  19 +-
 include/linux/blk-cgroup.h                    | 146 +++-
 include/linux/blk-mq.h                        |   4 +-
 include/linux/blk_types.h                     |  27 +-
 include/linux/blkdev.h                        |  66 +-
 include/linux/cdrom.h                         |   3 +-
 include/linux/cgroup-defs.h                   |   3 +
 include/linux/genhd.h                         |  14 +-
 include/linux/memcontrol.h                    |  13 +
 include/linux/nvme.h                          |  72 +-
 include/linux/sched.h                         |   8 +
 include/linux/swap.h                          |  11 +-
 include/linux/t10-pi.h                        |  24 +
 include/linux/tracehook.h                     |   2 +
 include/scsi/scsi_cmnd.h                      |  13 +-
 include/scsi/scsi_device.h                    |  14 +-
 include/uapi/linux/bcache.h                   |   4 +-
 include/uapi/linux/blkzoned.h                 |   2 +-
 kernel/fork.c                                 |   5 +
 kernel/trace/blktrace.c                       |   6 +-
 mm/huge_memory.c                              |   6 +-
 mm/memcontrol.c                               |  13 +
 mm/memory.c                                   |  11 +-
 mm/page_io.c                                  |   3 +-
 mm/readahead.c                                |  19 +-
 mm/shmem.c                                    |  10 +-
 mm/swapfile.c                                 |  31 +
 172 files changed, 6029 insertions(+), 2659 deletions(-)
 create mode 100644 block/blk-iolatency.c
 create mode 100644 block/blk-mq-debugfs-zoned.c
 create mode 100644 block/blk-rq-qos.c
 create mode 100644 block/blk-rq-qos.h
 create mode 100644 drivers/block/null_blk.h
 rename drivers/block/{null_blk.c => null_blk_main.c} (95%)
 create mode 100644 drivers/block/null_blk_zoned.c

-- 
Jens Axboe
