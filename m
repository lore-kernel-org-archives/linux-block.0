Return-Path: <prvs=4341bde3a=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	=Oleksandr Natalenko <oleksandr@natalenko.name>,
	Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH v4 0/7] Make suspend and resume safe for md-on-SCSI
Date: Mon, 25 Sep 2017 13:29:17 -0700
Message-Id: <20170925202924.16603-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Hello Jens,

It is known that during the resume following a hibernate, especially when
using an md RAID1 array created on top of SCSI devices, sometimes the
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

Changes between v3 and v4:
- Made sure that this patch series not only works for scsi-mq but also for
  the legacy SCSI stack.
- Removed an smp_rmb()/smp_wmb() pair from the hot path and added a comment
  that explains why that is safe.
- Reordered the patches in this patch series.

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
  scsi-mq: Reduce suspend latency
  scsi: Set QUEUE_FLAG_PREEMPT_ONLY while quiesced
  block: Make SCSI device suspend and resume work reliably

Ming Lei (1):
  block: Make q_usage_counter also track legacy requests

 block/blk-core.c          | 60 +++++++++++++++++++++++++++++++++++++++++------
 block/blk-mq-debugfs.c    |  2 +-
 block/blk-mq.c            | 14 ++++-------
 block/blk-timeout.c       |  2 +-
 drivers/ide/ide-atapi.c   |  3 +--
 drivers/ide/ide-io.c      |  2 +-
 drivers/ide/ide-pm.c      |  4 ++--
 drivers/md/md.c           | 21 ++++++++++-------
 drivers/scsi/scsi_lib.c   | 30 +++++++++++++++---------
 fs/block_dev.c            |  4 ++--
 include/linux/blk_types.h |  6 +++++
 include/linux/blkdev.h    | 10 ++++----
 12 files changed, 109 insertions(+), 49 deletions(-)

-- 
2.14.1
