Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:34240 "EHLO
        mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751725AbcIGXqS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Sep 2016 19:46:18 -0400
Received: by mail-pa0-f41.google.com with SMTP id to9so10872634pac.1
        for <linux-block@vger.kernel.org>; Wed, 07 Sep 2016 16:46:17 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 0/5] blk-mq: abstract tag allocation out into scale_bitmap library
Date: Wed,  7 Sep 2016 16:46:01 -0700
Message-Id: <cover.1473291702.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Here's v2 of the patch making blk-mq's scalable bitmaps a generic
library, now blown up into 5 patches. v1 is here [1].

Changes since v1:

- Return -EINVAL instead of BUG_ON() if an invalid shift is passed to
  the initialization functions.
- Rename last_cache to alloc_hint.
- Split the wait queue allocation change into a separate patch. Patch 1
  should now be a no-op.
- Add patches 3 and 4 to make the API cleaner by pushing some context
  from the blk-mq data structures into the common scale_bitmap code.
- Add patch 5 to randomize the allocation hint on initialization like
  was intended originally for blk-mq.

I ran some fio jobs on top of null-blk and verified that there was no
performance impact from patches 1-4. Patch 5 is a slight win, although I
couldn't come up with a benchmark where the tag allocation is enough of
a bottleneck to see huge benefits. My synthetic test module [2], which
does the scale_bitmap operations directly, shows much better results.

This survived a quick run of xfstests and a battery of benchmarks.
Applies to 4.8-rc5.

Thanks!

1: http://marc.info/?l=linux-block&m=147251402805405&w=2
2: https://github.com/osandov/osandov-linux/blob/master/modules/scale_bitmap_benchmark/scale_bitmap_benchmark.c

Omar Sandoval (5):
  blk-mq: abstract tag allocation out into scale_bitmap library
  scale_bitmap: allocate wait queues on a specific node
  scale_bitmap: push per-cpu last_tag into scale_bitmap_queue
  scale_bitmap: push alloc policy into scale_bitmap_queue
  scale_bitmap: randomize initial last_cache values

 MAINTAINERS                  |   1 +
 block/Kconfig                |   1 +
 block/blk-mq-tag.c           | 504 ++++++++++---------------------------------
 block/blk-mq-tag.h           |  42 ++--
 block/blk-mq.c               | 115 +++-------
 block/blk-mq.h               |  11 -
 include/linux/blk-mq.h       |   9 +-
 include/linux/scale_bitmap.h | 390 +++++++++++++++++++++++++++++++++
 lib/Kconfig                  |   3 +
 lib/Makefile                 |   2 +
 lib/scale_bitmap.c           | 325 ++++++++++++++++++++++++++++
 11 files changed, 887 insertions(+), 516 deletions(-)
 create mode 100644 include/linux/scale_bitmap.h
 create mode 100644 lib/scale_bitmap.c

-- 
2.9.3

