Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block changes for 4.16-rc
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Message-ID: <5a2213b5-bc7f-da73-f566-886c38a6d3c9@kernel.dk>
Date: Mon, 29 Jan 2018 08:40:25 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Linus,

This is the main pull request for block IO related changes for the 4.16
kernel. Nothing major in this pull request, but a good amount of
improvements and fixes all over the map. This pull request contains:

- BFQ improvements, fixes, and cleanups from Angelo, Chiara, and Paolo.

- Support for SMR zones for deadline and mq-deadline from Damien and
  Christoph.

- Set of fixes for bcache by way of Michael Lyle, including fixes from
  himself, Kent, Rui, Tang, and Coly.

- Series from Matias for lightnvm with fixes from Hans Holmberg, Javier,
  and Matias. Mostly centered around pblk, and the removing rrpc 1.2 in
  preparation for supporting 2.0.

- A couple of NVMe pull requests from Christoph. Nothing major in here,
  just fixes and cleanups, and support for command tracing from
  Johannes.

- Support for blk-throttle for tracking reads and writes separately.
  From Joseph Qi. A few cleanups/fixes also for blk-throttle from
  Weiping.

- Series from Mike Snitzer that enables dm to register its queue more
  logically, something that's alwways been problematic on dm since it's
  a stacked device.

- Series from Ming cleaning up some of the bio accessor use, in
  preparation for supporting multipage bvecs.

- Various fixes from Ming closing up holes around queue mapping and
  quiescing.

- BSD partition fix from Richard Narron, fixing a problem where we can't
  mount newer (10/11) FreeBSD partitions.

- Series from Tejun reworking blk-mq timeout handling. The previous
  scheme relied on atomic bits, but it had races where we would think a
  request had timed out if it to reused at the wrong time.

- null_blk now supports faking timeouts, to enable us to better exercise
  and test that functionality separately. From me.

- Kill the separate atomic poll bit in the request struct. After this,
  we don't use the atomic bits on blk-mq anymore at all. From me.

- sgl_alloc/free helpers from Bart.

- Heavily contended tag case scalability improvement from me.

- Various little fixes and cleanups from Arnd, Bart, Corentin, Douglas,
  Eryu, Goldwyn, and myself.


Note that you'll get a single merge conflict when pulling this in, due
to the change:

commit 4ccafe032005e9b96acbef2e389a4de5b1254add
Author: Jens Axboe <axboe@kernel.dk>
Date:   Wed Dec 20 13:13:58 2017 -0700

    block: unalign call_single_data in struct request

that went into your tree after I had forked off for-4.16/block. The
resolution is trivial, just ensure that the moved 'csd' struct member
retains the type of struct __call_single_data, not call_single_data_t.

Please pull!


  git://git.kernel.dk/linux-block.git for-4.16/block


----------------------------------------------------------------
Angelo Ruocco (2):
      block, bfq: check low_latency flag in bfq_bfqq_save_state()
      block, bfq: remove superfluous check in queue-merging setup

Arnd Bergmann (3):
      DAC960: split up ioctl function to reduce stack size
      null_blk: remove explicit 'select FAULT_INJECTION'
      blkcg: simplify statistic accumulation code

Bart Van Assche (20):
      pktcdvd: Fix pkt_setup_dev() error path
      pktcdvd: Fix a recently introduced NULL pointer dereference
      lib/scatterlist: Introduce sgl_alloc() and sgl_free()
      crypto: scompress - use sgl_alloc() and sgl_free()
      nvmet/fc: Use sgl_alloc() and sgl_free()
      nvmet/rdma: Use sgl_alloc() and sgl_free()
      target: Use sgl_alloc_order() and sgl_free()
      blk-mq: Fix spelling in a source code comment
      block: Fix kernel-doc warnings reported when building with W=1
      blk-mq: Explain when 'active_queues' is decremented
      blk-mq: Add locking annotations to hctx_lock() and hctx_unlock()
      blk-mq: Reduce the number of if-statements in blk_mq_mark_tag_wait()
      block: Fix __bio_integrity_endio() documentation
      block: Unexport elv_register_queue() and elv_unregister_queue()
      block: Document scheduler modification locking requirements
      block: Protect less code with sysfs_lock in blk_{un,}register_queue()
      lib/scatterlist: Fix chaining support in sgl_alloc_order()
      blk-mq: Rename blk_mq_request_direct_issue() into blk_mq_request_issue_directly()
      blk-mq: Avoid that blk_mq_delay_run_hw_queue() introduces unintended delays
      block: Remove kblockd_schedule_delayed_work{,_on}()

Chiara Bruschi (1):
      block, bfq: fix occurrences of request finish method's old name

Christoph Hellwig (5):
      block: introduce zoned block devices zone write locking
      genirq/affinity: assign vectors to all possible CPUs
      blk-mq: simplify queue mapping & schedule with each possisble CPU
      nvme-pci: clean up CMB initialization
      nvme-pci: clean up SMBSZ bit definitions

Coly Li (2):
      bcache: reduce cache_set devices iteration by devices_max_used
      bcache: fix misleading error message in bch_count_io_errors()

Corentin Labbe (1):
      block: remove smart1,2.h

Damien Le Moal (4):
      mq-deadline: Introduce dispatch helpers
      mq-deadline: Introduce zone locking support
      deadline-iosched: Introduce dispatch helpers
      deadline-iosched: Introduce zone locking support

Douglas Gilbert (1):
      blk_rq_map_user_iov: fix error override

Eryu Guan (1):
      blk-mq-debugfs: don't allow write on attributes with seq_operations set

Goldwyn Rodrigues (1):
      block: Set BIO_TRACE_COMPLETION on new bio during split

Hans Holmberg (5):
      lightnvm: pblk: refactor emeta consistency check
      lightnvm: pblk: rename sync_point to flush_point
      lightnvm: pblk: clear flush point on completed writes
      lightnvm: pblk: prevent premature sync point resets
      lightnvm: pblk: remove pblk_gc_stop

Ilya Dryomov (2):
      block: fail op_is_write() requests to read-only partitions
      block: add bdev_read_only() checks to common helpers

Israel Rukshin (3):
      nvmet: fix error flow in nvmet_alloc_ctrl()
      nvmet: rearrange nvmet_ctrl_free()
      nvme: fix subsystem multiple controllers support check

James Smart (7):
      nvme_fcloop: fix abort race condition
      nvme_fcloop: disassocate local port structs
      nvme_fcloop: rework to remove xxx_IN_ISR feature flags
      nvme_fcloop: refactor host/target io job access
      nvmet-fc: cleanup nvmet add_port/remove_port
      nvme-fc: fix rogue admin cmds stalling teardown
      nvme-fc: correct hang in nvme_ns_remove()

Javier González (13):
      lightnvm: remove unnecessary field from nvm_rq
      lightnvm: refactor target type lookup
      lightnvm: guarantee target unique name across devs.
      lightnvm: pblk: compress and reorder helper functions
      lightnvm: pblk: remove pblk_for_each_lun helper
      lightnvm: pblk: use exact free block counter in RL
      lightnvm: set target over-provision on create ioctl
      lightnvm: pblk: ignore high ecc errors on recovery
      lightnvm: pblk: do not log recovery read errors
      lightnvm: pblk: ensure kthread alloc. before kicking it
      lightnvm: pblk: free write buffer on init failure
      lightnvm: pblk: print instance name on instance info
      lightnvm: pblk: add iostat support

Jens Axboe (17):
      blk-mq: improve heavily contended tag case
      mq-deadline: make it clear that __dd_dispatch_request() works on all hw queues
      Merge branch 'nvme-4.16' of git://git.infradead.org/nvme into for-4.16/block
      blk-mq: move hctx lock/unlock into a helper
      blk-mq: silence false positive warnings in hctx_unlock()
      bfq-iosched: don't call bfqg_and_blkg_put for !CONFIG_BFQ_GROUP_IOSCHED
      null_blk: wire up timeouts
      null_blk: add option for managing IO timeouts
      blk-mq: add a few missing debugfs RQF_ flags
      block: remove REQ_ATOM_POLL_SLEPT
      block: add accessors for setting/querying request deadline
      block: convert REQ_ATOM_COMPLETE to stealing rq->__deadline bit
      block: rearrange a few request fields for better cache layout
      blk-mq: add missing RQF_STARTED to debugfs
      blk-mq: fix bad clear of RQF_MQ_INFLIGHT in blk_mq_ct_ctx_init()
      Merge branch 'nvme-4.16' of git://git.infradead.org/nvme into for-4.16/block
      Merge branch 'nvme-4.16' of git://git.infradead.org/nvme into for-4.16/block

Jianchao Wang (2):
      nvme-pci: fix NULL pointer reference in nvme_alloc_ns
      nvme-pci: introduce RECONNECTING state to mark initializing procedure

Johannes Thumshirn (4):
      bsg: use pr_debug instead of hand crafted macros
      nvme: don't free uuid pointer before printing it
      nvme: add tracepoint for nvme_setup_cmd
      nvme: add tracepoint for nvme_complete_rq

Joseph Qi (1):
      blk-throttle: track read and write request individually

Keith Busch (7):
      nvme: Add more command status translation
      nvme/multipath: Consult blk_status_t for failover
      block: Provide blk_status_t decoding for path errors
      nvme/multipath: Use blk_path_error
      dm mpath: Use blk_path_error
      nvme-pci: Fix queue double allocations
      nvme-pci: Suspend queues after deleting them

Kent Overstreet (2):
      bcache: Fix, improve efficiency of closure_sync()
      bcache: mark closure_sync() __sched

Liu Bo (1):
      blk-mq: remove confusing comment of blk_mq_sched_dispatch_requests

Matias Bjørling (7):
      null_blk: remove lightnvm support
      lightnvm: remove rrpc
      lightnvm: use internal pblk methods
      lightnvm: remove hybrid ocssd 1.2 support
      lightnvm: remove lower page tables
      lightnvm: make geometry structures 2.0 ready
      lightnvm: pblk: refactor pblk_ppa_comp function

Max Gurtovoy (2):
      nvme: modify the debug level for setting shutdown timeout
      nvme-rdma: remove redundant boolean for inline_data

Michael Lyle (4):
      bcache: writeback: properly order backing device IO
      bcache: allow quick writeback when backing idle
      bcache: fix writeback target calc on large devices
      bcache: closures: move control bits one bit right

Mike Snitzer (6):
      block: only bdi_unregister() in del_gendisk() if !GENHD_FL_HIDDEN
      block: properly protect the 'queue' kobj in blk_unregister_queue
      block: allow gendisk's request_queue registration to be deferred
      dm: fix incomplete request_queue initialization
      blk-mq: factor out a few helpers from __blk_mq_try_issue_directly
      blk-mq-sched: remove unused 'can_block' arg from blk_mq_sched_insert_request

Ming Lei (24):
      block: introduce bio helpers for converting to multipage bvec
      block: convert to bio_first_bvec_all & bio_first_page_all
      fs: convert to bio_last_bvec_all()
      block: bounce: avoid direct access to bvec table
      block: bounce: don't access bio->bi_io_vec in copy_to_high_bio_irq
      dm: limit the max bio size as BIO_MAX_PAGES * PAGE_SIZE
      bcache: comment on direct access to bvec table
      block: move bio_alloc_pages() to bcache
      btrfs: avoid access to .bi_vcnt directly
      btrfs: avoid accessing bvec table directly for a cloned bio
      dm-crypt: don't clear bvec->bv_page in crypt_free_buffer_pages()
      blk-merge: compute bio->bi_seg_front_size efficiently
      block: blk-merge: try to make front segments in full size
      block: blk-merge: remove unnecessary check
      blk-mq: quiesce queue before freeing queue
      blk-mq: quiesce queue during switching io sched and updating nr_requests
      blk-mq: avoid to map CPU into stale hw queue
      blk-mq: fix race between updating nr_hw_queues and switching io sched
      blk-mq: fix kernel oops in blk_mq_tag_idle()
      Revert "block: blk-merge: try to make front segments in full size"
      blk-mq: make sure hctx->next_cpu is set correctly
      blk-mq: turn WARN_ON in __blk_mq_run_hw_queue into printk
      blk-mq: improve DM's blk-mq IO merging via blk_insert_cloned_request feedback
      blk-mq: don't dispatch request in blk_mq_request_direct_issue if queue is busy

Minwoo Im (2):
      nvme-pci: remove an unnecessary initialization in HMB code
      nvme: fix comment typos in nvme_create_io_queues

Nitzan Carmi (1):
      nvme: take refcount on transport module

Paolo Bonzini (1):
      block: silently forbid sending any ioctl to a partition

Paolo Valente (9):
      block, bfq: increase threshold to deem I/O as random
      block, bfq: add missing rq_pos_tree update on rq removal
      block, bfq: let a queue be merged only shortly after starting I/O
      block, bfq: consider also past I/O in soft real-time detection
      block, bfq: remove batches of confusing ifdefs
      block, bfq: put async queues for root bfq groups too
      block, bfq: release oom-queue ref to root group on exit
      block, bfq: limit tags for writes and async I/O
      block, bfq: limit sectors served with interactive weight raising

Richard Narron (1):
      partitions/msdos: Unable to mount UFS 44bsd partitions

Roland Dreier (1):
      nvme-fabrics: fix memory leak when parsing host ID option

Roy Shterman (2):
      nvme-fabrics: protect against module unload during create_ctrl
      nvme: host delete_work and reset_work on separate workqueues

Rui Hua (1):
      bcache: ret IOERR when read meets metadata error

Sagi Grimberg (7):
      nvmet-rdma: removed queue cleanup from module exit
      nvmet-rdma: lowering log level for chatty debug messages
      nvmet: lower log level for each queue creation
      nvme-pci: don't open-code nvme_reset_ctrl
      nvme-pci: serialize pci resets
      nvme-pci: allocate device queues storage space at probe
      nvmet: release a ns reference in nvmet_req_uninit if needed

Tang Junhui (3):
      bcache: stop writeback thread after detaching
      bcache: segregate flash only volume write streams
      bcache: fix wrong return value in bch_debug_init()

Tejun Heo (7):
      blk-mq: protect completion path with RCU
      blk-mq: replace timeout synchronization with a RCU and generation based scheme
      blk-mq: use blk_mq_rq_state() instead of testing REQ_ATOM_COMPLETE
      blk-mq: make blk_abort_request() trigger timeout path
      blk-mq: remove REQ_ATOM_COMPLETE usages from blk-mq
      blk-mq: remove REQ_ATOM_STARTED
      blk-mq: rename blk_mq_hw_ctx->queue_rq_srcu to ->srcu

Tina Ruchandani (1):
      aoe: use ktime_t instead of timeval

Vasyl Gomonovych (1):
      bcache: Use PTR_ERR_OR_ZERO()

Wang Long (1):
      writeback: update comment in inode_io_list_move_locked

Zhai Zhaoxuan (1):
      bcache: fix unmatched generic_end_io_acct() & generic_start_io_acct()

weiping zhang (2):
      blk-throttle: export io_serviced_recursive, io_service_bytes_recursive
      blk-throttle: use queue_is_rq_based

 block/bfq-cgroup.c                     |    7 +-
 block/bfq-iosched.c                    |  529 ++++++++---
 block/bfq-iosched.h                    |   19 +
 block/bfq-wf2q.c                       |    7 +
 block/bio-integrity.c                  |    1 -
 block/bio.c                            |   30 +-
 block/blk-core.c                       |   87 +-
 block/blk-exec.c                       |    2 +-
 block/blk-lib.c                        |   12 +
 block/blk-map.c                        |    4 +-
 block/blk-merge.c                      |   13 +-
 block/blk-mq-debugfs.c                 |   22 +-
 block/blk-mq-sched.c                   |    3 +-
 block/blk-mq-sched.h                   |    2 +-
 block/blk-mq-sysfs.c                   |    9 +-
 block/blk-mq-tag.c                     |   13 +-
 block/blk-mq.c                         |  667 ++++++++-----
 block/blk-mq.h                         |   52 +-
 block/blk-sysfs.c                      |   47 +-
 block/blk-throttle.c                   |  146 +--
 block/blk-timeout.c                    |   26 +-
 block/blk-zoned.c                      |   42 +
 block/blk.h                            |   46 +-
 block/bounce.c                         |   33 +-
 block/bsg-lib.c                        |    3 +-
 block/bsg.c                            |   40 +-
 block/deadline-iosched.c               |  114 ++-
 block/elevator.c                       |   12 +-
 block/genhd.c                          |   23 +-
 block/mq-deadline.c                    |  141 ++-
 block/partitions/msdos.c               |    4 +-
 block/scsi_ioctl.c                     |   34 +-
 crypto/Kconfig                         |    1 +
 crypto/scompress.c                     |   51 +-
 drivers/block/DAC960.c                 |  160 ++--
 drivers/block/Kconfig                  |    4 +
 drivers/block/aoe/aoe.h                |    3 +-
 drivers/block/aoe/aoecmd.c             |   48 +-
 drivers/block/drbd/drbd_bitmap.c       |    2 +-
 drivers/block/null_blk.c               |  290 ++----
 drivers/block/pktcdvd.c                |   12 +-
 drivers/block/smart1,2.h               |  278 ------
 drivers/block/zram/zram_drv.c          |    2 +-
 drivers/lightnvm/Kconfig               |    7 -
 drivers/lightnvm/Makefile              |    1 -
 drivers/lightnvm/core.c                |  462 ++++-----
 drivers/lightnvm/pblk-cache.c          |    5 +
 drivers/lightnvm/pblk-core.c           |   55 +-
 drivers/lightnvm/pblk-gc.c             |   23 +-
 drivers/lightnvm/pblk-init.c           |  104 +-
 drivers/lightnvm/pblk-map.c            |    2 +-
 drivers/lightnvm/pblk-rb.c             |  111 ++-
 drivers/lightnvm/pblk-read.c           |   35 +-
 drivers/lightnvm/pblk-recovery.c       |   43 +-
 drivers/lightnvm/pblk-rl.c             |   54 +-
 drivers/lightnvm/pblk-sysfs.c          |   15 +-
 drivers/lightnvm/pblk-write.c          |   23 +-
 drivers/lightnvm/pblk.h                |  163 ++--
 drivers/lightnvm/rrpc.c                | 1625 --------------------------------
 drivers/lightnvm/rrpc.h                |  290 ------
 drivers/md/bcache/alloc.c              |   19 +-
 drivers/md/bcache/bcache.h             |   24 +-
 drivers/md/bcache/btree.c              |   10 +-
 drivers/md/bcache/closure.c            |   47 +-
 drivers/md/bcache/closure.h            |   60 +-
 drivers/md/bcache/debug.c              |    7 +-
 drivers/md/bcache/io.c                 |   13 +-
 drivers/md/bcache/movinggc.c           |    2 +-
 drivers/md/bcache/request.c            |   29 +-
 drivers/md/bcache/super.c              |   27 +-
 drivers/md/bcache/util.c               |   34 +
 drivers/md/bcache/util.h               |    1 +
 drivers/md/bcache/writeback.c          |  203 +++-
 drivers/md/bcache/writeback.h          |   12 +-
 drivers/md/dm-crypt.c                  |    1 -
 drivers/md/dm-mpath.c                  |   19 +-
 drivers/md/dm-rq.c                     |   28 +-
 drivers/md/dm.c                        |   21 +-
 drivers/nvme/host/Makefile             |    4 +
 drivers/nvme/host/core.c               |  134 ++-
 drivers/nvme/host/fabrics.c            |   22 +-
 drivers/nvme/host/fabrics.h            |    2 +
 drivers/nvme/host/fc.c                 |    7 +
 drivers/nvme/host/lightnvm.c           |  185 +---
 drivers/nvme/host/multipath.c          |   44 +-
 drivers/nvme/host/nvme.h               |    9 +-
 drivers/nvme/host/pci.c                |  216 ++---
 drivers/nvme/host/rdma.c               |    6 +-
 drivers/nvme/host/trace.c              |  130 +++
 drivers/nvme/host/trace.h              |  165 ++++
 drivers/nvme/target/Kconfig            |    2 +
 drivers/nvme/target/core.c             |   14 +-
 drivers/nvme/target/fabrics-cmd.c      |    2 +-
 drivers/nvme/target/fc.c               |   60 +-
 drivers/nvme/target/fcloop.c           |  244 ++++-
 drivers/nvme/target/loop.c             |    3 +-
 drivers/nvme/target/rdma.c             |   83 +-
 drivers/target/Kconfig                 |    1 +
 drivers/target/target_core_transport.c |   46 +-
 fs/btrfs/compression.c                 |    4 +-
 fs/btrfs/extent_io.c                   |   11 +-
 fs/btrfs/extent_io.h                   |    2 +-
 fs/btrfs/inode.c                       |    8 +-
 fs/buffer.c                            |    2 +-
 fs/f2fs/data.c                         |    2 +-
 fs/fs-writeback.c                      |    2 +-
 include/linux/bio.h                    |   24 +-
 include/linux/blk-cgroup.h             |    8 +-
 include/linux/blk-mq.h                 |    3 +-
 include/linux/blk_types.h              |   28 +
 include/linux/blkdev.h                 |  172 +++-
 include/linux/bvec.h                   |    9 +
 include/linux/elevator.h               |    2 -
 include/linux/genhd.h                  |    5 +
 include/linux/lightnvm.h               |  125 +--
 include/linux/nvme.h                   |   22 +-
 include/linux/scatterlist.h            |   11 +
 include/uapi/linux/lightnvm.h          |    9 +
 kernel/irq/affinity.c                  |   30 +-
 kernel/power/swap.c                    |    2 +-
 lib/Kconfig                            |    4 +
 lib/sbitmap.c                          |    2 +-
 lib/scatterlist.c                      |  127 +++
 mm/page_io.c                           |    4 +-
 124 files changed, 3884 insertions(+), 4729 deletions(-)
 delete mode 100644 drivers/block/smart1,2.h
 delete mode 100644 drivers/lightnvm/rrpc.c
 delete mode 100644 drivers/lightnvm/rrpc.h
 create mode 100644 drivers/nvme/host/trace.c
 create mode 100644 drivers/nvme/host/trace.h

-- 
Jens Axboe
