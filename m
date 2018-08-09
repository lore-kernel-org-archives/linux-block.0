Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:38990 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727676AbeHIJHT (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 9 Aug 2018 05:07:19 -0400
From: Coly Li <colyli@suse.de>
To: linux-bcache@vger.kernel.org
Cc: linux-block@vger.kernel.org, Coly Li <colyli@suse.de>
Subject: [PATCH 00/17] fixes reported by checkpatch.pl 
Date: Thu,  9 Aug 2018 14:43:03 +0800
Message-Id: <20180809064320.10229-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This series contains several minor fixes and code cleanup reported by
scripts/checkpatch.pl. After this series, there are still a few warning
from checkpatch.pl, but I think they are necessary to be the way they
are and don't change them. For example, error message exceeds 80 chars
line limit.

Thanks in advance for any comment or review.

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
  bcache: add the missing code comments for smp_mb()

 drivers/md/bcache/Kconfig     |   6 +-
 drivers/md/bcache/alloc.c     |  39 ++++---
 drivers/md/bcache/bcache.h    | 210 +++++++++++++++++-----------------
 drivers/md/bcache/bset.c      | 129 +++++++++++----------
 drivers/md/bcache/bset.h      | 146 ++++++++++++-----------
 drivers/md/bcache/btree.c     |  66 ++++++-----
 drivers/md/bcache/btree.h     |  86 +++++++-------
 drivers/md/bcache/closure.c   |   6 +-
 drivers/md/bcache/closure.h   |   6 +-
 drivers/md/bcache/debug.c     |  23 ++--
 drivers/md/bcache/debug.h     |   6 +-
 drivers/md/bcache/extents.c   |  37 +++---
 drivers/md/bcache/extents.h   |   6 +-
 drivers/md/bcache/io.c        |  24 ++--
 drivers/md/bcache/journal.c   |  25 ++--
 drivers/md/bcache/journal.h   |  28 ++---
 drivers/md/bcache/movinggc.c  |  14 ++-
 drivers/md/bcache/request.c   |  59 +++++-----
 drivers/md/bcache/request.h   |  18 +--
 drivers/md/bcache/stats.c     |  15 ++-
 drivers/md/bcache/stats.h     |  15 ++-
 drivers/md/bcache/super.c     | 103 ++++++++++-------
 drivers/md/bcache/sysfs.c     |  36 +++---
 drivers/md/bcache/sysfs.h     |   6 +-
 drivers/md/bcache/util.c      |   2 +
 drivers/md/bcache/util.h      |  24 ++--
 drivers/md/bcache/writeback.c |  27 +++--
 drivers/md/bcache/writeback.h |  19 +--
 include/uapi/linux/bcache.h   |   8 +-
 29 files changed, 660 insertions(+), 529 deletions(-)

-- 
2.18.0
