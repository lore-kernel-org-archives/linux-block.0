Return-Path: <axboe@kernel.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 4.18-rc
Message-ID: <753e12b2-54a3-e1dc-e3f1-7ad6cc4b6deb@kernel.dk>
Date: Tue, 5 Jun 2018 09:06:05 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Linus,

This just contains the dm kzalloc fix that was discussed, and
a fix that I queued up yesterday for a case where blk-mq
doesn't honor the stop bit appropriately.

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-linus-20180605


----------------------------------------------------------------
Jianchao Wang (1):
      blk-mq: return when hctx is stopped in blk_mq_run_work_fn

Kent Overstreet (1):
      dm: Use kzalloc for all structs with embedded biosets/mempools

 block/blk-mq.c                | 2 +-
 drivers/md/dm-bio-prison-v1.c | 2 +-
 drivers/md/dm-bio-prison-v2.c | 2 +-
 drivers/md/dm-io.c            | 2 +-
 drivers/md/dm-kcopyd.c        | 2 +-
 drivers/md/dm-region-hash.c   | 2 +-
 drivers/md/dm-snap.c          | 2 +-
 drivers/md/dm-thin.c          | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

-- 
Jens Axboe
