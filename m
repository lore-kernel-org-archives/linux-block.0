Return-Path: <axboe@kernel.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 4.14-rc
Message-ID: <3496e261-abbf-70fe-ea98-7bbbea28e3ce@kernel.dk>
Date: Wed, 18 Oct 2017 12:22:09 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Linus,

Three small fixes in this pull request:

- A fix for skd, it was using kfree() to free a structure allocate with
  kmem_cache_alloc().

- Stable fix for nbd, fixing a regression using the normal ioctl based
  tools.

- Fix for a previous fix in this series, that fixed up inconsistencies
  between buffered and direct IO.

Please pull!


  git://git.kernel.dk/linux-block.git for-linus


----------------------------------------------------------------
Himanshu Jha (1):
      skd: Use kmem_cache_free

Josef Bacik (1):
      nbd: don't set the device size until we're connected

Lukas Czerner (1):
      fs: Avoid invalidation in interrupt context in dio_complete()

 drivers/block/nbd.c      |  2 +-
 drivers/block/skd_main.c |  2 +-
 fs/direct-io.c           | 19 +++++++++++++------
 3 files changed, 15 insertions(+), 8 deletions(-)

-- 
Jens Axboe
