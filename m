Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A0BC04EB8
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 18:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E5EA20834
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 18:36:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E5EA20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726006AbeLDSgF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 13:36:05 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:35248 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbeLDSgF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Dec 2018 13:36:05 -0500
Received: by mail-yw1-f67.google.com with SMTP id h32so7397120ywk.2;
        Tue, 04 Dec 2018 10:36:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PngW+zHDTehzFZdt5/WrhsrAhc9bGD9P26Ud3RbTyIU=;
        b=DOzQYWjgRqbZPCiwf1z5ekkKqXUmm0MwzbRLjIUPETbpAciRCmIb1XmcxLtU8NycG1
         6CRNItFn/B7Q3fFsrBRBqZyURFB/TaiZJ20hFfYdTkoQ0vG3OehFdN1eU504Qb29MZmf
         QolC6zZldlwhiGhxJd15BnQD9iSE+nTvt8w2SNLZFnuE/0jCruBBq9Kh77keWzzjfH6/
         v4EkEIvZqj8CZxWHJtBu8OL9Dn0FgryX+buaXDHaZIh2WUWKQQzS0QtwtiUlhIN9Z0Cz
         VxuX3V/ynk49f9HLGeApACqxhEP92AZZUf4sM9G0J2RNHrwiuYz0dv1u+68B0BCZ3x5C
         +W3g==
X-Gm-Message-State: AA+aEWZAL4zfudIVRLlW8MQDJkjxB9yPIZtyMyujshOmpN5rYYduCXnM
        ZMQTpiRrUG/TsROCfdrFyTQ=
X-Google-Smtp-Source: AFSGD/XDdAObGumK0waRHGW8qcx3/7DgJX2Epx040vaSuA73/YiH9eTtgXEg4nImg1SbXu/PB2xm2A==
X-Received: by 2002:a81:5404:: with SMTP id i4mr21679468ywb.364.1543948564064;
        Tue, 04 Dec 2018 10:36:04 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([199.201.65.135])
        by smtp.gmail.com with ESMTPSA id x82sm4274798ywb.34.2018.12.04.10.36.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Dec 2018 10:36:03 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH v5 00/14] block: always associate blkg and refcount cleanup
Date:   Tue,  4 Dec 2018 13:35:46 -0500
Message-Id: <20181204183600.99746-1-dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi everyone,

A special case with dm is the flush bio which is statically initialized
before the block device is opened and associated with a disk. This
caused blkg association to throw a NPE. 0005 addresses this case by
moving association to be on the flush path.

With v4 moving association to piggyback off of bio_set_dev(), this
caused a NPE to be thrown by the special case above. I was overly
cautious with v4 and added the bio_has_queue() check which is now
removed in v5.

Also, the addition of bio_set_dev_only() wasn't quite right due to
writeback and swap sharing the same bio init paths in many places. The
safer thing to do is double association for those paths and in a follow
up series split out the bio init paths.

Changes in v5: 
All:  Fixed minor grammar and syntactic issues.
0004: Removed bio_has_queue() for being overly cautious.
0005: New, properly addressed the static flush_bio in md. 
0006: Removed the rcu lock in blkcg_bio_issue_check() as the bio will
      own a ref on the blkg so it is unnecessary.
0011: Consolidated bio_associate_blkg_from_css() (removed __ version).

From v4:
This is respin of v3 [1] with fixes for the errors reported in [2] and
[3]. v3 was reverted in [4].

The issue in [3] was that bio->bi_disk->queue and blkg->q were out
of sync. So when I changed blk_get_rl() to use blkg->q, the wrong queue
was returned and elevator from q->elevator->type threw a NPE. Note, with
v4.21, the old block stack was removed and so this patch was dropped. I
did backport this to v4.20 and verified this series does not encounter
the error.

The biggest changes in v4 are when association occurs and clearly
defining the cases where association should happen.
  1. Association is now done when the device is set to keep blkg->q and
     bio->bi_disk->queue in sync.
  2. When a bio is submitted directly to the device, it will not be
     associated with a blkg. This is because a blkg represents the
     relationship between a blkcg and a request_queue. Going directly to
     the device means the request_queue may not exist meaning no blkg
     will exist.

The patch updating blk_get_rl() was dropped (v3 10/12). The patch to
always associate a blkg from v3 (v3 04/12) was fixed and split into
patches 0004 and 0005. 0011 is new removing bio_disassociate_task().

Summarizing the ideas of this series:
  1. Gracefully handle blkg failure to create by walking up the blkg
     tree rather than fall through to root.
  2. Associate a bio with a blkg in core logic rather than per
     controller logic.
  3. Rather than have a css and blkg reference, hold just a blkg ref
     as it also holds a css ref.
  4. Switch to percpu ref counting for blkg.

[1] https://lore.kernel.org/lkml/20180911184137.35897-1-dennisszhou@gmail.com/ 
[2] https://lore.kernel.org/lkml/13987.1539646128@turing-police.cc.vt.edu/
[3] https://marc.info/?l=linux-cgroups&m=154110436103723
[4] https://lore.kernel.org/lkml/20181101212410.47569-1-dennis@kernel.org/

This patchset contains the following 14 patches:
  0001-blkcg-fix-ref-count-issue-with-bio_blkcg-using-task_.patch
  0002-blkcg-update-blkg_lookup_create-to-do-locking.patch
  0003-blkcg-convert-blkg_lookup_create-to-find-closest-blk.patch
  0004-blkcg-introduce-common-blkg-association-logic.patch
  0005-dm-set-flush-bio-device-on-demand.patch
  0006-blkcg-associate-blkg-when-associating-a-device.patch
  0007-blkcg-consolidate-bio_issue_init-to-be-a-part-of-cor.patch
  0008-blkcg-associate-a-blkg-for-pages-being-evicted-by-sw.patch
  0009-blkcg-associate-writeback-bios-with-a-blkg.patch
  0010-blkcg-remove-bio-bi_css-and-instead-use-bio-bi_blkg.patch
  0011-blkcg-remove-additional-reference-to-the-css.patch
  0012-blkcg-remove-bio_disassociate_task.patch
  0013-blkcg-change-blkg-reference-counting-to-use-percpu_r.patch
  0014-blkcg-rename-blkg_try_get-to-blkg_tryget.patch

This patchset is on top of linu-block#for-4.21/block 154989e45fd8.

diffstats below:

Dennis Zhou (14):
  blkcg: fix ref count issue with bio_blkcg() using task_css
  blkcg: update blkg_lookup_create() to do locking
  blkcg: convert blkg_lookup_create() to find closest blkg
  blkcg: introduce common blkg association logic
  dm: set the static flush bio device on demand
  blkcg: associate blkg when associating a device
  blkcg: consolidate bio_issue_init() to be a part of core
  blkcg: associate a blkg for pages being evicted by swap
  blkcg: associate writeback bios with a blkg
  blkcg: remove bio->bi_css and instead use bio->bi_blkg
  blkcg: remove additional reference to the css
  blkcg: remove bio_disassociate_task()
  blkcg: change blkg reference counting to use percpu_ref
  blkcg: rename blkg_try_get() to blkg_tryget()

 Documentation/admin-guide/cgroup-v2.rst |   8 +-
 block/bfq-cgroup.c                      |   4 +-
 block/bfq-iosched.c                     |   2 +-
 block/bio.c                             | 156 +++++++++++++++---------
 block/blk-cgroup.c                      |  95 ++++++++++++---
 block/blk-iolatency.c                   |  24 +---
 block/blk-throttle.c                    |  11 --
 block/bounce.c                          |   3 +-
 drivers/block/loop.c                    |   5 +-
 drivers/md/dm.c                         |  12 +-
 drivers/md/raid0.c                      |   2 +-
 fs/buffer.c                             |  10 +-
 fs/ext4/page-io.c                       |   2 +-
 include/linux/bio.h                     |  29 +++--
 include/linux/blk-cgroup.h              | 120 ++++++++++++------
 include/linux/blk_types.h               |   7 +-
 include/linux/cgroup.h                  |   2 +
 include/linux/writeback.h               |   5 +-
 kernel/cgroup/cgroup.c                  |  48 ++++++--
 kernel/trace/blktrace.c                 |   4 +-
 mm/page_io.c                            |   2 +-
 21 files changed, 361 insertions(+), 190 deletions(-)

Thanks,
Dennis
