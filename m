Return-Path: <colyli@suse.de>
From: Coly Li <colyli@suse.de>
To: colyli@suse.de,
	axboe@kernel.dk,
	linux-bcache@vger.kernel.org
Cc: linux-block@vger.kernel.org
Subject: [PATCH 0/9] bcache patches for Linux v4.19 
Date: Thu, 26 Jul 2018 12:17:32 +0800
Message-Id: <20180726041741.1669-1-colyli@suse.de>
List-ID: <linux-block@vger.kernel.org>

Hi Jenns,

Here is the first wave bcache patches for Linnux v4.19.

Florian Schmaus contributes useful chagnes for code cleanup, and
Arnd Bergmann replaces get_seconds() by ktime_get_real_seconds(). 

Shenghui Wang contributes a patch to fix a memory leak in bcache. And
patches from Tang Junhui are for recoganized performance improvement,
these patches are posted for monthes and good to me.

Please pick the first wave for 4.19. Thanks in advance.

Coly Li
---
Arnd Bergmann (1):
  bcache: stop using the deprecated get_seconds()

Florian Schmaus (3):
  bcache: do not assign in if condition register_bcache()
  bcache: do not assign in if condition in bcache_init()
  bcache: do not assign in if condition in bcache_device_init()

Shenghui Wang (1):
  bcache: free heap cache_set->flush_btree in bch_journal_free

Tang Junhui (4):
  bcache: simplify the calculation of the total amount of flash dirty
    data
  bcache: finish incremental GC
  bcache: calculate the number of incremental GC nodes according to the
    total of btree nodes
  bcache: fix I/O significant decline while backend devices registering

 drivers/md/bcache/bcache.h    |  6 +++++
 drivers/md/bcache/btree.c     | 49 ++++++++++++++++++++++++++++++++--
 drivers/md/bcache/journal.c   |  1 +
 drivers/md/bcache/request.c   |  3 +++
 drivers/md/bcache/super.c     | 50 ++++++++++++++++++++++++-----------
 drivers/md/bcache/writeback.c | 34 +++++++++++++++++++++---
 drivers/md/bcache/writeback.h | 19 -------------
 include/uapi/linux/bcache.h   |  4 +--
 8 files changed, 123 insertions(+), 43 deletions(-)

-- 
2.17.1
