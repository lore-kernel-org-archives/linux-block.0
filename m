Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:35546 "EHLO
        mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753892AbcIQI2i (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 17 Sep 2016 04:28:38 -0400
Received: by mail-pa0-f51.google.com with SMTP id oz2so28458558pac.2
        for <linux-block@vger.kernel.org>; Sat, 17 Sep 2016 01:28:37 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Alexei Starovoitov <ast@fb.com>
Subject: [PATCH v4 0/6] blk-mq: generalization and bug fixes for tag allocation
Date: Sat, 17 Sep 2016 01:28:20 -0700
Message-Id: <cover.1474100040.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

This is v4 of the patch series to turn blk-mq's scalable tag allocation
into a generic library, fixing a few bugs along the way. This is both
cleanup and preparation for coming blk-mq work.

v1 is here [1], v2 is here [2], v3 is here [3].

Changes in v4:

- Added patch 6 to fix a bug in blk-mq where shrinking the tag set
  doesn't stop allocations from happening to high tags.
- Changed the interface for raw `sbitmap_get()` to pass the allocation
  hint as a value, not a pointer. This pushes the hint updating out into
  `sbitmap_queue_get()` where it makes more sense.

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

Applies to v4.8-rc6.

Thanks!

1: http://marc.info/?l=linux-block&m=147251402805405&w=2
2: http://marc.info/?l=linux-block&m=147329198222482&w=2
3: http://marc.info/?l=linux-block&m=147344663202718&w=2

Omar Sandoval (6):
  blk-mq: abstract tag allocation out into sbitmap library
  sbitmap: allocate wait queues on a specific node
  sbitmap: push per-cpu last_tag into sbitmap_queue
  sbitmap: push alloc policy into sbitmap_queue
  sbitmap: randomize initial alloc_hint values
  sbitmap: re-initialize allocation hints after resize

 MAINTAINERS             |   1 +
 block/Kconfig           |   1 +
 block/blk-mq-tag.c      | 503 +++++++++++-------------------------------------
 block/blk-mq-tag.h      |  42 ++--
 block/blk-mq.c          | 114 ++++-------
 block/blk-mq.h          |  11 --
 include/linux/blk-mq.h  |   9 +-
 include/linux/sbitmap.h | 373 +++++++++++++++++++++++++++++++++++
 lib/Kconfig             |   3 +
 lib/Makefile            |   2 +
 lib/sbitmap.c           | 347 +++++++++++++++++++++++++++++++++
 11 files changed, 889 insertions(+), 517 deletions(-)
 create mode 100644 include/linux/sbitmap.h
 create mode 100644 lib/sbitmap.c

-- 
2.9.3

