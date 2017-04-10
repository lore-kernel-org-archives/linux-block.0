Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:34246 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751396AbdDJGwS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Apr 2017 02:52:18 -0400
Received: by mail-pf0-f174.google.com with SMTP id c198so17760114pfc.1
        for <linux-block@vger.kernel.org>; Sun, 09 Apr 2017 23:52:18 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: kernel-team@fb.com
Subject: [PATCH v3 0/5] blk-mq: Kyber multiqueue I/O scheduler
Date: Sun,  9 Apr 2017 23:51:08 -0700
Message-Id: <cover.1491806249.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

This is v3 of Kyber, an I/O scheduler for multiqueue devices combining
several techniques: the scalable bitmap library, the new blk-stats API,
and queue depth throttling similar to blk-wbt. v1 was here [1], v2 was
here [2].

v3 reworks how hardware queues are restarted when domain tokens are
exhausted. Instead of reintroducing the QUEUE_FLAG_RESTART bit, which
was removed in 6d8c6c0f97ad ("blk-mq: Restart a single queue if tag sets
are shared"), the new approach hooks into the sbitmap queues like we do
for driver tags since da55f2cc7841 ("blk-mq: use sbq wait queues instead
of restart for driver tags").

This series is based on block/for-next + the initialization fix series I
sent out yesterday [2]. Patches 1 and 2 implement a new sbitmap
operation. Patch 3 exports a couple of helpers. Patch 4 moves a
scheduler callback to somewhere more useful. Patch 5 implements the new
scheduler.

Thanks!

1: http://marc.info/?l=linux-block&m=148978871820916&w=2
2: http://marc.info/?l=linux-block&m=149132467510945&w=2

Omar Sandoval (5):
  sbitmap: add sbitmap_get_shallow() operation
  blk-mq: add shallow depth option for blk_mq_get_tag()
  blk-mq: export helpers
  blk-mq-sched: make completed_request() callback more useful
  blk-mq: introduce Kyber multiqueue I/O scheduler

 Documentation/block/kyber-iosched.txt |  14 +
 block/Kconfig.iosched                 |   9 +
 block/Makefile                        |   1 +
 block/blk-mq-sched.h                  |  11 +-
 block/blk-mq-tag.c                    |   5 +-
 block/blk-mq.c                        |   7 +-
 block/blk-mq.h                        |   1 +
 block/kyber-iosched.c                 | 717 ++++++++++++++++++++++++++++++++++
 include/linux/blk-mq.h                |   1 +
 include/linux/elevator.h              |   2 +-
 include/linux/sbitmap.h               |  55 +++
 lib/sbitmap.c                         |  75 +++-
 12 files changed, 880 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/block/kyber-iosched.txt
 create mode 100644 block/kyber-iosched.c

-- 
2.12.2
