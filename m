Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176]:33320 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750796AbdAaWyG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Jan 2017 17:54:06 -0500
Received: by mail-pf0-f176.google.com with SMTP id y143so112610806pfb.0
        for <linux-block@vger.kernel.org>; Tue, 31 Jan 2017 14:54:06 -0800 (PST)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: kernel-team@fb.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 0/6] block: fix blk-mq debugfs vs. blktrace
Date: Tue, 31 Jan 2017 14:53:16 -0800
Message-Id: <cover.1485902856.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

When I moved the blk-mq debugging information to debugfs, I didn't
realize that blktrace also created directories in debugfs that
conflicted with the blk-mq directories. This series fixes that.

Patch 1 adds a new debugfs helper needed for patch 6. Greg, could I get
an ack on that if it makes sense? Jens and I went back and forth on this
for a little while, but patch 6 has more of the rationale on why we
decided that this approach was the cleanest.

Patches 2 and 3 are cleanups.

Patch 4 is the first part of the fix, making blk-mq and blktrace use the
same top-level "block" directory.

Patches 5 and 6 make blk-mq and blktrace play nicely with each other
w.r.t. the debugfs "block/$dev" directories.

I tested this with multiple configurations, so hopefully I didn't mess
that up this time.

Applies to for-4.11/block.

Thanks!

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Omar Sandoval (6):
  debugfs: add debugfs_lookup()
  block: fix debugfs config conditional in struct request_queue
  blktrace: make do_blk_trace_setup() static
  block: use same block debugfs directory for blk-mq and blktrace
  blk-mq: move debugfs_remove() of disk dir to blk_release_queue()
  blktrace: use existing disk debugfs directory

 block/blk-core.c             |  9 +++++++++
 block/blk-mq-debugfs.c       | 12 +++---------
 block/blk-mq-sysfs.c         |  2 +-
 block/blk-mq.c               |  2 --
 block/blk-mq.h               |  5 -----
 block/blk-sysfs.c            |  3 +++
 block/blk.h                  |  4 ++++
 fs/debugfs/inode.c           | 36 ++++++++++++++++++++++++++++++++++++
 include/linux/blkdev.h       |  2 +-
 include/linux/blktrace_api.h |  4 ----
 include/linux/debugfs.h      |  8 ++++++++
 kernel/trace/blktrace.c      | 35 +++++++++++++++--------------------
 12 files changed, 80 insertions(+), 42 deletions(-)

-- 
2.11.0

