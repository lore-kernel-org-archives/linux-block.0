Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:35401 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753651AbdBGRZA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Feb 2017 12:25:00 -0500
Received: by mail-wm0-f49.google.com with SMTP id v186so20597132wmd.0
        for <linux-block@vger.kernel.org>; Tue, 07 Feb 2017 09:25:00 -0800 (PST)
From: Paolo Valente <paolo.valente@linaro.org>
To: Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        broonie@kernel.org, Paolo Valente <paolo.valente@linaro.org>
Subject: [WIP PATCHSET 0/4] WIP branch for bfq-mq
Date: Tue,  7 Feb 2017 18:24:42 +0100
Message-Id: <20170207172446.4528-1-paolo.valente@linaro.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi,

I have finally pushed here [1] the current WIP branch of bfq for
blk-mq, which I have tentatively named bfq-mq.

This branch *IS NOT* meant for merging into mainline and contain code
that mau easily violate code style, and not only, in many
places. Commits implement the following main steps:
1) Add the last version of bfq for blk
2) Clone bfq source files into identical bfq-mq source files
3) Modify bfq-mq files to get a working version of bfq for blk-mq
(cgroups support not yet functional)

In my intentions, the main goals of this branch are:

1) Show, as soon as I could, the changes I made to let bfq-mq comply
with blk-mq-sched framework. I though this could be particularly
useful for Jens, being BFQ identical to CFQ in terms of hook
interfaces and io-context handling, and almost identical in terms
request-merging.

2) Enable people to test this first version bfq-mq. Code is purposely
overfull of log messages and invariant checks that halt the system on
failure (lock assertions, BUG_ONs, ...).

To make it easier to revise commits, I'm sending the patches that
transform bfq into bfq-mq (last four patches in the branch [1]). They
work on two files, bfq-mq-iosched.c and bfq-mq.h, which, at the
beginning, are just copies of bfq-iosched.c and bfq.h.

Thanks,
Paolo

[1] https://github.com/Algodev-github/bfq-mq

Paolo Valente (4):
  blk-mq: pass bio to blk_mq_sched_get_rq_priv
  Move thinktime from bic to bfqq
  Embed bfq-ioc.c and add locking on request queue
  Modify interface and operation to comply with blk-mq-sched

 block/bfq-cgroup.c       |   4 -
 block/bfq-mq-iosched.c   | 852 +++++++++++++++++++++++++++++------------------
 block/bfq-mq.h           |  65 ++--
 block/blk-mq-sched.c     |   8 +-
 block/blk-mq-sched.h     |   5 +-
 include/linux/elevator.h |   2 +-
 6 files changed, 567 insertions(+), 369 deletions(-)

--
2.10.0
