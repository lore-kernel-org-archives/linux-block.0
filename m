Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:34261 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750784AbdDNIBG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Apr 2017 04:01:06 -0400
Received: by mail-pf0-f172.google.com with SMTP id c198so38505373pfc.1
        for <linux-block@vger.kernel.org>; Fri, 14 Apr 2017 01:01:06 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: kernel-team@fb.com
Subject: [PATCH v4 0/5] blk-mq: Kyber multiqueue I/O scheduler
Date: Fri, 14 Apr 2017 00:59:57 -0700
Message-Id: <cover.1492156558.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

This is v4 of Kyber, an I/O scheduler for multiqueue devices combining
several techniques: the scalable bitmap library, the new blk-stats API,
and queue depth throttling similar to blk-wbt. v1 was here [1], v2 was
here [2], v3 was here [3].

v4 fixes a hang in v3 caused by a race condition in the wait queue
handling in kyber_get_domain_token().

This series is based on block/for-next. Patches 1 and 2 implement a new
sbitmap operation. Patch 3 exports a couple of helpers. Patch 4 moves a
scheduler callback to somewhere more useful. Patch 5 implements the new
scheduler.

Thanks!

1: http://marc.info/?l=linux-block&m=148978871820916&w=2
2: http://marc.info/?l=linux-block&m=149132467510945&w=2
3: http://marc.info/?l=linux-block&m=149180713919341&w=2

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
 block/kyber-iosched.c                 | 719 ++++++++++++++++++++++++++++++++++
 include/linux/blk-mq.h                |   1 +
 include/linux/elevator.h              |   2 +-
 include/linux/sbitmap.h               |  55 +++
 lib/sbitmap.c                         |  75 +++-
 12 files changed, 882 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/block/kyber-iosched.txt
 create mode 100644 block/kyber-iosched.c

-- 
2.12.2
