Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36073 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbeI1FRJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Sep 2018 01:17:09 -0400
Received: by mail-pf1-f196.google.com with SMTP id b7-v6so2915353pfo.3
        for <linux-block@vger.kernel.org>; Thu, 27 Sep 2018 15:56:31 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@fb.com>, kernel-team@fb.com
Subject: [PATCH v2 0/5] kyber: better heuristics
Date: Thu, 27 Sep 2018 15:55:50 -0700
Message-Id: <cover.1538088475.git.osandov@fb.com>
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Hi,

This is my series to improve the heuristics used by Kyber. Patches 1 and
2 are preparation. Patch 3 is a minor optimization. Patch 4 is the main
change, and includes a detailed description of the new heuristics. Patch
5 adds tracepoints for debugging. This is basically the same as the RFC
I posted back in August [1] with one added tracepoint (kyber_throttled)
and rebased on linux-block/for-next.

Thanks!

1: https://www.spinics.net/lists/linux-block/msg29453.html

Omar Sandoval (5):
  block: move call of scheduler's ->completed_request() hook
  block: export blk_stat_enable_accounting()
  kyber: don't make domain token sbitmap larger than necessary
  kyber: implement improved heuristics
  kyber: add tracepoints

 block/blk-mq-sched.h         |   4 +-
 block/blk-mq.c               |   5 +-
 block/blk-stat.c             |   1 +
 block/kyber-iosched.c        | 547 ++++++++++++++++++++---------------
 include/linux/elevator.h     |   2 +-
 include/trace/events/kyber.h |  96 ++++++
 6 files changed, 409 insertions(+), 246 deletions(-)
 create mode 100644 include/trace/events/kyber.h

-- 
2.19.0
