Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f49.google.com ([74.125.83.49]:32788 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751210AbdDCVnF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Apr 2017 17:43:05 -0400
Received: by mail-pg0-f49.google.com with SMTP id x125so132433895pgb.0
        for <linux-block@vger.kernel.org>; Mon, 03 Apr 2017 14:43:05 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: kernel-team@fb.com
Subject: [PATCH 0/5] blk-mq: scheduler and hw queue initialization fixes/enhancements
Date: Mon,  3 Apr 2017 14:42:00 -0700
Message-Id: <cover.1491254827.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Hi, Jens,

This series has some fixes and enhancements for blk-mq:

- Patch 1 is a cleanup in preparation for the rest of the series
- Patch 2 is a fix necessary for patch 4 when scheduling is enabled,
  making sure we bring up new hardware queues with scheduler tags
- Patch 3 makes error handling in elevator_switch() more robust, making
  us fall back to none like you recommended last time
- Patch 4 is the remap fix from last week
- Patch 5 is an extension of patch 2 for multiqueue schedulers that
  allocate per-hctx data. Nothing in-tree needs it, but Kyber will.

Let me know if you'd prefer deferring this to 4.12 or want to apply 1-4
for 4.11. These are based on block/for-next, so the latter might require
a respin.

Thanks!

Omar Sandoval (5):
  blk-mq-sched: refactor scheduler initialization
  blk-mq-sched: set up scheduler tags when bringing up new queues
  blk-mq-sched: fix crash in switch error path
  blk-mq: remap queues when adding/removing hardware queues
  blk-mq-sched: provide hooks for initializing hardware queue data

 block/blk-mq-sched.c     | 178 +++++++++++++++++++++++++++++------------------
 block/blk-mq-sched.h     |  13 ++--
 block/blk-mq.c           |  25 +++++--
 block/blk-sysfs.c        |   2 +-
 block/elevator.c         | 114 +++++++++++++++---------------
 include/linux/elevator.h |   4 +-
 6 files changed, 198 insertions(+), 138 deletions(-)

-- 
2.12.2
