Return-Path: <axboe@kernel.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Followup merge window block fixes/changes
Message-ID: <82ee3a59-1767-3073-7893-bf78b5933c5e@kernel.dk>
Date: Fri, 17 Nov 2017 09:51:19 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Linus,

A followup pull request, with some parts that either needed a bit more
testing before going in, merge sync, or just later arriving fixes. This
pull request contains:

- Timer related updates from Kees. These were purposefully delayed since
  I didn't want to pull in a later v4.14-rc tag to my block tree.

- ide-cd prep sense buffer fix from Bart. Also delayed, as not to clash
  with the late fix we put into 4.14-rc.

- Small BFQ updates series from Luca and Paolo.

- Single nvmet fix from James, fixing a non-functional case there.

- Bio fast clone fix from Michael, which made bcache return the wrong
  data for some cases.

- Legacy IO path regression hang fix from Ming.

Please pull!


  git://git.kernel.dk/linux-block.git for-linus


----------------------------------------------------------------
Bart Van Assche (1):
      ide: Make ide_cdrom_prep_fs() initialize the sense buffer pointer

James Smart (1):
      nvmet_fc: fix better length checking

Jens Axboe (1):
      Merge branch 'for-4.15/timer' into for-linus

Kees Cook (5):
      block/floppy: Convert callback to pass timer_list
      amifloppy: Convert timers to use timer_setup()
      block/aoe: Convert timers to use timer_setup()
      block: swim3: Convert timers to use timer_setup()
      md: Convert timers to use timer_setup()

Luca Miccio (2):
      block, bfq: add missing invocations of bfqg_stats_update_io_add/remove
      block, bfq: move debug blkio stats behind CONFIG_DEBUG_BLK_CGROUP

Michael Lyle (1):
      bio: ensure __bio_clone_fast copies bi_partno

Ming Lei (1):
      block: wake up all tasks blocked in get_request()

Paolo Valente (2):
      doc, block, bfq: update max IOPS sustainable with BFQ
      block, bfq: update blkio stats outside the scheduler lock

 Documentation/block/bfq-iosched.txt |  43 +++++++++--
 block/bfq-cgroup.c                  | 148 ++++++++++++++++++++----------------
 block/bfq-iosched.c                 | 117 ++++++++++++++++++++++++++--
 block/bfq-iosched.h                 |   4 +-
 block/bfq-wf2q.c                    |   1 -
 block/bio.c                         |   1 +
 block/blk-core.c                    |   4 +-
 drivers/block/amiflop.c             |  57 +++++++-------
 drivers/block/aoe/aoecmd.c          |   6 +-
 drivers/block/aoe/aoedev.c          |   9 +--
 drivers/block/floppy.c              |  10 ++-
 drivers/block/swim3.c               |  31 ++++----
 drivers/ide/ide-cd.c                |   3 +-
 drivers/md/bcache/stats.c           |   8 +-
 drivers/md/dm-delay.c               |   6 +-
 drivers/md/dm-integrity.c           |   6 +-
 drivers/md/dm-raid1.c               |   8 +-
 drivers/md/md.c                     |   9 +--
 drivers/nvme/target/fc.c            |   6 +-
 19 files changed, 311 insertions(+), 166 deletions(-)

-- 
Jens Axboe
