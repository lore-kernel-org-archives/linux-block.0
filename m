Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block changes for 4.12-rc
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Message-ID: <e26dfe26-9ee7-df5a-02de-912d03e9fd54@kernel.dk>
Date: Sun, 30 Apr 2017 20:49:58 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Linus,

First branch of the core and driver block changes for 4.12. This pull
request contains:

- Add BFQ IO scheduler under the new blk-mq scheduling framework. BFQ was
  initially a fork of CFQ, but subsequently changed to implement
  fairness based on B-WF2Q+, a modified variant of WF2Q. BFQ is meant to
  be used on desktop type single drives, providing good fairness. From
  Paolo.

- Add Kyber IO scheduler. This is a full multiqueue aware scheduler,
  using a scalable token based algorithm that throttles IO based on live
  completion IO stats, similary to blk-wbt. From Omar.

- A series from Jan, moving users to separately allocated backing
  devices. This continues the work of separating backing device life
  times, solving various problems with hot removal.

- A series of updates for lightnvm, mostly from Javier. Includes a
  'pblk' target that exposes an open channel SSD as a physical block
  device.

- A series of fixes and improvements for nbd from Josef.

- A series from Omar, removing queue sharing between devices on mostly
  legacy drivers. This helps us clean up other bits, if we know that a
  queue only has a single device backing. This has been overdue for
  more than a decade.

- Fixes for the blk-stats, and improvements to unify the stats and user
  windows. This both improves blk-wbt, and enables other users to
  register a need to receive IO stats for a device. From Omar.

- blk-throttle improvements from Shaohua. This provides a scalable
  framework for implementing scalable priotization - particularly for
  blk-mq, but applicable to any type of block device. The interface is
  marked experimental for now.

- Bucketized IO stats for IO polling from Stephen Bates. This improves
  efficiency of polled workloads in the presence of mixed block size IO.

- A few fixes for opal, from Scott.

- A few pulls for NVMe, including a lot of fixes for NVMe-over-fabrics.
  From a variety of folks, mostly Sagi and James Smart.

- A series from Bart, improving our exposed info and capabilities from
  the blk-mq debugfs support.

- A series from Christoph, cleaning up how handle WRITE_ZEROES.

- A series from Christoph, cleaning up the block layer handling of how
  we track errors in a request. On top of being a nice cleanup, it also
  shrinks the size of struct request a bit.

- Removal of mg_disk and hd (sorry Linus) by Christoph. The former was
  never used by platforms, and the latter has outlived it's usefulness.

- Various little bug fixes and cleanups from a wide variety of folks.

Please pull! There will be a for-4.12/post-merge pull request right
after this one, which adds a few bits that ending up depending on later
changes in your master.


  git://git.kernel.dk/linux-block.git for-4.12/block


----------------------------------------------------------------
Adam Manzanares (1):
      block: fix inheriting request priority from bio

Arianna Avanzini (4):
      block, bfq: add full hierarchical scheduling and cgroups support
      block, bfq: add Early Queue Merge (EQM)
      block, bfq: reduce idling only in symmetric scenarios
      block, bfq: handle bursts of queue activations

Arnd Bergmann (1):
      lightnvm: assume 64-bit lba numbers

Bart Van Assche (22):
      blk-mq: Remove blk_mq_queue_data.list
      blk-mq: Make it safe to use RCU to iterate over blk_mq_tag_set.tag_list
      blk-mq: Clarify comments in blk_mq_dispatch_rq_list()
      blk-mq: Export queue state through /sys/kernel/debug/block/*/state
      blk-mq: Show symbolic names for hctx state and flags
      block: Export blk_init_request_from_bio()
      null_blk: Use blk_init_request_from_bio() instead of open-coding it
      lightnvm: Use blk_init_request_from_bio() instead of open-coding it
      block: Inline blk_rq_set_prio()
      block: Optimize ioprio_best()
      blk-mq: Remove blk_mq_sched_move_to_dispatch()
      blk-mq: Fix preempt count imbalance
      blk-mq: Register <dev>/queue/mq after having registered <dev>/queue
      blk-mq: Let blk_mq_debugfs_register() look up the queue name
      blk-mq-debugfs: Rename functions for registering and unregistering the mq directory
      blk-mq: Only unregister hctxs for which registration succeeded
      blk-mq: Unregister debugfs attributes earlier
      blk-mq: Move the "state" debugfs attribute one level down
      blk-mq: Make blk_flags_show() callers append a newline character
      blk-mq: Show operation, cmd_flags and rq_flags names
      blk-mq: Add blk_mq_ops.show_rq()
      scsi: Implement blk_mq_ops.show_rq()

Christoph Hellwig (69):
      blk-mq: remove BLK_MQ_F_DEFER_ISSUE
      blk-mq: merge mq and sq make_request instances
      blk-mq: improve blk_mq_try_issue_directly
      blk-mq: split the plug and sync cases in blk_mq_make_request
      blk-mq: streamline blk_mq_make_request
      nvme-fc: drop ctrl for all command completions
      nvme: factor request completion code into a common helper
      remove the obsolete hd driver
      nvme: move ->retries setup to nvme_setup_cmd
      nvme: cleanup nvme_req_needs_retry
      nvme: mark nvme_max_retries static
      nvme: move the retries count to struct nvme_request
      block, scsi: move the retries field to struct scsi_request
      sd: split sd_setup_discard_cmnd
      block: renumber REQ_OP_WRITE_ZEROES
      block: implement splitting of REQ_OP_WRITE_ZEROES bios
      sd: implement REQ_OP_WRITE_ZEROES
      md: support REQ_OP_WRITE_ZEROES
      dm io: discards don't take a payload
      dm: support REQ_OP_WRITE_ZEROES
      dm kcopyd: switch to use REQ_OP_WRITE_ZEROES
      block: stop using blkdev_issue_write_same for zeroing
      block: add a flags argument to (__)blkdev_issue_zeroout
      block: add a REQ_NOUNMAP flag for REQ_OP_WRITE_ZEROES
      block: add a new BLKDEV_ZERO_NOFALLBACK flag
      block_dev: use blkdev_issue_zerout for hole punches
      sd: implement unmapping Write Zeroes
      nvme: implement REQ_OP_WRITE_ZEROES
      zram: implement REQ_OP_WRITE_ZEROES
      loop: implement REQ_OP_WRITE_ZEROES
      brd: remove discard support
      rbd: remove the discard_zeroes_data flag
      rsxx: remove the discard_zeroes_data flag
      mmc: remove the discard_zeroes_data flag
      block: stop using discards for zeroing
      drbd: make intelligent use of blkdev_issue_zeroout
      drbd: implement REQ_OP_WRITE_ZEROES
      block: remove the discard_zeroes_data flag
      remove the mg_disk driver
      block: remove the osdblk driver
      block: remove blk_end_request_err and __blk_end_request_err
      block: remove blk_end_request_cur
      block: make __blk_end_bidi_request private
      pd: don't check blk_execute_rq return value.
      block: remove the blk_execute_rq return value
      nvme-fc: fix status code handling in nvme_fc_fcpio_done
      nvme: split nvme status from block req->errors
      nvme: make nvme_error_status private
      virtio: fix spelling of virtblk_scsi_request_done
      virtio_blk: don't use req->errors
      scsi: introduce a result field in struct scsi_request
      loop: zero-fill bio on the submitting cpu
      null_blk: don't pass always-0 req->errors to blk_mq_complete_request
      dm rq: don't pass irrelevant error code to blk_mq_complete_request
      dm mpath: don't check for req->errors
      nbd: don't use req->errors
      mtip32xx: add a status field to struct mtip_cmd
      xen-blkfront: don't use req->errors
      blk-mq: remove the error argument to blk_mq_complete_request
      blk-mq: simplify __blk_mq_complete_request
      block: add a error_count field to struct request
      floppy: switch from req->errors to req->error_count
      ataflop: switch from req->errors to req->error_count
      swim3: remove (commented out) printing of req->errors
      blktrace: remove the unused block_rq_abort tracepoint
      block: remove the errors field from struct request
      scsi_transport_sas: always pass 0 error to blk_end_request_all
      ide-pm: always pass 0 error to __blk_end_request_all
      ide-pm: always pass 0 error to ide_complete_rq in ide_do_devset

Christophe JAILLET (1):
      lightnvm: Fix error handling

Colin Ian King (2):
      block/sed-opal: fix spelling mistake: "Lifcycle" -> "Lifecycle"
      block, bfq: don't dereference bic before null checking it

Dan Carpenter (7):
      block: make nr_iovecs unsigned in bio_alloc_bioset()
      net: off by one in inet6_pton()
      lightnvm: pblk-gc: fix an error pointer dereference in init
      lightnvm: fix some WARN() messages
      lightnvm: fix some error code in pblk-init.c
      lightnvm: potential underflow in pblk_read_rq()
      lightnvm: don't print a warning for ADDR_EMPTY

Dan Williams (1):
      block: hide badblocks attribute by default

Eric Biggers (4):
      block: correct documentation for blkdev_issue_discard() flags
      block: remove outdated part of blkdev_issue_flush() comment
      block: constify struct blk_integrity_profile
      blk-mq: constify struct blk_mq_ops

Geliang Tang (2):
      block: floppy: use setup_timer
      mg_disk: use setup_timer

Helen Koike (1):
      nvme: improve performance for virtual NVMe devices

Ilya Dryomov (1):
      block: get rid of blk_integrity_revalidate()

James Smart (14):
      nvme_fc: Sync FC-NVME header with standard
      nvme_fc: Add check of status_code in ERSP_IU
      nvmet_fc: Sync NVME LS reject reasons with spec
      nvme_fc: correct LS validation
      nvmet_fc: Clear SG list to avoid double frees
      nvme_fc: Clean up host fcpio done status handling
      nvmet_fc: add target feature flags for upcall isr contexts
      nvmet_fc: add req_release to lldd api
      nvme_fcloop: split job struct from transport for req_release
      nvmet_fc: Rework target side abort handling
      nvmet_fc: add missing reference in add_port
      nvme_fc: Move LS's to rport
      nvme_fc: Add ls aborts on remote port teardown
      nvmet_fc: Change traddr field separator to a colon

Jan Kara (38):
      block: Fix bdi assignment to bdev inode when racing with disk delete
      bdi: Mark congested->bdi as internal
      bdi: Make wb->bdi a proper reference
      bdi: Unify bdi->wb_list handling for root wb_writeback
      bdi: Shutdown writeback on all cgwbs in cgwb_bdi_destroy()
      bdi: Do not wait for cgwbs release in bdi_unregister()
      bdi: Rename cgwb_bdi_destroy() to cgwb_bdi_unregister()
      block: Fix oops in locked_inode_to_wb_and_lock_list()
      kobject: Export kobject_get_unless_zero()
      block: Fix oops scsi_disk_get()
      cfq: Disable writeback throttling by default
      block: Fix list corruption of blk stats callback list
      block: Make writeback throttling defaults consistent for SQ devices
      bdi: Provide bdi_register_va() and bdi_alloc()
      block: Unregister bdi on last reference drop
      bdi: Export bdi_alloc_node() and bdi_put()
      fs: Provide infrastructure for dynamic BDIs in filesystems
      fs: Get proper reference for s_bdi
      lustre: Convert to separately allocated bdi
      9p: Convert to separately allocated bdi
      btrfs: Convert to separately allocated bdi
      ceph: Convert to separately allocated bdi
      cifs: Convert to separately allocated bdi
      ecryptfs: Convert to separately allocated bdi
      afs: Convert to separately allocated bdi
      mtd: Convert to dynamically allocated bdi infrastructure
      coda: Convert to separately allocated bdi
      exofs: Convert to separately allocated bdi
      fuse: Convert to separately allocated bdi
      fuse: Get rid of bdi_initialized
      gfs2: Convert to properly refcounting bdi
      nilfs2: Convert to properly refcounting bdi
      ncpfs: Convert to separately allocated bdi
      nfs: Convert to separately allocated bdi
      ubifs: Convert to separately allocated bdi
      fs: Remove SB_I_DYNBDI flag
      block: Remove unused functions
      bdi: Drop 'parent' argument from bdi_register[_va]()

Javier González (17):
      lightnvm: submit erases using the I/O path
      lightnvm: rename scrambler controller hint
      lightnvm: free reverse device map
      lightnvm: double-clear of dev->lun_map on target init error
      lightnvm: fix cleanup order of disk on init error
      lightnvm: bad type conversion for nvme control bits
      lightnvm: allow to init targets on factory mode
      lightnvm: make nvm_free static
      lightnvm: clean unused variable
      lightnvm: fix type checks on rrpc
      lightnvm: convert sprintf into strlcpy
      lightnvm: physical block device (pblk) target
      lightnvm: pblk: fix race condition on line retry
      lightnvm: pblk: fix bad error check
      lightnvm: pblk: fix memory leak on error path
      lightnvm: pblk: free metadata on line alloc failure
      lightnvm: pblk: fix erase counters on error fail

Jean Delvare (1):
      virtio_blk: Fix English description of VIRTIO_BLK_SCSI

Jens Axboe (20):
      block: fix stacked driver stats init and free
      blk-mq: fix a typo and a spelling mistake
      Revert "blkcg: allocate struct blkcg_gq outside request queue spinlock"
      blk-mq: include errors in did_work calculation
      blk-mq: fix schedule-under-preempt for blocking drivers
      null_blk: add blocking mode
      block: move timeout field in struct request to pack better
      Merge branch 'for-linus' into for-4.12/block
      Merge branch 'stable/for-jens-4.12' of git://git.kernel.org/.../konrad/xen into for-4.12/block
      bfq: fix compile error if CONFIG_CGROUPS=n
      blk-throttle: fix unused variable warning with BLK_DEV_THROTTLING_LOW=n
      blk-mq: fix schedule-while-atomic with scheduler attached
      blk-mq: add might_sleep check to blk_mq_get_driver_tag()
      blk-stat: kill blk_stat_rq_ddir()
      mtip32xx: fix dereference of stack garbage
      Merge branch 'nvme-4.12' of git://git.infradead.org/nvme into for-4.12/block
      blk-mq-sched: alloate reserved tags out of normal pool
      blk-mq: unify hctx delayed_run_work and run_work
      block: add kblock_mod_delayed_work_on()
      blk-mq: unify hctx delay_work and run_work

Josef Bacik (16):
      block-mq: don't re-queue if we get a queue error
      nbd: put socket in error cases
      nbd: handle single path failures gracefully
      nbd: separate out the config information
      nbd: stop using the bdev everywhere
      nbd: add a basic netlink interface
      nbd: add a reconfigure netlink command
      nbd: multicast dead link notifications
      nbd: only clear the queue on device teardown
      nbd: handle dead connections
      nbd: add a status netlink command
      nbd: add device refcounting
      nbd: add a flag to destroy an nbd device on disconnect
      nbd: set the max segment size to UINT_MAX
      nbd: set the max segments to USHRT_MAX
      nbd: fix use after free on module unload

Junxiong Guan (1):
      nvme: let dm-mpath distinguish nvme error codes

Keith Busch (2):
      nvme/pci: Don't set reserved SQ create flags
      nvme/pci: Poll CQ on timeout

Logan Gunthorpe (1):
      nvmet: convert from kmap to nvmet_copy_from_sgl

Marc Olson (1):
      blkfront: add uevent for size change

Martin K. Petersen (2):
      scsi: sd: Separate zeroout and discard command choices
      scsi: sd: Remove LBPRZ dependency for discards

Matias Bjørling (1):
      lightnvm: enable nvme size compile asserts

Max Gurtovoy (1):
      nvmet: use symbolic constants for log identifiers

Mike Snitzer (1):
      block: fix blk_integrity_register to use template's interval_exp if not 0

Minchan Kim (1):
      block: do not put mq context in blk_mq_alloc_request_hctx

Ming Lei (6):
      blk-mq: don't complete un-started request in timeout handler
      blk-mq: comment on races related with timeout handler
      block: add a read barrier in blk_queue_enter()
      block: rename blk_mq_freeze_queue_start()
      block: block new I/O just after queue is set as dying
      mtip32xx: use runtime tag to initialize command header

NeilBrown (3):
      block: simple improvements for bio->flags
      block: trace completion of all bios.
      lightnvm: don't check for failure from mempool_alloc()

Omar Sandoval (22):
      blk-stat: fix blk_stat_sum() if all samples are batched
      block: remove extra calls to wbt_exit()
      blk-stat: use READ and WRITE instead of BLK_STAT_{READ,WRITE}
      blk-stat: move BLK_RQ_STAT_BATCH definition to blk-stat.c
      blk-stat: convert to callback-based statistics reporting
      hd: stop sharing request queue across multiple gendisks
      parport/pd: stop sharing request queue across multiple gendisks
      parport/pcd: stop sharing request queue across multiple gendisks
      parport/pf: stop sharing request queue across multiple gendisks
      swim: stop sharing request queue across multiple gendisks
      jsflash: stop sharing request queue across multiple gendisks
      block: warn if sharing request queue across gendisks
      blk-mq: fix leak of q->stats
      block: fix leak of q->rq_wb
      blk-mq-sched: provide hooks for initializing hardware queue data
      blk-mq: make driver tag failure path easier to follow
      blk-mq: use true instead of 1 for blk_mq_queue_data.last
      sbitmap: add sbitmap_get_shallow() operation
      blk-mq: add shallow depth option for blk_mq_get_tag()
      blk-mq: export helpers
      blk-mq-sched: make completed_request() callback more useful
      blk-mq: introduce Kyber multiqueue I/O scheduler

Paolo Valente (12):
      block, bfq: introduce the BFQ-v0 I/O scheduler as an extra scheduler
      block, bfq: improve throughput boosting
      block, bfq: modify the peak-rate estimator
      block, bfq: add more fairness with writes and slow processes
      block, bfq: improve responsiveness
      block, bfq: reduce I/O latency for soft real-time applications
      block, bfq: preserve a low latency also with NCQ-capable drives
      block, bfq: reduce latency during request-pool saturation
      block, bfq: boost the throughput on NCQ-capable flash-based devices
      block, bfq: boost the throughput with random I/O on NCQ-capable HDDs
      block, bfq: remove all get and put of I/O contexts
      block, bfq: split bfq-iosched.c into multiple source files

Parav Pandit (2):
      nvmet: Fixed avoided printing nvmet: twice in error logs.
      nvmet: Introduced helper routine for controller status check.

Rakesh Pandit (2):
      ligtnvm: fix double blk_put_queue on same queue
      lightnvm: propagate pblk_init return to userspace

Sagi Grimberg (24):
      blk-mq-pci: Fix two spelling mistakes
      nvme-loop: fix a possible use-after-free when destroying the admin queue
      nvme-loop: handle cpu unplug when re-establishing the controller
      nvmet: confirm sq percpu has scheduled and switched to atomic
      nvmet-rdma: Fix a possible uninitialized variable dereference
      nvme-rdma: handle cpu unplug when re-establishing the controller
      nvmet-rdma: occasionally flush ongoing controller teardown
      nvme-rdma: Give some more grace for rdma connection establishment
      nvme-loop: remove some code duplication
      net/utils: generic inet_pton_with_scope helper
      nvmet-rdma: use generic inet_pton_with_scope
      nvme-rdma: use inet_pton_with_scope helper
      iscsi-target: use generic inet_pton_with_scope
      nvme-rdma: fix module_init (theoretical) error path
      nvme-loop: fix module_init (theoretical) error path
      nvme-fc: fix module_init (theoretical) error path
      nvme-loop: remove unneeded includes
      nvme-loop: retrieve iod from the cqe command_id
      nvme-rdma: get rid of local reconnect_delay
      nvme-fabrics: Allow ctrl loss timeout configuration
      nvme-rdma: Support ctrl_loss_tmo
      nvme-rdma: increment request retries counter before requeuing
      nvme-loop: increment request retries counter before requeuing
      nvme-fc: increment request retries counter before requeuing

Scott Bauer (2):
      block: sed-opal: Tone down all the pr_* to debugs
      nvme/lightnvm: Prevent small buffer overflow in nvme_nvm_identify

Shaohua Li (19):
      blk-throttle: use U64_MAX/UINT_MAX to replace -1
      blk-throttle: prepare support multiple limits
      blk-throttle: add configure option for new .low interface
      blk-throttle: add .low interface
      blk-throttle: configure bps/iops limit for cgroup in low limit
      blk-throttle: add upgrade logic for LIMIT_LOW state
      blk-throttle: add downgrade logic
      blk-throttle: make sure expire time isn't too big
      blk-throttle: make throtl_slice tunable
      blk-throttle: choose a small throtl_slice for SSD
      blk-throttle: detect completed idle cgroup
      blk-throttle: make bandwidth change smooth
      blk-throttle: add a simple idle detection
      blk-throttle: add interface to configure idle time threshold
      blk-throttle: ignore idle cgroup limit
      blk-throttle: add interface for per-cgroup target latency
      block: track request size in blk_issue_stat
      blk-throttle: add a mechanism to estimate IO latency
      blk-throttle: add latency target support

Stephen Bates (3):
      blk-stat: convert blk-stat bucket callback to signed
      blk-mq: Add a polling specific stats function
      blk-mq: Fix poll_stat for new size-based bucketing.

Tahsin Erdogan (2):
      blkcg: allocate struct blkcg_gq outside request queue spinlock
      blkcg: allocate struct blkcg_gq outside request queue spinlock

Ulf Hansson (1):
      MAINTAINERS: bfq: Add Paolo as maintainer for the BFQ I/O scheduler

Wei Yongjun (1):
      lightnvm: fix possible memory leak in pblk_bb_discovery()

 Documentation/ABI/testing/sysfs-block              |   10 +-
 Documentation/block/00-INDEX                       |    2 +
 Documentation/block/bfq-iosched.txt                |  531 ++
 Documentation/block/kyber-iosched.txt              |   14 +
 Documentation/block/queue-sysfs.txt                |   11 +-
 Documentation/blockdev/mflash.txt                  |   84 -
 Documentation/lightnvm/pblk.txt                    |   21 +
 MAINTAINERS                                        |    8 +
 block/Kconfig                                      |   12 +
 block/Kconfig.iosched                              |   30 +
 block/Makefile                                     |    3 +
 block/bfq-cgroup.c                                 | 1139 +++++
 block/bfq-iosched.c                                | 5047 ++++++++++++++++++++
 block/bfq-iosched.h                                |  941 ++++
 block/bfq-wf2q.c                                   | 1616 +++++++
 block/bio.c                                        |   19 +-
 block/blk-cgroup.c                                 |  123 +-
 block/blk-core.c                                   |  143 +-
 block/blk-exec.c                                   |   11 +-
 block/blk-flush.c                                  |    5 +-
 block/blk-integrity.c                              |   24 +-
 block/blk-lib.c                                    |   78 +-
 block/blk-merge.c                                  |   17 +-
 block/blk-mq-debugfs.c                             |  331 +-
 block/blk-mq-pci.c                                 |    2 +-
 block/blk-mq-sched.c                               |  103 +-
 block/blk-mq-sched.h                               |   18 +-
 block/blk-mq-sysfs.c                               |   61 +-
 block/blk-mq-tag.c                                 |    5 +-
 block/blk-mq.c                                     |  565 +--
 block/blk-mq.h                                     |   16 +-
 block/blk-settings.c                               |    3 -
 block/blk-stat.c                                   |  323 +-
 block/blk-stat.h                                   |  204 +-
 block/blk-sysfs.c                                  |   82 +-
 block/blk-throttle.c                               |  985 +++-
 block/blk-timeout.c                                |    1 -
 block/blk-wbt.c                                    |   95 +-
 block/blk-wbt.h                                    |   16 +-
 block/blk.h                                        |   15 +-
 block/bsg-lib.c                                    |    8 +-
 block/bsg.c                                        |   12 +-
 block/cfq-iosched.c                                |   17 +-
 block/compat_ioctl.c                               |    2 +-
 block/elevator.c                                   |    3 +
 block/genhd.c                                      |   13 +-
 block/ioctl.c                                      |    4 +-
 block/ioprio.c                                     |   12 +-
 block/kyber-iosched.c                              |  719 +++
 block/partition-generic.c                          |    1 -
 block/scsi_ioctl.c                                 |   23 +-
 block/sed-opal.c                                   |  153 +-
 block/t10-pi.c                                     |    8 +-
 drivers/block/Kconfig                              |   47 +-
 drivers/block/Makefile                             |    3 -
 drivers/block/ataflop.c                            |   12 +-
 drivers/block/brd.c                                |   54 -
 drivers/block/cciss.c                              |   42 +-
 drivers/block/drbd/drbd_debugfs.c                  |    3 -
 drivers/block/drbd/drbd_int.h                      |    6 -
 drivers/block/drbd/drbd_main.c                     |    5 +-
 drivers/block/drbd/drbd_nl.c                       |    9 +-
 drivers/block/drbd/drbd_receiver.c                 |  105 +-
 drivers/block/drbd/drbd_req.c                      |   13 +-
 drivers/block/drbd/drbd_worker.c                   |    4 +-
 drivers/block/floppy.c                             |   10 +-
 drivers/block/hd.c                                 |  803 ----
 drivers/block/loop.c                               |   38 +-
 drivers/block/loop.h                               |    1 +
 drivers/block/mg_disk.c                            | 1112 -----
 drivers/block/mtip32xx/mtip32xx.c                  |   58 +-
 drivers/block/mtip32xx/mtip32xx.h                  |    1 +
 drivers/block/nbd.c                                | 1417 +++++-
 drivers/block/null_blk.c                           |   22 +-
 drivers/block/osdblk.c                             |  693 ---
 drivers/block/paride/pcd.c                         |   57 +-
 drivers/block/paride/pd.c                          |   57 +-
 drivers/block/paride/pf.c                          |   57 +-
 drivers/block/pktcdvd.c                            |    2 +-
 drivers/block/rbd.c                                |    3 +-
 drivers/block/rsxx/dev.c                           |    1 -
 drivers/block/swim.c                               |   55 +-
 drivers/block/swim3.c                              |    4 +-
 drivers/block/virtio_blk.c                         |   21 +-
 drivers/block/xen-blkfront.c                       |   41 +-
 drivers/block/zram/zram_drv.c                      |   13 +-
 drivers/cdrom/cdrom.c                              |    3 +-
 drivers/ide/ide-atapi.c                            |   11 +-
 drivers/ide/ide-cd.c                               |   21 +-
 drivers/ide/ide-cd_ioctl.c                         |    3 +-
 drivers/ide/ide-devsets.c                          |    8 +-
 drivers/ide/ide-disk.c                             |    3 +-
 drivers/ide/ide-dma.c                              |    2 +-
 drivers/ide/ide-eh.c                               |   36 +-
 drivers/ide/ide-floppy.c                           |   10 +-
 drivers/ide/ide-io.c                               |   10 +-
 drivers/ide/ide-ioctls.c                           |    7 +-
 drivers/ide/ide-park.c                             |    3 +-
 drivers/ide/ide-pm.c                               |    9 +-
 drivers/ide/ide-tape.c                             |    4 +-
 drivers/ide/ide-taskfile.c                         |    8 +-
 drivers/lightnvm/Kconfig                           |    9 +
 drivers/lightnvm/Makefile                          |    5 +
 drivers/lightnvm/core.c                            |  147 +-
 drivers/lightnvm/pblk-cache.c                      |  114 +
 drivers/lightnvm/pblk-core.c                       | 1667 +++++++
 drivers/lightnvm/pblk-gc.c                         |  555 +++
 drivers/lightnvm/pblk-init.c                       |  962 ++++
 drivers/lightnvm/pblk-map.c                        |  136 +
 drivers/lightnvm/pblk-rb.c                         |  852 ++++
 drivers/lightnvm/pblk-read.c                       |  529 ++
 drivers/lightnvm/pblk-recovery.c                   |  998 ++++
 drivers/lightnvm/pblk-rl.c                         |  184 +
 drivers/lightnvm/pblk-sysfs.c                      |  507 ++
 drivers/lightnvm/pblk-write.c                      |  414 ++
 drivers/lightnvm/pblk.h                            | 1121 +++++
 drivers/lightnvm/rrpc.c                            |   25 +-
 drivers/md/dm-cache-target.c                       |    1 -
 drivers/md/dm-core.h                               |    1 +
 drivers/md/dm-crypt.c                              |    1 -
 drivers/md/dm-io.c                                 |   18 +-
 drivers/md/dm-kcopyd.c                             |    6 +-
 drivers/md/dm-linear.c                             |    1 +
 drivers/md/dm-mpath.c                              |    3 +-
 drivers/md/dm-raid.c                               |    6 +-
 drivers/md/dm-raid1.c                              |    1 -
 drivers/md/dm-rq.c                                 |   15 +-
 drivers/md/dm-stripe.c                             |    2 +
 drivers/md/dm-table.c                              |   49 +-
 drivers/md/dm-thin.c                               |    2 -
 drivers/md/dm.c                                    |   32 +-
 drivers/md/linear.c                                |    1 +
 drivers/md/md.h                                    |    7 +
 drivers/md/multipath.c                             |    1 +
 drivers/md/raid0.c                                 |    2 +
 drivers/md/raid1.c                                 |    4 +-
 drivers/md/raid10.c                                |    1 +
 drivers/md/raid5.c                                 |   53 +-
 drivers/mmc/core/queue.c                           |    2 -
 drivers/mtd/mtdcore.c                              |   23 +-
 drivers/mtd/mtdsuper.c                             |    6 +-
 drivers/mtd/ubi/block.c                            |    2 +-
 drivers/nvme/host/core.c                           |   94 +-
 drivers/nvme/host/fabrics.c                        |   28 +
 drivers/nvme/host/fabrics.h                        |   10 +
 drivers/nvme/host/fc.c                             |  223 +-
 drivers/nvme/host/lightnvm.c                       |   49 +-
 drivers/nvme/host/nvme.h                           |   48 +-
 drivers/nvme/host/pci.c                            |  223 +-
 drivers/nvme/host/rdma.c                           |  154 +-
 drivers/nvme/target/admin-cmd.c                    |   31 +-
 drivers/nvme/target/core.c                         |   21 +-
 drivers/nvme/target/discovery.c                    |   19 +-
 drivers/nvme/target/fabrics-cmd.c                  |   36 +-
 drivers/nvme/target/fc.c                           |  274 +-
 drivers/nvme/target/fcloop.c                       |  197 +-
 drivers/nvme/target/io-cmd.c                       |   24 +-
 drivers/nvme/target/loop.c                         |   92 +-
 drivers/nvme/target/nvmet.h                        |   11 +-
 drivers/nvme/target/rdma.c                         |   47 +-
 drivers/sbus/char/jsflash.c                        |   50 +-
 drivers/scsi/Makefile                              |    1 +
 drivers/scsi/lpfc/lpfc_nvmet.c                     |  126 +-
 drivers/scsi/lpfc/lpfc_nvmet.h                     |    7 +-
 drivers/scsi/osd/osd_initiator.c                   |    9 +-
 drivers/scsi/osst.c                                |    4 +-
 drivers/scsi/qla2xxx/qla_bsg.c                     |    6 +-
 drivers/scsi/scsi_debugfs.c                        |   13 +
 drivers/scsi/scsi_debugfs.h                        |    4 +
 drivers/scsi/scsi_error.c                          |    2 +-
 drivers/scsi/scsi_lib.c                            |   25 +-
 drivers/scsi/scsi_transport_sas.c                  |    4 +-
 drivers/scsi/sd.c                                  |  259 +-
 drivers/scsi/sd.h                                  |    8 +
 drivers/scsi/sd_zbc.c                              |    1 +
 drivers/scsi/sg.c                                  |    4 +-
 drivers/scsi/st.c                                  |    8 +-
 .../staging/lustre/lustre/include/lustre_disk.h    |    4 -
 drivers/staging/lustre/lustre/llite/llite_lib.c    |   24 +-
 drivers/target/iscsi/iscsi_target_configfs.c       |   46 +-
 drivers/target/target_core_device.c                |    2 +-
 drivers/target/target_core_pscsi.c                 |    4 +-
 fs/9p/v9fs.c                                       |   10 +-
 fs/9p/v9fs.h                                       |    1 -
 fs/9p/vfs_super.c                                  |   15 +-
 fs/afs/internal.h                                  |    1 -
 fs/afs/super.c                                     |    5 +-
 fs/afs/volume.c                                    |    8 -
 fs/block_dev.c                                     |   28 +-
 fs/btrfs/ctree.h                                   |    1 -
 fs/btrfs/disk-io.c                                 |   36 +-
 fs/btrfs/super.c                                   |    7 +
 fs/ceph/addr.c                                     |    6 +-
 fs/ceph/debugfs.c                                  |    2 +-
 fs/ceph/super.c                                    |   35 +-
 fs/ceph/super.h                                    |    2 -
 fs/cifs/cifs_fs_sb.h                               |    1 -
 fs/cifs/cifsfs.c                                   |    7 +-
 fs/cifs/connect.c                                  |   10 -
 fs/coda/inode.c                                    |   11 +-
 fs/dax.c                                           |    2 +-
 fs/ecryptfs/ecryptfs_kernel.h                      |    1 -
 fs/ecryptfs/main.c                                 |    4 +-
 fs/exofs/exofs.h                                   |    1 -
 fs/exofs/super.c                                   |   17 +-
 fs/fuse/dev.c                                      |   13 +-
 fs/fuse/fuse_i.h                                   |    6 -
 fs/fuse/inode.c                                    |   42 +-
 fs/gfs2/ops_fstype.c                               |    8 +-
 fs/ncpfs/inode.c                                   |    8 +-
 fs/ncpfs/ncp_fs_sb.h                               |    1 -
 fs/nfs/client.c                                    |   10 -
 fs/nfs/internal.h                                  |    6 +-
 fs/nfs/super.c                                     |   33 +-
 fs/nfs/write.c                                     |   13 +-
 fs/nfsd/blocklayout.c                              |    7 +-
 fs/nilfs2/super.c                                  |    2 +-
 fs/super.c                                         |   53 +-
 fs/ubifs/super.c                                   |   25 +-
 fs/ubifs/ubifs.h                                   |    3 -
 fs/xfs/xfs_bmap_util.c                             |    2 +-
 include/linux/backing-dev-defs.h                   |    8 +-
 include/linux/backing-dev.h                        |   16 +-
 include/linux/bio.h                                |    2 +-
 include/linux/blk-mq.h                             |   21 +-
 include/linux/blk_types.h                          |   47 +-
 include/linux/blkdev.h                             |   76 +-
 include/linux/coda_psdev.h                         |    1 -
 include/linux/device-mapper.h                      |   11 +-
 include/linux/elevator.h                           |    4 +-
 include/linux/fs.h                                 |    3 +
 include/linux/genhd.h                              |   12 +-
 include/linux/ide.h                                |    2 +-
 include/linux/inet.h                               |    6 +
 include/linux/kobject.h                            |    2 +
 include/linux/lightnvm.h                           |   13 +-
 include/linux/mg_disk.h                            |   45 -
 include/linux/mtd/mtd.h                            |    5 -
 include/linux/nfs_fs_sb.h                          |    1 -
 include/linux/nvme-fc-driver.h                     |  104 +-
 include/linux/nvme-fc.h                            |   68 +-
 include/linux/nvme.h                               |   13 +
 include/linux/sbitmap.h                            |   55 +
 include/linux/t10-pi.h                             |    8 +-
 include/linux/writeback.h                          |    1 +
 include/scsi/scsi_request.h                        |    2 +
 include/trace/events/block.h                       |   61 +-
 include/uapi/linux/lightnvm.h                      |    4 +
 include/uapi/linux/nbd-netlink.h                   |   98 +
 include/uapi/linux/nbd.h                           |    6 +-
 kernel/trace/blktrace.c                            |   35 +-
 lib/kobject.c                                      |    5 +-
 lib/sbitmap.c                                      |   75 +-
 mm/backing-dev.c                                   |  186 +-
 net/core/utils.c                                   |  103 +
 255 files changed, 24643 insertions(+), 6152 deletions(-)
 create mode 100644 Documentation/block/bfq-iosched.txt
 create mode 100644 Documentation/block/kyber-iosched.txt
 delete mode 100644 Documentation/blockdev/mflash.txt
 create mode 100644 Documentation/lightnvm/pblk.txt
 create mode 100644 block/bfq-cgroup.c
 create mode 100644 block/bfq-iosched.c
 create mode 100644 block/bfq-iosched.h
 create mode 100644 block/bfq-wf2q.c
 create mode 100644 block/kyber-iosched.c
 delete mode 100644 drivers/block/hd.c
 delete mode 100644 drivers/block/mg_disk.c
 delete mode 100644 drivers/block/osdblk.c
 create mode 100644 drivers/lightnvm/pblk-cache.c
 create mode 100644 drivers/lightnvm/pblk-core.c
 create mode 100644 drivers/lightnvm/pblk-gc.c
 create mode 100644 drivers/lightnvm/pblk-init.c
 create mode 100644 drivers/lightnvm/pblk-map.c
 create mode 100644 drivers/lightnvm/pblk-rb.c
 create mode 100644 drivers/lightnvm/pblk-read.c
 create mode 100644 drivers/lightnvm/pblk-recovery.c
 create mode 100644 drivers/lightnvm/pblk-rl.c
 create mode 100644 drivers/lightnvm/pblk-sysfs.c
 create mode 100644 drivers/lightnvm/pblk-write.c
 create mode 100644 drivers/lightnvm/pblk.h
 create mode 100644 drivers/scsi/scsi_debugfs.c
 create mode 100644 drivers/scsi/scsi_debugfs.h
 delete mode 100644 include/linux/mg_disk.h
 create mode 100644 include/uapi/linux/nbd-netlink.h

-- 
Jens Axboe
