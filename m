Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33472 "EHLO
        mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752039AbcIISm2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 9 Sep 2016 14:42:28 -0400
Received: by mail-pa0-f43.google.com with SMTP id cm16so30845258pac.0
        for <linux-block@vger.kernel.org>; Fri, 09 Sep 2016 11:42:27 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Alexei Starovoitov <ast@fb.com>
Subject: [PATCH v3 0/5] blk-mq: abstract tag allocation out into sbitmap library
Date: Fri,  9 Sep 2016 11:42:06 -0700
Message-Id: <cover.1473446095.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

This is v3 of the scalable bitmap library derived from blk-mq's tag
allocation code. v1 is here [1], v2 is here [2].

Changes in v3:

- Renamed scale_bitmap to sbitmap

Changes in v2:

- Return -EINVAL instead of BUG_ON() if an invalid shift is passed to
  the initialization functions.
- Rename last_cache to alloc_hint.
- Split the wait queue allocation change into a separate patch. Patch 1
  should now be a no-op.
- Add patches 3 and 4 to make the API cleaner by pushing some context
  from the blk-mq data structures into the common scale_bitmap code.
- Add patch 5 to randomize the allocation hint on initialization like
  was intended originally for blk-mq.

Applies to v4.8-rc5.

1: http://marc.info/?l=linux-block&m=147251402805405
2: http://marc.info/?l=linux-block&m=147329198222482

Omar Sandoval (5):
  blk-mq: abstract tag allocation out into sbitmap library
  sbitmap: allocate wait queues on a specific node
  sbitmap: push per-cpu last_tag into sbitmap_queue
  sbitmap: push alloc policy into sbitmap_queue
  sbitmap: randomize initial last_cache values

 MAINTAINERS             |   1 +
 block/Kconfig           |   1 +
 block/blk-mq-tag.c      | 503 +++++++++++-------------------------------------
 block/blk-mq-tag.h      |  42 ++--
 block/blk-mq.c          | 114 ++++-------
 block/blk-mq.h          |  11 --
 include/linux/blk-mq.h  |   9 +-
 include/linux/sbitmap.h | 379 ++++++++++++++++++++++++++++++++++++
 lib/Kconfig             |   3 +
 lib/Makefile            |   2 +
 lib/sbitmap.c           | 320 ++++++++++++++++++++++++++++++
 11 files changed, 868 insertions(+), 517 deletions(-)
 create mode 100644 include/linux/sbitmap.h
 create mode 100644 lib/sbitmap.c

-- 
2.9.3

