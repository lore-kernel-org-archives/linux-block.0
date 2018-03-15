Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:46680 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752602AbeCOPI1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Mar 2018 11:08:27 -0400
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Michael Lyle <mlyle@lyle.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Coly Li <colyli@suse.de>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH 00/16] bcache: Compiler, sparse and smatch fixes
Date: Thu, 15 Mar 2018 08:07:58 -0700
Message-Id: <20180315150814.9412-1-bart.vanassche@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello Michael, Coly and Christoph,

A few weeks ago I analyzed the compiler (W=1), sparse and smatch warnings
triggered by the bcache driver. This patch series is what I came up with.
Although none of these patches have been tested I think these patches are
worth a closer look. Feedback is welcome.

Thanks,

Bart.

Bart Van Assche (16):
  bcache: Fix indentation
  bcache: Add __printf annotation to __bch_check_keys()
  bcache: Annotate switch fall-through
  bcache: Fix kernel-doc warnings
  bcache: Remove an unused variable
  bcache: Suppress more warnings about set-but-not-used variables
  bcache: Reduce the number of sparse complaints about lock imbalances
  bcache: Fix a compiler warning in bcache_device_init()
  bcache: Remove a redundant assignment
  bcache: Suppress a compiler warning in bch_##name##_h()
  bcache: Check the d->disk pointer before using it
  bcache: Make it easier for static analyzers to analyze
    bch_allocator_thread()
  bcache: Make bch_dump_read() fail if copying to user space fails
  bcache: Make csum_set() implementation easier to read
  bcache: Fix an endianness bug
  bcache: Fix endianness annotations

 drivers/md/bcache/alloc.c     |   7 +--
 drivers/md/bcache/bcache.h    |  22 ++++++--
 drivers/md/bcache/bset.c      |   4 +-
 drivers/md/bcache/bset.h      |   5 +-
 drivers/md/bcache/btree.c     |   4 +-
 drivers/md/bcache/closure.c   |   8 +--
 drivers/md/bcache/debug.c     |   5 +-
 drivers/md/bcache/extents.c   |   2 -
 drivers/md/bcache/journal.c   |   4 +-
 drivers/md/bcache/request.c   |   1 +
 drivers/md/bcache/super.c     |  23 ++++----
 drivers/md/bcache/util.c      |  33 +++++++-----
 drivers/md/bcache/writeback.h |   2 +-
 include/uapi/linux/bcache.h   | 118 ++++++++++++++++++++++--------------------
 14 files changed, 131 insertions(+), 107 deletions(-)

-- 
2.16.2
