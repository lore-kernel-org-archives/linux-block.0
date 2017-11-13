Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Core block changes for 4.15-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Message-ID: <f8bf136a-96c3-3a96-37d0-55c0facf1a62@kernel.dk>
Date: Sun, 12 Nov 2017 20:05:53 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Linus,

This is the main pull request for block storage for 4.15-rc1. Nothing
out of the ordinary in here, and no API changes or anything like that.
Just various new features for drivers, core changes, etc. In particular,
this pull request contains:

- A patch series from Bart, closing the whole on blk/scsi-mq queue
  quescing.

- A series from Christoph, building towards hidden gendisks (for
  multipath) and ability to move bio chains around.

- NVMe
	- Support for native multipath for NVMe (Christoph).
	- Userspace notifications for AENs (Keith).
	- Command side-effects support (Keith).
	- SGL support (Chaitanya Kulkarni)
	- FC fixes and improvements (James Smart)
	- Lots of fixes and tweaks (Various)

- bcache
	- New maintainer (Michael Lyle)
	- Writeback control improvements (Michael)
	- Various fixes (Coly, Elena, Eric, Liang, et al)

- lightnvm updates, mostly centered around the pblk interface (Javier,
  Hans, and Rakesh).

- Removal of unused bio/bvec kmap atomic interfaces (me, Christoph)

- Writeback series that fix the much discussed hundreds of millions of
  sync-all units. This goes all the way, as discussed previously (me).

- Fix for missing wakeup on writeback timer adjustments (Yafang Shao).

- Fix laptop mode on blk-mq (me).

- {mq,name} tupple lookup for IO schedulers, allowing us to have alias
  names. This means you can use 'deadline' on both !mq and on mq (where
  it's called mq-deadline). (me).

- blktrace race fix, oopsing on sg load (me).

- blk-mq optimizations (me).

- Obscure waitqueue race fix for kyber (Omar).

- NBD fixes (Josef).

- Disable writeback throttling by default on bfq, like we do on cfq
  (Luca Miccio).

- Series from Ming that enable us to treat flush requests on blk-mq like
  any other request. This is a really nice cleanup.

- Series from Ming that improves merging on blk-mq with schedulers,
  getting us closer to flipping the switch on scsi-mq again.

- BFQ updates (Paolo).

- blk-mq atomic flags memory ordering fixes (Peter Z).

- Loop cgroup support (Shaohua).

- Lots of minor fixes from lots of different folks, both for core and
  driver code. 

You'll get a few merge conflicts pulling this into master, due to
changes that have gone in after I forked off this branch. They are all
trivial, I've included my resolution at the end of the email. The only
one that is a little illogical is the last bit of nvme/host/core.c,
where a || is changed to a && while merging. This is due to a fixup for
the code being replaced in your master, but which wasn't carried through
on the nvme tree side. The last conflict is in the cdrom Makefile, due
to the SPDX late changes.

Note that due to a screwup of mine, the 60 latest patches (or so) have
been rebased on Friday. This has, naturally, screwed up the commit time
for particularly the NVMe multipath changes. Error is all mine, the NVMe
bits have been pretty smooth this round.

Please pull!


  git://git.kernel.dk/linux-block.git for-4.15/block


----------------------------------------------------------------
Arnd Bergmann (2):
      block: fix CDROM dependency on BLK_DEV
      skd: use ktime_get_real_seconds()

Bart Van Assche (10):
      block: Fix a race between blk_cleanup_queue() and timeout handling
      block: Rework drivers/cdrom/Makefile
      blk-mq: Make blk_mq_get_request() error path less confusing
      blk-mq: Avoid that request queue removal can trigger list corruption
      block: Introduce blk_get_request_flags()
      block: Introduce BLK_MQ_REQ_PREEMPT
      ide, scsi: Tell the block layer at request allocation time about preempt requests
      block: Add the QUEUE_FLAG_PREEMPT_ONLY request queue flag
      block, scsi: Make SCSI quiesce and resume work reliably
      block, nvme: Introduce blk_mq_req_flags_t

Chaitanya Kulkarni (1):
      nvme-pci: add SGL support

Christoph Hellwig (38):
      block: move __elv_next_request to blk-core.c
      block: remove QUEUE_FLAG_STACKABLE
      nvme: simplify compat_ioctl handling
      nvme: use ida_simple_{get,remove} for the controller instance
      nvme: use kref_get_unless_zero in nvme_find_get_ns
      nvme: simplify nvme_open
      nvme: switch controller refcounting to use struct device
      nvme: get rid of nvme_ctrl_list
      nvme: check for a live controller in nvme_dev_open
      nvme-fc: merge __nvme_fc_schedule_delete_work into __nvme_fc_del_ctrl
      nvme: move controller deletion to common code
      nvme-rdma: remove nvme_rdma_remove_ctrl
      nvme: consolidate common code from ->reset_work
      block: move REQ_NOWAIT
      block: add REQ_DRV bit
      block: provide a direct_make_request helper
      block: add a blk_steal_bios helper
      block: don't look at the struct device dev_t in disk_devt
      block: introduce GENHD_FL_HIDDEN
      block: add a poll_fn callback to struct request_queue
      block: fix peeking requests during PM
      nvme: move the dying queue check from cancel to completion
      nvme: always unregister the integrity profile in __nvme_revalidate_disk
      nvme: don't pass struct nvme_ns to nvme_init_integrity
      nvme: don't pass struct nvme_ns to nvme_config_discard
      nvme: set the chunk size before freezing the queue
      nvme: split __nvme_revalidate_disk
      nvme: fix and clarify the check for missing metadata
      block: remove __bio_kmap_atomic
      block: pass full fmode_t to blk_verify_command
      nvmet: better data length validation
      nvmet: kill nvmet_inline_bio_init
      nvme: track subsystems
      nvme: introduce a nvme_ns_ids structure
      nvme: track shared namespaces
      nvme: implement multipath access to nvme subsystems
      nvme: also expose the namespace identification sysfs files for mpath nodes
      xtensa/simdisk: fix compile error

Christos Gkekas (1):
      mtip32xx: Clean up unused variables

Colin Ian King (1):
      block: avoid null pointer dereference on null disk

Coly Li (4):
      bcache: check ca->alloc_thread initialized before wake up it
      bcache: fix a comments typo in bch_alloc_sectors()
      bcache: rewrite multiple partitions support
      bcache: only permit to recovery read error when cache device is clean

Corentin Labbe (1):
      block: cryptoloop - Fix build warning

Dmitry Monakhov (1):
      block: Invalidate cache on discard v2

Elena Reshetova (1):
      bcache: convert cached_dev.count from atomic_t to refcount_t

Eric Wheeler (1):
      bcache: update bio->bi_opf bypass/writeback REQ_ flag hints

Greg Edwards (1):
      fs: guard_bio_eod() needs to consider partitions

Hannes Reinecke (3):
      block: create 'slaves' and 'holders' entries for hidden gendisks
      nvme: create 'slaves' and 'holders' entries for hidden controllers
      nvme: expose subsys attribute to sysfs

Hans Holmberg (10):
      lightnvm: pblk: prevent gc kicks when gc is not operational
      lightnvm: pblk: recover partially written lines correctly
      lightnvm: pblk: free full lines during recovery
      lightnvm: pblk: start gc if needed during init
      lightnvm: pblk: consider bad sectors in emeta during recovery
      lightnvm: pblk: shut down gc gracefully during exit
      lightnvm: pblk: add l2p crc debug printouts
      lightnvm: pblk: gc all lines in the pipeline before exit
      lightnvm: pblk: correct valid lba count calculation
      lightnvm: pblk: remove spinlock when freeing line metadata

Hongxu Jia (1):
      ide: ide-atapi: fix compile error with defining macro DEBUG

Ilya Dryomov (3):
      block: move CAP_SYS_ADMIN check in blkdev_roset()
      block: factor out __blkdev_issue_zero_pages()
      block: cope with WRITE ZEROES failing in blkdev_issue_zeroout()

Israel Rukshin (4):
      nvme-rdma: Add BLK_MQ_F_NO_SCHED flag to admin tag set
      nvme-fc: Add BLK_MQ_F_NO_SCHED flag to admin tag set
      nvme-loop: Add BLK_MQ_F_NO_SCHED flag to admin tag set
      nvmet-rdma: update queue list during ib_device removal

James Smart (21):
      nvmet: bump NVMET_NR_QUEUES to 128
      nvme-fc: add uevent for auto-connect
      nvme-fc: create fc class and transport device
      nvme-fc: move remote port get/put/free location
      nvme-fc: correct io termination handling
      nvme-fc: correct io timeout behavior
      nvme: add duplicate_connect option
      nvme: add helper to compare options to controller
      nvme-rdma: add support for duplicate_connect option
      nvme-fc: add support for duplicate_connect option
      nvme-fc: remove NVME_FC_MAX_SEGMENTS
      nvme-fc: avoid workqueue flush stalls
      nvme-fc: change ctlr state assignments during reset/reconnect
      nvme-fc: add a dev_loss_tmo field to the remoteport
      nvme-fc: check connectivity before initiating reconnects
      nvme: allow controller RESETTING to RECONNECTING transition
      nvme-fc: add dev_loss_tmo timeout and remoteport resume support
      nvmet: fix fatal_err_work deadlock
      nvme-fc: fix localport resume using stale values
      nvme-fc: decouple ns references from lldd references
      lpfc: tie in to new dev_loss_tmo interface in nvme transport

Javier González (34):
      lightnvm: pblk: initialize debug stat counter
      lightnvm: pblk: use right flag for GC allocation
      lightnvm: pblk: free padded entries in write buffer
      lightnvm: pblk: fix write I/O sync stat
      lightnvm: pblk: avoid deadlock on low LUN config
      lightnvm: pblk: fix min size for page mempool
      lightnvm: pblk: simplify work_queue mempool
      lightnvm: pblk: decouple read/erase mempools
      lightnvm: pblk: do not use a mempool for line bitmaps
      lightnvm: pblk: remove checks on mempool alloc.
      lightnvm: pblk: use constant for GC max inflight
      lightnvm: pblk: normalize ppa namings
      lightnvm: pblk: refactor read lba sanity check
      lightnvm: pblk: simplify data validity check on GC
      lightnvm: pblk: refactor read path on GC
      lightnvm: pblk: put bio on bio completion
      lightnvm: pblk: simplify path on REQ_PREFLUSH
      lightnvm: pblk: allocate bio size more accurately
      lightnvm: pblk: improve naming for internal req.
      lightnvm: pblk: refactor rqd alloc/free
      lightnvm: pblk: use rqd->end_io for completion
      lightnvm: pblk: check lba sanity on read path
      lightnvm: pblk: guarantee line integrity on reads
      lightnvm: pblk: remove redundant check on read path
      lightnvm: pblk: remove I/O dependency on write path
      lightnvm: pblk: enable 1 LUN configuration
      lightnvm: pblk: ensure right bad block calculation
      lightnvm: pblk: cleanup unused and static functions
      lightnvm: pblk: avoid being reported as hung on rated GC
      lightnvm: fail fast on passthrough commands
      lightnvm: implement generic path for sync I/O
      lightnvm: pblk: remove leftover testing function
      nvme: compare NQN string with right size
      nvme: fix eui_show() print format

Jens Axboe (31):
      blk-mq-tag: kill unused tag enums
      blk-mq: wire up completion notifier for laptop mode
      buffer: have alloc_page_buffers() use __GFP_NOFAIL
      buffer: grow_dev_page() should use __GFP_NOFAIL for all cases
      buffer: eliminate the need to call free_more_memory() in __getblk_slow()
      fs: kill 'nr_pages' argument from wakeup_flusher_threads()
      writeback: switch wakeup_flusher_threads() to cyclic writeback
      writeback: remove 'range_cyclic' argument for wb_start_writeback()
      writeback: provide a wakeup_flusher_threads_bdi()
      writeback: pass in '0' for nr_pages writeback in laptop mode
      writeback: make wb_start_writeback() static
      writeback: move nr_pages == 0 logic to one location
      writeback: only allow one inflight and pending full flush
      blk-mq: document the need to have STARTED and COMPLETED share a byte
      writeback: eliminate work item allocation in bd_start_writeback()
      sysctl: remove /proc/sys/vm/nr_pdflush_threads
      backing-dev: kill unused pdflush_proc_obsolete()
      Revert "lightnvm: prevent bd removal if busy"
      elevator: lookup mq vs non-mq elevators
      elevator: allow name aliases
      mq-deadline: add 'deadline' as a name alias
      Merge branch 'nvme-4.15' of git://git.infradead.org/nvme into for-4.15/block
      cdrom: hide CONFIG_CDROM menu selection
      blktrace: fix unlocked access to init/start-stop/teardown
      blktrace: fix unlocked registration of tracepoints
      Revert "blk-mq: don't handle TAG_SHARED in restart"
      block: kill bio_kmap/kunmap_irq()
      blk-mq: fix issue with shared tag queue re-running
      blk-mq: only run the hardware queue if IO is pending
      blk-mq: improve tag waiting setup for non-shared tags
      blk-mq: fixup some comment typos and lengths

Jianchao Wang (1):
      blk-mq: put the driver tag of nxt rq before first one is requeued

Jiufei Xue (1):
      blk-throttle: fix null pointer dereference while throttling writeback IOs

Josef Bacik (2):
      nbd: wait uninterruptible for the dead timeout
      nbd: don't start req until after the dead connection logic

Keith Busch (8):
      nvme: Remove unused headers
      nvme: factor get log into a helper
      nvme: check admin passthru command effects
      nvme: centralize AEN defines
      nvme-fc: remove unused "queue_size" field
      nvme: remove handling of multiple AEN requests
      nvme: unexport starting async event work
      nvme: send uevent for some asynchronous events

Kent Overstreet (1):
      bcache: Add Michael Lyle to MAINTAINERS

Liang Chen (2):
      bcache: safeguard a dangerous addressing in closure_queue
      bcache: explicitly destroy mutex while exiting

Luca Miccio (1):
      block,bfq: Disable writeback throttling

Marc Olson (1):
      nvme: update timeout module parameter type

Martin Wilck (1):
      nvme: fix visibility of "uuid" ns attribute

Max Gurtovoy (2):
      nvme-rdma: align nvme_rdma_device structure
      nvme-rdma: fix nvme_rdma_create_queue_ib error flow

Michael Lyle (7):
      bcache: don't write back data if reading it failed
      bcache: implement PI controller for writeback rate
      bcache: smooth writeback rate control
      bcache: writeback rate shouldn't artifically clamp
      bcache: rearrange writeback main thread ratelimit
      bcache: MAINTAINERS: set bcache to MAINTAINED
      bcache: writeback rate clamping: make 32 bit safe

Mikulas Patocka (1):
      brd: remove unused brd_mutex

Ming Lei (21):
      blk-mq-sched: dispatch from scheduler IFF progress is made in ->dispatch
      blk-mq-sched: move actual dispatching into one helper
      sbitmap: introduce __sbitmap_for_each_set()
      block: kyber: check if there are requests in ctx in kyber_has_work()
      blk-mq: introduce .get_budget and .put_budget in blk_mq_ops
      blk-mq-sched: improve dispatching from sw queue
      scsi: allow passing in null rq to scsi_prep_state_check()
      scsi: implement .get_budget and .put_budget for blk-mq
      blk-mq: don't handle TAG_SHARED in restart
      blk-mq: don't restart queue when .get_budget returns BLK_STS_RESOURCE
      SCSI: don't get target/host busy_count in scsi_mq_get_budget()
      blk-mq: don't handle failure in .get_budget
      blk-flush: don't run queue for requests bypassing flush
      block: pass 'run_queue' to blk_mq_request_bypass_insert
      blk-flush: use blk_mq_request_bypass_insert()
      blk-mq-sched: decide how to handle flush rq via RQF_FLUSH_SEQ
      blk-mq: move blk_mq_put_driver_tag*() into blk-mq.h
      blk-mq: don't allocate driver tag upfront for flush rq
      blk-mq: put driver tag if dispatch budget can't be got
      nvme-pci: avoid dereference of symbol from unloaded module
      block: Make q_usage_counter also track legacy requests

Minwoo Im (5):
      nvme-pci: fix typos in comments
      nvme: comment typo fixed in clearing AER
      null_blk: fix default values in documentation
      null_blk: add an usage for shared tags in documentation
      nvmet: fix comment typos in admin-cmd.c

Nitzan Carmi (1):
      nvme-rdma: Add debug message when reaches timeout

Omar Sandoval (1):
      kyber: fix hang on domain token wait queue

Paolo Valente (5):
      block, bfq: fix wrong init of saved start time for weight raising
      block, bfq: check and switch back to interactive wr also on queue split
      block, bfq: let early-merged queues be weight-raised on split too
      block, bfq: decrease burst size when queues in burst exit
      block, bfq: fix unbalanced decrements of burst size

Peter Foley (1):
      bcache: Avoid nested function definition

Peter Zijlstra (1):
      blk-mq: attempt to fix atomic flag memory ordering

Rakesh Pandit (19):
      writeback: merge try_to_writeback_inodes_sb_nr() into caller
      fs/block_dev: remove vfs_msg() interface
      lightnvm: prevent target type module removal when in use
      lightnvm: prevent bd removal if busy
      lightnvm: protect target type list with correct locks
      lightnvm: remove already calculated nr_chnls
      lightnvm: pblk: fix error path in pblk_lines_alloc_metadata
      lightnvm: include NVM Express driver if OCSSD is selected for build
      lightnvm: pblk: protect line bitmap while submitting meta io
      lightnvm: pblk: fix message if L2P MAP is in device
      lightnvm: pblk: improve error message if down_timeout fails
      lightnvm: pblk: print incompatible line version correctly
      lightnvm: pblk: reuse pblk_gc_should_kick
      lightnvm: pblk: fix changing GC group list for a line
      lightnvm: pblk: remove useless line
      lightnvm: remove unused argument from nvm_set_tgt_bb_tbl
      lightnvm: remove stale extern and unused exported symbols
      lightnvm: pblk: reduce arguments in __pblk_rb_update_l2p
      lightnvm: pblk: fix releases of kmem cache in error path

Randy Dunlap (2):
      nvme: use menu Kconfig interface
      block: fix Sphinx kernel-doc warning

Roy Shterman (1):
      nvmet: Change max_nsid in subsystem due to ns_disable if needed

Sagi Grimberg (16):
      nvme-fabrics: request transport module
      block: introduce blk_mq_tagset_iter
      nvme: introduce nvme_reinit_tagset
      block: remove blk_mq_reinit_tagset
      nvme-rdma: pass tagset to directly nvme_rdma_free_tagset
      nvme-rdma: fix wrong logging message
      nvme-rdma: move assignment to declaration
      nvme-rdma: Check that reinit_request got a proper mr
      nvme-rdma: teardown admin/io queues once on error recovery
      nvme-rdma: Don't local invalidate if the queue is not live
      nvme-rdma: change queue flag semantics DELETING -> ALLOCATED
      nvme-rdma: stop controller reset if the controller is deleting
      nvme-rdma: reuse nvme_delete_ctrl when reconnect attempts expire
      nvme: flush reset_work before safely continuing with delete operation
      nvmet: remove redundant memset if failed to get_smart_log failed
      nvmet: remove redundant local variable

Scott Bauer (1):
      MAINTAINERS: Remove Rafael from Opal maintainers.

Shaohua Li (8):
      kthread: add a mechanism to store cgroup info
      blkcg: delete unused APIs
      block: make blkcg aware of kthread stored original cgroup info
      block/loop: make loop cgroup aware
      block: fix a build error
      blk-stat: delete useless code
      block: set request_list for request
      kthread: zero the kthread data structure

Tang Junhui (1):
      bcache: update bucket_in_use in real time

Tim Hansen (2):
      block: remove unnecessary NULL checks in bioset_integrity_free()
      block/bio: Remove null checks before mempool_destroy in bioset_free

Wei Yongjun (1):
      nullb: fix error return code in null_init()

Yafang Shao (2):
      writeback: schedule periodic writeback with sysctl
      mm/page-writeback.c: make changes of dirty_writeback_centisecs take effect immediately

Yijing Wang (2):
      bcache: Remove redundant set_capacity
      bcache: remove unused parameter

tang.junhui (1):
      bcache: fix wrong cache_misses statistics

weiping zhang (7):
      null_blk: add "no_sched" module parameter
      blk-mq: remove unused function hctx_allow_merges
      blkcg: check pol->cpd_free_fn before free cpd
      null_blk: update usage hints for submit_queues
      null_blk: add usage hints for no_sched
      blk-mq: fix nr_requests wrong value when modify it from sysfs
      blkcg: add sanity check for blkcg policy operations

 .../ABI/obsolete/proc-sys-vm-nr_pdflush_threads    |    5 -
 Documentation/block/biodoc.txt                     |   11 +-
 Documentation/block/null_blk.txt                   |   19 +-
 MAINTAINERS                                        |    5 +-
 arch/xtensa/platforms/iss/simdisk.c                |    4 +-
 block/bfq-iosched.c                                |  225 +++-
 block/bio-integrity.c                              |    7 +-
 block/bio.c                                        |   40 +-
 block/blk-cgroup.c                                 |    9 +-
 block/blk-core.c                                   |  274 ++++-
 block/blk-flush.c                                  |   37 +-
 block/blk-lib.c                                    |  108 +-
 block/blk-mq-debugfs.c                             |    3 +-
 block/blk-mq-sched.c                               |  203 +--
 block/blk-mq-tag.c                                 |   11 +-
 block/blk-mq-tag.h                                 |    7 +-
 block/blk-mq.c                                     |  422 ++++---
 block/blk-mq.h                                     |   60 +-
 block/blk-settings.c                               |    2 +-
 block/blk-stat.c                                   |   45 +-
 block/blk-throttle.c                               |   12 +-
 block/blk-timeout.c                                |    5 +-
 block/blk-wbt.c                                    |    2 +-
 block/blk.h                                        |   46 +-
 block/bsg.c                                        |   18 +-
 block/elevator.c                                   |   67 +-
 block/genhd.c                                      |   70 +-
 block/ioctl.c                                      |   19 +-
 block/kyber-iosched.c                              |   12 +-
 block/mq-deadline.c                                |    1 +
 block/scsi_ioctl.c                                 |    8 +-
 drivers/block/Kconfig                              |    5 +
 drivers/block/brd.c                                |    1 -
 drivers/block/cryptoloop.c                         |    2 -
 drivers/block/loop.c                               |   13 +
 drivers/block/loop.h                               |    1 +
 drivers/block/mtip32xx/mtip32xx.c                  |    7 -
 drivers/block/nbd.c                                |   26 +-
 drivers/block/null_blk.c                           |   10 +-
 drivers/block/paride/Kconfig                       |    1 +
 drivers/block/skd_main.c                           |    3 +-
 drivers/cdrom/Makefile                             |   15 +-
 drivers/ide/Kconfig                                |    2 +
 drivers/ide/ide-atapi.c                            |    6 +-
 drivers/ide/ide-pm.c                               |    4 +-
 drivers/lightnvm/Kconfig                           |    3 +-
 drivers/lightnvm/core.c                            |  176 +--
 drivers/lightnvm/pblk-cache.c                      |   24 +-
 drivers/lightnvm/pblk-core.c                       |  512 ++++----
 drivers/lightnvm/pblk-gc.c                         |  289 +++--
 drivers/lightnvm/pblk-init.c                       |  197 +--
 drivers/lightnvm/pblk-map.c                        |   28 +-
 drivers/lightnvm/pblk-rb.c                         |   30 +-
 drivers/lightnvm/pblk-read.c                       |  274 +++--
 drivers/lightnvm/pblk-recovery.c                   |  129 +-
 drivers/lightnvm/pblk-rl.c                         |   43 +-
 drivers/lightnvm/pblk-sysfs.c                      |    2 +-
 drivers/lightnvm/pblk-write.c                      |  229 ++--
 drivers/lightnvm/pblk.h                            |  132 +-
 drivers/md/bcache/alloc.c                          |   15 +-
 drivers/md/bcache/bcache.h                         |   19 +-
 drivers/md/bcache/btree.c                          |   17 +-
 drivers/md/bcache/btree.h                          |    2 +-
 drivers/md/bcache/closure.h                        |    6 +
 drivers/md/bcache/request.c                        |   36 +-
 drivers/md/bcache/super.c                          |   52 +-
 drivers/md/bcache/sysfs.c                          |   28 +-
 drivers/md/bcache/util.c                           |   10 +-
 drivers/md/bcache/util.h                           |    4 +-
 drivers/md/bcache/writeback.c                      |  117 +-
 drivers/md/bcache/writeback.h                      |    6 +-
 drivers/md/bitmap.c                                |    2 +-
 drivers/md/dm-rq.c                                 |    2 +-
 drivers/md/dm-table.c                              |   15 +-
 drivers/md/dm.c                                    |   11 -
 drivers/nvme/Kconfig                               |    4 +
 drivers/nvme/host/Kconfig                          |    9 +
 drivers/nvme/host/Makefile                         |    1 +
 drivers/nvme/host/core.c                           | 1301 ++++++++++++++------
 drivers/nvme/host/fabrics.c                        |   16 +-
 drivers/nvme/host/fabrics.h                        |   14 +
 drivers/nvme/host/fc.c                             |  793 +++++++++---
 drivers/nvme/host/lightnvm.c                       |   86 +-
 drivers/nvme/host/multipath.c                      |  291 +++++
 drivers/nvme/host/nvme.h                           |  169 ++-
 drivers/nvme/host/pci.c                            |  243 +++-
 drivers/nvme/host/rdma.c                           |  246 ++--
 drivers/nvme/target/admin-cmd.c                    |   21 +-
 drivers/nvme/target/core.c                         |   23 +
 drivers/nvme/target/fc.c                           |   48 +-
 drivers/nvme/target/io-cmd.c                       |   20 +-
 drivers/nvme/target/loop.c                         |   66 +-
 drivers/nvme/target/nvmet.h                        |    6 +-
 drivers/nvme/target/rdma.c                         |   16 +-
 drivers/scsi/Kconfig                               |    3 +-
 drivers/scsi/lpfc/lpfc_attr.c                      |    5 +
 drivers/scsi/scsi_lib.c                            |   99 +-
 drivers/scsi/sg.c                                  |    2 +-
 fs/block_dev.c                                     |   20 +-
 fs/buffer.c                                        |   70 +-
 fs/direct-io.c                                     |    2 +-
 fs/fs-writeback.c                                  |  153 +--
 fs/iomap.c                                         |    2 +-
 fs/ntfs/aops.c                                     |    2 +-
 fs/ntfs/mft.c                                      |    2 +-
 fs/sync.c                                          |    2 +-
 include/linux/backing-dev-defs.h                   |   24 +
 include/linux/backing-dev.h                        |    4 -
 include/linux/bio.h                                |   25 -
 include/linux/blk-cgroup.h                         |   25 +-
 include/linux/blk-mq.h                             |   40 +-
 include/linux/blk_types.h                          |   16 +-
 include/linux/blkdev.h                             |   36 +-
 include/linux/buffer_head.h                        |    2 +-
 include/linux/elevator.h                           |    1 +
 include/linux/genhd.h                              |    4 +-
 include/linux/kthread.h                            |   11 +
 include/linux/lightnvm.h                           |   11 +-
 include/linux/nvme-fc-driver.h                     |   15 +-
 include/linux/nvme.h                               |   30 +
 include/linux/sbitmap.h                            |   64 +-
 include/linux/writeback.h                          |   30 +-
 include/scsi/scsi_device.h                         |    1 +
 include/trace/events/writeback.h                   |    1 -
 kernel/kthread.c                                   |   66 +-
 kernel/sysctl.c                                    |    5 -
 kernel/trace/blktrace.c                            |   90 +-
 mm/backing-dev.c                                   |   20 -
 mm/page-writeback.c                                |   36 +-
 mm/page_io.c                                       |    2 +-
 mm/vmscan.c                                        |    2 +-
 131 files changed, 5470 insertions(+), 3089 deletions(-)
 delete mode 100644 Documentation/ABI/obsolete/proc-sys-vm-nr_pdflush_threads
 create mode 100644 drivers/nvme/host/multipath.c

diff --cc drivers/cdrom/Makefile
index a95566ff47d3,7f3f43cc2257..0f3664b45f48
--- a/drivers/cdrom/Makefile
+++ b/drivers/cdrom/Makefile
@@@ -1,14 -1,2 +1,3 @@@
 +# SPDX-License-Identifier: GPL-2.0
- # Makefile for the kernel cdrom device drivers.
- #
- # 30 Jan 1998, Michael Elizabeth Chastain, <mailto:mec@shout.net>
- # Rewritten to use lists instead of if-statements.
- 
- # Each configuration option enables a list of files.
- 
- obj-$(CONFIG_BLK_DEV_IDECD)	+=              cdrom.o
- obj-$(CONFIG_BLK_DEV_SR)	+=              cdrom.o
- obj-$(CONFIG_PARIDE_PCD)	+=		cdrom.o
- obj-$(CONFIG_CDROM_PKTCDVD)	+=		cdrom.o
- 
- obj-$(CONFIG_GDROM)		+= gdrom.o      cdrom.o
+ obj-$(CONFIG_CDROM)	+= cdrom.o
+ obj-$(CONFIG_GDROM)	+= gdrom.o
diff --cc drivers/nvme/host/core.c
index 37f9039bb9ca,993813ccdc0b..25da74d310d1
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@@ -1249,13 -1407,10 +1407,11 @@@ static int nvme_revalidate_disk(struct 
  		goto out;
  	}
  
 +	__nvme_revalidate_disk(disk, id);
- 	nvme_report_ns_ids(ctrl, ns->ns_id, id, eui64, nguid, &uuid);
- 	if (!uuid_equal(&ns->uuid, &uuid) ||
- 	    memcmp(&ns->nguid, &nguid, sizeof(ns->nguid)) ||
- 	    memcmp(&ns->eui, &eui64, sizeof(ns->eui))) {
+ 	nvme_report_ns_ids(ctrl, ns->head->ns_id, id, &ids);
+ 	if (!nvme_ns_ids_equal(&ns->head->ids, &ids)) {
  		dev_err(ctrl->device,
- 			"identifiers changed for nsid %d\n", ns->ns_id);
+ 			"identifiers changed for nsid %d\n", ns->head->ns_id);
  		ret = -ENODEV;
  	}
  
diff --cc drivers/nvme/host/fc.c
index be49d0f79381,6eb460b117d6..7ab0be55c7d0
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@@ -2760,7 -3104,7 +3104,8 @@@ nvme_fc_init_ctrl(struct device *dev, s
  	ctrl->rport = rport;
  	ctrl->dev = lport->dev;
  	ctrl->cnum = idx;
+ 	ctrl->assoc_active = false;
 +	init_waitqueue_head(&ctrl->ioabort_wait);
  
  	get_device(ctrl->dev);
  	kref_init(&ctrl->ref);

-- 
Jens Axboe
