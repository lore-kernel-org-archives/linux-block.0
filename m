Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 4.11-rc6
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Omar Sandoval <osandov@osandov.com>
Message-ID: <737cfc73-ff01-cce6-bab9-cdb81612886b@kernel.dk>
Date: Sat, 8 Apr 2017 11:50:19 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Linus,

Here's a pull request for 4.11-rc, fixing a set of issues mostly
centered around the new scheduling framework. These have been brewing
for a while, but split up into what we absolutely need in 4.11, and what
we can defer until 4.12. These are well tested, on both single queue and
multiqueue setups, and with and without shared tags. They fix several
hangs that have happened in testing. This is obviously larger than I
would have preferred at this point in time, but I don't think we can
shave much off this and still get the desired results.

In detail, this pull request contains:

- Set of 5 fixes for NVMe, mostly from Christoph and one from Roland.

- A series from Bart, fixing issues with dm-mq and SCSI shared tags and
  scheduling. Note that one of those patches commit messages may read
  like an optimization, but it is in fact an important fix for queue
  restarts in particular.

- A series from Omar, most importantly fixing a hang with multiple
  hardware queues when we fail to get a driver tag. Another important
  fix in there is for resizing hardware queues, which nbd does when
  handling multiple sockets for one connection.

- Fixing an imbalance in putting the ctx for hctx request allocations
  from Minchan.

Please pull for -rc6! Note that I'll be sporadically available the next
10 days. Omar is standing by as the point of contact, until I return.


  git://git.kernel.dk/linux-block.git for-linus


----------------------------------------------------------------
Bart Van Assche (4):
      blk-mq: Introduce blk_mq_delay_run_hw_queue()
      scsi: Avoid that SCSI queues get stuck
      dm rq: Avoid that request processing stalls sporadically
      blk-mq: Restart a single queue if tag sets are shared

Christoph Hellwig (4):
      nvme: add missing byte swap in nvme_setup_discard
      nvmet: add missing byte swap in nvmet_get_smart_log
      nvmet: fix byte swap in nvmet_execute_write_zeroes
      nvmet: fix byte swap in nvmet_parse_io_cmd

Jens Axboe (1):
      Merge branch 'nvme-4.11-rc' of git://git.infradead.org/nvme into for-linus

Minchan Kim (1):
      block: do not put mq context in blk_mq_alloc_request_hctx

Omar Sandoval (5):
      blk-mq: use the right hctx when getting a driver tag fails
      blk-mq-sched: refactor scheduler initialization
      blk-mq-sched: set up scheduler tags when bringing up new queues
      blk-mq-sched: fix crash in switch error path
      blk-mq: remap queues when adding/removing hardware queues

Roland Dreier (1):
      nvme: Correct NVMF enum values to match NVMe-oF rev 1.0

 block/blk-mq-sched.c            | 181 +++++++++++++++++++++++++++++-----------
 block/blk-mq-sched.h            |  25 ++----
 block/blk-mq.c                  |  85 ++++++++++++++-----
 block/blk-mq.h                  |   2 +-
 block/blk-sysfs.c               |   2 +-
 block/elevator.c                | 114 +++++++++++++------------
 drivers/md/dm-rq.c              |   1 +
 drivers/nvme/host/core.c        |   2 +-
 drivers/nvme/target/admin-cmd.c |   2 +-
 drivers/nvme/target/io-cmd.c    |   4 +-
 drivers/scsi/scsi_lib.c         |   6 +-
 include/linux/blk-mq.h          |   2 +
 include/linux/blkdev.h          |   1 -
 include/linux/elevator.h        |   2 +-
 include/linux/nvme.h            |  16 ++--
 15 files changed, 281 insertions(+), 164 deletions(-)

-- 
Jens Axboe
