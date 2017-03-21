Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f46.google.com ([74.125.83.46]:33685 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757074AbdCUP5H (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Mar 2017 11:57:07 -0400
Received: by mail-pg0-f46.google.com with SMTP id n190so95800365pga.0
        for <linux-block@vger.kernel.org>; Tue, 21 Mar 2017 08:57:06 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: linux-block@vger.kernel.org
Cc: kernel-team@fb.com
Subject: [PATCH v2 0/4] block: callback-based statistics
Date: Tue, 21 Mar 2017 08:56:04 -0700
Message-Id: <cover.1490110621.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

This patchset generalizes the blk-stats infrastructure to allow users to
register a callback to be called at a given time with the statistics of
requests completed during that window. Writeback throttling and hybrid
polling are converted to the new infrastructure. The new Kyber I/O
scheduler uses this, as well (but it needs to be rebased on this v2).

The details are in patch 4, which is the actual conversion. Patches 1-3
are preparation cleanups.

Changes since v1:

- Now the user can subdivide stats into arbitrary buckets. Both in-tree
  users just do reads vs. writes, but we can extend poll based on
  request size in the future
- blk_stat_arm_callback() became blk_stat_activate_msecs() and
  blk_stat_activate_nsecs()
- The poll statistics are exposed in debugfs

Omar Sandoval (4):
  block: remove extra calls to wbt_exit()
  blk-stat: use READ and WRITE instead of BLK_STAT_{READ,WRITE}
  blk-stat: move BLK_RQ_STAT_BATCH definition to blk-stat.c
  blk-stat: convert to callback-based statistics reporting

 block/blk-core.c          |   7 +-
 block/blk-mq-debugfs.c    |  99 +++++++--------
 block/blk-mq.c            |  78 ++++++++----
 block/blk-mq.h            |   1 -
 block/blk-stat.c          | 315 ++++++++++++++++++++++------------------------
 block/blk-stat.h          | 182 ++++++++++++++++++++++++---
 block/blk-sysfs.c         |  31 +----
 block/blk-wbt.c           |  61 ++++-----
 block/blk-wbt.h           |   2 +-
 include/linux/blk_types.h |   3 -
 include/linux/blkdev.h    |  10 +-
 11 files changed, 454 insertions(+), 335 deletions(-)

-- 
2.12.0
