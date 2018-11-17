Return-Path: <SRS0=MdGt=N4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4740C43441
	for <linux-block@archiver.kernel.org>; Sat, 17 Nov 2018 21:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A6E32080D
	for <linux-block@archiver.kernel.org>; Sat, 17 Nov 2018 21:44:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Kc95hzXn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A6E32080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725894AbeKRICE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 18 Nov 2018 03:02:04 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37271 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725743AbeKRICD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Nov 2018 03:02:03 -0500
Received: by mail-pl1-f194.google.com with SMTP id b5so6355907plr.4
        for <linux-block@vger.kernel.org>; Sat, 17 Nov 2018 13:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id;
        bh=S2cqtfL9iYXpoc5fRosGZliocoTsjIJJ7O3OeWY7CHw=;
        b=Kc95hzXnvf6p8u+imt1RXIiTlcaDHfn/sJveZ2/gos00i7lGXpiTzFZK7BanOLO8mi
         n1srjRr2CZJ/RUkQi3R3RVFuV99iIWoLkvmBl7fbAPXZ/q1sm/0/ozsPPTySq97o8YFs
         usnnYknSNgFVtf0fMw2ylX4OVf4sTblxsoY8Z421BXO8nQ/Mj06Xf/k9oPutdGGSICoc
         iUm+WLH7O07pd71Nd4cCts4Jumcg7ABsZtbxtA1Uko2Mt0uQNRon4+rlbi3axkUMCu1n
         ZKfvKGp7G6tEuMmu6Iv5/VYdS3zHOeVRyDNQTXphzQJT9GL6xHyKQajZpGWbtiwPVV7N
         tPew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=S2cqtfL9iYXpoc5fRosGZliocoTsjIJJ7O3OeWY7CHw=;
        b=lag13DVzGXOcjvBBBtF/7AsLZP7AzTCKyuDMkBThqGVcqJ1YvZ3vX6uYCcwdS9bpyD
         VrGOY1cH+x2liw0nZHSSLo7FNHXSm4NEbR4LM01YOsTkTvmHUdEKfbzHJJVQXa/FP4ZF
         lw05FkTZYmsc8OmIYogGs6VeZYk/7XToPTiSTfARw3DDQNcQ+fUZjRmCCX83PZWmKy6A
         dGBQC2AXNAGBropWxjoLXpmD7+EaShLFOJZZbRBAfbs1kqnwzICOjJbzfB3X+OQBte/G
         rouvDMoC1Rds4VBcO+oFJ4EdwQmS/s5X6nOdySOQWh5/uO8jIcRPTJio9uOFfRH1MWTv
         w9Fg==
X-Gm-Message-State: AGRZ1gJ4kcwvqw7Wqt+6UlRtQD9/3W8ScetQqJ5XTcen6wgiDMV2DNG0
        SNIzi2ZIQutu+RY9LhTrtAbZ1y2mqaE=
X-Google-Smtp-Source: AJdET5ftHF+vuZDkWz/x4vRK76TlJyzkNVXM0/eL++Mg7sE8eTBBSZM7q7317OsRlccP7JdgDaG4FA==
X-Received: by 2002:a17:902:104:: with SMTP id 4-v6mr16801708plb.184.1542491039875;
        Sat, 17 Nov 2018 13:43:59 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id o84sm29006501pfi.172.2018.11.17.13.43.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Nov 2018 13:43:58 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [PATCHSET v4] Various block optimizations
Date:   Sat, 17 Nov 2018 14:43:47 -0700
Message-Id: <20181117214354.822-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Some of these are optimizations, the latter part is prep work
for supporting polling with aio.

Patches against my for-4.21/block branch. These patches can also
be found in my mq-perf branch. Some of them are prep patches for
the aio poll work, which can be found in my aio-poll branch.
These will get posted soon.

Changes since v3:

- Fix tiny race in iocb flag checking for plugging
- Improve poll-many implementation, including nvme-rdma
- Get rid of unneeded smp_rmb()
- Drop merged patches

Changes since v2:

- Include polled swap IO in the poll optimizations
- Get rid of unnecessary write barrier for DIO wakeup
- Fix a potential stall if need_resched() was set and preempt
  wasn't enabled
- Provide separate mq_ops for NVMe with poll queues
- Drop q->mq_ops patch
- Rebase on top of for-4.21/block

Changes since v1:

- Improve nvme irq disabling for polled IO
- Fix barriers in the ordered wakeup for polled O_DIRECT
- Add patch to allow polling to find any command that is done
- Add patch to control whether polling spins or not
- Have async O_DIRECT mark a bio as pollable
- Don't plug for polling


 block/blk-core.c                  |  4 +-
 block/blk-mq.c                    | 91 +++++++++++++++++++++------------------
 drivers/nvme/host/fc.c            | 33 --------------
 drivers/nvme/host/multipath.c     |  6 +--
 drivers/nvme/host/pci.c           | 22 +++++-----
 drivers/nvme/host/rdma.c          | 38 ++++++++--------
 drivers/nvme/target/io-cmd-bdev.c |  2 +-
 fs/block_dev.c                    | 11 +++--
 fs/direct-io.c                    |  2 +-
 fs/iomap.c                        |  5 ++-
 include/linux/blk-mq.h            |  2 +-
 include/linux/blkdev.h            |  4 +-
 mm/page_io.c                      |  5 ++-
 13 files changed, 101 insertions(+), 124 deletions(-)

-- 
Jens Axboe


