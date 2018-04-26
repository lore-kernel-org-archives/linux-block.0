Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:35289 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752148AbeDZHWH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Apr 2018 03:22:07 -0400
Received: by mail-it0-f68.google.com with SMTP id 186-v6so22538000itu.0
        for <linux-block@vger.kernel.org>; Thu, 26 Apr 2018 00:22:07 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@fb.com>, kernel-team@fb.com
Subject: [PATCH 0/2] block: inflight counter fixes
Date: Thu, 26 Apr 2018 00:21:57 -0700
Message-Id: <cover.1524727168.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Hi, Jens,

I added a blktest (block/017) for the inflight counter after you
mentioned that we should have one and it easily found a bug :) Patch 2
fixes the bug found by the test, and patch 1 fixes another bug I
noticed. Based on Linus' master.

Thanks!

Omar Sandoval (2):
  blk-mq: count allocated but not started requests in iostats inflight
  blk-mq: fix sysfs inflight counter

 block/blk-mq.c            | 40 +++++++++++++++++++++++++++------------
 block/blk-mq.h            |  4 +++-
 block/genhd.c             | 12 ++++++++++++
 block/partition-generic.c | 10 ++++++----
 include/linux/genhd.h     |  4 +++-
 5 files changed, 52 insertions(+), 18 deletions(-)

-- 
2.17.0
