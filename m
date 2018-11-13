Return-Path: <SRS0=aXbO=NY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D44B9C0044C
	for <linux-block@archiver.kernel.org>; Tue, 13 Nov 2018 15:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D4B421582
	for <linux-block@archiver.kernel.org>; Tue, 13 Nov 2018 15:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="bjoqSfpK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D4B421582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbeKNBlS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Nov 2018 20:41:18 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:40305 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731287AbeKNBlS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Nov 2018 20:41:18 -0500
Received: by mail-it1-f195.google.com with SMTP id e11so19043094itl.5
        for <linux-block@vger.kernel.org>; Tue, 13 Nov 2018 07:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id;
        bh=Yl+egARCa3TOZ7FZ3tb13xUWql2hR1sKdkfL/FxDfIc=;
        b=bjoqSfpKqZo8eksvj9AFVS+fZkYQiARiEiISfzwiC3olwtROsravjdYiui3+heCq1H
         3TSADEE+xszcyE7GTnrQ1XSzijlnY4Y7sQ35PQ6B+Yit8fEshjCksTTRojfrAXDPRS99
         qzOXoLr3346H02ZvVPRjWBsxYvwyc81r29DtdK83KVDwZiEs1UijlLqNnWQTnWFE4K17
         iGlmjypEGn8BLF5DyJTuZO5MK8JZJzf5xqtA3NjYH9Ah1n3bugLYDp+ro7Rh5V7VW+3s
         OfDeu34Jb8qgfX6JNi7aUPMkSy69Y/spuXOGKp2qocxgPtLfBAfVQ6pESWQhxxLoLaQa
         EZ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=Yl+egARCa3TOZ7FZ3tb13xUWql2hR1sKdkfL/FxDfIc=;
        b=qyx6wESIfpWe1f0Hk9rCfT8a2biwLserpvB2kzwBKaZwC6mYGUnTomJ0vYaMDyIhnN
         xQkOjuRbnnhLR25aSnwrCxLVI/M26O0Q8sMTPA0NWxc2FLkTbPacCnGcLD9RHWD9vMrW
         G8tBtCd+13II8jS1a858FS7qh2ZcfOtlBzgmGGwbjMWj1NuOruiJC4pJ6YejaFBxih2W
         +sjBFo3e9gFXFzuDWsZ1rR99srkzWE29NDrZqtzLS1glJiFBtKfquFQAUxhqBO73GjWd
         CLZgyYwe9vSYV1nEd6tVjqCQz/raobDko/webjjeZ3FF3haLGrAj6NF89aMCqNlAFRzf
         7G4w==
X-Gm-Message-State: AGRZ1gIuSxklNRkBQUB3/EBlRicMrocK/OmXNQFiQ3Mc3P0lTsxC52cT
        JcFy8aVOqv4oPLmSwxJT71aY0qv9ecs=
X-Google-Smtp-Source: AJdET5dWM0afpP/pkckGwwV7IE7x/ZonPf40CgtWwp5j1Gd+G6NAeitIVwOS2eIiSvvFon5CwESgmQ==
X-Received: by 2002:a24:3684:: with SMTP id l126-v6mr4184305itl.142.1542123758369;
        Tue, 13 Nov 2018 07:42:38 -0800 (PST)
Received: from x1.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id o14-v6sm6721987ito.3.2018.11.13.07.42.37
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 07:42:37 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Subject: [PATCHSET v2 0/11] Various block optimizations
Date:   Tue, 13 Nov 2018 08:42:22 -0700
Message-Id: <20181113154233.15256-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Some of these are optimizations, the latter part is prep work
for supporting polling with aio.

Patches against my for-4.21/block branch. These patches can also
be found in my mq-perf branch, though there are other patches
sitting on top of this series (notably aio polling, as mentioned).

Changes since v1:

- Improve nvme irq disabling for polled IO
- Fix barriers in the ordered wakeup for polled O_DIRECT
- Add patch to allow polling to find any command that is done
- Add patch to control whether polling spins or not
- Have async O_DIRECT mark a bio as pollable
- Don't plug for polling


 block/blk-cgroup.c                |   8 +--
 block/blk-core.c                  |  20 ++++----
 block/blk-flush.c                 |   3 +-
 block/blk-mq-debugfs.c            |   2 +-
 block/blk-mq.c                    | 105 +++++++++++++++++++++-----------------
 block/blk-mq.h                    |  12 ++---
 block/blk-rq-qos.c                |  90 +++++++++-----------------------
 block/blk-rq-qos.h                |  35 ++++++++++---
 block/blk-softirq.c               |   4 +-
 block/blk-sysfs.c                 |  18 +++----
 block/blk-wbt.c                   |   2 +-
 block/elevator.c                  |   9 ++--
 block/genhd.c                     |   8 +--
 drivers/md/dm-table.c             |   2 +-
 drivers/nvme/host/multipath.c     |   6 +--
 drivers/nvme/host/pci.c           |  45 +++++++++-------
 drivers/nvme/target/io-cmd-bdev.c |   2 +-
 drivers/scsi/scsi_lib.c           |   2 +-
 fs/block_dev.c                    |  32 +++++++++---
 fs/direct-io.c                    |   2 +-
 fs/iomap.c                        |   9 ++--
 include/linux/blk-mq-ops.h        | 100 ++++++++++++++++++++++++++++++++++++
 include/linux/blk-mq.h            |  94 +---------------------------------
 include/linux/blkdev.h            |  37 +++++++++++---
 mm/page_io.c                      |   2 +-
 25 files changed, 347 insertions(+), 302 deletions(-)

-- 
Jens Axboe


