Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:60704 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729923AbeGZPj5 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Jul 2018 11:39:57 -0400
From: Coly Li <colyli@suse.de>
To: colyli@suse.de, linux-bcache@vger.kernel.org
Cc: linux-block@vger.kernel.org
Subject: [PATCH 0/9] Pending bcache patches for review
Date: Thu, 26 Jul 2018 22:22:30 +0800
Message-Id: <20180726142239.44669-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi folks,

I ask for help to review these patches, some of them are posted for months.
They are OK with my test for a while, still tt would be great to have more
reviewer before these patches go into v4.19.

Thanks in advance. 

Coly Li
---
Coly Li (9):
  bcache: do not check return value of debugfs_create_dir()
  bcache: display rate debug parameters to 0 when writeback is not
    running
  bcache: avoid unncessary cache prefetch bch_btree_node_get()
  bcache: add a comment in register_bdev()
  bcache: fix mistaken code comments in struct cache
  bcache: fix mistaken comments in bch_keylist_realloc()
  bcache: add code comments for bset.c
  bcache: initiate bcache_debug to NULL
  bcache: set max writeback rate when I/O request is idle

 drivers/md/bcache/bcache.h    | 16 +++---
 drivers/md/bcache/bset.c      | 63 ++++++++++++++++++++++++
 drivers/md/bcache/btree.c     | 14 +++---
 drivers/md/bcache/closure.c   | 13 +++--
 drivers/md/bcache/closure.h   |  4 +-
 drivers/md/bcache/debug.c     | 13 ++---
 drivers/md/bcache/request.c   | 56 ++++++++++++++++++++-
 drivers/md/bcache/super.c     |  9 +++-
 drivers/md/bcache/sysfs.c     | 37 +++++++++-----
 drivers/md/bcache/util.c      |  2 +-
 drivers/md/bcache/util.h      |  2 +-
 drivers/md/bcache/writeback.c | 91 +++++++++++++++++++++++------------
 12 files changed, 244 insertions(+), 76 deletions(-)

-- 
2.17.1
