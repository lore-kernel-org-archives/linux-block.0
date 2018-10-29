Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-ide@vger.kernel.org
Subject: [PATCHSET v2 0/29] blk-mq driver conversions and legacy path removal
Date: Mon, 29 Oct 2018 10:34:15 -0600
Message-Id: <20181029163444.9940-1-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

Elements of the previous series went into mainline, this is a v2
posting with those killed, series reshuffled, bugs fixed, etc.

his patch series converts the remaining drivers to blk-mq. SCSI
supports both paths, this removes the legacy IO path from SCSI. At the
end, legacy IO code and schedulers are killed off.

I'm not aware of any issues with this series.

This patch series is on top of current -git. It can also be bound in
my mq-conversions branch.

Changes since v1:

- Fix removed q->mq_ops non-NULL check in wbt_enable_default()
- Remove spurious return in ide-io.c:ide_timer_expiry()
- Dropped DM legacy path removal patch, now in mainline
- Dropped ib_srp patch, now in mainline
- Fixed a missing port unlock in IDE
- Add SCSI ufs to the BSG conversions
- Add patch to remove bsg-lib queue hook dependencies
- Fixed missing clear of IO contexts
- Added blk-mq backend for blk_lld_busy()

 Documentation/block/biodoc.txt         |   88 -
 Documentation/block/cfq-iosched.txt    |  291 --
 Documentation/scsi/scsi-parameters.txt |    5 -
 block/Kconfig                          |    6 -
 block/Kconfig.iosched                  |   61 -
 block/Makefile                         |    5 +-
 block/bfq-iosched.c                    |    1 -
 block/blk-cgroup.c                     |   55 -
 block/blk-core.c                       | 1836 +-----------
 block/blk-exec.c                       |   20 +-
 block/blk-flush.c                      |  154 +-
 block/blk-ioc.c                        |   33 +-
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
 block/bsg-lib.c                        |  146 +-
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
 drivers/ide/ide-io.c                   |  100 +-
 drivers/ide/ide-park.c                 |    4 +-
 drivers/ide/ide-pm.c                   |   28 +-
 drivers/ide/ide-probe.c                |   68 +-
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
 drivers/scsi/scsi_lib.c                |  599 +---
 drivers/scsi/scsi_priv.h               |    1 -
 drivers/scsi/scsi_scan.c               |   10 +-
 drivers/scsi/scsi_sysfs.c              |    8 +-
 drivers/scsi/scsi_transport_fc.c       |   71 +-
 drivers/scsi/scsi_transport_iscsi.c    |    7 +-
 drivers/scsi/scsi_transport_sas.c      |   10 +-
 drivers/scsi/sg.c                      |    2 +-
 drivers/scsi/st.c                      |    2 +-
 drivers/scsi/ufs/ufs_bsg.c             |    4 +-
 drivers/scsi/ufs/ufshcd.c              |    6 -
 drivers/target/target_core_pscsi.c     |    2 +-
 include/linux/blk-cgroup.h             |  108 -
 include/linux/blk-mq.h                 |    6 +
 include/linux/blkdev.h                 |  176 +-
 include/linux/bsg-lib.h                |    6 +-
 include/linux/elevator.h               |   90 +-
 include/linux/ide.h                    |   13 +-
 include/linux/init.h                   |    1 -
 include/scsi/scsi_host.h               |   18 +-
 include/scsi/scsi_tcq.h                |   14 +-
 init/do_mounts_initrd.c                |    3 -
 init/initramfs.c                       |    6 -
 init/main.c                            |   12 -
 77 files changed, 825 insertions(+), 10712 deletions(-)

-- 
Jens Axboe
