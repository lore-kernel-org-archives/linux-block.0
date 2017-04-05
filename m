Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f54.google.com ([74.125.83.54]:35766 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753787AbdDES3W (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Apr 2017 14:29:22 -0400
Received: by mail-pg0-f54.google.com with SMTP id 81so12173446pgh.2
        for <linux-block@vger.kernel.org>; Wed, 05 Apr 2017 11:29:22 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: kernel-team@fb.com
Subject: [PATCH v2 0/8] blk-mq: various fixes and cleanups
Date: Wed,  5 Apr 2017 11:28:12 -0700
Message-Id: <cover.1491416593.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

This v2 of my series from a couple of days ago [1] with one extra fix
and two extra cleanups.

- Patch 1 is the new fix for a hang that Josef reported after trying v1.
- Patches 2-6 are the original series. Patch 5 now has Christoph's and
  Sagi's Reviewed-by.
- Patches 7 and 8 are trivial cleanups.

Patches 1-5 should probably go into 4.11, and 6-8 are for 4.12.

1: http://marc.info/?l=linux-block&m=149125578724683&w=2

Omar Sandoval (8):
  blk-mq: use the right hctx when getting a driver tag fails
  blk-mq-sched: refactor scheduler initialization
  blk-mq-sched: set up scheduler tags when bringing up new queues
  blk-mq-sched: fix crash in switch error path
  blk-mq: remap queues when adding/removing hardware queues
  blk-mq-sched: provide hooks for initializing hardware queue data
  blk-mq: make driver tag failure path easier to follow
  blk-mq: clean up direct issue blk_mq_queue_data initialization

 block/blk-mq-sched.c     | 187 +++++++++++++++++++++++++++++------------------
 block/blk-mq-sched.h     |  13 ++--
 block/blk-mq.c           |  72 ++++++++++--------
 block/blk-mq.h           |   2 +-
 block/blk-sysfs.c        |   2 +-
 block/elevator.c         | 114 +++++++++++++++--------------
 include/linux/elevator.h |   4 +-
 7 files changed, 227 insertions(+), 167 deletions(-)

-- 
2.12.2
