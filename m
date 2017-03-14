Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f53.google.com ([74.125.83.53]:33875 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752903AbdCNVEa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Mar 2017 17:04:30 -0400
Received: by mail-pg0-f53.google.com with SMTP id 141so240303pgd.1
        for <linux-block@vger.kernel.org>; Tue, 14 Mar 2017 14:04:29 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: linux-block@vger.kernel.org
Cc: kernel-team@fb.com
Subject: [PATCH 0/4] block: callback-based statistics
Date: Tue, 14 Mar 2017 14:03:27 -0700
Message-Id: <cover.1489524591.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

This patchset generalizes the blk-stats infrastructure to allow users to
register a callback to be called at a given time with the statistics of
requests completed during that window. Writeback throttling and hybrid
polling are converted to the new infrastructure. The ultimate goal is to
use this infrastructure for the mq I/O scheduler.

The details are in patch 4, which is the actual conversion. Patches 1-3
are preparation cleanups.

A couple of minor open issues:

- Since there is no single source of truth for stats anymore (it's
  per-callback now), I got rid of the sysfs/debugfs files. If we still
  want these, we could potentially expose the statistics that poll is
  using.
- Polling used to use per-hctx stats, but now the stats are gathered to
  a per-request_queue cache. This might make the stats noisier, but we
  can improve this in the future by splitting out stats by request size
  or something like that.

Omar Sandoval (4):
  block: tear out blk-stat debugfs/sysfs entries
  block: remove extra calls to wbt_exit()
  block: change stats from array type to struct type
  blk-stats: convert to callback-based statistics reporting

 block/blk-core.c           |   7 +-
 block/blk-mq-debugfs.c     |  55 ---------
 block/blk-mq.c             |  79 ++++++++----
 block/blk-mq.h             |   1 -
 block/blk-stat.c           | 300 ++++++++++++++++++++-------------------------
 block/blk-stat.h           |  98 ++++++++++++---
 block/blk-sysfs.c          |  31 +----
 block/blk-wbt.c            |  66 +++++-----
 block/blk-wbt.h            |   2 +-
 include/linux/blk_types.h  |   8 +-
 include/linux/blkdev.h     |  10 +-
 include/trace/events/wbt.h |  20 +--
 12 files changed, 331 insertions(+), 346 deletions(-)

-- 
2.12.0
