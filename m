Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:46913 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750997AbeB0Q4N (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Feb 2018 11:56:13 -0500
From: Coly Li <colyli@suse.de>
To: linux-bcache@vger.kernel.org
Cc: linux-block@vger.kernel.org, Coly Li <colyli@suse.de>
Subject: [PATCH v7 0/9] bcache: device failure handling improvement 
Date: Wed, 28 Feb 2018 00:55:48 +0800
Message-Id: <20180227165557.20442-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi maintainers and folks,

This patch set tries to improve bcache device failure handling, includes
cache device and backing device failures.

The basic idea to handle failed cache device is,
- Unregister cache set
- Detach all backing devices which are attached to this cache set
- Stop all the detached bcache devices (configurable)
- Stop all flash only volume on the cache set
The above process is named 'cache set retire' by me. The result of cache
set retire is, cache set and bcache devices are all removed, following
I/O requests will get failed immediately to notift upper layer or user
space coce that the cache device is failed or disconnected.
- Stop all the detached bcache devices (configurable)
- Stop all flash only volume on the cache set
The above process is named 'cache set retire' by me. The result of cache
set retire is, cache set and bcache devices are all removed
(configurable), following I/O requests will get failed immediately to
notify upper layer or user space coce that the cache device is failed or
disconnected.

The change of v7 patch set is to add an inline wait_for_kthread_stop() in
following 2 patches,
 - bcache: add CACHE_SET_IO_DISABLE to struct cache_set flags
 - bcache: stop bcache device when backing device is offline
When CACHE_SET_IO_DISABLE bit is set and writeback thread, gc thread or
status update thread exits while-loop, before returns from the kernel
thread routine, wait_for_kthread_stop() will be called. This inline
function just sleep-and-wait for kthread_should_stop() to return true.
By this modification, kthreads will always be stopped by kthread_stop()
even CACHE_SET_IO_DISABLE bit set stops the while-loop of these kernel
threads.

Changelog:
v7: add wait_for_kthread_stop() in writebac, gc, and status update kernel
    threads.
v6: fix typo and mistaken spelling.
v5: replace patch "bcache: stop all attached bcache devices for a retired
    cache set" from v4 patch set by "bcache: add stop_when_cache_set_failed
    option to backing device" from v5 patch set.
    fix issues from v4 patch set.
    improve kernel message format, remove redundant prefix string.
v4: add per-cached_dev option stop_attached_devs_on_fail to avoid stopping
    attached bcache device from a retiring cache set.
v3: fix detach issue find in v2 patch set.
v2: fixes all problems found in v1 review.
    add patches to handle backing device failure.
    add one more patch to set writeback_rate_update_seconds range.
    include a patch from Junhui Tang.
v1: the initial version, only handles cache device failure.

Coly Li (8):
  bcache: fix cached_dev->count usage for bch_cache_set_error()
  bcache: quit dc->writeback_thread when BCACHE_DEV_DETACHING is set
  bcache: stop dc->writeback_rate_update properly
  bcache: add CACHE_SET_IO_DISABLE to struct cache_set flags
  bcache: add stop_when_cache_set_failed option to backing device
  bcache: add backing_request_endio() for bi_end_io of attached backing
    device I/O
  bcache: add io_disable to struct cached_dev
  bcache: stop bcache device when backing device is offline

Tang Junhui (1):
  bcache: fix inaccurate io state for detached bcache devices

Thanks in advance for any review, testing or bug report.

Coly Li
---

 drivers/md/bcache/alloc.c     |   3 +-
 drivers/md/bcache/bcache.h    |  59 +++++++++++-
 drivers/md/bcache/btree.c     |  11 ++-
 drivers/md/bcache/io.c        |  16 +++-
 drivers/md/bcache/journal.c   |   4 +-
 drivers/md/bcache/request.c   | 185 ++++++++++++++++++++++++++++++++------
 drivers/md/bcache/super.c     | 205 ++++++++++++++++++++++++++++++++++++++----
 drivers/md/bcache/sysfs.c     |  55 +++++++++++-
 drivers/md/bcache/util.h      |   6 --
 drivers/md/bcache/writeback.c |  92 ++++++++++++++++---
 drivers/md/bcache/writeback.h |   2 -
 11 files changed, 559 insertions(+), 79 deletions(-)

-- 
2.16.1
