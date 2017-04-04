Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f41.google.com ([74.125.83.41]:33142 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752822AbdDDQvH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Apr 2017 12:51:07 -0400
Received: by mail-pg0-f41.google.com with SMTP id x125so157811953pgb.0
        for <linux-block@vger.kernel.org>; Tue, 04 Apr 2017 09:51:07 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: kernel-team@fb.com
Subject: [PATCH v2 0/5] blk-mq: Kyber multiqueue I/O scheduler
Date: Tue,  4 Apr 2017 09:49:53 -0700
Message-Id: <cover.1491324365.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

This is v2 of Kyber, an I/O scheduler for multiqueue devices combining
several techniques: the scalable bitmap library, the new blk-stats API,
and queue depth throttling similar to blk-wbt. v1 was here [1].

v2 adds a tunable target synchronous write latency. The heuristics are
more fleshed out and balance read and synchronous write latencies based
on the latency targets. The queueing and dispatch mechanism is the same
as before.

This series is based on block/for-next + the initialization fix series I
sent out yesterday [2]. Patches 1 and 2 implement a new sbitmap
operation. Patch 3 moves a scheduler callback to somewhere more useful.
Patch 4 exports a required function. Patch 5 implements the new
scheduler.

Thanks!

1: http://marc.info/?l=linux-block&m=148978871820916&w=2
2: http://marc.info/?l=linux-block&m=149125578724683&w=2

Omar Sandoval (5):
  sbitmap: add sbitmap_get_shallow() operation
  blk-mq: add shallow depth option for blk_mq_get_tag()
  blk-mq-sched: make completed_request() callback more useful
  blk-mq: export blk_mq_finish_request()
  blk-mq: introduce Kyber multiqueue I/O scheduler

 Documentation/block/kyber-iosched.txt |  14 +
 block/Kconfig.iosched                 |   9 +
 block/Makefile                        |   1 +
 block/blk-mq-sched.h                  |  11 +-
 block/blk-mq-tag.c                    |   5 +-
 block/blk-mq.c                        |   6 +-
 block/blk-mq.h                        |   1 +
 block/kyber-iosched.c                 | 706 ++++++++++++++++++++++++++++++++++
 include/linux/elevator.h              |   2 +-
 include/linux/sbitmap.h               |  55 +++
 lib/sbitmap.c                         |  75 +++-
 11 files changed, 867 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/block/kyber-iosched.txt
 create mode 100644 block/kyber-iosched.c

-- 
2.12.2
