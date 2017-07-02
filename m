Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Core block/IO changes for 4.13-rc
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Message-ID: <c2565c20-527f-72fb-dc5c-bb81f56220f9@kernel.dk>
Date: Sun, 2 Jul 2017 17:44:32 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Linus,

This is the main pull request for the block layer for 4.13. Not a huge
round in terms of features, but there's a lot of churn related to some
core cleanups. Note that merge request will throw 3 merge failures for
you. I've included how I resolved them in the for-next (or
for-4.13/merge) branch after the pull stats, at the end of this email.

Note this depends on the UUID tree pull request, that Christoph already
sent out.

This pull request contains:

- A series from Christoph, unifying the error/stats codes in the block
  layer. We now use blk_status_t everywhere, instead of using different
  schemes for different places.

- Also from Christoph, some cleanups around request allocation and IO
  scheduler interactions in blk-mq.

- And yet another series from Christoph, cleaning up how we handle and
  do bounce buffering in the block layer.

- A blk-mq debugfs series from Bart, further improving on the support we
  have for exporting internal information to aid debugging IO hangs or
  stalls.

- Also from Bart, a series that cleans up the request initialization
  differences across types of devices.

- A series from Goldwyn Rodrigues, allowing the block layer to return
  failure if we will block and the user asked for non-blocking.

- Patch from Hannes for supporting setting loop devices block size to
  that of the underlying device.

- Two series of patches from Javier, fixing various issues with
  lightnvm, particular around pblk.

- A series from me, adding support for write hints. This comes with NVMe
  support as well, so applications can help guide data placement on
  flash to improve performance, latencies, and write amplification.

- A series from Ming, improving and hardening blk-mq support for
  stopping/starting and quiescing hardware queues.

- Two pull requests for NVMe updates. Nothing major on the feature side,
  but lots of cleanups and bug fixes. From the usual crew.

- A series from Neil Brown, greatly improving the bio rescue set
  support. Most notably, this kills the bio rescue work queues, if we
  don't really need them.

- Lots of other little bug fixes that are all over the place.

Please pull!


  git://git.kernel.dk/linux-block.git for-4.13/block


----------------------------------------------------------------
Arnav Dawn (1):
      nvme.h: add dword 12 - 15 fields to struct nvme_features

Arnd Bergmann (1):
      loop: fix error handling regression

Arvind Yadav (1):
      block: swim3: make of_device_ids const.

Bart Van Assche (27):
      blk-mq-debugfs: Show atomic request flags
      blk-mq-debugfs: Show requeue list
      blk-mq-debugfs: Show busy requests
      blk-mq-debugfs: Add 'kick' operation
      block: Introduce queue flag QUEUE_FLAG_SCSI_PASSTHROUGH
      bsg: Check queue type before attaching to a queue
      pktcdvd: Check queue type before attaching to a queue
      cdrom: Check SCSI passthrough support before reading audio
      nfsd: Check queue type before submitting a SCSI request
      nvmet-fc: Remove a set-but-not-used variable
      block: Dedicated error code fixups
      blk-mq: Reduce blk_mq_hw_ctx size
      block: Make request operation type argument declarations consistent
      block: Introduce request_queue.initialize_rq_fn()
      block: Make most scsi_req_init() calls implicit
      block: Change argument type of scsi_req_init()
      blk-mq: Initialize .rq_flags in blk_mq_rq_ctx_init()
      block: Add a comment above queue_lockdep_assert_held()
      block: Check locking assumptions at runtime
      block: Document what queue type each function is intended for
      blk-mq: Document locking assumptions
      block: Constify disk_type
      blk-mq: Warn when attempting to run a hardware queue that is not mapped
      block: Add fallthrough markers to switch statements
      block: Declare local symbols static
      block: Fix off-by-one errors in blk_status_to_errno() and print_req_error()
      blk-mq: Make it safe to quiesce and unquiesce from an interrupt handler

Christoph Hellwig (52):
      nvme-lightnvm: use blk_execute_rq in nvme_nvm_submit_user_cmd
      scsi/osd: don't save block errors into req_results
      gfs2: remove the unused sd_log_error field
      dm: fix REQ_RAHEAD handling
      fs: remove the unused error argument to dio_end_io()
      fs: simplify dio_bio_complete
      block_dev: propagate bio_iov_iter_get_pages error in __blkdev_direct_IO
      dm mpath: merge do_end_io_bio into multipath_end_io_bio
      dm: don't return errnos from ->map
      dm: change ->end_io calling convention
      block: introduce new block status code type
      blk-mq: switch ->queue_rq return value to blk_status_t
      block: switch bios to blk_status_t
      nvme-rdma: fix merge error
      Merge branch 'uuid-types' of bombadil.infradead.org:public_git/uuid into nvme-base
      nvme.h: add struct nvme_host_mem_buf_desc and HMB flags
      nvme: save hmpre and hmmin in struct nvme_ctrl
      nvme-pci: implement host memory buffer support
      nvme: mark shutdown_timeout static
      nvme: move protection information check into nvme_setup_rw
      nvme-rdma: merge init_request and exit_request methods
      nvme-fc: merge init_request methods
      nvme-loop: merge init_request methods
      nvme-pci: merge init_request methods
      nvme: move reset workqueue handling to common code
      nvme: no need to wait for the reset when keepalive fails
      blk-mq: mark blk_mq_rq_ctx_init static
      blk-mq: move blk_mq_sched_{get,put}_request to blk-mq.c
      blk-mq: remove blk_mq_sched_{get,put}_rq_priv
      blk-mq-sched: unify request finished methods
      blk-mq: simplify blk_mq_free_request
      blk-mq: streamline blk_mq_get_request
      bfq-iosched: fix NULL ioc check in bfq_get_rq_private
      blk-mq: refactor blk_mq_sched_assign_ioc
      blk-mq-sched: unify request prepare methods
      blk-mq: remove __blk_mq_alloc_request
      block: remove the unused bio_to_phys macro
      block: stop using bio_data() in blk_write_same_mergeable
      pktcdvd: remove the call to blk_queue_bounce
      blk-map: call blk_queue_bounce from blk_rq_append_bio
      block: move bounce declarations to block/blk.h
      block: remove the queue_bounce_pfn helper
      block: don't bother with bounce limits for make_request drivers
      blk-mq: don't bounce by default
      block: don't set bounce limit in blk_init_allocated_queue
      block: don't set bounce limit in blk_init_queue
      dm: don't set bounce limit
      mmc/block: remove a call to blk_queue_bounce_limit
      nvme: remove a misleading comment on struct nvme_ns
      nvme: read the subsystem NQN from Identify Controller
      nvme: simplify nvme_dev_attrs_are_visible
      nvme-fabrics: verify that a controller returns the correct NQN

Dan Carpenter (3):
      dm: missing break in process_queued_bios()
      nvme-rdma: fix error code in nvme_rdma_create_ctrl()
      btrfs: use new block error code

Goldwyn Rodrigues (10):
      fs: Separate out kiocb flags setup based on RWF_* flags
      fs: Introduce filemap_range_has_page()
      fs: Use RWF_* flags for AIO operations
      fs: Introduce RWF_NOWAIT and FMODE_AIO_NOWAIT
      fs: return if direct I/O will trigger writeback
      fs: Introduce IOMAP_NOWAIT
      block: return on congested block device
      ext4: nowait aio support
      xfs: nowait aio support
      btrfs: nowait aio support

Guan Junxiong (2):
      nvme: add fields into identify controller data structure
      nvmf: keep track of nvmet connect error status

Hannes Reinecke (2):
      loop: Remove unused 'bdev' argument from loop_set_capacity
      loop: support 4k physical blocksize

James Smart (5):
      nvme_fc: fix double calls to nvme_cleanup_cmd()
      nvme_fc: replace ioabort msleep loop with completion
      nvme_fc: Fix crash when nvme controller connection fails.
      nvmet_fc: fix crashes on bad opcodes
      nvme_fc: fix error recovery on link down.

Javier González (30):
      lightnvm: re-convert ppa format on I/O failure
      lightnvm: propagate right error code to target
      lightnvm: pblk: spare double cpu_to_le64 calc.
      lightnvm: pblk: add debug stat for read cache hits
      lightnvm: pblk: expose max sec per write on sysfs
      lightnvm: pblk: generalize erase path
      lightnvm: pblk: rename read request pool
      lightnvm: pblk: sched. metadata on write thread
      lightnvm: pblk: delete redundant debug line stat
      lightnvm: pblk: delete redundant buffer pointer
      lightnvm: pblk: issue multiplane reads if possible
      lightnvm: pblk: simplify meta. memory allocation
      lightnvm: pblk: decouple bad block from line alloc
      lightnvm: pblk: choose optimal victim GC line
      lightnvm: pblk: set metadata list for all I/Os
      lightnvm: pblk: cleanup unnecessary code
      lightnvm: pblk: add lock assertions on helpers
      lightnvm: pblk: redesign GC algorithm
      lightnvm: pblk: set mempool and workqueue params.
      lightnvm: pblk: fail gracefully on irrec. error
      lightnvm: pblk: fix bad le64 assignations
      lightnvm: pblk: fix double-free on pblk init
      lightnvm: pblk: remove unused return variable
      lightnvm: pblk: schedule if data is not ready
      lightnvm: pblk: use right metadata buffer for recovery
      lightnvm: pblk: use vmalloc for GC data buffer
      lightnvm: pblk: remove target using async. I/Os
      lightnvm: pblk: add initialization check
      lightnvm: pblk: verify that cache read is still valid
      lightnvm: pblk: set line bitmap check under debug

Jens Axboe (16):
      Merge tag 'v4.12-rc5' into for-4.13/block
      blk-mq: fixup type of 'ret' in __blk_mq_try_issue_directly()
      Merge branch 'nvme-4.13' of git://git.infradead.org/nvme into for-4.13/block
      null_blk: add support for shared tags
      Merge commit '8e8320c9315c' into for-4.13/block
      mtip32xx: fix up the checking for internal command failure
      fs: add fcntl() interface for setting/getting write life time hints
      block: add support for write hints in a bio
      blk-mq: expose write hints through debugfs
      fs: add O_DIRECT and aio support for sending down write life time hints
      fs: add support for buffered writeback to pass down write hints
      ext4: add support for passing in write hints for buffered writes
      xfs: add support for passing in write hints for buffered writes
      btrfs: add support for passing in write hints for buffered writes
      nvme: add support for streams and directives
      fs/fcntl: use copy_to/from_user() for u64 types

Johannes Thumshirn (11):
      scatterlist: add sg_zero_buffer() helper
      nvmet: use NVME_IDENTIFY_DATA_SIZE
      nvme: introduce NVMe Namespace Identification Descriptor structures
      nvme: rename uuid to nguid in nvme_ns
      nvme: get list of namespace descriptors
      nvme: provide UUID value to userspace
      nvmet: implement namespace identify descriptor list
      nvmet: add uuid field to nvme_ns and populate via configfs
      nvmet: allow overriding the NVMe VS via configfs
      nvme: use ctrl->device consistently for logging
      nvme: add hostid token to fabric options

Josef Bacik (1):
      nbd: set sk->sk_sndtimeo for our sockets

Julia Lawall (1):
      drbd: Drop unnecessary static

Kai-Heng Feng (1):
      nvme: explicitly disable APST on quirked devices

Keith Busch (2):
      nvme-pci: Remove watchdog timer
      nvme: Remove SCSI translations

Matthias Kaehlcke (1):
      cfq-iosched: Delete unused function min_vdisktime()

Max Gurtovoy (1):
      blk-mq: map all HWQ also in hyperthreaded system

Mike Snitzer (1):
      dm: bump DM_VERSION_MINOR in response to target method error code changes

Ming Lei (12):
      blk-mq: merge bio into sw queue before plugging
      blk-mq: make per-sw-queue bio merge as default .bio_merge
      blk-mq: move blk_mq_quiesce_queue() into include/linux/blk-mq.h
      blk-mq: introduce blk_mq_quiesce_queue_nowait()
      blk-mq: introduce blk_mq_unquiesce_queue
      blk-mq: use the introduced blk_mq_unquiesce_queue()
      blk-mq: use QUEUE_FLAG_QUIESCED to quiesce queue
      blk-mq: update comments on blk_mq_quiesce_queue()
      blk-mq: don't stop queue for quiescing
      blk-mq: clarify dispatch may not be drained/blocked by stopping queue
      Revert "blk-mq: don't use sync workqueue flushing from drivers"
      nvme: host: unquiesce queue in nvme_kill_queues()

NeilBrown (14):
      loop: Add PF_LESS_THROTTLE to block/loop device thread.
      blk: remove bio_set arg from blk_queue_split()
      blk: replace bioset_create_nobvec() with a flags arg to bioset_create()
      blk: make the bioset rescue_workqueue optional.
      blk: use non-rescuing bioset for q->bio_split.
      block: Improvements to bounce-buffer handling
      rbd: use bio_clone_fast() instead of bio_clone()
      drbd: use bio_clone_fast() instead of bio_clone()
      pktcdvd: use bio_clone_fast() instead of bio_clone()
      lightnvm/pblk-read: use bio_clone_fast()
      xen-blkfront: remove bio splitting.
      bcache: use kmalloc to allocate bio in bch_data_verify()
      block: remove bio_clone() and all references.
      block: don't check for BIO_MAX_PAGES in blk_bio_segment_split()

Paolo Valente (1):
      block, bfq: update wr_busy_queues if needed on a queue split

Rakesh Pandit (1):
      lightnvm: if LUNs are already allocated fix return

Sagi Grimberg (19):
      nvme-loop: get rid of unused controller lock
      nvme-rdma: get rid of unused ctrl lock
      nvme-rdma: Make queue flags bit numbers and not shifts
      nvme-rdma: Don't rearm the CQ when polling directly
      nvme-rdma: make nvme_rdma_[create|destroy]_queue_ib symmetrical
      nvme-rdma: rework rdma connection establishment error path
      nvme-rdma: Get rid of CONNECTED state
      nvme: Don't allow to reset a reconnecting controller
      nvme: Move transports to use nvme-core workqueue
      nvme: queue ns scanning and async request from nvme_wq
      nvme: move nr_reconnects to nvme_ctrl
      nvme-pci: remove redundant includes
      nvme: don't hard code size of struct t10_pi_tuple
      nvme-pci: Introduce nvme_ring_cq_doorbell
      nvme-pci: factor out cqe handling into a dedicated routine
      nvme-pci: factor out the cqe reading mechanics from __nvme_process_cq
      nvme-pci: open-code polling logic in nvme_poll
      nvme: use a single NVME_AQ_DEPTH and relax it to 32
      nvmet-rdma: register ib_client to not deadlock in device removal

Scott Bauer (1):
      nvme: implement NS Optimal IO Boundary from 1.3 Spec

Shaun McDowell (1):
      nbd: add FUA op support

Valentin Rothberg (1):
      nvme: Makefile: remove dead build rule

Xu Yu (1):
      nvme-pci: remap BAR0 to cover admin CQ doorbell for large stride

weiping (1):
      blk-mq: remove double set queue_num

 Documentation/block/biodoc.txt      |    2 +-
 arch/s390/include/asm/eadm.h        |    6 +-
 arch/um/drivers/ubd_kern.c          |    2 +-
 block/badblocks.c                   |    1 +
 block/bfq-iosched.c                 |   59 +-
 block/bio-integrity.c               |    8 +-
 block/bio.c                         |   85 +-
 block/blk-core.c                    |  331 +++--
 block/blk-exec.c                    |    4 +-
 block/blk-flush.c                   |   16 +-
 block/blk-integrity.c               |    4 +-
 block/blk-map.c                     |    7 +-
 block/blk-merge.c                   |   48 +-
 block/blk-mq-cpumap.c               |   68 +-
 block/blk-mq-debugfs.c              |  101 +-
 block/blk-mq-sched.c                |  158 +--
 block/blk-mq-sched.h                |   28 +-
 block/blk-mq.c                      |  399 +++---
 block/blk-mq.h                      |   11 -
 block/blk-settings.c                |    5 -
 block/blk-tag.c                     |   15 +-
 block/blk-timeout.c                 |    4 +-
 block/blk.h                         |   15 +
 block/bounce.c                      |   47 +-
 block/bsg-lib.c                     |    5 +-
 block/bsg.c                         |   13 +-
 block/cfq-iosched.c                 |    9 -
 block/elevator.c                    |    1 +
 block/genhd.c                       |    4 +-
 block/ioprio.c                      |    3 +-
 block/kyber-iosched.c               |   31 +-
 block/scsi_ioctl.c                  |   13 +-
 block/t10-pi.c                      |   32 +-
 drivers/block/DAC960.c              |    2 +-
 drivers/block/amiflop.c             |   10 +-
 drivers/block/aoe/aoeblk.c          |    1 +
 drivers/block/aoe/aoecmd.c          |   12 +-
 drivers/block/aoe/aoedev.c          |    2 +-
 drivers/block/ataflop.c             |   16 +-
 drivers/block/brd.c                 |    1 -
 drivers/block/cciss.c               |    4 +-
 drivers/block/drbd/drbd_actlog.c    |    2 +-
 drivers/block/drbd/drbd_bitmap.c    |    6 +-
 drivers/block/drbd/drbd_int.h       |    5 +-
 drivers/block/drbd/drbd_main.c      |   14 +-
 drivers/block/drbd/drbd_nl.c        |    2 +-
 drivers/block/drbd/drbd_receiver.c  |    6 +-
 drivers/block/drbd/drbd_req.c       |    8 +-
 drivers/block/drbd/drbd_req.h       |    2 +-
 drivers/block/drbd/drbd_worker.c    |   16 +-
 drivers/block/floppy.c              |    9 +-
 drivers/block/loop.c                |   64 +-
 drivers/block/loop.h                |    1 +
 drivers/block/mtip32xx/mtip32xx.c   |   54 +-
 drivers/block/mtip32xx/mtip32xx.h   |    2 +-
 drivers/block/nbd.c                 |   44 +-
 drivers/block/null_blk.c            |  125 +-
 drivers/block/paride/pcd.c          |    9 +-
 drivers/block/paride/pd.c           |    3 +-
 drivers/block/paride/pf.c           |   19 +-
 drivers/block/pktcdvd.c             |   40 +-
 drivers/block/ps3disk.c             |   11 +-
 drivers/block/ps3vram.c             |   16 +-
 drivers/block/rbd.c                 |   28 +-
 drivers/block/rsxx/dev.c            |   17 +-
 drivers/block/rsxx/dma.c            |   13 +-
 drivers/block/rsxx/rsxx_priv.h      |    2 +-
 drivers/block/skd_main.c            |   32 +-
 drivers/block/sunvdc.c              |    4 +-
 drivers/block/swim.c                |    8 +-
 drivers/block/swim3.c               |   29 +-
 drivers/block/sx8.c                 |   20 +-
 drivers/block/umem.c                |    4 +-
 drivers/block/virtio_blk.c          |   23 +-
 drivers/block/xen-blkback/blkback.c |   19 +-
 drivers/block/xen-blkfront.c        |   81 +-
 drivers/block/xsysace.c             |    9 +-
 drivers/block/z2ram.c               |    4 +-
 drivers/cdrom/cdrom.c               |    7 +-
 drivers/cdrom/gdrom.c               |   10 +-
 drivers/ide/ide-atapi.c             |   12 +-
 drivers/ide/ide-cd.c                |   11 +-
 drivers/ide/ide-cd_ioctl.c          |    1 -
 drivers/ide/ide-devsets.c           |    1 -
 drivers/ide/ide-disk.c              |    1 -
 drivers/ide/ide-dma.c               |    2 +-
 drivers/ide/ide-eh.c                |   16 +-
 drivers/ide/ide-floppy.c            |    6 +-
 drivers/ide/ide-io.c                |   10 +-
 drivers/ide/ide-ioctls.c            |    2 -
 drivers/ide/ide-park.c              |    2 -
 drivers/ide/ide-pm.c                |    8 +-
 drivers/ide/ide-probe.c             |    7 +-
 drivers/ide/ide-tape.c              |    3 +-
 drivers/ide/ide-taskfile.c          |    7 +-
 drivers/ide/siimage.c               |    6 +-
 drivers/lightnvm/core.c             |   13 +-
 drivers/lightnvm/pblk-cache.c       |    8 +-
 drivers/lightnvm/pblk-core.c        |  617 ++++++---
 drivers/lightnvm/pblk-gc.c          |  475 ++++---
 drivers/lightnvm/pblk-init.c        |  389 ++++--
 drivers/lightnvm/pblk-map.c         |   75 +-
 drivers/lightnvm/pblk-rb.c          |  106 +-
 drivers/lightnvm/pblk-read.c        |   93 +-
 drivers/lightnvm/pblk-recovery.c    |  275 ++--
 drivers/lightnvm/pblk-rl.c          |   90 +-
 drivers/lightnvm/pblk-sysfs.c       |   94 +-
 drivers/lightnvm/pblk-write.c       |  353 +++--
 drivers/lightnvm/pblk.h             |  296 +++--
 drivers/lightnvm/rrpc.c             |   10 +-
 drivers/md/bcache/bcache.h          |    7 +-
 drivers/md/bcache/btree.c           |    6 +-
 drivers/md/bcache/debug.c           |    2 +-
 drivers/md/bcache/io.c              |    6 +-
 drivers/md/bcache/journal.c         |    2 +-
 drivers/md/bcache/movinggc.c        |   10 +-
 drivers/md/bcache/request.c         |   28 +-
 drivers/md/bcache/request.h         |    2 +-
 drivers/md/bcache/super.c           |   14 +-
 drivers/md/bcache/writeback.c       |    4 +-
 drivers/md/dm-bio-prison-v1.c       |    4 +-
 drivers/md/dm-bio-prison-v1.h       |    2 +-
 drivers/md/dm-bufio.c               |   28 +-
 drivers/md/dm-cache-target.c        |   36 +-
 drivers/md/dm-crypt.c               |   41 +-
 drivers/md/dm-flakey.c              |   13 +-
 drivers/md/dm-integrity.c           |   30 +-
 drivers/md/dm-io.c                  |   13 +-
 drivers/md/dm-log-writes.c          |   13 +-
 drivers/md/dm-mpath.c               |   85 +-
 drivers/md/dm-raid1.c               |   29 +-
 drivers/md/dm-rq.c                  |   30 +-
 drivers/md/dm-rq.h                  |    2 +-
 drivers/md/dm-snap.c                |   15 +-
 drivers/md/dm-stripe.c              |   17 +-
 drivers/md/dm-target.c              |    2 +-
 drivers/md/dm-thin.c                |   67 +-
 drivers/md/dm-verity-target.c       |   16 +-
 drivers/md/dm-zero.c                |    4 +-
 drivers/md/dm.c                     |   88 +-
 drivers/md/md.c                     |   14 +-
 drivers/md/multipath.c              |   10 +-
 drivers/md/raid1.c                  |   38 +-
 drivers/md/raid10.c                 |   38 +-
 drivers/md/raid5-cache.c            |    6 +-
 drivers/md/raid5-ppl.c              |    4 +-
 drivers/md/raid5.c                  |   24 +-
 drivers/memstick/core/ms_block.c    |    7 +-
 drivers/memstick/core/mspro_block.c |    8 +-
 drivers/mmc/core/block.c            |   37 +-
 drivers/mmc/core/queue.c            |    3 +-
 drivers/mtd/mtd_blkdevs.c           |   31 +-
 drivers/mtd/ubi/block.c             |    8 +-
 drivers/nvdimm/blk.c                |    5 +-
 drivers/nvdimm/btt.c                |    5 +-
 drivers/nvdimm/pmem.c               |   29 +-
 drivers/nvme/host/Kconfig           |   12 -
 drivers/nvme/host/Makefile          |    1 -
 drivers/nvme/host/core.c            |  525 ++++++--
 drivers/nvme/host/fabrics.c         |   69 +-
 drivers/nvme/host/fabrics.h         |    4 +-
 drivers/nvme/host/fc.c              |  137 +-
 drivers/nvme/host/lightnvm.c        |   18 +-
 drivers/nvme/host/nvme.h            |   42 +-
 drivers/nvme/host/pci.c             |  647 +++++----
 drivers/nvme/host/rdma.c            |  212 ++-
 drivers/nvme/host/scsi.c            | 2460 -----------------------------------
 drivers/nvme/target/admin-cmd.c     |   65 +-
 drivers/nvme/target/configfs.c      |   68 +
 drivers/nvme/target/core.c          |    3 +-
 drivers/nvme/target/discovery.c     |    4 +-
 drivers/nvme/target/fc.c            |   10 +-
 drivers/nvme/target/fcloop.c        |    2 -
 drivers/nvme/target/io-cmd.c        |    4 +-
 drivers/nvme/target/loop.c          |   67 +-
 drivers/nvme/target/nvmet.h         |    1 +
 drivers/nvme/target/rdma.c          |  102 +-
 drivers/s390/block/dasd.c           |   36 +-
 drivers/s390/block/dcssblk.c        |    2 +-
 drivers/s390/block/scm_blk.c        |    8 +-
 drivers/s390/block/scm_blk.h        |    4 +-
 drivers/s390/block/xpram.c          |    2 +-
 drivers/s390/cio/eadm_sch.c         |    6 +-
 drivers/s390/cio/scm.c              |    2 +-
 drivers/sbus/char/jsflash.c         |    5 +-
 drivers/scsi/osd/osd_initiator.c    |   29 +-
 drivers/scsi/osst.c                 |    3 +-
 drivers/scsi/scsi_error.c           |    3 +-
 drivers/scsi/scsi_lib.c             |  104 +-
 drivers/scsi/scsi_transport_sas.c   |   10 +-
 drivers/scsi/sg.c                   |    8 +-
 drivers/scsi/st.c                   |    3 +-
 drivers/target/target_core_iblock.c |   12 +-
 drivers/target/target_core_pscsi.c  |    6 +-
 fs/aio.c                            |   15 +-
 fs/block_dev.c                      |   23 +-
 fs/btrfs/btrfs_inode.h              |    3 +-
 fs/btrfs/check-integrity.c          |    4 +-
 fs/btrfs/compression.c              |   46 +-
 fs/btrfs/compression.h              |    4 +-
 fs/btrfs/ctree.h                    |    6 +-
 fs/btrfs/disk-io.c                  |   75 +-
 fs/btrfs/disk-io.h                  |   12 +-
 fs/btrfs/extent_io.c                |   27 +-
 fs/btrfs/extent_io.h                |    6 +-
 fs/btrfs/file-item.c                |   14 +-
 fs/btrfs/file.c                     |   33 +-
 fs/btrfs/inode.c                    |   82 +-
 fs/btrfs/raid56.c                   |   16 +-
 fs/btrfs/scrub.c                    |   26 +-
 fs/btrfs/volumes.c                  |   11 +-
 fs/buffer.c                         |   15 +-
 fs/crypto/bio.c                     |    2 +-
 fs/direct-io.c                      |   25 +-
 fs/ext4/file.c                      |   35 +-
 fs/ext4/page-io.c                   |   15 +-
 fs/ext4/readpage.c                  |    4 +-
 fs/f2fs/data.c                      |   10 +-
 fs/f2fs/segment.c                   |    2 +-
 fs/fcntl.c                          |   67 +
 fs/gfs2/incore.h                    |    1 -
 fs/gfs2/lops.c                      |   10 +-
 fs/gfs2/meta_io.c                   |    2 +-
 fs/gfs2/ops_fstype.c                |    4 +-
 fs/inode.c                          |    1 +
 fs/iomap.c                          |   13 +-
 fs/jfs/jfs_logmgr.c                 |    2 +-
 fs/jfs/jfs_metapage.c               |    4 +-
 fs/mpage.c                          |    4 +-
 fs/nfs/blocklayout/blocklayout.c    |    4 +-
 fs/nfsd/blocklayout.c               |    4 +-
 fs/nilfs2/segbuf.c                  |    2 +-
 fs/ocfs2/cluster/heartbeat.c        |    6 +-
 fs/open.c                           |    1 +
 fs/read_write.c                     |   12 +-
 fs/xfs/xfs_aops.c                   |    9 +-
 fs/xfs/xfs_buf.c                    |    7 +-
 fs/xfs/xfs_file.c                   |   32 +-
 fs/xfs/xfs_iomap.c                  |   22 +
 fs/xfs/xfs_super.c                  |    3 +-
 include/linux/bio.h                 |   21 +-
 include/linux/blk-mq.h              |   28 +-
 include/linux/blk_types.h           |   26 +-
 include/linux/blkdev.h              |   72 +-
 include/linux/device-mapper.h       |    4 +-
 include/linux/elevator.h            |    7 +-
 include/linux/fs.h                  |   74 +-
 include/linux/ide.h                 |    6 +-
 include/linux/iomap.h               |    1 +
 include/linux/nvme.h                |  102 +-
 include/linux/scatterlist.h         |    2 +
 include/scsi/osd_initiator.h        |    2 +-
 include/scsi/scsi_cmnd.h            |    1 +
 include/scsi/scsi_request.h         |    2 +-
 include/uapi/linux/aio_abi.h        |    2 +-
 include/uapi/linux/dm-ioctl.h       |    4 +-
 include/uapi/linux/fcntl.h          |   21 +
 include/uapi/linux/fs.h             |    4 +
 include/uapi/linux/loop.h           |    3 +
 include/uapi/linux/nbd.h            |    4 +
 kernel/power/swap.c                 |   14 +-
 kernel/trace/blktrace.c             |    4 +-
 lib/scatterlist.c                   |   35 +
 mm/filemap.c                        |   64 +-
 mm/page_io.c                        |    4 +-
 265 files changed, 5911 insertions(+), 6236 deletions(-)

And here's the merge:

commit 166a00988549e9a5dfb341e2453385fca102b57d
Merge: 4d8a991d460d a2b93775002b
Author: Jens Axboe <axboe@kernel.dk>
Date:   Thu Jun 29 18:09:58 2017 -0600

    Merge branch 'for-4.13/block' into for-4.13/merge
    
    Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --cc drivers/md/dm-io.c
index 8d5ca30f6551,81248a8a8b57..25039607f3cb
--- a/drivers/md/dm-io.c
+++ b/drivers/md/dm-io.c
@@@ -317,9 -318,9 +318,9 @@@ static void do_region(int op, int op_fl
  	else if (op == REQ_OP_WRITE_SAME)
  		special_cmd_max_sectors = q->limits.max_write_same_sectors;
  	if ((op == REQ_OP_DISCARD || op == REQ_OP_WRITE_ZEROES ||
 -	     op == REQ_OP_WRITE_SAME)  &&
 -	    special_cmd_max_sectors == 0) {
 +	     op == REQ_OP_WRITE_SAME) && special_cmd_max_sectors == 0) {
 +		atomic_inc(&io->count);
- 		dec_count(io, region, -EOPNOTSUPP);
+ 		dec_count(io, region, BLK_STS_NOTSUPP);
  		return;
  	}
  
diff --cc drivers/md/dm-raid1.c
index 4da8858856fb,3ab584b686e0..f30d8e8e9bbf
--- a/drivers/md/dm-raid1.c
+++ b/drivers/md/dm-raid1.c
@@@ -1255,26 -1253,16 +1256,26 @@@ static int mirror_end_io(struct dm_targ
  		if (!(bio->bi_opf & REQ_PREFLUSH) &&
  		    bio_op(bio) != REQ_OP_DISCARD)
  			dm_rh_dec(ms->rh, bio_record->write_region);
- 		return error;
+ 		return DM_ENDIO_DONE;
  	}
  
- 	if (error == -EOPNOTSUPP)
+ 	if (*error == BLK_STS_NOTSUPP)
 -		return DM_ENDIO_DONE;
 +		goto out;
  
- 	if ((error == -EWOULDBLOCK) && (bio->bi_opf & REQ_RAHEAD))
+ 	if (bio->bi_opf & REQ_RAHEAD)
 -		return DM_ENDIO_DONE;
 +		goto out;
  
- 	if (unlikely(error)) {
+ 	if (unlikely(*error)) {
 +		if (!bio_record->details.bi_bdev) {
 +			/*
 +			 * There wasn't enough memory to record necessary
 +			 * information for a retry or there was no other
 +			 * mirror in-sync.
 +			 */
 +			DMERR_LIMIT("Mirror read failed.");
- 			return -EIO;
++			goto out;
 +		}
 +
  		m = bio_record->m;
  
  		DMERR("Mirror read failed from %s. Trying alternative device.",
@@@ -1290,8 -1278,7 +1291,8 @@@
  			bd = &bio_record->details;
  
  			dm_bio_restore(bd, bio);
 +			bio_record->details.bi_bdev = NULL;
- 			bio->bi_error = 0;
+ 			bio->bi_status = 0;
  
  			queue_bio(ms, bio, rw);
  			return DM_ENDIO_INCOMPLETE;
@@@ -1299,10 -1286,7 +1300,10 @@@
  		DMERR("All replicated volumes dead, failing I/O");
  	}
  
 +out:
 +	bio_record->details.bi_bdev = NULL;
 +
- 	return error;
+ 	return DM_ENDIO_DONE;
  }
  
  static void mirror_presuspend(struct dm_target *ti)
diff --cc fs/block_dev.c
index 0a7404ef9335,2c5f08696fff..a7df151f8aba
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@@ -262,11 -263,8 +263,11 @@@ __blkdev_direct_IO_simple(struct kiocb 
  	if (vecs != inline_vecs)
  		kfree(vecs);
  
- 	if (unlikely(bio.bi_error))
- 		ret = bio.bi_error;
+ 	if (unlikely(bio.bi_status))
 -		return blk_status_to_errno(bio.bi_status);
++		ret = blk_status_to_errno(bio.bi_status);
 +
 +	bio_uninit(&bio);
 +
  	return ret;
  }
  

-- 
Jens Axboe
