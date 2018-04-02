Return-Path: <axboe@kernel.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block changes for 4.17-rc
Message-ID: <a50c0cc4-2eed-3753-321b-d9ea6f723f11@kernel.dk>
Date: Mon, 2 Apr 2018 17:44:58 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Linus,

This is the main pull request for block for 4.17. It's a pretty quiet
round this time, which is nice. This pull request contains:

- Series from Bart, cleaning up the way we set/test/clear atomic queue
  flags.

- Series from Bart, fixing races between gendisk and queue registration
  and removal.

- Set of bcache fixes and improvements from various folks, by way of
  Michael Lyle.

- Set of lightnvm updates from Matias, most of it being the 1.2 to
  2.0 transition.

- Removal of unused DIO flags from Nikolay.

- blk-mq/sbitmap memory ordering fixes from Omar.

- Divide-by-zero fix for BFQ from Paolo.

- Minor documentation patches from Randy.

- Timeout fix from Tejun.

- Alpha "can't write a char atomically" fix from Mikulas.

- Set of NVMe fixes by way of Keith.

- bsg and bsg-lib improvements from Christoph.

- A few sed-opal fixes from Jonas.

- cdrom check-disk-change deadlock fix from Maurizio.

- Various little fixes, comment fixes, etc from various folks.

You'll get a merge conflict that you need to resolve in
drivers/nvme/host/core.c - I've included the resolution at the end of
the email. Also see:

http://git.kernel.dk/cgit/linux-block/log/?h=for-4.17/merged

if you wish, that's the above pull request merged with master.

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-4.17/block-20180402


----------------------------------------------------------------
Anshuman Khandual (1):
      lib/scatterlist: Add SG_CHAIN and SG_END macros for LSB encodings

Arnd Bergmann (2):
      misc: rtsx: rename SG_END macro
      staging: rts5208: rename SG_END macro

Bart Van Assche (31):
      blk-mq-debugfs: Reorder queue show and store methods
      blk-mq-debugfs: Show zone locking information
      block/loop: Delete gendisk before cleaning up the request queue
      md: Delete gendisk before cleaning up the request queue
      zram: Delete gendisk before cleaning up the request queue
      block: Add 'lock' as third argument to blk_alloc_queue_node()
      block: Fix a race between the cgroup code and request queue initialization
      block: Fix a race between request queue removal and the block cgroup controller
      block: Reorder the queue flag manipulation function definitions
      block: Use the queue_flag_*() functions instead of open-coding these
      block: Introduce blk_queue_flag_{set,clear,test_and_{set,clear}}()
      block: Protect queue flag changes with the queue lock
      mtip32xx: Use the blk_queue_flag_*() functions
      bcache: Use the blk_queue_flag_{set,clear}() functions
      iscsi: Use blk_queue_flag_set()
      target/tcm_loop: Use blk_queue_flag_set()
      block: Use blk_queue_flag_*() in drivers instead of queue_flag_*()
      block: Complain if queue_flag_(set|clear)_unlocked() is abused
      block: Move the queue_flag_*() functions from a public into a private header file
      block: Suppress kernel-doc warnings triggered by blk-zoned.c
      blk-mq-debugfs: Show more request state information
      block: Move SECTOR_SIZE and SECTOR_SHIFT definitions into <linux/blkdev.h>
      bcache: Fix indentation
      bcache: Add __printf annotation to __bch_check_keys()
      bcache: Annotate switch fall-through
      bcache: Fix kernel-doc warnings
      bcache: Remove an unused variable
      bcache: Suppress more warnings about set-but-not-used variables
      bcache: Reduce the number of sparse complaints about lock imbalances
      bcache: Fix a compiler warning in bcache_device_init()
      block: Change a rcu_read_{lock,unlock}_sched() pair into rcu_read_{lock,unlock}()

Chengguang Xu (1):
      bcache: move closure debug file into debug directory

Christoph Hellwig (6):
      bsg-lib: introduce a timeout field in struct bsg_job
      bsg-lib: remove bsg_job.req
      bsg: split handling of SCSI CDBs vs transport requeues
      block: bio_check_eod() needs to consider partitions
      nvmet: refactor configfs transport type handling
      nvmet: constify struct nvmet_fabrics_ops

Coly Li (7):
      bcache: fix cached_dev->count usage for bch_cache_set_error()
      bcache: quit dc->writeback_thread when BCACHE_DEV_DETACHING is set
      bcache: stop dc->writeback_rate_update properly
      bcache: add CACHE_SET_IO_DISABLE to struct cache_set flags
      bcache: add stop_when_cache_set_failed option to backing device
      bcache: add backing_request_endio() for bi_end_io
      bcache: add io_disable to struct cached_dev

Dan Carpenter (1):
      lightnvm: pblk: remove some unnecessary NULL checks

Hans Holmberg (8):
      lightnvm: pblk: handle bad sectors in the emeta area correctly
      lightnvm: pblk: check data lines version on recovery
      lightnvm: pblk: export write amplification counters to sysfs
      lightnvm: pblk: add padding distribution sysfs attribute
      lightnvm: pblk: delete writer kick timer before stopping thread
      lightnvm: pblk: allow allocation of new lines during shutdown
      lightnvm: pblk: prevent race in pblk_rb_flush_point_set
      lightnvm: pblk: don't recover unwritten lines

Heiner Litz (2):
      lightnvm: fix bad block initialization
      lightnvm: Avoid validation of default op value

Israel Rukshin (2):
      nvmet-rdma: Remove unused queue state
      nvmet-rdma: Fix use after free in nvmet_rdma_cm_handler()

James Smart (5):
      nvme_fc: fix ctrl create failures racing with workq items
      nvme_fc: io timeout should defer abort to ctrl reset
      nvme_fc: fix abort race on teardown with lld reject
      nvme_fc: on remoteport reuse, set new nport_id and role.
      nvmet_fc: prevent new io rqsts in possible isr completions

Jarosław Janik (1):
      nvme-pci: disable APST for Samsung NVMe SSD 960 EVO + ASUS PRIME Z370-A

Javier González (14):
      lightnvm: pblk: refactor bad block identification
      lightnvm: pblk: refactor init/exit sequences
      lightnvm: simplify geometry structure
      lightnvm: add minor version to generic geometry
      lightnvm: add shorten OCSSD version in geo
      lightnvm: complete geo structure with maxoc*
      lightnvm: normalize geometry nomenclature
      lightnvm: add support for 2.0 address format
      lightnvm: make address conversions depend on generic device
      lightnvm: implement get log report chunk helpers
      lightnvm: pblk: check for supported version
      lightnvm: pblk: rename ppaf* to addrf*
      lightnvm: pblk: implement get log report chunk
      lightnvm: pblk: implement 2.0 support

Jens Axboe (1):
      null_blk: add 'requeue' fault attribute

Jianchao Wang (3):
      nvme-pci: quiesce IO queues prior to disabling device HMB accesses
      nvme: fix the dangerous reference of namespaces list
      nvme: change namespaces_mutext to namespaces_rwsem

Jiufei Xue (1):
      writeback: remove dead code in wb_blkcg/memcg_offline

Johannes Thumshirn (1):
      lightnvm: centralize permission check for lightnvm ioctl

Jonas Rabenstein (2):
      block: sed-opal: fix response string extraction
      block: sed-opal: fix u64 short atom length

Joseph Qi (1):
      blk-throttle: fix race between blkcg_bio_issue_check() and cgroup_rmdir()

Keith Busch (3):
      nvme-pci: Add .get_address ctrl callback
      nvme: Skip checking heads without namespaces
      blk-mq: Allow PCI vector offset for mapping queues

Markus Elfring (1):
      lightnvm/pblk-gc: Delete an error message for a failed memory allocation in pblk_gc_line_prepare_ws()

Matias Bjørling (12):
      nvme: implement log page low/high offset and dwords
      nvme: make nvme_get_log_ext non-static
      lightnvm: remove chnl_offset in nvme_nvm_identity
      lightnvm: remove mlc pairs structure
      lightnvm: remove multiple groups in 1.2 data structure
      lightnvm: make 1.2 data structures explicit
      lightnvm: flatten nvm_id_group into nvm_id
      lightnvm: add 2.0 geometry identification
      lightnvm: remove max_rq_size
      lightnvm: remove nvm_dev_ops->max_phys_sect
      nvme: lightnvm: add late setup of block size and metadata
      lightnvm: remove function name in strings

Maurizio Lombardi (1):
      cdrom: do not call check_disk_change() inside cdrom_open()

Max Gurtovoy (4):
      nvme: centralize ctrl removal prints
      nvmet-rdma: Don't flush system_wq by default during remove_one
      nvme-rdma: Don't flush delete_wq by default during remove_one
      nvmet: move device_uuid configfs attr definition to suitable place

Mikulas Patocka (2):
      block: use 32-bit blk_status_t on Alpha
      Fix slab name "biovec-(1<<(21-12))"

Ming Lei (1):
      block: null_blk: fix 'Invalid parameters' when loading module

Minwoo Im (1):
      nvme: use define instead of magic value for identify size

Nikolay Borisov (2):
      direct-io: Remove unused DIO_ASYNC_EXTEND flag
      direct-io: Remove unused DIO_SKIP_DIO_COUNT logic

Nitzan Carmi (2):
      nvme-rdma: Allow DELETING state change failure in error_recovery
      nvme: Add .stop_ctrl to nvme ctrl ops

Omar Sandoval (4):
      block: clear ctx pending bit under ctx lock
      sbitmap: use test_and_set_bit_lock()/clear_bit_unlock()
      loop: don't call into filesystem while holding lo_ctl_mutex
      loop: use killable lock in ioctls

Paolo Valente (1):
      block, bfq: lower-bound the estimated peak rate to 1

Randy Dunlap (2):
      Documentation/cdrom: update cdrom-standard.tex for kernel changes
      Documentation/cdrom: fix German sharp s in LaTex

Ross Zwisler (1):
      MAINTAINERS: add coverage for drivers/block

Sagi Grimberg (3):
      net/utils: Introduce inet_addr_is_any
      nvmet: don't return "any" ip address in discovery log page
      iscsi-target: use common inet_addr_is_any

Shawn Lin (1):
      mmc: block: Delete gendisk before cleaning up the request queue

Souvik Banerjee (1):
      blktrace: fix comment in blktrace_api.h

Tang Junhui (4):
      bcache: fix inaccurate io state for detached bcache devices
      bcache: fix incorrect sysfs output value of strip size
      bcache: fix error return value in memory shrink
      bcache: fix using of loop variable in memory shrink

Tejun Heo (1):
      blk-mq: Directly schedule q->timeout_work when aborting a request

Thomas Tai (2):
      nvme: Add fault injection feature
      Documentation: nvme: Documentation for nvme fault injection

 Documentation/cdrom/cdrom-standard.tex             |  31 +-
 Documentation/fault-injection/fault-injection.txt  |   8 +
 .../fault-injection/nvme-fault-injection.txt       | 116 +++
 MAINTAINERS                                        |   1 +
 arch/xtensa/platforms/iss/simdisk.c                |   1 -
 block/bfq-iosched.c                                |  25 +-
 block/bfq-iosched.h                                |   2 +-
 block/bio.c                                        |   4 +-
 block/blk-cgroup.c                                 |  78 +-
 block/blk-core.c                                   | 250 ++++---
 block/blk-mq-debugfs.c                             | 150 ++--
 block/blk-mq-pci.c                                 |   6 +-
 block/blk-mq.c                                     |  20 +-
 block/blk-settings.c                               |   6 +-
 block/blk-stat.c                                   |   6 +-
 block/blk-sysfs.c                                  |  29 +-
 block/blk-timeout.c                                |   8 +-
 block/blk-zoned.c                                  |   4 +-
 block/blk.h                                        |  69 ++
 block/bsg-lib.c                                    | 165 +++--
 block/bsg.c                                        | 262 +++----
 block/sed-opal.c                                   |  37 +-
 drivers/block/brd.c                                |   1 -
 drivers/block/drbd/drbd_main.c                     |   3 +-
 drivers/block/drbd/drbd_nl.c                       |   4 +-
 drivers/block/loop.c                               |  77 +-
 drivers/block/mtip32xx/mtip32xx.c                  |   8 +-
 drivers/block/nbd.c                                |   8 +-
 drivers/block/null_blk.c                           | 124 +++-
 drivers/block/paride/pcd.c                         |   2 +
 drivers/block/rbd.c                                |  13 +-
 drivers/block/rsxx/dev.c                           |   6 +-
 drivers/block/skd_main.c                           |   4 +-
 drivers/block/umem.c                               |   7 +-
 drivers/block/xen-blkfront.c                       |  10 +-
 drivers/block/zram/zram_drv.c                      |   8 +-
 drivers/block/zram/zram_drv.h                      |   1 -
 drivers/cdrom/cdrom.c                              |   3 -
 drivers/cdrom/gdrom.c                              |   3 +
 drivers/ide/ide-cd.c                               |  10 +-
 drivers/ide/ide-cd.h                               |   6 +-
 drivers/ide/ide-disk.c                             |   4 +-
 drivers/ide/ide-probe.c                            |   4 +-
 drivers/lightnvm/core.c                            | 240 +++---
 drivers/lightnvm/pblk-cache.c                      |   4 +
 drivers/lightnvm/pblk-core.c                       | 202 +++--
 drivers/lightnvm/pblk-gc.c                         |  12 +-
 drivers/lightnvm/pblk-init.c                       | 820 +++++++++++++--------
 drivers/lightnvm/pblk-map.c                        |   6 +-
 drivers/lightnvm/pblk-rb.c                         |  21 +-
 drivers/lightnvm/pblk-read.c                       |   2 +-
 drivers/lightnvm/pblk-recovery.c                   |  91 ++-
 drivers/lightnvm/pblk-rl.c                         |   2 +-
 drivers/lightnvm/pblk-sysfs.c                      | 235 +++++-
 drivers/lightnvm/pblk-write.c                      |   2 +-
 drivers/lightnvm/pblk.h                            | 304 +++++---
 drivers/md/bcache/alloc.c                          |   3 +-
 drivers/md/bcache/bcache.h                         |  57 +-
 drivers/md/bcache/bset.c                           |   4 +-
 drivers/md/bcache/bset.h                           |   5 +-
 drivers/md/bcache/btree.c                          |  26 +-
 drivers/md/bcache/closure.c                        |  17 +-
 drivers/md/bcache/closure.h                        |   5 +-
 drivers/md/bcache/debug.c                          |  14 +-
 drivers/md/bcache/extents.c                        |   2 -
 drivers/md/bcache/io.c                             |  16 +-
 drivers/md/bcache/journal.c                        |   8 +-
 drivers/md/bcache/request.c                        | 186 ++++-
 drivers/md/bcache/super.c                          | 160 +++-
 drivers/md/bcache/sysfs.c                          |  55 +-
 drivers/md/bcache/util.c                           |  25 +-
 drivers/md/bcache/util.h                           |   6 -
 drivers/md/bcache/writeback.c                      |  92 ++-
 drivers/md/bcache/writeback.h                      |   4 +-
 drivers/md/dm-table.c                              |  16 +-
 drivers/md/dm.c                                    |   2 +-
 drivers/md/md-linear.c                             |   4 +-
 drivers/md/md.c                                    |  10 +-
 drivers/md/raid0.c                                 |   4 +-
 drivers/md/raid1.c                                 |   6 +-
 drivers/md/raid10.c                                |   6 +-
 drivers/md/raid5.c                                 |   4 +-
 drivers/misc/cardreader/rtsx_pcr.c                 |   4 +-
 drivers/mmc/core/block.c                           |   2 +-
 drivers/mmc/core/queue.c                           |   8 +-
 drivers/mtd/mtd_blkdevs.c                          |   6 +-
 drivers/nvdimm/blk.c                               |   2 +-
 drivers/nvdimm/btt.c                               |   2 +-
 drivers/nvdimm/nd.h                                |   1 -
 drivers/nvdimm/pmem.c                              |   6 +-
 drivers/nvme/host/Makefile                         |   1 +
 drivers/nvme/host/core.c                           | 123 ++--
 drivers/nvme/host/fault_inject.c                   |  79 ++
 drivers/nvme/host/fc.c                             |  36 +-
 drivers/nvme/host/lightnvm.c                       | 757 ++++++++++++++-----
 drivers/nvme/host/multipath.c                      |   8 +-
 drivers/nvme/host/nvme.h                           |  35 +-
 drivers/nvme/host/pci.c                            |  26 +-
 drivers/nvme/host/rdma.c                           |  34 +-
 drivers/nvme/target/configfs.c                     |  65 +-
 drivers/nvme/target/core.c                         |  12 +-
 drivers/nvme/target/discovery.c                    |  30 +-
 drivers/nvme/target/fc.c                           |  23 +-
 drivers/nvme/target/loop.c                         |   4 +-
 drivers/nvme/target/nvmet.h                        |  12 +-
 drivers/nvme/target/rdma.c                         |  72 +-
 drivers/s390/block/dasd.c                          |   4 +-
 drivers/s390/block/dcssblk.c                       |   2 +-
 drivers/s390/block/scm_blk.c                       |   4 +-
 drivers/s390/block/xpram.c                         |   4 +-
 drivers/s390/scsi/zfcp_fc.c                        |   4 +-
 drivers/scsi/gdth.h                                |   3 -
 drivers/scsi/iscsi_tcp.c                           |   2 +-
 drivers/scsi/megaraid/megaraid_sas_base.c          |   2 +-
 drivers/scsi/megaraid/megaraid_sas_fusion.c        |   2 +-
 drivers/scsi/mpt3sas/mpt3sas_scsih.c               |   2 +-
 drivers/scsi/qla2xxx/qla_os.c                      |   2 +-
 drivers/scsi/scsi_debug.c                          |   2 +-
 drivers/scsi/scsi_lib.c                            |   6 +-
 drivers/scsi/scsi_sysfs.c                          |   3 +-
 drivers/scsi/scsi_transport_sas.c                  |   3 +-
 drivers/scsi/sd.c                                  |   8 +-
 drivers/scsi/smartpqi/smartpqi_init.c              |   2 +-
 drivers/scsi/sr.c                                  |   2 +
 drivers/staging/rts5208/rtsx_chip.h                |  12 +-
 drivers/staging/rts5208/rtsx_transport.c           |  10 +-
 drivers/target/iscsi/iscsi_target.c                |  28 +-
 drivers/target/loopback/tcm_loop.c                 |   2 +-
 fs/direct-io.c                                     |   9 +-
 include/linux/blk-cgroup.h                         |   1 +
 include/linux/blk-mq-pci.h                         |   3 +-
 include/linux/blk_types.h                          |   5 +
 include/linux/blkdev.h                             | 121 ++-
 include/linux/bsg-lib.h                            |   7 +-
 include/linux/bsg.h                                |  35 +-
 include/linux/device-mapper.h                      |   2 -
 include/linux/fs.h                                 |   6 -
 include/linux/ide.h                                |   1 -
 include/linux/inet.h                               |   1 +
 include/linux/lightnvm.h                           | 334 ++++++---
 include/linux/rtsx_pci.h                           |  12 +-
 include/linux/sbitmap.h                            |   8 +
 include/linux/scatterlist.h                        |  23 +-
 include/uapi/linux/blktrace_api.h                  |   2 +-
 include/uapi/linux/msdos_fs.h                      |   2 +
 lib/sbitmap.c                                      |  10 +-
 mm/backing-dev.c                                   |   2 -
 net/core/utils.c                                   |  23 +
 148 files changed, 4266 insertions(+), 2060 deletions(-)
 create mode 100644 Documentation/fault-injection/nvme-fault-injection.txt
 create mode 100644 drivers/nvme/host/fault_inject.c


diff --cc drivers/nvme/host/core.c
index 7aeca5db7916,f81e3b323366..197a6ba9700f
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@@ -3033,6 -3052,8 +3052,7 @@@ static void nvme_alloc_ns(struct nvme_c
  			ns->disk->disk_name);
  
  	nvme_mpath_add_disk(ns->head);
 -	nvme_mpath_add_disk_links(ns);
+ 	nvme_fault_inject_init(ns);
  	return;
   out_unlink_ns:
  	mutex_lock(&ctrl->subsys->lock);

-- 
Jens Axboe
