Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33295 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbeHIWxY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Aug 2018 18:53:24 -0400
Received: by mail-pf1-f193.google.com with SMTP id d4-v6so3390234pfn.0
        for <linux-block@vger.kernel.org>; Thu, 09 Aug 2018 13:26:55 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@fb.com>, kernel-team@fb.com
Subject: [RFC PATCH 0/5] kyber: better heuristics
Date: Thu,  9 Aug 2018 13:26:42 -0700
Message-Id: <cover.1533846185.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Hello,

I've spent the past few weeks experimenting with different heuristics
for Kyber in order to deal with some edge cases we've hit here. This
series is my progress so far, implementing less handwavy heuristics
while keeping the same basic mechanisms. Patches 1 and 2 are
preparation. Patch 3 is a minor optimization. Patch 4 is the main
change, and includes a detailed description of the new heuristics. Patch
5 adds tracepoints for debugging.

Please, take a look and try it out.

Thanks!

Omar Sandoval (5):
  block: move call of scheduler's ->completed_request() hook
  block: export blk_stat_enable_accounting()
  kyber: don't make domain token sbitmap larger than necessary
  kyber: implement improved heuristics
  kyber: add tracepoints

 block/blk-mq-sched.h         |   4 +-
 block/blk-mq.c               |   5 +-
 block/blk-stat.c             |   1 +
 block/kyber-iosched.c        | 541 +++++++++++++++++++----------------
 include/linux/elevator.h     |   2 +-
 include/trace/events/kyber.h |  76 +++++
 6 files changed, 383 insertions(+), 246 deletions(-)
 create mode 100644 include/trace/events/kyber.h

-- 
2.18.0
