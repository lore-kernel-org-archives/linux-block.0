Return-Path: <prvs=7391cfe80=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH v2 0/5] Improve blk-mq performance
Date: Fri, 27 Jul 2018 15:56:15 -0700
Message-Id: <20180727225620.17855-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Hello Jens,

The blk-mq timeout handling rework that went upstream during the v4.18
development cycle introduced a performance regression due to the atomic
instructions that were added in the hot path. This patch series improves
blk-mq performance by reducing the number of atomic instructions in the
hot path. This patch series increases the number of IOPS reported by a
fio test against the null_blk driver with 15% on an x86_64 system. This
patch series applies on top of a merge of your for-next and for-linus
branches. This patch series passes the block and srp blktests tests.

Bart.

Changes compared to v1:
- Dropped the patch that renames BLK_EH_DONE into BLK_EH_DONT_RESET_TIMER.
- Added a new patch that introduces the timeout handler return code
  BLK_EH_DONT_COMPLETE.
- If blk_mq_complete_request() is called from inside the request timed
  out function, complete the request immediately to avoid triggering a
  deadlock.
- Instead of introducing one new request state, introduce two new request
  states, namely MQ_RQ_COMPLETION_DELAYED and MQ_RQ_TIMED_OUT.
- Fixed a race condition in blk_mq_change_rq_state().

Bart Van Assche (5):
  blk-mq: Introduce the timeout handler return code BLK_EH_DONT_COMPLETE
  block: Remove a superfluous #include directive
  block: Split blk_add_timer()
  block: Simplify blk_add_timer() and blk_mq_add_timer()
  blk-mq: Rework blk-mq timeout handling again

 Documentation/scsi/scsi_eh.txt            |   4 +-
 block/blk-core.c                          |   3 +
 block/blk-mq-debugfs.c                    |   8 +-
 block/blk-mq.c                            | 325 +++++++++++++++++-----
 block/blk-mq.h                            |  10 +-
 block/blk-timeout.c                       | 116 +++++---
 block/blk.h                               |   1 +
 drivers/block/nbd.c                       |   2 +-
 drivers/message/fusion/mptsas.c           |   2 +-
 drivers/s390/block/dasd.c                 |   6 +-
 drivers/scsi/gdth.c                       |   2 +-
 drivers/scsi/libiscsi.c                   |   6 +-
 drivers/scsi/megaraid/megaraid_sas_base.c |   2 +-
 drivers/scsi/mvumi.c                      |   2 +-
 drivers/scsi/qla4xxx/ql4_os.c             |   2 +-
 drivers/scsi/scsi_error.c                 |  18 +-
 drivers/scsi/scsi_transport_fc.c          |   9 +-
 drivers/scsi/scsi_transport_srp.c         |   4 +-
 drivers/scsi/ufs/ufshcd.c                 |   6 +-
 include/linux/blk-mq.h                    |  14 -
 include/linux/blkdev.h                    |  60 +++-
 21 files changed, 417 insertions(+), 185 deletions(-)

-- 
2.18.0
