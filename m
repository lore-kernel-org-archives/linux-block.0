Return-Path: <prvs=4177119eb=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH 0/5] Make SCSI device suspend work reliably
Date: Fri,  8 Sep 2017 16:52:21 -0700
Message-Id: <20170908235226.26622-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Hello Jens,

Recently it was reported on the block layer mailing list that suspend
does not work reliably neither for the legacy block layer nor for blk-mq.
The purpose of this patch series is to make device suspend work reliably
without affecting the hot path significantly and without introducing any
race conditions between request queue cleanup and blk_get_request().

Please consider this patch series for kernel v4.15.

Thanks,

Bart.

Bart Van Assche (5):
  percpu-refcount: Introduce percpu_ref_switch_to_atomic_nowait()
  scsi: Change the type of the second last argument of scsi_execute()
  block: Introduce REQ_PM and remove RQF_PM
  block: Make SCSI device suspend work reliably
  blk-mq: Implement power management support

 block/blk-core.c                | 89 ++++++++++++++++++++++++++---------------
 block/blk-mq-debugfs.c          |  2 +-
 block/blk-mq.c                  | 34 ++++++++++++++++
 block/blk.h                     | 12 ++++++
 block/elevator.c                |  4 +-
 drivers/scsi/scsi_lib.c         | 15 +++----
 drivers/scsi/sd.c               |  4 +-
 drivers/scsi/ufs/ufshcd.c       | 11 ++---
 include/linux/blk_types.h       |  2 +
 include/linux/blkdev.h          |  3 +-
 include/linux/percpu-refcount.h |  1 +
 include/scsi/scsi_device.h      |  2 +-
 lib/percpu-refcount.c           | 21 ++++++++++
 13 files changed, 147 insertions(+), 53 deletions(-)

-- 
2.14.1
