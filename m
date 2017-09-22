Return-Path: <prvs=431df6ef2=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	=Oleksandr Natalenko <oleksandr@natalenko.name>,
	Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH v3 0/6] Make SCSI device suspend and resume work reliably
Date: Fri, 22 Sep 2017 15:13:59 -0700
Message-Id: <20170922221405.22091-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Hello Jens,

It is known that during the resume following a hibernate sometimes the
system hangs instead of coming up properly. This patch series fixes this
problem. This patch series is an alternative for Ming Lei's "[PATCH V5
0/10] block/scsi: safe SCSI quiescing" patch series. The advantages of
this patch series are:
- Easier to review because no new race conditions are introduced between
  queue freezing and blk_cleanup_queue(). As the discussion that followed
  Ming's patch series shows the correctness of the new code is hard to
  verify.
- No new freeze modes and hence no new freeze mode variables.

These patches have been tested on top of a merge of the block layer
for-next branch and Linus' master tree. Linus' master tree includes
patch "KVM: x86: Fix the NULL pointer parameter in check_cr_write()"
but the block layer for-next branch not yet.

Please consider these changes for kernel v4.15.

Thanks,

Bart.

Changes between v2 and v3:
- Made md kernel threads freezable.
- Changed the approach for quiescing SCSI devices again.
- Addressed Ming's review comments.

Changes compared to v1 of this patch series:
- Changed the approach and rewrote the patch series.

Bart Van Assche (6):
  md: Make md resync and reshape threads freezable
  block: Convert RQF_PREEMPT into REQ_PREEMPT
  block: Add the QUEUE_FLAG_PREEMPT_ONLY request queue flag
  scsi: Set QUEUE_FLAG_PREEMPT_ONLY while quiesced
  block: Make SCSI device suspend and resume work reliably
  scsi-mq: Reduce suspend latency

 block/blk-core.c          | 46 +++++++++++++++++++++++++++++++++++++++-------
 block/blk-mq-debugfs.c    |  2 +-
 block/blk-mq.c            |  4 ++--
 block/blk-timeout.c       |  2 +-
 drivers/ide/ide-atapi.c   |  3 +--
 drivers/ide/ide-io.c      |  2 +-
 drivers/ide/ide-pm.c      |  4 ++--
 drivers/md/md.c           | 21 +++++++++++++--------
 drivers/scsi/scsi_lib.c   | 36 ++++++++++++++++++++++++++----------
 fs/block_dev.c            |  4 ++--
 include/linux/blk_types.h |  6 ++++++
 include/linux/blkdev.h    | 10 ++++++----
 12 files changed, 100 insertions(+), 40 deletions(-)

-- 
2.14.1
