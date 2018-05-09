Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:38900 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934164AbeEIJJB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 May 2018 05:09:01 -0400
Received: by mail-pf0-f195.google.com with SMTP id o76so25321996pfi.5
        for <linux-block@vger.kernel.org>; Wed, 09 May 2018 02:09:01 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@fb.com>, kernel-team@fb.com
Subject: [PATCH v3 0/7] block: consolidate struct request timestamp fields
Date: Wed,  9 May 2018 02:08:46 -0700
Message-Id: <cover.1525856630.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Here's the timestamp field rework rebased on for-4.18/block. The only
conflict was the blk stat bits, which this series removes in favor of
rq->wbt_flags. No other changes since v2.

Cover letter from v1:

Currently, struct request has four timestamp fields:

- start_time (jiffies), marked at get_request() time and used for
  iostats
- issue_stat (ktime nanoseconds, with some bits shared with wbt and
  io.low), marked at start_request() time and used for accounting the
  time spent in the device for blk-stats (i.e., wbt, kyber, hybrid
  polling)
- start_time_ns (sched_clock nanoseconds), also marked at get_request()
  time, used for CFQ and BFQ cgroups support
- io_start_time_ns (sched_clock nanoseconds), also marked at
  start_request() time and also used for CFQ and BFQ

Clearly, there's some redundancy here. This patch series consolidates
these four timestamps into two, both of which are in ktime nanoseconds.
This shaves off up to 16 bytes from struct request, gets rid of the
usage of sched_clock(), and actually removes lines of code.

Patches 1 and 2 do some prep in wbt. Patch 3 does some prep in io.low.
Patch 4 splits up issue_stat into just a timestamp and separate fields
to fill a hole in struct request. Patch 5 does some prep in CFQ and BFQ.
Patch 6 allows us to save a call to ktime_get(). Patch 7 does the final
consolidation.

Please take a look. I added a blktest (block/018) to sanity check
iostats, but other stuff is harder to test so it could use some eyes.
Thanks!

Omar Sandoval (7):
  block: move some wbt helpers to blk-wbt.c
  block: pass struct request instead of struct blk_issue_stat to wbt
  block: replace bio->bi_issue_stat with bio-specific type
  block: get rid of struct blk_issue_stat
  block: use ktime_get_ns() instead of sched_clock() for cfq and bfq
  block: move blk_stat_add() to __blk_mq_end_request()
  block: consolidate struct request timestamp fields

 block/bfq-cgroup.c        | 40 ++++++++++++------------
 block/bfq-iosched.c       |  4 +--
 block/bfq-iosched.h       | 10 +++---
 block/blk-core.c          | 32 +++++++++++---------
 block/blk-merge.c         | 11 +++----
 block/blk-mq.c            | 33 +++++++++++---------
 block/blk-stat.c          | 10 ++----
 block/blk-stat.h          | 45 +--------------------------
 block/blk-throttle.c      | 22 ++++++--------
 block/blk-wbt.c           | 59 +++++++++++++++++++++++-------------
 block/blk-wbt.h           | 47 +++++++++-------------------
 block/blk.h               |  2 +-
 block/cfq-iosched.c       | 64 ++++++++++++++++++---------------------
 block/kyber-iosched.c     |  6 ++--
 drivers/md/dm-rq.c        |  2 +-
 include/linux/blk_types.h | 49 ++++++++++++++++++++++++++++--
 include/linux/blkdev.h    | 61 +++++++++----------------------------
 17 files changed, 228 insertions(+), 269 deletions(-)

-- 
2.17.0
