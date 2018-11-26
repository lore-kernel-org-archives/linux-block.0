Return-Path: <SRS0=/l1b=OF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF68C43441
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 21:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D750520C01
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 21:19:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D750520C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbeK0IPS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Nov 2018 03:15:18 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:46040 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbeK0IPS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Nov 2018 03:15:18 -0500
Received: by mail-yb1-f196.google.com with SMTP id f6-v6so6701385ybg.12;
        Mon, 26 Nov 2018 13:19:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8rMoiDmdRPmR3hN5zZipHlN1I4Sy3AxFGp9yVlEAyEw=;
        b=mBuOM7+I7/852olIYpBQ8q6QOzjphpUDUJZhKsStU2a7jgPTxRVay6EsP0fhDTYguc
         g/fCt3IWVobU4Uf8wyLL5+2ug8KICmDgwzbJ6X5mscPDtXzNMJf4EaQ9e0zID/ZZVtOY
         4NbnZ99ODvh4BYa0oj+PVjP0Brf6z3E4Pi6H7cFN0UuUd9FfbqR2jntPmRR4660JQnwQ
         R4x6/W/UbTQzgTa2n/OV4UH+7TR/AQ8eKl64kUVvSMdSOkxYaEZ9lHMTpMWjD5GIlpKA
         5OkH0/S9snoD4uFzjTcqyn906BqAzfWSWNtdPievKlN33hqhBXUOj8nUALNlnu6uaPpY
         GZHg==
X-Gm-Message-State: AA+aEWZHEyfhHzK2JsgJOqrButF2j/gkTDqHWTOgtG6da/g9j1SlfOh+
        BcP7kybTpuN7H0GMOuGcIDE=
X-Google-Smtp-Source: AFSGD/VD8wzsw3a6HHAWKXZGkNEhl+bUQMV1BTZx/LUmSRZywffk9IU2Vw6N0sROIynASzFQ8K/ktA==
X-Received: by 2002:a25:e80d:: with SMTP id k13-v6mr29537108ybd.420.1543267191928;
        Mon, 26 Nov 2018 13:19:51 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([199.201.65.135])
        by smtp.gmail.com with ESMTPSA id d135-v6sm495462ywh.43.2018.11.26.13.19.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 26 Nov 2018 13:19:51 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 00/13 v4] block: always associate blkg and refcount cleanup
Date:   Mon, 26 Nov 2018 16:19:33 -0500
Message-Id: <20181126211946.77067-1-dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi everyone,

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

This patchset contains the following 13 patches:
  0001-blkcg-fix-ref-count-issue-with-bio_blkcg-using-task_.patch
  0002-blkcg-update-blkg_lookup_create-to-do-locking.patch
  0003-blkcg-convert-blkg_lookup_create-to-find-closest-blk.patch
  0004-blkcg-introduce-common-blkg-association-logic.patch
  0005-blkcg-associate-blkg-when-associating-a-device.patch
  0006-blkcg-consolidate-bio_issue_init-to-be-a-part-of-cor.patch
  0007-blkcg-associate-a-blkg-for-pages-being-evicted-by-sw.patch
  0008-blkcg-associate-writeback-bios-with-a-blkg.patch
  0009-blkcg-remove-bio-bi_css-and-instead-use-bio-bi_blkg.patch
  0010-blkcg-remove-additional-reference-to-the-css.patch
  0011-blkcg-remove-bio_disassociate_task.patch
  0012-blkcg-change-blkg-reference-counting-to-use-percpu_r.patch
  0013-blkcg-rename-blkg_try_get-to-blkg_tryget.patch

This patchset is on top of linux-block#for-4.21/block 5f0ed774ed29.

diffstats below:

Dennis Zhou (13):
  blkcg: fix ref count issue with bio_blkcg() using task_css
  blkcg: update blkg_lookup_create() to do locking
  blkcg: convert blkg_lookup_create() to find closest blkg
  blkcg: introduce common blkg association logic
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
 block/bio.c                             | 189 ++++++++++++++++--------
 block/blk-cgroup.c                      |  97 ++++++++++--
 block/blk-iolatency.c                   |  24 +--
 block/blk-throttle.c                    |  11 --
 block/bounce.c                          |   4 +-
 drivers/block/loop.c                    |   5 +-
 drivers/md/raid0.c                      |   2 +-
 fs/buffer.c                             |  12 +-
 fs/ext4/page-io.c                       |   4 +-
 include/linux/bio.h                     |  34 +++--
 include/linux/blk-cgroup.h              | 119 ++++++++++-----
 include/linux/blk_types.h               |   7 +-
 include/linux/cgroup.h                  |   2 +
 include/linux/writeback.h               |   5 +-
 kernel/cgroup/cgroup.c                  |  48 ++++--
 kernel/trace/blktrace.c                 |   4 +-
 mm/page_io.c                            |   4 +-
 20 files changed, 396 insertions(+), 189 deletions(-)

Thanks,
Dennis
