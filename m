Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44963 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757525AbeDXMPA (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Apr 2018 08:15:00 -0400
From: Coly Li <colyli@suse.de>
To: linux-bcache@vger.kernel.org
Cc: linux-block@vger.kernel.org, Coly Li <colyli@suse.de>
Subject: [PATCH 0/6] bcache fixes for device failure handling 
Date: Tue, 24 Apr 2018 20:14:40 +0800
Message-Id: <20180424121446.130552-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi folks,

I receive bug reports from partners for the bcache cache device failure
handling patch set (which is just merged into 4.17). Fortunately we are
still in 4.17 merge window, so I ask helps for offering code review
before I ask Jens to pick these fixes for 4.17-rc3.

The patches are well commneted IMHO and passes regression test by myself.
Thanks for your help in advance.

Coly Li

---
Coly Li (6):
  bcache: store disk name in struct cache and struct cached_dev
  bcache: set CACHE_SET_IO_DISABLE in bch_cached_dev_error()
  bcache: count backing device I/O error for writeback I/O
  bcache: add wait_for_kthread_stop() in bch_allocator_thread()
  bcache: set dc->io_disable to true in conditional_stop_bcache_device()
  bcache: use pr_info() to inform duplicated CACHE_SET_IO_DISABLE set

 drivers/md/bcache/alloc.c     |  1 +
 drivers/md/bcache/bcache.h    |  4 +++
 drivers/md/bcache/debug.c     |  3 +-
 drivers/md/bcache/io.c        |  8 ++---
 drivers/md/bcache/request.c   |  5 +--
 drivers/md/bcache/super.c     | 73 ++++++++++++++++++++++++++++++-------------
 drivers/md/bcache/writeback.c |  4 ++-
 7 files changed, 64 insertions(+), 34 deletions(-)

-- 
2.16.2
