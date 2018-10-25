Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-ide@vger.kernel.org
Subject: [PATCHSET 0/28] blk-mq driver conversions and legacy path removal
Date: Thu, 25 Oct 2018 15:10:11 -0600
Message-Id: <20181025211039.11559-1-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

The first round of this went into 4.20-rc, but we've still some of
them pending. This patch series converts the remaining drivers to
blk-mq. The ones that support dual paths (like SCSI and DM) have
the non-mq path removed. At the end, legacy IO code and schedulers
are killed off.

This patch series is on top of my for-linus branch. It can also
be bound in my mq-conversions branch.

 Documentation/block/biodoc.txt         |   88 -
 Documentation/block/cfq-iosched.txt    |  291 --
 Documentation/scsi/scsi-parameters.txt |    5 -
 block/Kconfig                          |    6 -
 block/Kconfig.iosched                  |   61 -
 block/Makefile                         |    5 +-
 block/bfq-iosched.c                    |    1 -
 block/blk-cgroup.c                     |   55 -
 block/blk-core.c                       | 1860 +-----------
 block/blk-exec.c                       |   20 +-
 block/blk-flush.c                      |  154 +-
 block/blk-ioc.c                        |   46 +-
 block/blk-merge.c                      |   35 +-
 block/blk-mq-debugfs.c                 |    2 -
 block/blk-mq-tag.c                     |    6 +-
 block/blk-mq.c                         |   13 +-
 block/blk-settings.c                   |   49 -
 block/blk-softirq.c                    |   20 -
 block/blk-sysfs.c                      |   39 +-
 block/blk-tag.c                        |  378 ---
 block/blk-timeout.c                    |   99 +-
 block/blk-wbt.c                        |    3 +-
 block/blk.h                            |   60 +-
 block/bsg-lib.c                        |  131 +-
 block/cfq-iosched.c                    | 4916 --------------------------------
 block/deadline-iosched.c               |  560 ----
 block/elevator.c                       |  447 +--
 block/kyber-iosched.c                  |    1 -
 block/mq-deadline.c                    |    1 -
 block/noop-iosched.c                   |  124 -
 drivers/block/sunvdc.c                 |  149 +-
 drivers/ide/ide-atapi.c                |   25 +-
 drivers/ide/ide-cd.c                   |  175 +-
 drivers/ide/ide-disk.c                 |    5 +-
 drivers/ide/ide-io.c                   |  101 +-
 drivers/ide/ide-park.c                 |    4 +-
 drivers/ide/ide-pm.c                   |   28 +-
 drivers/ide/ide-probe.c                |   68 +-
 drivers/infiniband/ulp/srp/ib_srp.c    |    7 -
 drivers/md/Kconfig                     |   11 -
 drivers/md/dm-core.h                   |   10 -
 drivers/md/dm-mpath.c                  |   18 +-
 drivers/md/dm-rq.c                     |  293 +-
 drivers/md/dm-rq.h                     |    4 -
 drivers/md/dm-sysfs.c                  |    3 +-
 drivers/md/dm-table.c                  |   36 +-
 drivers/md/dm.c                        |   21 +-
 drivers/md/dm.h                        |    1 -
 drivers/memstick/core/ms_block.c       |  110 +-
 drivers/memstick/core/ms_block.h       |    1 +
 drivers/memstick/core/mspro_block.c    |  121 +-
 drivers/s390/block/dasd_ioctl.c        |   22 +-
 drivers/scsi/Kconfig                   |   12 -
 drivers/scsi/cxlflash/main.c           |    6 -
 drivers/scsi/hosts.c                   |   29 +-
 drivers/scsi/lpfc/lpfc_scsi.c          |    2 +-
 drivers/scsi/osd/osd_initiator.c       |    4 +-
 drivers/scsi/osst.c                    |    2 +-
 drivers/scsi/qedi/qedi_main.c          |    3 +-
 drivers/scsi/qla2xxx/qla_os.c          |   30 +-
 drivers/scsi/scsi.c                    |    5 +-
 drivers/scsi/scsi_debug.c              |    3 +-
 drivers/scsi/scsi_error.c              |    4 +-
 drivers/scsi/scsi_lib.c                |  624 +---
 drivers/scsi/scsi_priv.h               |    1 -
 drivers/scsi/scsi_scan.c               |   10 +-
 drivers/scsi/scsi_sysfs.c              |    8 +-
 drivers/scsi/scsi_transport_fc.c       |   72 +-
 drivers/scsi/scsi_transport_iscsi.c    |    9 +-
 drivers/scsi/scsi_transport_sas.c      |   10 +-
 drivers/scsi/sg.c                      |    2 +-
 drivers/scsi/st.c                      |    2 +-
 drivers/scsi/ufs/ufshcd.c              |    6 -
 drivers/target/target_core_pscsi.c     |    2 +-
 include/linux/blk-cgroup.h             |  108 -
 include/linux/blkdev.h                 |  174 +-
 include/linux/bsg-lib.h                |    3 +-
 include/linux/elevator.h               |   90 +-
 include/linux/ide.h                    |   13 +-
 include/linux/init.h                   |    1 -
 include/scsi/scsi_host.h               |   18 +-
 include/scsi/scsi_tcq.h                |   14 +-
 init/do_mounts_initrd.c                |    3 -
 init/initramfs.c                       |    6 -
 init/main.c                            |   12 -
 85 files changed, 833 insertions(+), 11144 deletions(-)

-- 
Jens Axboe
