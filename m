Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pl0-f67.google.com ([209.85.160.67]:37320 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754301AbeCSAgk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Mar 2018 20:36:40 -0400
Received: by mail-pl0-f67.google.com with SMTP id w12-v6so9224976plp.4
        for <linux-block@vger.kernel.org>; Sun, 18 Mar 2018 17:36:39 -0700 (PDT)
From: Michael Lyle <mlyle@lyle.org>
To: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
Cc: axboe@fb.com, Michael Lyle <mlyle@lyle.org>
Subject: [for-4.17 00/20] First 20 commits for bcache
Date: Sun, 18 Mar 2018 17:36:13 -0700
Message-Id: <20180319003633.27225-1-mlyle@lyle.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Jens---

Here's a series of patches for 4.17.  All have been reviewed and tested.
There's more in my review queue, but they're all things that are
"trickier" and will take a bit more work to convince myself are safe.

All have received simple creation/attach/detach/reboot scenario testing
and will continue to be tested.  Please apply at your leisure.

Thanks,

Mike

--
Bart Van Assche (8):
  bcache: Fix indentation
  bcache: Add __printf annotation to __bch_check_keys()
  bcache: Annotate switch fall-through
  bcache: Fix kernel-doc warnings
  bcache: Remove an unused variable
  bcache: Suppress more warnings about set-but-not-used variables
  bcache: Reduce the number of sparse complaints about lock imbalances
  bcache: Fix a compiler warning in bcache_device_init()

Chengguang Xu (1):
  bcache: move closure debug file into debug directory

Coly Li (7):
  bcache: fix cached_dev->count usage for bch_cache_set_error()
  bcache: quit dc->writeback_thread when BCACHE_DEV_DETACHING is set
  bcache: stop dc->writeback_rate_update properly
  bcache: add CACHE_SET_IO_DISABLE to struct cache_set flags
  bcache: add stop_when_cache_set_failed option to backing device
  bcache: add backing_request_endio() for bi_end_io
  bcache: add io_disable to struct cached_dev

Tang Junhui (4):
  bcache: fix inaccurate io state for detached bcache devices
  bcache: fix incorrect sysfs output value of strip size
  bcache: fix error return value in memory shrink
  bcache: fix using of loop variable in memory shrink

 drivers/md/bcache/alloc.c     |   3 +-
 drivers/md/bcache/bcache.h    |  57 ++++++++++++-
 drivers/md/bcache/bset.c      |   4 +-
 drivers/md/bcache/bset.h      |   5 +-
 drivers/md/bcache/btree.c     |  26 +++---
 drivers/md/bcache/closure.c   |  17 ++--
 drivers/md/bcache/closure.h   |   5 +-
 drivers/md/bcache/debug.c     |  14 ++--
 drivers/md/bcache/extents.c   |   2 -
 drivers/md/bcache/io.c        |  16 +++-
 drivers/md/bcache/journal.c   |   8 +-
 drivers/md/bcache/request.c   | 184 +++++++++++++++++++++++++++++++++++-------
 drivers/md/bcache/super.c     | 154 ++++++++++++++++++++++++++++++-----
 drivers/md/bcache/sysfs.c     |  55 ++++++++++++-
 drivers/md/bcache/util.c      |  25 +++---
 drivers/md/bcache/util.h      |   6 --
 drivers/md/bcache/writeback.c |  92 ++++++++++++++++++---
 drivers/md/bcache/writeback.h |   4 +-
 18 files changed, 552 insertions(+), 125 deletions(-)

-- 
2.14.1
