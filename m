Return-Path: <colyli@suse.de>
From: Coly Li <colyli@suse.de>
To: axboe@kernel.dk,
	linux-bcache@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	Coly Li <colyli@suse.de>
Subject: [PATCH 00/10] bcache patches for 4.19, 2nd wave
Date: Thu,  9 Aug 2018 15:48:41 +0800
Message-Id: <20180809074851.11027-1-colyli@suse.de>
List-ID: <linux-block@vger.kernel.org>

Hi Jens, 

Here are 2nd wave bcache patches for 4.19.

The patches from me were either verified by other people or posted
for quite long time. Except for the debugfs_create_dir() fix and
"set max writeback rate" fix, rested patches are simple or trivial
IMHO.

Our new bcache developer Shenghui Wang contributes two patches in
this run. The first one fixes a misleading error message, and the
second one is a code style clean up.

Thanks in advance for picking them.

Coly Li
---
Coly Li (8):
  bcache: do not check return value of debugfs_create_dir()
  bcache: display rate debug parameters to 0 when writeback is not
    running
  bcache: avoid unncessary cache prefetch bch_btree_node_get()
  bcache: add a comment in super.c
  bcache: fix mistaken code comments in bcache.h
  bcache: fix mistaken comments in request.c
  bcache: add code comments for bset.c
  bcache: set max writeback rate when I/O request is idle

Shenghui Wang (2):
  bcache: make the pr_err statement used for ENOENT only in
    sysfs_attatch section
  bcache: trivial - remove tailing backslash in macro BTREE_FLAG

 drivers/md/bcache/bcache.h    | 18 +++----
 drivers/md/bcache/bset.c      | 63 ++++++++++++++++++++++++
 drivers/md/bcache/btree.c     | 14 +++---
 drivers/md/bcache/btree.h     |  2 +-
 drivers/md/bcache/closure.c   | 13 +++--
 drivers/md/bcache/closure.h   |  4 +-
 drivers/md/bcache/debug.c     | 11 +++--
 drivers/md/bcache/request.c   | 61 +++++++++++++++++++++--
 drivers/md/bcache/super.c     |  9 +++-
 drivers/md/bcache/sysfs.c     | 41 ++++++++++------
 drivers/md/bcache/util.c      |  2 +-
 drivers/md/bcache/util.h      |  2 +-
 drivers/md/bcache/writeback.c | 91 +++++++++++++++++++++++------------
 13 files changed, 251 insertions(+), 80 deletions(-)

-- 
2.18.0
