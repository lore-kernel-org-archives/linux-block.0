Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wr0-f169.google.com ([209.85.128.169]:34936 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752486AbeADTAG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Jan 2018 14:00:06 -0500
Received: by mail-wr0-f169.google.com with SMTP id l19so2402550wrc.2
        for <linux-block@vger.kernel.org>; Thu, 04 Jan 2018 11:00:05 -0800 (PST)
From: Paolo Valente <paolo.valente@linaro.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: unify the interface of the proportional-share policy in blkio/io
Message-Id: <56EFD7A1-A894-410D-A923-E33911ED4647@linaro.org>
Date: Thu, 4 Jan 2018 20:00:02 +0100
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        ANGELO RUOCCO <220530@studenti.unimore.it>
To: Tejun Heo <tj@kernel.org>, lennart@poettering.net,
        Jens Axboe <axboe@fb.com>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Tejun, Jens, all,
the shares of storage resources are controlled through weights in the
proportional-share policy of the blkio/io controllers of the cgroups
subsystem.  But, on blk-mq, this control doesn't work for any legacy
application, service or tool.  In a similar vein, in most of the
interface files where legacy code expects to find statistics,
statistics are not updated at all.  The cause is as follows.

For devices using blk-mq, the proportional-share policy is enforced by
BFQ, while CFQ enforces this policy for blk.  But the current
implementation of blkio/io doesn't allow two I/O schedulers to share
the same interface sysfs files; so, if CFQ creates these files for the
proportional-share policy for blk, BFQ cannot attach somehow to them,
and viceversa.  One of these parameters is the weight of blkio/io
groups, used to control resource shares.  So, to still allow people to
set group weights with BFQ, I resorted to making BFQ create its own
weight parameter, with a different name: bfq.weight.  I used a similar
approach to replicate all statistic files.

Of course, no legacy code uses these different names, or is likely to
do so.  Having these two sets of names is simply a source of
confusion, as also pointed out, e.g., by Lennart Poettering, and
acknowledged by Tejun [1].

So, I started to work on getting a unified interface, with a
collaborator.  And we designed a solution that seems sensible to us.
Before proceeding with the implementation, we would need some feedback
on this solution, especially to avoid wasting time on the wrong
solution.

The code that shows or reads values through blkio/io parameters, for
the proportional-share policy, is currently fully contained in the BFQ
and CFQ schedulers.  We want to split this code into two parts:
1.  I/O part, which reads the value passed by the user, and shows the
value to the user; we want to move this part, which becomes common
among schedulers, into blk-cgroup.c or the like.
2.  get/set part, which gets/gives the value from/to the above part,
reading/writing this value from/to the internal state of the
scheduler; each scheduler knows what to do exactly for each of these
get/set function, so this part will stay in the scheduler.

In addition, we consider two types of parameters:
1. exact parameters, such as the weight, for which: (a) the
read-from-user function (I/O part moved to blk-cgroup) must pass the
value read to both I/O schedulers, through the set functions of the
schedulers, and (b) the show-to-user function (I/O part moved to
blk-cgroup) assumes that it would get the same value from any of the
two schedulers;
2. cumulative parameters such as the statistics, for which the related
code is identical (and replicated) in CFQ and BFQ.  Our idea, in this
case, is to move the common code into blk-cgroup, and leave in the
schedulers only the parts that may differ.  In practice, to update
statistics, CFQ and BFQ will invoke common blk-cgroup functions, and
the latter will take care of properly cumulating/combining statistics.

The solution for the second type of parameters may prove useful to
unify also the computation of statistics for the throttling policy.

Does this proposal sound reasonable?

Thanks,
Paolo

[1] https://github.com/systemd/systemd/issues/7057
