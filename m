Return-Path: <prvs=430e6b2f0=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	=Oleksandr Natalenko <oleksandr@natalenko.name>,
	Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH v2 0/4] Make SCSI device suspend and resume work reliably
Date: Thu, 21 Sep 2017 14:22:51 -0700
Message-Id: <20170921212255.12788-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Hello Jens,

It is known that during the resume following a hibernate sometimes the
system hangs instead of coming up properly. This patch series fixes this
problem. This patch series is an alternative for Ming Lei's "[PATCH V5
0/10] block/scsi: safe SCSI quiescing" patch series. The advantages of
this patch series are:
- No new freeze states and hence no new freeze state variables.
- Easier to review because no new race conditions are introduced between
  queue freezing and blk_cleanup_queue(). As the discussion that followed
  Ming's patch series shows the correctness of the new code is hard to
  verify.

These patches have been tested on top of a merge of the block layer
for-next branch and Linus' master tree. Linus' master tree includes
patch "KVM: x86: Fix the NULL pointer parameter in check_cr_write()"
but the block layer for-next branch not yet.

Please consider these changes for kernel v4.15.

Thanks,

Bart.

Changes compared to v1 of this patch series:
- Changed the approach and rewrote the patch series.


Bart Van Assche (4):
  block: Convert RQF_PREEMPT into REQ_PREEMPT
  block: Add the QUEUE_PREEMPT_ONLY request queue flag
  block, scsi: Make SCSI device suspend and resume work reliably
  scsi-mq: Reduce suspend latency

 block/blk-core.c          | 26 +++++++++++++++++++++++---
 block/blk-mq-debugfs.c    |  2 +-
 drivers/ide/ide-atapi.c   |  3 +--
 drivers/ide/ide-io.c      |  2 +-
 drivers/ide/ide-pm.c      |  4 ++--
 drivers/scsi/scsi_lib.c   | 31 +++++++++++++++++++++----------
 include/linux/blk_types.h |  6 ++++++
 include/linux/blkdev.h    |  8 +++++---
 8 files changed, 60 insertions(+), 22 deletions(-)

-- 
2.14.1
