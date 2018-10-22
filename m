Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block changes for 4.20
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Message-ID: <eea763b6-e97c-59ad-f2f0-b78de68fb0de@kernel.dk>
Date: Mon, 22 Oct 2018 01:51:27 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Linus,

This is the main pull request for block changes for 4.20. This pull
request contains:

- Series enabling runtime PM for blk-mq (Bart).

- Two pull requests from Christoph for NVMe, with items such as;

	- Better AEN tracking
	- Multipath improvements
	- RDMA fixes
	- Rework of FC for target removal
	- Fixes for issues identified by static checkers
	- Fabric cleanups, as prep for TCP transport
	- Various cleanups and bug fixes

- Block merging cleanups (Christoph)

- Conversion of drivers to generic DMA mapping API (Christoph)

- Series fixing ref count issues with blkcg (Dennis)

- Series improving BFQ heuristics (Paolo, et al)

- Series improving heuristics for the Kyber IO scheduler (Omar)

- Removal of dangerous bio_rewind_iter() API (Ming)

- Apply single queue IPI redirection logic to blk-mq (Ming)

- Set of fixes and improvements for bcache (Coly et al)

- Series closing a hotplug race with sysfs group attributes (Hannes)

- Set of patches for lightnvm:

	- pblk trace support (Hans)
	- SPDX license header update (Javier)
	- Tons of refactoring patches to cleanly abstract the 1.2 and
	  2.0 specs behind a common core interface. (Javier, Matias)
	- Enable pblk to use a common interface to retrieve chunk
	  metadata (Matias)
	- Bug fixes (Various)

- Set of fixes and updates to the blk IO latency target (Josef)

- blk-mq queue number updates fixes (Jianchao)

- Convert a bunch of drivers from the old legacy IO interface to blk-mq.
  This will conclude with the removal of the legacy IO interface itself
  in 4.21, with the rest of the drivers (me, Omar)

- Removal of the DAC960 driver. The SCSI tree will introduce two
  replacement drivers for this. (Hannes)

I merged in v4.19-rc6 to resolve a conflict, but also to pull in a few
fixes that went into the storage area after the 4.20 tree was forked
off.

Please pull!


  git://git.kernel.dk/linux-block.git for-4.20/block-20181021


----------------------------------------------------------------
Bart Van Assche (25):
      blk-mq: Document the functions that iterate over requests
      block: Move power management code into a new source file
      block, scsi: Change the preempt-only flag into a counter
      block: Split blk_pm_add_request() and blk_pm_put_request()
      block: Schedule runtime resume earlier
      percpu-refcount: Introduce percpu_ref_resurrect()
      block: Allow unfreezing of a queue while requests are in progress
      block: Make blk_get_request() block for non-PM requests while suspended
      blk-mq: Enable support for runtime power management
      block: Finish renaming REQ_DISCARD into REQ_OP_DISCARD
      blk-mq-debugfs: Also show requests that have not yet been started
      nvmet: use strcmp() instead of strncmp() for subsystem lookup
      nvmet-rdma: check for timeout in nvme_rdma_wait_for_cm()
      nvme-core: declare local symbols static
      nvme-core: rework a NQN copying operation
      nvme-pci: fix nvme_suspend_queue() kernel-doc header
      nvmet: use strlcpy() instead of strcpy()
      nvmet-rdma: declare local symbols static
      nvmet: avoid integer overflow in the discard code
      nvme-fc: fix kernel-doc headers
      nvme-fc: introduce struct nvme_fcp_op_w_sgl
      nvme-fc: rework the request initialization code
      nvmet-fc: fix kernel-doc headers
      nvme-core: make implicit seed truncation explicit
      nvmet-fcloop: suppress a compiler warning

Bartlomiej Zolnierkiewicz (2):
      block: remove redundant 'default n' from Kconfig-s
      drivers/block: remove redundant 'default n' from Kconfig-s

Ben Peddell (1):
      bcache: Populate writeback_rate_minimum attribute

Chaitanya Kulkarni (4):
      nvmet: remove redundant module prefix
      nvme-core: add async event trace helper
      nvmet: remove unreachable code
      nvme-pci: remove duplicate check

Christoph Hellwig (23):
      block: use bio_add_page in bio_iov_iter_get_pages
      block: move integrity_req_gap_{back,front}_merge to blk.h
      block: move req_gap_{back,front}_merge to blk-merge.c
      block: move req_gap_back_merge to blk.h
      block: simplify BIOVEC_PHYS_MERGEABLE
      block: add a missing BIOVEC_SEG_BOUNDARY check in bio_add_pc_page
      block: merge BIOVEC_SEG_BOUNDARY into biovec_phys_mergeable
      block: remove bvec_to_phys
      block: don't include io.h from bio.h
      block: don't include bug.h from bio.h
      arm: remove the unused BIOVEC_MERGEABLE define
      xen: remove the xen_biovec_phys_mergeable export
      xen: provide a prototype for xen_biovec_phys_mergeable in xen.h
      block: remove ARCH_BIOVEC_PHYS_MERGEABLE
      xen: don't include <xen/xen.h> from <asm/io.h> and <asm/dma-mapping.h>
      nvme: take node locality into account when selecting a path
      ubd: remove use of blk_rq_map_sg
      skd: switch to the generic DMA API
      sx8: remove dead IF_64BIT_DMA_IS_POSSIBLE code
      sx8: switch to the generic DMA API
      umem: switch to the generic DMA API
      rsxx: switch to the generic DMA API
      mtip32xx: fully switch to the generic DMA API

Coly Li (3):
      bcache: use REQ_PRIO to indicate bio for metadata
      bcache: fix typo in code comments of closure_return_with_destructor()
      bcache: replace hard coded number with BUCKET_GC_GEN_MAX

Dennis Zhou (2):
      blkcg: fix edge case for blk_get_rl() under memory pressure
      blkcg: reassociate bios when make_request() is called recursively

Dennis Zhou (Facebook) (12):
      blkcg: fix ref count issue with bio_blkcg using task_css
      blkcg: update blkg_lookup_create to do locking
      blkcg: convert blkg_lookup_create to find closest blkg
      blkcg: always associate a bio with a blkg
      blkcg: consolidate bio_issue_init to be a part of core
      blkcg: associate a blkg for pages being evicted by swap
      blkcg: associate writeback bios with a blkg
      blkcg: remove bio->bi_css and instead use bio->bi_blkg
      blkcg: remove additional reference to the css
      blkcg: cleanup and make blk_get_rl use blkg_lookup_create
      blkcg: change blkg reference counting to use percpu_ref
      blkcg: rename blkg_try_get to blkg_tryget

Dongbo Cao (3):
      bcache: remove useless parameter of bch_debug_init()
      bcache: split combined if-condition code into separate ones
      bcache: panic fix for making cache device

Federico Motta (1):
      block, bfq: improve asymmetric scenarios detection

Gustavo A. R. Silva (1):
      pktcdvd: fix fall-through annotation

Hannes Reinecke (6):
      block: genhd: add 'groups' argument to device_add_disk
      nvme: register ns_id attributes as default sysfs groups
      aoe: register default groups with device_add_disk()
      zram: register default groups with device_add_disk()
      virtio-blk: modernize sysfs attribute creation
      drivers/block: Remove DAC960 driver

Hans Holmberg (11):
      lightnvm: introduce nvm_rq_to_ppa_list
      lightnvm: pblk: allocate line map bitmaps using a mempool
      lightnvm: pblk: remove unused parameters in pblk_up_rq
      lightnvm: pblk: fix up prints in pblk_read_check_rand
      lightnvm: pblk: fix write amplificiation calculation
      lightnvm: pblk: add trace events for chunk states
      lightnvm: pblk: add trace events for line state changes
      lightnvm: pblk: add trace events for pblk state changes
      lightnvm: pblk: add tracing for chunk resets
      lightnvm: pblk: stop recreating global caches
      lightnvm: pblk: fix mapping issue on failed writes

James Smart (3):
      nvmet_fc: support target port removal with nvmet layer
      nvme_fc: add 'nvme_discovery' sysfs attribute to fc transport device
      nvme: call nvme_complete_rq when nvmf_check_ready fails for mpath I/O

Javier González (21):
      lightnvm: pblk: fix race condition on metadata I/O
      lightnvm: pblk: add helpers for chunk addresses
      lightnvm: pblk: improve line helpers
      lightnvm: pblk: fix comment typo
      lightnvm: pblk: remove unused variable.
      lightnvm: pblk: guarantee emeta on line close
      lightnvm: move ppa transformations to core
      lightnvm: pblk: calculate line pad distance in helper
      lightnvm: use internal allocation for chunk log page
      lightnvm: pblk: encapsulate rqd dma allocations
      lightnvm: pblk: refactor metadata paths
      lightnvm: pblk: take write semaphore on metadata
      lightnvm: pblk: recover open lines on 2.0 devices
      lightnvm: pblk: add SPDX license tag
      lightnvm: pblk: fix race on sysfs line state
      lightnvm: pblk: remove unused function
      lightnvm: pblk: encapsulate rb pointer operations
      lightnvm: pblk: move ring buffer alloc/free rb init
      lightnvm: pblk: guarantee mw_cunits on read buffer
      lightnvm: do no update csecs and sos on 1.2
      lightnvm: pblk: guarantee that backpointer is respected on writer stall

Jens Axboe (19):
      Merge tag 'v4.19-rc6' into for-4.20/block
      Merge branch 'nvme-4.20' of git://git.infradead.org/nvme into for-4.20/block
      aoe: convert aoeblk to blk-mq
      skd: fixup usage of legacy IO API
      null_blk: remove legacy IO path
      block: remove bogus check for queue_lock assignment
      cdrom: don't attempt to fiddle with cdo->capability
      blk-mq: provide helper for setting up an SQ queue and tag set
      ps3disk: convert to blk-mq
      paride: convert pcd to blk-mq
      paride: convert pd to blk-mq
      paride: convert pf to blk-mq
      xsysace: convert to blk-mq
      mtd_blkdevs: convert to blk-mq
      gdrom: convert to blk-mq
      z2ram: convert to blk-mq
      sx8: convert to blk-mq
      Merge branch 'nvme-4.20' of git://git.infradead.org/nvme into for-4.20/block
      block: setup bounce bio_sets properly

Jia-Ju Bai (1):
      lightnvm: pblk: fix two sleep-in-atomic-context bugs

Jianchao Wang (4):
      blk-mq: adjust debugfs and sysfs register when updating nr_hw_queues
      blk-mq: change gfp flags to GFP_NOIO in blk_mq_realloc_hw_ctxs
      blk-mq: realloc hctx when hw queue is mapped to another node
      blk-mq: fallback to previous nr_hw_queues when updating fails

Josef Bacik (5):
      blk-iolatency: use q->nr_requests directly
      blk-iolatency: deal with nr_requests == 1
      blk-iolatency: deal with small samples
      blk-iolatency: use a percentile approache for ssd's
      blk-iolatency: keep track of previous windows stats

Kees Cook (1):
      drbd: Convert from ahash to shash

Keith Busch (2):
      nvme: update node paths after adding new path
      nvme-pci: fix hot removal during error handling

Konstantin Khlebnikov (1):
      block: describe difference between flags IO_STAT and STATS

Liu Bo (1):
      Blk-throttle: update to use rbtree with leftmost node cached

Maciej S. Szmigiero (1):
      cfq: clear queue pointers from cfqg after unpinning them in cfq_pd_offline

Matias Bjørling (10):
      lightnvm: remove dependencies on BLK_DEV_NVME and PCI
      lightnvm: combine 1.2 and 2.0 command flags
      lightnvm: pblk: fix rqd.error return value in pblk_blk_erase_sync
      lightnvm: move device L2P detection to core
      lightnvm: move bad block and chunk state logic to core
      lightnvm: pblk: unify vector max req constants
      lightnvm: pblk: fix incorrect min_write_pgs
      lightnvm: pblk: remove size and out of bounds read check
      lightnvm: pblk: refactor put line fn on read completion
      lightnvm: pblk: remove debug from pblk_[down/up]_page

Milan P. Gandhi (2):
      nvme: fix typo in nvme_identify_ns_descs
      nvme-fc: fix for a minor typos

Ming Lei (2):
      block: remove bio_rewind_iter()
      blk-mq: complete req in softirq context in case of single queue

Nathan Chancellor (1):
      rsxx: Remove unnecessary parentheses

Omar Sandoval (17):
      block: move call of scheduler's ->completed_request() hook
      block: export blk_stat_enable_accounting()
      kyber: don't make domain token sbitmap larger than necessary
      kyber: implement improved heuristics
      kyber: add tracepoints
      kyber: fix integer overflow of latency targets on 32-bit
      swim: fix cleanup on setup error
      swim: convert to blk-mq
      swim3: add real error handling in setup
      swim3: convert to blk-mq
      amiflop: fold headers into C file
      amiflop: clean up on errors during setup
      amiflop: convert to blk-mq
      ataflop: fold headers into C file
      ataflop: fix error handling during setup
      ataflop: convert to blk-mq
      floppy: convert to blk-mq

Paolo Valente (3):
      block, bfq: correctly charge and reset entity service in all cases
      block, bfq: inject other-queue I/O into seeky idle queues on NCQ flash
      blok, bfq: do not plug I/O if all queues are weight-raised

Richard Weinberger (1):
      um: Convert ubd driver to blk-mq

Sagi Grimberg (4):
      nvmet: don't split large I/Os unconditionally
      nvmet-rdma: use a private workqueue for delete
      nvme-rdma: always have a valid trsvcid
      nvme-fabrics: move controller options matching to fabrics

Shenghui Wang (4):
      bcache: account size of buckets used in uuid write to ca->meta_sectors_written
      bcache: recal cached_dev_sectors on detach
      bcache: remove unused bch_passthrough_cache
      bcache: use MAX_CACHES_PER_SET instead of magic number 8 in __bch_bucket_alloc_set

Tang Junhui (4):
      bcache: trace missed reading by cache_missed
      bcache: fix ioctl in flash device
      bcache: correct dirty data statistics
      bcache: fix miss key refill->end in writeback

Wei Yongjun (1):
      lightnvm: pblk: fix error handling of pblk_lines_init()

Young_X (1):
      cdrom: fix improper type cast, which can leat to information leak.

YueHaibing (2):
      blk-iolatency: remove set but not used variables 'changed' and 'blkiolat'
      null_blk: remove set but not used variable 'q'

Zhoujie Wu (1):
      lightnvm: pblk: consider max hw sectors supported for max_write_pgs

jun qian (1):
      block: umem: replace spin_lock_bh with spin_lock in tasklet callback

 Documentation/admin-guide/cgroup-v2.rst    |    8 +-
 Documentation/blockdev/README.DAC960       |  756 ---
 Documentation/blockdev/zram.txt            |    2 +-
 Documentation/device-mapper/log-writes.txt |    2 +-
 arch/arm/include/asm/io.h                  |   15 -
 arch/arm64/include/asm/io.h                |    9 -
 arch/m68k/emu/nfblock.c                    |    2 +-
 arch/m68k/include/asm/atafd.h              |   13 -
 arch/m68k/include/asm/atafdreg.h           |   80 -
 arch/um/drivers/ubd_kern.c                 |  236 +-
 arch/x86/include/asm/io.h                  |   12 -
 arch/x86/include/asm/xen/events.h          |    2 +
 arch/x86/xen/enlighten.c                   |    1 +
 arch/x86/xen/enlighten_pvh.c               |    1 +
 arch/x86/xen/platform-pci-unplug.c         |    1 +
 arch/x86/xen/pmu.c                         |    1 +
 block/Kconfig                              |   10 +-
 block/Kconfig.iosched                      |    3 -
 block/Makefile                             |    1 +
 block/bfq-cgroup.c                         |    4 +-
 block/bfq-iosched.c                        |  291 +-
 block/bfq-iosched.h                        |   53 +-
 block/bfq-wf2q.c                           |   49 +-
 block/bio-integrity.c                      |   12 +-
 block/bio.c                                |  218 +-
 block/blk-cgroup.c                         |  123 +-
 block/blk-core.c                           |  276 +-
 block/blk-flush.c                          |    6 +-
 block/blk-integrity.c                      |   12 +-
 block/blk-iolatency.c                      |  230 +-
 block/blk-merge.c                          |   88 +-
 block/blk-mq-debugfs.c                     |   13 +-
 block/blk-mq-sched.h                       |    4 +-
 block/blk-mq-tag.c                         |   69 +-
 block/blk-mq.c                             |  211 +-
 block/blk-pm.c                             |  216 +
 block/blk-pm.h                             |   69 +
 block/blk-softirq.c                        |    5 +-
 block/blk-stat.c                           |    1 +
 block/blk-throttle.c                       |   54 +-
 block/blk.h                                |   73 +-
 block/bounce.c                             |   41 +-
 block/cfq-iosched.c                        |   16 +-
 block/elevator.c                           |   22 +-
 block/genhd.c                              |   19 +-
 block/kyber-iosched.c                      |  547 ++-
 drivers/block/DAC960.c                     | 7229 ----------------------------
 drivers/block/DAC960.h                     | 4414 -----------------
 drivers/block/Kconfig                      |   13 -
 drivers/block/Makefile                     |    1 -
 drivers/block/amiflop.c                    |  318 +-
 drivers/block/aoe/aoe.h                    |    5 +-
 drivers/block/aoe/aoeblk.c                 |   70 +-
 drivers/block/aoe/aoecmd.c                 |   19 +-
 drivers/block/aoe/aoedev.c                 |   15 +-
 drivers/block/ataflop.c                    |  273 +-
 drivers/block/drbd/Kconfig                 |    1 -
 drivers/block/drbd/drbd_int.h              |   15 +-
 drivers/block/drbd/drbd_main.c             |   16 +-
 drivers/block/drbd/drbd_nl.c               |   39 +-
 drivers/block/drbd/drbd_protocol.h         |    4 +-
 drivers/block/drbd/drbd_receiver.c         |   35 +-
 drivers/block/drbd/drbd_req.c              |    2 +-
 drivers/block/drbd/drbd_worker.c           |   65 +-
 drivers/block/floppy.c                     |   68 +-
 drivers/block/loop.c                       |    5 +-
 drivers/block/mtip32xx/mtip32xx.c          |   49 +-
 drivers/block/null_blk_main.c              |  111 +-
 drivers/block/paride/pcd.c                 |   88 +-
 drivers/block/paride/pd.c                  |   94 +-
 drivers/block/paride/pf.c                  |   56 +-
 drivers/block/pktcdvd.c                    |    2 +-
 drivers/block/ps3disk.c                    |   88 +-
 drivers/block/ps3vram.c                    |    2 +-
 drivers/block/rsxx/core.c                  |    2 +-
 drivers/block/rsxx/cregs.c                 |    2 +-
 drivers/block/rsxx/dev.c                   |    2 +-
 drivers/block/rsxx/dma.c                   |   52 +-
 drivers/block/skd_main.c                   |   69 +-
 drivers/block/sunvdc.c                     |    2 +-
 drivers/block/swim.c                       |  106 +-
 drivers/block/swim3.c                      |  211 +-
 drivers/block/sx8.c                        |  166 +-
 drivers/block/umem.c                       |   42 +-
 drivers/block/virtio_blk.c                 |   68 +-
 drivers/block/xen-blkfront.c               |    2 +-
 drivers/block/xsysace.c                    |   80 +-
 drivers/block/z2ram.c                      |   87 +-
 drivers/block/zram/Kconfig                 |    2 -
 drivers/block/zram/zram_drv.c              |   28 +-
 drivers/cdrom/cdrom.c                      |   29 +-
 drivers/cdrom/gdrom.c                      |  174 +-
 drivers/ide/ide-cd.c                       |    2 +-
 drivers/ide/ide-gd.c                       |    2 +-
 drivers/lightnvm/Kconfig                   |    3 +-
 drivers/lightnvm/core.c                    |  334 +-
 drivers/lightnvm/pblk-cache.c              |    1 +
 drivers/lightnvm/pblk-core.c               |  587 ++-
 drivers/lightnvm/pblk-gc.c                 |   11 +-
 drivers/lightnvm/pblk-init.c               |  321 +-
 drivers/lightnvm/pblk-map.c                |   13 +-
 drivers/lightnvm/pblk-rb.c                 |  110 +-
 drivers/lightnvm/pblk-read.c               |   86 +-
 drivers/lightnvm/pblk-recovery.c           |  471 +-
 drivers/lightnvm/pblk-rl.c                 |    5 +-
 drivers/lightnvm/pblk-sysfs.c              |   12 +-
 drivers/lightnvm/pblk-trace.h              |  145 +
 drivers/lightnvm/pblk-write.c              |   90 +-
 drivers/lightnvm/pblk.h                    |  221 +-
 drivers/md/bcache/alloc.c                  |    2 +-
 drivers/md/bcache/bcache.h                 |    2 +-
 drivers/md/bcache/btree.c                  |    2 +-
 drivers/md/bcache/closure.h                |    3 +-
 drivers/md/bcache/debug.c                  |    2 +-
 drivers/md/bcache/extents.c                |    2 +-
 drivers/md/bcache/request.c                |    9 +-
 drivers/md/bcache/request.h                |    2 +-
 drivers/md/bcache/super.c                  |  113 +-
 drivers/md/bcache/sysfs.c                  |    2 +
 drivers/md/raid0.c                         |    2 +-
 drivers/memstick/core/ms_block.c           |    2 +-
 drivers/memstick/core/mspro_block.c        |    2 +-
 drivers/mmc/core/block.c                   |    2 +-
 drivers/mtd/mtd_blkdevs.c                  |  102 +-
 drivers/nvdimm/blk.c                       |    2 +-
 drivers/nvdimm/btt.c                       |    2 +-
 drivers/nvdimm/pmem.c                      |    2 +-
 drivers/nvme/host/core.c                   |   47 +-
 drivers/nvme/host/fabrics.c                |   37 +-
 drivers/nvme/host/fabrics.h                |    2 +
 drivers/nvme/host/fc.c                     |  153 +-
 drivers/nvme/host/lightnvm.c               |  137 +-
 drivers/nvme/host/multipath.c              |   79 +-
 drivers/nvme/host/nvme.h                   |   35 +-
 drivers/nvme/host/pci.c                    |    9 +-
 drivers/nvme/host/rdma.c                   |   78 +-
 drivers/nvme/host/trace.h                  |   28 +
 drivers/nvme/target/admin-cmd.c            |    4 +-
 drivers/nvme/target/core.c                 |    3 +-
 drivers/nvme/target/discovery.c            |    6 +-
 drivers/nvme/target/fc.c                   |  136 +-
 drivers/nvme/target/fcloop.c               |    1 +
 drivers/nvme/target/io-cmd-bdev.c          |    9 +-
 drivers/nvme/target/io-cmd-file.c          |    3 +-
 drivers/nvme/target/nvmet.h                |    1 +
 drivers/nvme/target/rdma.c                 |   19 +-
 drivers/s390/block/dasd_genhd.c            |    2 +-
 drivers/s390/block/dcssblk.c               |    2 +-
 drivers/s390/block/scm_blk.c               |    2 +-
 drivers/scsi/scsi_lib.c                    |   11 +-
 drivers/scsi/scsi_pm.c                     |    1 +
 drivers/scsi/sd.c                          |    3 +-
 drivers/scsi/sr.c                          |    3 +-
 drivers/target/target_core_spc.c           |    6 +-
 drivers/xen/biomerge.c                     |    3 +-
 drivers/xen/xen-acpi-pad.c                 |    1 +
 fs/buffer.c                                |   10 +-
 fs/ext4/page-io.c                          |    2 +-
 include/linux/amifd.h                      |   63 -
 include/linux/amifdreg.h                   |   82 -
 include/linux/bio.h                        |   78 +-
 include/linux/blk-cgroup.h                 |  145 +-
 include/linux/blk-mq.h                     |    4 +
 include/linux/blk-pm.h                     |   24 +
 include/linux/blk_types.h                  |    1 -
 include/linux/blkdev.h                     |  164 +-
 include/linux/bvec.h                       |    3 -
 include/linux/cgroup.h                     |    2 +
 include/linux/elevator.h                   |    2 +-
 include/linux/genhd.h                      |    5 +-
 include/linux/lightnvm.h                   |  166 +-
 include/linux/mtd/blktrans.h               |    5 +-
 include/linux/nvme.h                       |    1 +
 include/linux/percpu-refcount.h            |    1 +
 include/linux/writeback.h                  |    5 +-
 include/trace/events/kyber.h               |   96 +
 include/xen/xen.h                          |    4 +
 kernel/cgroup/cgroup.c                     |   48 +-
 kernel/trace/blktrace.c                    |    4 +-
 lib/percpu-refcount.c                      |   28 +-
 mm/page_io.c                               |    2 +-
 181 files changed, 5670 insertions(+), 16863 deletions(-)
 delete mode 100644 Documentation/blockdev/README.DAC960
 delete mode 100644 arch/m68k/include/asm/atafd.h
 delete mode 100644 arch/m68k/include/asm/atafdreg.h
 create mode 100644 block/blk-pm.c
 create mode 100644 block/blk-pm.h
 delete mode 100644 drivers/block/DAC960.c
 delete mode 100644 drivers/block/DAC960.h
 create mode 100644 drivers/lightnvm/pblk-trace.h
 delete mode 100644 include/linux/amifd.h
 delete mode 100644 include/linux/amifdreg.h
 create mode 100644 include/linux/blk-pm.h
 create mode 100644 include/trace/events/kyber.h

-- 
Jens Axboe
