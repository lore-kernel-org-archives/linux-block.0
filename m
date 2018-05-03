Return-Path: <colyli@suse.de>
From: Coly Li <colyli@suse.de>
To: linux-bcache@vger.kernel.org,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	Coly Li <colyli@suse.de>
Subject: [PATCH v4 0/6] bcache device failure handling fixes for 4.17-rc4
Date: Thu,  3 May 2018 18:51:31 +0800
Message-Id: <20180503105137.2922-1-colyli@suse.de>
List-ID: <linux-block@vger.kernel.org>

Hi Jens,

I receive bug reports from partners for the bcache cache device failure
handling patch set (which is just merged into 4.17-rc1). Fortunately we
are still in 4.17 merge window, I suggest to have these fixes to go into
4.17 merge window too.

The patches are well commented IMHO and pass my own regression tests.
Fortunately Hannes offers code reveiw to all the patches and offers his
Reviewed-by.

Thanks for your help in advance.

Changlog:
v4: Add reviewed-by from Hannnes Reinecke.
v3: Remove an extra "Fixes:" line from patch "bcache: use pr_info() to
    inform duplicated CACHE_SET_IO_DISABLE set", and move part of its
    content into patch "bcache: set CACHE_SET_IO_DISABLE in
    bch_cached_dev_error()".
v2: With more fixes from v1 patch set.
v1: First version for review.

Coly Li
---
Coly Li (6):
  bcache: store disk name in struct cache and struct cached_dev
  bcache: set CACHE_SET_IO_DISABLE in bch_cached_dev_error()
  bcache: count backing device I/O error for writeback I/O
  bcache: add wait_for_kthread_stop() in bch_allocator_thread()
  bcache: set dc->io_disable to true in conditional_stop_bcache_device()
  bcache: use pr_info() to inform duplicated CACHE_SET_IO_DISABLE set

 drivers/md/bcache/alloc.c     |  5 ++-
 drivers/md/bcache/bcache.h    |  4 +++
 drivers/md/bcache/debug.c     |  3 +-
 drivers/md/bcache/io.c        |  8 ++---
 drivers/md/bcache/request.c   |  5 +--
 drivers/md/bcache/super.c     | 75 ++++++++++++++++++++++++++++++-------------
 drivers/md/bcache/writeback.c |  4 ++-
 7 files changed, 68 insertions(+), 36 deletions(-)

-- 
2.16.3
