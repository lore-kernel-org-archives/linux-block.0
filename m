Return-Path: <axboe@kernel.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 4.8-rc1
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <0db36b42-0384-7bcd-395f-b510765c9f62@kernel.dk>
Date: Fri, 5 Aug 2016 15:16:43 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

Hi Linus,

Here's the 2nd round of block updates for this merge window. It's a mix
of fixes for changes that went in previously in this round, and fixes in
general. This pull request contains:

- Fixes for loop from Christoph

- A bdi vs gendisk lifetime fix from Dan, worth two cookies.

- A blk-mq timeout fix, when on frozen queues. From Gabriel.

- Writeback fix from Jan, ensuring that __writeback_single_inode() does
   the right thing.

- Fix for bio->bi_rw usage in f2fs from me.

- Error path deadlock fix in blk-mq sysfs registration from me.

- Floppy O_ACCMODE fix from Jiri.

- Fix to the new bio op methods from Mike. One more followup will be
   coming here, ensuring that we don't propagate the block types outside
   of block. That, and a rename of bio->bi_rw is coming right after -rc1
   is cut.

- Various little fixes

Please pull!


   git://git.kernel.dk/linux-block.git for-linus


----------------------------------------------------------------
Christoph Hellwig (2):
       loop: don't try to use AIO for discards
       loop: make do_req_filebacked more robust

Dan Williams (1):
       block: fix bdi vs gendisk lifetime mismatch

Gabriel Krisman Bertazi (1):
       blk-mq: Allow timeouts to run while queue is freezing

Hou Tao (1):
       blkcg: kill unused field nr_undestroyed_grps

Jan Kara (1):
       writeback: Write dirty times for WB_SYNC_ALL writeback

Jens Axboe (2):
       f2fs: drop bio->bi_rw manual assignment
       blk-mq: fix deadlock in blk_mq_register_disk() error path

Jiri Kosina (1):
       floppy: fix open(O_ACCMODE) for ioctl-only open

John Pittman (1):
       Include: blkdev: Removed duplicate 'struct request;' declaration.

Mike Christie (1):
       mm/block: convert rw_page users to bio op use

Paolo Valente (1):
       block: add missing group association in bio-cloning functions

Shaun Tancheff (1):
       Fixup direct bi_rw modifiers

Vegard Nossum (2):
       block: fix use-after-free in seq file
       nbd: fix race in ioctl

  block/bio.c                      | 15 +++++++++
  block/blk-mq-sysfs.c             | 12 ++++---
  block/blk-mq.c                   | 15 ++++++++-
  block/blk-throttle.c             |  5 ---
  block/genhd.c                    |  3 +-
  drivers/block/brd.c              | 17 +++++-----
  drivers/block/floppy.c           | 21 ++++++-------
  drivers/block/loop.c             | 67 
++++++++++++++++++----------------------
  drivers/block/nbd.c              | 12 +++----
  drivers/block/zram/zram_drv.c    | 28 +++++++++--------
  drivers/nvdimm/btt.c             | 18 +++++------
  drivers/nvdimm/pmem.c            | 12 +++----
  fs/block_dev.c                   |  7 +++--
  fs/btrfs/extent_io.c             |  8 +----
  fs/f2fs/data.c                   |  1 -
  fs/fs-writeback.c                |  1 +
  fs/mpage.c                       |  2 +-
  include/linux/backing-dev-defs.h |  1 +
  include/linux/backing-dev.h      |  1 +
  include/linux/bio.h              |  3 ++
  include/linux/blk_types.h        | 22 ++++++-------
  include/linux/blkdev.h           |  3 +-
  include/linux/fs.h               |  3 +-
  include/linux/pagemap.h          |  2 +-
  mm/backing-dev.c                 | 19 ++++++++++++
  mm/filemap.c                     |  6 ++--
  26 files changed, 168 insertions(+), 136 deletions(-)


-- 
Jens Axboe
