Return-Path: <colyli@suse.de>
From: Coly Li <colyli@suse.de>
To: axboe@kernel.dk
Cc: linux-bcache@vger.kernel.org,
	linux-block@vger.kernel.org,
	Coly Li <colyli@suse.de>
Subject: [PATCH 00/15] bcache patches for 4.20 
Date: Mon,  8 Oct 2018 20:41:06 +0800
Message-Id: <20181008124121.20192-1-colyli@suse.de>
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

Hi Jens,

Here are patches for Linux 4.20. In this run we don't have big changes,
most of the patches for fixes or code cleanup.

Ben Peddell resends a patch which had no response for a while, I pick
it for this version. Our new developer Dongbo Cao contributes a bug fix
to avoid kernel panic for too small cache set size, with other code
cleanup changes. Shenghui and me have several code cleanup and minor
fixes, and Junhui again contributes helpful fixes for several real bugs.

Please pull them for 4.20 merge window. Thanks in advance.

Coly Li
---

Ben Peddell (1):
  bcache: Populate writeback_rate_minimum attribute

Coly Li (3):
  bcache: use REQ_PRIO to indicate bio for metadata
  bcache: fix typo in code comments of closure_return_with_destructor()
  bcache: replace hard coded number with BUCKET_GC_GEN_MAX

Dongbo Cao (3):
  bcache: remove useless parameter of bch_debug_init()
  bcache: split combined if-condition code into separate ones
  bcache: panic fix for making cache device

Shenghui Wang (4):
  bcache: account size of buckets used in uuid write to
    ca->meta_sectors_written
  bcache: recal cached_dev_sectors on detach
  bcache: remove unused bch_passthrough_cache
  bcache: use MAX_CACHES_PER_SET instead of magic number 8 in
    __bch_bucket_alloc_set

Tang Junhui (4):
  bcache: trace missed reading by cache_missed
  bcache: fix ioctl in flash device
  bcache: correct dirty data statistics
  bcache: fix miss key refill->end in writeback

 drivers/md/bcache/alloc.c   |   2 +-
 drivers/md/bcache/bcache.h  |   2 +-
 drivers/md/bcache/btree.c   |   2 +-
 drivers/md/bcache/closure.h |   3 +-
 drivers/md/bcache/debug.c   |   2 +-
 drivers/md/bcache/extents.c |   2 +-
 drivers/md/bcache/request.c |   9 ++-
 drivers/md/bcache/request.h |   2 +-
 drivers/md/bcache/super.c   | 113 +++++++++++++++++++++++++++++-------
 drivers/md/bcache/sysfs.c   |   2 +
 10 files changed, 109 insertions(+), 30 deletions(-)

-- 
2.19.0
