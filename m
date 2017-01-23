Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:35239 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750705AbdAWTAT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Jan 2017 14:00:19 -0500
Received: by mail-pf0-f174.google.com with SMTP id f144so43215960pfa.2
        for <linux-block@vger.kernel.org>; Mon, 23 Jan 2017 11:00:19 -0800 (PST)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: kernel-team@fb.com
Subject: [PATCH 00/10] blk-mq: move debugging information from sysfs to debugfs
Date: Mon, 23 Jan 2017 10:59:37 -0800
Message-Id: <cover.1485197480.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

This series ends our abuse of sysfs and puts all of the debugging information
in debugfs instead. This has a few benefits:

1. Removes the possibility of userspace being stupid and relying on something
   in sysfs that we only exposed for debugging.
2. Lifts the limitations of sysfs, including the one-value-per-file convention
   and maximum of one page of output.
3. Allows us to add more debugging information that we often want but don't
   have when debugging a live system.

Thanks!
Omar

Omar Sandoval (10):
  blk-mq: create debugfs directory tree
  blk-mq: add hctx->{state,flags} to debugfs
  blk-mq: move hctx->dispatch and ctx->rq_list from sysfs to debugfs
  blk-mq: add extra request information to debugfs
  sbitmap: add helpers for dumping to a seq_file
  blk-mq: export software queue pending map to debugfs
  blk-mq: move tags and sched_tags info from sysfs to debugfs
  blk-mq: add tags and sched_tags bitmaps to debugfs
  blk-mq: move hctx io_poll, stats, and dispatched from sysfs to debugfs
  blk-mq: move hctx and ctx counters from sysfs to debugfs

 block/Makefile          |   1 +
 block/blk-mq-debugfs.c  | 750 ++++++++++++++++++++++++++++++++++++++++++++++++
 block/blk-mq-sysfs.c    | 248 ++--------------
 block/blk-mq-tag.c      |  27 --
 block/blk-mq-tag.h      |   1 -
 block/blk-mq.c          |   2 +
 block/blk-mq.h          |  33 +++
 include/linux/blkdev.h  |   5 +
 include/linux/sbitmap.h |  34 +++
 lib/sbitmap.c           |  83 ++++++
 10 files changed, 929 insertions(+), 255 deletions(-)
 create mode 100644 block/blk-mq-debugfs.c

-- 
2.11.0

