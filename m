Return-Path: <colyli@suse.de>
From: Coly Li <colyli@suse.de>
To: axboe@kernel.dk,
	linux-bcache@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	Coly Li <colyli@suse.de>
Subject: [PATCH v3 00/17] bcache for 4.19, 3rd wave
Date: Sat, 11 Aug 2018 13:19:43 +0800
Message-Id: <20180811052000.103680-1-colyli@suse.de>
List-ID: <linux-block@vger.kernel.org>

Hi Jens,

This series contains several minor fixes and code cleanup reported by
scripts/checkpatch.pl. After this series, there are still a few warning
from checkpatch.pl, but I think they are necessary to be the way they
are and don't change them. For example, error message exceeds 80 chars
line limit.

Thanks in advance for any comment or review.

Changelog:
v3: Fix coments from Shenghui Wang.
v2: Fix comments from Shenghui Wang.
v1: Initial version

Coly Li 
---
Coly Li (17):
  bcache: style fix to replace 'unsigned' by 'unsigned int'
  bcache: style fix to add a blank line after declarations
  bcache: add identifier names to arguments of function definitions
  bcache: style fixes for lines over 80 characters
  bcache: replace Symbolic permissions by octal permission numbers
  bcache: replace printk() by pr_*() routines
  bcache: fix indent by replacing blank by tabs
  bcache: replace '%pF' by '%pS' in seq_printf()
  bcache: fix typo 'succesfully' to 'successfully'
  bcache: prefer 'help' in Kconfig
  bcache: do not check NULL pointer before calling kmem_cache_destroy
  bcache: fix code comments style
  bcache: add static const prefix to char * array declarations
  bcache: move open brace at end of function definitions to next line
  bcache: add missing SPDX header
  bcache: remove unnecessary space before ioctl function pointer
    arguments
  bcache: add the missing comments for smp_mb()/smp_wmb()

 drivers/md/bcache/Kconfig     |   6 +-
 drivers/md/bcache/alloc.c     |  39 ++++---
 drivers/md/bcache/bcache.h    | 210 +++++++++++++++++-----------------
 drivers/md/bcache/bset.c      | 142 +++++++++++++----------
 drivers/md/bcache/bset.h      | 146 ++++++++++++-----------
 drivers/md/bcache/btree.c     |  72 +++++++-----
 drivers/md/bcache/btree.h     |  86 +++++++-------
 drivers/md/bcache/closure.c   |   6 +-
 drivers/md/bcache/closure.h   |   6 +-
 drivers/md/bcache/debug.c     |  23 ++--
 drivers/md/bcache/debug.h     |   6 +-
 drivers/md/bcache/extents.c   |  37 +++---
 drivers/md/bcache/extents.h   |   6 +-
 drivers/md/bcache/io.c        |  24 ++--
 drivers/md/bcache/journal.c   |  27 +++--
 drivers/md/bcache/journal.h   |  28 ++---
 drivers/md/bcache/movinggc.c  |  14 ++-
 drivers/md/bcache/request.c   |  61 +++++-----
 drivers/md/bcache/request.h   |  18 +--
 drivers/md/bcache/stats.c     |  15 ++-
 drivers/md/bcache/stats.h     |  15 ++-
 drivers/md/bcache/super.c     | 107 ++++++++++-------
 drivers/md/bcache/sysfs.c     |  36 +++---
 drivers/md/bcache/sysfs.h     |   6 +-
 drivers/md/bcache/util.c      |   2 +
 drivers/md/bcache/util.h      |  24 ++--
 drivers/md/bcache/writeback.c |  30 +++--
 drivers/md/bcache/writeback.h |  19 +--
 include/uapi/linux/bcache.h   |   8 +-
 29 files changed, 679 insertions(+), 540 deletions(-)

-- 
2.18.0
