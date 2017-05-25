Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, "Bart Van
 Assche" <bart.vanassche@sandisk.com>
Subject: [PATCH 00/19] Block layer patches for kernel v4.13
Date: Thu, 25 May 2017 11:43:08 -0700
Message-ID: <20170525184327.23570-1-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

Hello Jens,

The patches in this series are:
* A repost of the block layer patches I had sent to Martin earlier
  this week but now sent to you.
* Two patches to reduce the size of struct blk_mq_hw_ctx.
* A series of documentation patches I prepared about two months ago
  but for which I had not yet had the time to post these.

Please consider these patches for kernel v4.13.

Thanks,

Bart.

Bart Van Assche (19):
  block: Avoid that blk_exit_rl() triggers a use-after-free
  block: Introduce queue flag QUEUE_FLAG_SCSI_PDU
  bsg: Check queue type before attaching to a queue
  pktcdvd: Check queue type before attaching to a queue
  cdrom: Check private request size before attaching to a queue
  nfsd: Check private request size before submitting a SCSI request
  scsi: Make scsi_ioctl_reset() pass the request queue pointer to
    blk_rq_init()
  block: Introduce request_queue.initialize_rq_fn()
  block: Make scsi_req_init() calls implicit
  blk-mq: Change blk_mq_hw_ctx.queue_rq_srcu into an array
  blk-mq: Reduce blk_mq_hw_ctx size
  blk-mq: Initialize a request before assigning a tag
  blk-mq: Fix the comment above blk_mq_quiesce_queue()
  block: Add a comment above queue_lockdep_assert_held()
  block: Check locking assumptions at runtime
  block: Document what queue type each function is intended for
  blk-mq: Document locking assumptions
  block: Constify disk_type
  block: Make request operation type argument declarations consistent

 block/blk-cgroup.c                 |   2 +-
 block/blk-core.c                   | 129 ++++++++++++++++++++++++++++---------
 block/blk-flush.c                  |   8 ++-
 block/blk-merge.c                  |   2 +
 block/blk-mq.c                     |  68 ++++++++++++-------
 block/blk-sysfs.c                  |   2 +-
 block/blk-tag.c                    |  15 ++---
 block/blk-timeout.c                |   4 +-
 block/blk.h                        |   2 +-
 block/bsg-lib.c                    |   1 +
 block/bsg.c                        |   7 +-
 block/genhd.c                      |   4 +-
 block/scsi_ioctl.c                 |   3 -
 drivers/block/cciss.c              |   1 +
 drivers/block/pktcdvd.c            |   6 +-
 drivers/cdrom/cdrom.c              |   5 +-
 drivers/ide/ide-atapi.c            |   2 -
 drivers/ide/ide-cd.c               |   1 -
 drivers/ide/ide-cd_ioctl.c         |   1 -
 drivers/ide/ide-devsets.c          |   1 -
 drivers/ide/ide-disk.c             |   1 -
 drivers/ide/ide-ioctls.c           |   2 -
 drivers/ide/ide-park.c             |   2 -
 drivers/ide/ide-pm.c               |   2 -
 drivers/ide/ide-probe.c            |   7 +-
 drivers/ide/ide-tape.c             |   1 -
 drivers/ide/ide-taskfile.c         |   1 -
 drivers/scsi/osd/osd_initiator.c   |   2 -
 drivers/scsi/osst.c                |   1 -
 drivers/scsi/scsi_error.c          |   8 ++-
 drivers/scsi/scsi_lib.c            |  12 +++-
 drivers/scsi/scsi_transport_sas.c  |   7 ++
 drivers/scsi/sg.c                  |   2 -
 drivers/scsi/st.c                  |   1 -
 drivers/target/target_core_pscsi.c |   2 -
 fs/nfsd/blocklayout.c              |   4 +-
 include/linux/blk-mq.h             |  11 ++--
 include/linux/blkdev.h             |  16 ++++-
 38 files changed, 232 insertions(+), 114 deletions(-)

-- 
2.12.2
