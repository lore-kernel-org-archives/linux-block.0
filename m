Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, "Bart Van
 Assche" <bart.vanassche@sandisk.com>
Subject: [PATCH v3 00/12] More patches for kernel v4.13
Date: Thu, 8 Jun 2017 10:33:43 -0700
Message-ID: <20170608173355.25898-1-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

Hello Jens,

This patch series contains one patch that reduces the size of struct
blk_mq_hw_ctx, a few patches that simplify some of the block layer code and
also patches that improve the block layer documentation. Please consider these
patches for kernel v4.13.

The basis for these patches is a merge of your for-next and for-linus
branches. Please note that the first patch in this series applies fine on top
of the merge of these two branches but not on top of your for-next branch.

Thanks,

Bart.

Changes between v2 and v3:
* Added patch "blk-mq: Reduce blk_mq_hw_ctx size".
* Removed patch "block: Rename blk_mq_rq_{to,from}_pdu()".
* Addressed Christoph's review comments about patch "block: Introduce
  request_queue.initialize_rq_fn()".
* Rebased (and retested) this patch series on top of a merge of Jens'
  for-next and for-linus branches.

Changes between v1 and v2:
* Addressed Christoph's comment about moving the .initialize_rq_fn() call
  from blk_rq_init() / blk_mq_rq_ctx_init() into blk_get_request().
* Left out patch "scsi: Make scsi_ioctl_reset() pass the request queue pointer
  to blk_rq_init()" since it's no longer needed.
* Restored the scsi_req_init() call in ide_prep_sense().
* Combined the two patches that reduce the blk_mq_hw_ctx size into a single
  patch.
* Modified patch "blk-mq: Initialize a request before assigning a tag" such
  that .tag and .internal_tag are no longer initialized twice.
* Removed WARN_ON_ONCE(q->mq_ops) from blk_queue_bypass_end() because this
  function is used by both blk-sq and blk-mq.
* Added several new patches, e.g. "block: Rename blk_mq_rq_{to,from}_pdu()".

Bart Van Assche (12):
  blk-mq: Reduce blk_mq_hw_ctx size
  block: Make request operation type argument declarations consistent
  block: Introduce request_queue.initialize_rq_fn()
  block: Make most scsi_req_init() calls implicit
  block: Change argument type of scsi_req_init()
  blk-mq: Initialize a request before assigning a tag
  block: Add a comment above queue_lockdep_assert_held()
  block: Check locking assumptions at runtime
  block: Document what queue type each function is intended for
  blk-mq: Document locking assumptions
  block: Constify disk_type
  blk-mq: Warn when attempting to run a hardware queue that is not
    mapped

 block/blk-core.c                   | 130 ++++++++++++++++++++++++++++---------
 block/blk-flush.c                  |   8 ++-
 block/blk-merge.c                  |   3 +
 block/blk-mq-sched.c               |   2 +
 block/blk-mq.c                     |  60 +++++++++++------
 block/blk-tag.c                    |  15 ++---
 block/blk-timeout.c                |   4 +-
 block/blk.h                        |   2 +
 block/bsg.c                        |   1 -
 block/genhd.c                      |   4 +-
 block/scsi_ioctl.c                 |  13 ++--
 drivers/block/pktcdvd.c            |   1 -
 drivers/cdrom/cdrom.c              |   1 -
 drivers/ide/ide-atapi.c            |   3 +-
 drivers/ide/ide-cd.c               |   1 -
 drivers/ide/ide-cd_ioctl.c         |   1 -
 drivers/ide/ide-devsets.c          |   1 -
 drivers/ide/ide-disk.c             |   1 -
 drivers/ide/ide-ioctls.c           |   2 -
 drivers/ide/ide-park.c             |   2 -
 drivers/ide/ide-pm.c               |   2 -
 drivers/ide/ide-probe.c            |   6 +-
 drivers/ide/ide-tape.c             |   1 -
 drivers/ide/ide-taskfile.c         |   1 -
 drivers/scsi/osd/osd_initiator.c   |   2 -
 drivers/scsi/osst.c                |   1 -
 drivers/scsi/scsi_error.c          |   1 -
 drivers/scsi/scsi_lib.c            |  12 +++-
 drivers/scsi/scsi_transport_sas.c  |   6 ++
 drivers/scsi/sg.c                  |   2 -
 drivers/scsi/st.c                  |   1 -
 drivers/target/target_core_pscsi.c |   2 -
 fs/nfsd/blocklayout.c              |   1 -
 include/linux/blk-mq.h             |  13 ++--
 include/linux/blkdev.h             |  14 +++-
 include/scsi/scsi_request.h        |   2 +-
 36 files changed, 213 insertions(+), 109 deletions(-)

-- 
2.12.2
