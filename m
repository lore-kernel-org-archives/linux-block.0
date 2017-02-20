Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block pull request for- 4.11-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <dea6290e-0cfa-a93d-b03d-f6f3cd74d20f@kernel.dk>
Date: Sun, 19 Feb 2017 17:10:48 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

Hi Linus,

This is the collected pull request for 4.11 for the block core and
drivers. It's really two different branches:

	for-4.11/block-signed
	for-4.11/next-signed

for-4.11/next exists because some of Christoph's patch series were based
on patches that were added after for-4.11/block was forked off, which
would have caused needless merge pain. So for-4.11/next was forked off
v4.10-rc5, with for-4.11/block pulled in. Feel free to pull each of
these in succession instead of this pre-merged branch. Note that if you
do opt for pulling the two branches, for-4.11/block will throw a trivial
merge conflict in block/blk-mq.c, where you need to delete a function.
for-4.11/next merges cleanly, HOWEVER, a commit that was added in
mainline since v4.10-rc5 (f2e767bb5d6e) adds a line of code that is no
longer valid with the changes in for-4.11/next. Hence, if you do pull in
separately, you'll want to --no-commit and edit:

	drivers/scsi/mpt3sas/mpt3sas_scsih.c

to fix up that one line, like I did in the for-4.11/linus-merge branch.


With that said, this pull request contains:

- blk-mq scheduling framework from me and Omar, with a port of the
  deadline scheduler for this framework. A port of BFQ from Paolo
  is in the works, and should be ready for 4.12.

- Various fixups and improvements to the above scheduling framework
  from Omar, Paolo, Bart, me, others.

- Cleanup of the exported sysfs blk-mq data into debugfs, from
  Omar. This allows us to export more information that helps
  debug hangs or performance issues, without cluttering or
  abusing the sysfs API.

- Fixes for the sbitmap code, the scalable bitmap code that was
  migrated from blk-mq, from Omar.

- Removal of the BLOCK_PC support in struct request, and refactoring of
  carrying SCSI payloads in the block layer. This cleans up the code
  nicely, and enables us to kill the SCSI specific parts of struct
  request, shrinking it down nicely. From Christoph mainly, with help
  from Hannes.

- Support for ranged discard requests and discard merging, also from
  Christoph.

- Support for OPAL in the block layer, and for NVMe as well. Mainly
  from Scott Bauer, with fixes/updates from various others folks.

- Error code fixup for gdrom from Christophe.

- cciss pci irq allocation cleanup from Christoph.

- Making the cdrom device operations read only, from Kees Cook.

- Fixes for duplicate bdi registrations and bdi/queue life time
  problems from Jan and Dan.

- Set of fixes and updates for lightnvm, from Matias and Javier.

- A few fixes for nbd from Josef, using idr to name devices and
  a workqueue deadlock fix on receive. Also marks Josef as the
  current maintainer of nbd.

- Fix from Josef, overwriting queue settings when the number of
  hardware queues is updated for a blk-mq device.

- NVMe fix from Keith, ensuring that we don't repeatedly mark
  and IO aborted, if we didn't end up aborting it.

- SG gap merging fix from Ming Lei for block.

- Loop fix also from Ming, fixing a race and crash between setting
  loop status and IO.

- Two block race fixes from Tahsin, fixing request list iteration
  and fixing a race between device registration and udev device add
  notifiations.

- Double free fix from cgroup writeback, from Tejun.

- Another double free fix in blkcg, from Hou Tao.

- Partition overflow fix for EFI from Alden Tondettar.

Please pull! Either this pre-merged branch:


  git://git.kernel.dk/linux-block.git for-4.11/linus-merge-signed


or


  git://git.kernel.dk/linux-block.git for-4.11/block-signed
  git://git.kernel.dk/linux-block.git for-4.11/next-signed


in that order. All branches are signed tags.


----------------------------------------------------------------
Alden Tondettar (1):
      partitions/efi: Fix integer overflow in GPT size calculation

Alexander Potapenko (1):
      block: Initialize cfqq->ioprio_class in cfq_get_queue()

Bart Van Assche (5):
      blk-mq-debugfs: Add missing __acquires() / __releases() annotations
      blk-mq-debug: Avoid that sparse complains about req_flags_t usage
      blk-mq-debug: Make show() operations interruptible
      blk-mq-debug: Introduce debugfs_create_files()
      block: Update comments that refer to __bio_map_user() and bio_map_user()

Christoph Hellwig (39):
      block: add a op_is_flush helper
      md: cleanup bio op / flags handling in raid1_write_request
      block: fix elevator init check
      block: simplify blk_init_allocated_queue
      block: allow specifying size for extra command data
      block: cleanup tracing
      dm: remove incomplete BLOCK_PC support
      dm: always defer request allocation to the owner of the request_queue
      scsi: remove gfp_flags member in scsi_host_cmd_pool
      scsi: respect unchecked_isa_dma for blk-mq
      scsi: remove scsi_cmd_dma_pool
      scsi: remove __scsi_alloc_queue
      scsi: allocate scsi_cmnd structures as part of struct request
      block/bsg: move queue creation into bsg_setup_queue
      block: split scsi_request out of struct request
      block: don't assign cmd_flags in __blk_rq_prep_clone
      nvme/scsi: don't rely on BLK_MAX_CDB
      skd: implement trivial scsi ioctls directly
      block: make scsi_request and scsi ioctl support optional
      virtio_blk: remove struct request backpointer from virtblk_req
      virtio_blk: make SCSI passthrough support configurable
      scm_blk: remove unneeded REQ_TYPE_FS check
      ѕd: remove pointless REQ_TYPE_FS check
      mmc: remove pointless request type check in mmc_prep_request
      ms_block: remove pointless prep_fn
      mspro_block: remove pointless prep_fn
      nbd: remove REQ_TYPE_DRV_PRIV leftovers
      nbd: move request validity checking into nbd_send_cmd
      block: introduce blk_rq_is_passthrough
      ide: don't abuse cmd_type
      block: fold cmd_type into the REQ_OP_ space
      dm: don't allow ioctls to targets that don't map to whole devices
      block: move req_set_nomerge to blk.h
      block: enumify ELEVATOR_*_MERGE
      block: optionally merge discontiguous discard bios into a single request
      nvme: support ranged discard requests
      cciss: switch to pci_irq_alloc_vectors
      block/sed-opal: tone down not supported warnings
      block/sed-opal: allocate struct opal_dev dynamically

Christophe JAILLET (1):
      gdrom: Add missing error code

Dan Williams (1):
      scsi, block: fix duplicate bdi name registration crashes

Hannes Reinecke (3):
      scsi_dh_rdac: switch to scsi_execute_req_flags()
      scsi_dh_emc: switch to scsi_execute_req_flags()
      scsi_dh_hp_sw: switch to scsi_execute_req_flags()

Hou Tao (1):
      blkcg: fix double free of new_blkg in blkcg_init_queue

Jan Kara (5):
      block: Unhash block device inodes on gendisk destruction
      block: Use pointer to backing_dev_info from request_queue
      block: Dynamically allocate and refcount backing_dev_info
      block: Make blk_get_backing_dev_info() safe without open bdev
      block: Get rid of blk_get_backing_dev_info()

Javier González (3):
      lightnvm: Add CRC read error
      lightnvm: free properly on target creation error
      lightnvm: allow targets to use sysfs

Jens Axboe (43):
      blk-mq: make mq_ops a const pointer
      block: move existing elevator ops to union
      block: move rq_ioc() to blk.h
      blk-mq: un-export blk_mq_free_hctx_request()
      blk-mq: export some helpers we need to the scheduling framework
      blk-mq-tag: cleanup the normal/reserved tag allocation
      blk-mq: abstract out helpers for allocating/freeing tag maps
      blk-mq: add support for carrying internal tag information in blk_qc_t
      blk-mq: split tag ->rqs[] into two
      blk-mq-sched: add framework for MQ capable IO schedulers
      mq-deadline: add blk-mq adaptation of the deadline IO scheduler
      blk-mq-sched: allow setting of default IO scheduler
      blk-cgroup: ensure that we clear the stop bit on quiesced queues
      blk-cgroup: don't quiesce the queue on policy activate/deactivate
      elevator: fix unnecessary put of elevator in failure case
      blk-mq-tag: remove redundant check for 'data->hctx' being non-NULL
      blk-mq: stop hardware queue in blk_mq_delay_queue()
      blk-mq: allow resize of scheduler requests
      blk-mq: only apply active queue tag throttling for driver tags
      blk-mq: don't lose flags passed in to blk_mq_alloc_request()
      blk-mq-sched: check for successful allocation before assigning tag
      blk-mq: improve scheduler queue sync/async running
      blk-mq: fix potential race in queue restart and driver tag allocation
      blk-mq: release driver tag on a requeue event
      blk-mq-sched: fix starvation for multiple hardware queues and shared tags
      blk-mq-sched: change ->dispatch_requests() to ->dispatch_request()
      blk-mq-sched: add flush insertion into blk_mq_sched_insert_request()
      block: cleanup remaining manual checks for PREFLUSH|FUA
      Merge branch 'for-4.11/block' into for-4.11/rq-refactor
      nvme: fix compilation of scsi component
      block: move internal_tag to same cache line as tag
      blk-mq: don't fail allocating driver tag for stopped hw queue
      zram_drv: update for backing dev info changes
      blk-merge: return the merged request
      block: free merged request in the caller
      elevator: fix loading wrong elevator type for blk-mq devices
      blk-mq: have blk_mq_dispatch_rq_list() return if we queued IO or not
      blk-mq-sched: don't add flushes to the head of requeue queue
      blk-mq: don't special case flush inserts for blk-mq-sched
      blk-mq-sched: ask scheduler for work, if we failed dispatching leftovers
      block: don't defer flushes on blk-mq + scheduling
      Merge branch 'for-4.11/block' into for-4.11/linus-merge
      Merge branch 'for-4.11/next' into for-4.11/linus-merge

Josef Bacik (4):
      MAINTAINERS: Update maintainer entry for NBD
      nbd: use our own workqueue for recv threads
      nbd: use an idr to keep track of nbd devices
      block: set make_request_fn manually in blk_mq_update_nr_hw_queues

Kees Cook (1):
      cdrom: Make device operations read-only

Keith Busch (1):
      nvme/pci: Don't mark IOD as aborted if abort wasn't sent

Markus Elfring (2):
      blk-throttle: Adjust two function calls together with a variable assignment
      cfq-iosched: Adjust one function call together with a variable assignment

Matias Bjørling (11):
      lightnvm: merge gennvm with core
      lightnvm: collapse nvm_erase_ppa and nvm_erase_blk
      lightnvm: remove nvm_submit_ppa* functions
      lightnvm: remove nvm_get_bb_tbl and nvm_set_bb_tbl
      lightnvm: make nvm_map_* return void
      lightnvm: cleanup nvm transformation functions
      lightnvm: reduce number of nvm_id groups to one
      lightnvm: add ioctls for vector I/Os
      lightnvm: use end_io callback instead of instance
      lightnvm: fix off-by-one error on target initialization
      lightnvm: set default lun range when no luns are specified

Ming Lei (2):
      block: relax check on sg gap
      block/loop: fix race between I/O and set_status

Omar Sandoval (22):
      sbitmap: use smp_mb__after_atomic() in sbq_wake_up()
      sbitmap: fix wakeup hang after sbq resize
      blk-mq: create debugfs directory tree
      blk-mq: add hctx->{state,flags} to debugfs
      blk-mq: move hctx->dispatch and ctx->rq_list from sysfs to debugfs
      blk-mq: add extra request information to debugfs
      sbitmap: add helpers for dumping to a seq_file
      blk-mq: export software queue pending map to debugfs
      blk-mq: move tags and sched_tags info from sysfs to debugfs
      blk-mq: add tags and sched_tags bitmaps to debugfs
      blk-mq: move hctx io_poll, stats, and dispatched from sysfs to debugfs
      blk-mq: move hctx and ctx counters from sysfs to debugfs
      blk-mq: fix debugfs compilation issues
      debugfs: add debugfs_lookup()
      block: fix debugfs config conditional in struct request_queue
      blktrace: make do_blk_trace_setup() static
      block: use same block debugfs directory for blk-mq and blktrace
      blk-mq: move debugfs_remove() of disk dir to blk_release_queue()
      blktrace: use existing disk debugfs directory
      blk-mq-sched: bypass the scheduler for flushes entirely
      blk-mq-sched: (un)register elevator when (un)registering queue
      blk-mq-sched: don't hold queue_lock when calling exit_icq

Paolo Valente (1):
      blk-mq: pass bio to blk_mq_sched_get_rq_priv

Scott Bauer (8):
      Include: Uapi: Add user ABI for Sed/Opal
      block: Add Sed-opal library
      nvme: Add Support for Opal: Unlock from S3 & Opal Allocation/Ioctls
      Fix SED-OPAL UAPI structs to prevent 32/64 bit size differences.
      uapi: sed-opal fix IOW for activate lsp to use correct struct
      Move stack parameters for sed_ioctl to prevent oversized stack with CONFIG_KASAN
      Maintainers: Modify SED list from nvme to block
      nvme: Check for Security send/recv support before issuing commands.

Tahsin Erdogan (2):
      block: queue lock must be acquired when iterating over rls
      block: do not allow updates through sysfs until registration completes

Tejun Heo (1):
      block: fix double-free in the failure path of cgwb_bdi_init()

Vlastimil Babka (1):
      floppy: replace wrong kmalloc(GFP_USER) with GFP_KERNEL

 Documentation/cdrom/cdrom-standard.tex      |    9 +-
 MAINTAINERS                                 |   15 +-
 block/Kconfig                               |   24 +
 block/Kconfig.iosched                       |   50 +
 block/Makefile                              |   10 +-
 block/bio.c                                 |   16 +-
 block/blk-cgroup.c                          |   32 +-
 block/blk-core.c                            |  355 ++--
 block/blk-exec.c                            |   22 +-
 block/blk-flush.c                           |   26 +-
 block/blk-integrity.c                       |    4 +-
 block/blk-ioc.c                             |   34 +-
 block/blk-map.c                             |   13 +-
 block/blk-merge.c                           |   62 +-
 block/blk-mq-debugfs.c                      |  772 +++++++++
 block/blk-mq-sched.c                        |  515 ++++++
 block/blk-mq-sched.h                        |  143 ++
 block/blk-mq-sysfs.c                        |  235 +--
 block/blk-mq-tag.c                          |  190 +-
 block/blk-mq-tag.h                          |   10 +-
 block/blk-mq.c                              |  590 ++++---
 block/blk-mq.h                              |   72 +
 block/blk-settings.c                        |   22 +-
 block/blk-sysfs.c                           |   68 +-
 block/blk-tag.c                             |    1 +
 block/blk-throttle.c                        |    6 +-
 block/blk-wbt.c                             |    8 +-
 block/blk.h                                 |   47 +-
 block/bsg-lib.c                             |   49 +-
 block/bsg.c                                 |   64 +-
 block/cfq-iosched.c                         |   14 +-
 block/compat_ioctl.c                        |    7 +-
 block/deadline-iosched.c                    |   14 +-
 block/elevator.c                            |  267 ++-
 block/genhd.c                               |   25 +-
 block/ioctl.c                               |    7 +-
 block/mq-deadline.c                         |  556 ++++++
 block/noop-iosched.c                        |    2 +-
 block/opal_proto.h                          |  452 +++++
 block/partitions/efi.c                      |   17 +-
 block/scsi_ioctl.c                          |   83 +-
 block/sed-opal.c                            | 2488 +++++++++++++++++++++++++++
 drivers/ata/libata-scsi.c                   |    4 +-
 drivers/block/Kconfig                       |   13 +
 drivers/block/aoe/aoeblk.c                  |    4 +-
 drivers/block/cciss.c                       |  131 +-
 drivers/block/cciss.h                       |    6 +-
 drivers/block/drbd/drbd_main.c              |    6 +-
 drivers/block/drbd/drbd_nl.c                |   12 +-
 drivers/block/drbd/drbd_proc.c              |    2 +-
 drivers/block/drbd/drbd_req.c               |    2 +-
 drivers/block/floppy.c                      |    6 +-
 drivers/block/hd.c                          |   45 +-
 drivers/block/loop.c                        |   17 +-
 drivers/block/mg_disk.c                     |   31 +-
 drivers/block/nbd.c                         |  258 +--
 drivers/block/null_blk.c                    |   10 +-
 drivers/block/osdblk.c                      |    6 -
 drivers/block/paride/Kconfig                |    1 +
 drivers/block/paride/pcd.c                  |    2 +-
 drivers/block/paride/pd.c                   |   15 +-
 drivers/block/pktcdvd.c                     |   12 +-
 drivers/block/ps3disk.c                     |   15 +-
 drivers/block/rbd.c                         |   24 +-
 drivers/block/skd_main.c                    |   15 +-
 drivers/block/sx8.c                         |    4 +-
 drivers/block/virtio_blk.c                  |  205 ++-
 drivers/block/xen-blkfront.c                |    2 +-
 drivers/block/xsysace.c                     |    2 +-
 drivers/block/zram/zram_drv.c               |    2 +-
 drivers/cdrom/cdrom.c                       |   92 +-
 drivers/cdrom/gdrom.c                       |   41 +-
 drivers/ide/Kconfig                         |    1 +
 drivers/ide/ide-atapi.c                     |   78 +-
 drivers/ide/ide-cd.c                        |  192 ++-
 drivers/ide/ide-cd_ioctl.c                  |    5 +-
 drivers/ide/ide-cd_verbose.c                |    6 +-
 drivers/ide/ide-devsets.c                   |   13 +-
 drivers/ide/ide-disk.c                      |   12 +-
 drivers/ide/ide-eh.c                        |    8 +-
 drivers/ide/ide-floppy.c                    |   37 +-
 drivers/ide/ide-io.c                        |   13 +-
 drivers/ide/ide-ioctls.c                    |   14 +-
 drivers/ide/ide-park.c                      |   20 +-
 drivers/ide/ide-pm.c                        |   20 +-
 drivers/ide/ide-probe.c                     |   36 +-
 drivers/ide/ide-tape.c                      |   41 +-
 drivers/ide/ide-taskfile.c                  |    8 +-
 drivers/ide/sis5513.c                       |    2 +-
 drivers/lightnvm/Kconfig                    |    9 -
 drivers/lightnvm/Makefile                   |    3 +-
 drivers/lightnvm/core.c                     | 1027 ++++++-----
 drivers/lightnvm/gennvm.c                   |  657 -------
 drivers/lightnvm/gennvm.h                   |   62 -
 drivers/lightnvm/rrpc.c                     |    7 +-
 drivers/lightnvm/rrpc.h                     |    3 -
 drivers/lightnvm/sysblk.c                   |  733 --------
 drivers/md/bcache/request.c                 |   12 +-
 drivers/md/bcache/super.c                   |    8 +-
 drivers/md/dm-cache-target.c                |   15 +-
 drivers/md/dm-core.h                        |    1 -
 drivers/md/dm-era-target.c                  |    2 +-
 drivers/md/dm-mpath.c                       |  132 +-
 drivers/md/dm-rq.c                          |  268 +--
 drivers/md/dm-rq.h                          |    2 +-
 drivers/md/dm-table.c                       |    2 +-
 drivers/md/dm-target.c                      |    7 -
 drivers/md/dm-thin.c                        |   15 +-
 drivers/md/dm.c                             |   49 +-
 drivers/md/dm.h                             |    3 +-
 drivers/md/linear.c                         |    2 +-
 drivers/md/md.c                             |    6 +-
 drivers/md/multipath.c                      |    2 +-
 drivers/md/raid0.c                          |    6 +-
 drivers/md/raid1.c                          |   11 +-
 drivers/md/raid10.c                         |   10 +-
 drivers/md/raid5.c                          |   12 +-
 drivers/memstick/core/ms_block.c            |   11 -
 drivers/memstick/core/mspro_block.c         |   13 -
 drivers/message/fusion/mptsas.c             |    8 +-
 drivers/mmc/core/queue.c                    |    9 -
 drivers/mtd/mtd_blkdevs.c                   |   13 +-
 drivers/mtd/ubi/block.c                     |   15 +-
 drivers/nvme/host/core.c                    |   86 +-
 drivers/nvme/host/fc.c                      |    2 +-
 drivers/nvme/host/lightnvm.c                |  315 +++-
 drivers/nvme/host/nvme.h                    |   13 +
 drivers/nvme/host/pci.c                     |   19 +-
 drivers/nvme/host/rdma.c                    |    6 +-
 drivers/nvme/host/scsi.c                    |    7 +-
 drivers/nvme/target/loop.c                  |    2 +-
 drivers/s390/block/scm_blk.c                |    7 -
 drivers/scsi/Kconfig                        |    1 +
 drivers/scsi/device_handler/scsi_dh_emc.c   |  247 +--
 drivers/scsi/device_handler/scsi_dh_hp_sw.c |  222 +--
 drivers/scsi/device_handler/scsi_dh_rdac.c  |  174 +-
 drivers/scsi/hosts.c                        |   24 +-
 drivers/scsi/hpsa.c                         |    4 +-
 drivers/scsi/libfc/fc_lport.c               |    2 +-
 drivers/scsi/libsas/sas_expander.c          |    8 +-
 drivers/scsi/libsas/sas_host_smp.c          |   38 +-
 drivers/scsi/mpt3sas/mpt3sas_scsih.c        |    2 +-
 drivers/scsi/mpt3sas/mpt3sas_transport.c    |    8 +-
 drivers/scsi/osd/osd_initiator.c            |   22 +-
 drivers/scsi/osst.c                         |   18 +-
 drivers/scsi/qla2xxx/qla_bsg.c              |    2 +-
 drivers/scsi/qla2xxx/qla_isr.c              |    6 +-
 drivers/scsi/qla2xxx/qla_mr.c               |    2 +-
 drivers/scsi/scsi.c                         |  354 +---
 drivers/scsi/scsi_error.c                   |   43 +-
 drivers/scsi/scsi_lib.c                     |  264 ++-
 drivers/scsi/scsi_priv.h                    |    5 +-
 drivers/scsi/scsi_transport_fc.c            |   34 +-
 drivers/scsi/scsi_transport_iscsi.c         |   14 +-
 drivers/scsi/scsi_transport_sas.c           |    5 +
 drivers/scsi/sd.c                           |   48 +-
 drivers/scsi/sg.c                           |   33 +-
 drivers/scsi/smartpqi/smartpqi_init.c       |    2 +-
 drivers/scsi/sr.c                           |   11 +-
 drivers/scsi/st.c                           |   28 +-
 drivers/scsi/sun3_scsi.c                    |    2 +-
 drivers/target/Kconfig                      |    1 +
 drivers/target/target_core_pscsi.c          |   14 +-
 fs/block_dev.c                              |   22 +
 fs/btrfs/disk-io.c                          |    2 +-
 fs/btrfs/volumes.c                          |    2 +-
 fs/debugfs/inode.c                          |   36 +
 fs/gfs2/ops_fstype.c                        |    2 +-
 fs/nfsd/Kconfig                             |    1 +
 fs/nfsd/blocklayout.c                       |   19 +-
 fs/nilfs2/super.c                           |    2 +-
 fs/super.c                                  |    2 +-
 fs/xfs/xfs_buf.c                            |    3 +-
 fs/xfs/xfs_buf.h                            |    1 -
 include/linux/backing-dev-defs.h            |    2 +
 include/linux/backing-dev.h                 |   12 +-
 include/linux/blk-mq.h                      |    9 +-
 include/linux/blk_types.h                   |   38 +-
 include/linux/blkdev.h                      |  124 +-
 include/linux/blktrace_api.h                |   18 +-
 include/linux/bsg-lib.h                     |    5 +-
 include/linux/cdrom.h                       |    5 +-
 include/linux/debugfs.h                     |    8 +
 include/linux/device-mapper.h               |    3 -
 include/linux/elevator.h                    |   63 +-
 include/linux/fs.h                          |    2 +
 include/linux/genhd.h                       |    8 +
 include/linux/ide.h                         |   58 +-
 include/linux/lightnvm.h                    |  138 +-
 include/linux/nvme.h                        |    3 +
 include/linux/sbitmap.h                     |   30 +
 include/linux/sed-opal.h                    |   70 +
 include/scsi/scsi_cmnd.h                    |    4 +-
 include/scsi/scsi_host.h                    |    5 -
 include/scsi/scsi_request.h                 |   30 +
 include/scsi/scsi_transport.h               |    2 +
 include/trace/events/block.h                |   27 +-
 include/uapi/linux/lightnvm.h               |   50 +
 include/uapi/linux/sed-opal.h               |  119 ++
 kernel/trace/blktrace.c                     |   78 +-
 lib/sbitmap.c                               |  139 +-
 mm/backing-dev.c                            |   43 +-
 mm/page-writeback.c                         |    4 +-
 203 files changed, 9729 insertions(+), 5577 deletions(-)
 create mode 100644 block/blk-mq-debugfs.c
 create mode 100644 block/blk-mq-sched.c
 create mode 100644 block/blk-mq-sched.h
 create mode 100644 block/mq-deadline.c
 create mode 100644 block/opal_proto.h
 create mode 100644 block/sed-opal.c
 delete mode 100644 drivers/lightnvm/gennvm.c
 delete mode 100644 drivers/lightnvm/gennvm.h
 delete mode 100644 drivers/lightnvm/sysblk.c
 create mode 100644 include/linux/sed-opal.h
 create mode 100644 include/scsi/scsi_request.h
 create mode 100644 include/uapi/linux/sed-opal.h

-- 
Jens Axboe
