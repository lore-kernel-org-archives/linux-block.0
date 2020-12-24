Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD04EC433E0
	for <linux-block@archiver.kernel.org>; Thu, 24 Dec 2020 05:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EF7722AAC
	for <linux-block@archiver.kernel.org>; Thu, 24 Dec 2020 05:08:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725871AbgLXFIq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Dec 2020 00:08:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgLXFIq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Dec 2020 00:08:46 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41075C06179C
        for <linux-block@vger.kernel.org>; Wed, 23 Dec 2020 21:08:06 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id b8so788071plx.0
        for <linux-block@vger.kernel.org>; Wed, 23 Dec 2020 21:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=QMP7nTKyX1SqqYcC5+kS23ULietf7gzilRYOvli4+Es=;
        b=dStnublK/3HJ/MFJ3cEWwNC2/1MvfN8lBY2HZZnHYrqz9FH3cpv+7gM5fsE0Poxml5
         3kPcrframc5m3yrJh+7RfCnrsWOdF9xCOzfq/sI3H50bIjq5qnrG8NDQT9OFTKptijly
         FfyjxhPkvDHr0f5J0z80OqN+1xkAl0SMKtaCM0/N6JTqEz4tQmm51wUKQenF7XRhHMQ9
         IMvuT9CnrAPP77QIrc+XFZAw92MGsdQ86W/glt6QLBN0ZH6XJPIGFhGSaxtF8+cPsYXn
         6I6rx+9IpgDetH6N4H7QrWTWua53N4dQffW6K9WcK1Ecsid3acQdbHtXU1cNso8oRtl2
         ORfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=QMP7nTKyX1SqqYcC5+kS23ULietf7gzilRYOvli4+Es=;
        b=mNPGNCF7ttpw4Unaazpyz5y3IYDz5VYUnA0aRLyfrA7g22A+EHuw053y1AMTDCAPO5
         /wcCQXGAozVtFe5scpyt5ZNus985GRBFCuSbwVA35n1gpbqyNXRgyw1iGfxFlrM9GN4H
         AqCD3z1xXbEiuV19YLewap8wYvKYULz5UhaMHqaPYKLGgwGlsDSLWnaUWoYUrVeCTBiP
         +R4tfXWyrifjzerHAkvqrvREHmLXs4L5IVCRnpSIWImA4vddu7rwLkAtwP4V9ZB5+clx
         P2TnhLrPBeBJAX0z8Wn3QQwiNMb71jDOb1o8BB9JWgUqe7bi3FNdjy6zHTvVC3A5nLaf
         IMCA==
X-Gm-Message-State: AOAM533E/890lpuBL/drUwS94U5wncSAaEH2/apP6cby2KZtYhwAKtGM
        ebkfIwFquoFAzUn/Ppa47N9ESJXLF5aY7g==
X-Google-Smtp-Source: ABdhPJwZMMzZBklomsUCpuqlDq+cMMAcPDqBbKE5mI9rRu2Oyxtu6912oM9LWWOpFSMBQj/xkHjdjQ==
X-Received: by 2002:a17:902:6b0a:b029:dc:31af:8dc3 with SMTP id o10-20020a1709026b0ab02900dc31af8dc3mr5958112plk.41.1608786485549;
        Wed, 23 Dec 2020 21:08:05 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id 92sm1168708pjv.15.2020.12.23.21.08.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Dec 2020 21:08:04 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.11-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Message-ID: <151f83d5-5ba0-fb66-d455-16e987bca00a@kernel.dk>
Date:   Wed, 23 Dec 2020 22:08:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

A few stragglers in here, but mostly just straight fixes. In particular:

- Set of rnbd fixes for issues around changes for the merge window
  (Gioh, Jack, Md Haris Iqbal)

- iocost tracepoint addition (Baolin)

- Copyright/maintainers update (Christoph)

- Remove old blk-mq fast path CPU warning (Daniel)

- loop max_part fix (Josh)

- Remote IPI threaded IRQ fix (Sebastian)

- dasd stable fixes (Stefan)

- bcache merge window fixup and style fixup (Yi, Zheng)

Please pull!


The following changes since commit 009bd55dfcc857d8b00a5bbb17a8db060317af6f:

  Merge tag 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma (2020-12-16 13:42:26 -0800)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block-5.11-2020-12-23

for you to fetch changes up to 46926127d76359b46659c556df7b4aa1b6325d90:

  md/bcache: convert comma to semicolon (2020-12-23 09:25:15 -0700)

----------------------------------------------------------------
block-5.11-2020-12-23

----------------------------------------------------------------
Baolin Wang (1):
      blk-iocost: Add iocg idle state tracepoint

Christoph Hellwig (3):
      MAINTAINERS: add fs/block_dev.c to the block section
      block: remove a pointless self-reference in block_dev.c
      block: update some copyrights

Daniel Wagner (1):
      blk-mq: Remove 'running from the wrong CPU' warning

Gioh Kim (3):
      block/rnbd: Set write-back cache and fua same to the target device
      block/rnbd-clt: Dynamically allocate sglist for rnbd_iu
      block/rnbd-clt: Does not request pdu to rtrs-clt

Jack Wang (2):
      block/rnbd-clt: Fix possible memleak
      block/rnbd: Fix typos

Josh Triplett (1):
      nbd: Respect max_part for all partition scans

Md Haris Iqbal (2):
      block/rnbd-clt: Get rid of warning regarding size argument in strlcpy
      block/rnbd-srv: Protect dev session sysfs removal

Sebastian Andrzej Siewior (1):
      blk-mq: Don't complete on a remote CPU in force threaded mode

Stefan Haberland (4):
      s390/dasd: fix hanging device offline processing
      s390/dasd: prevent inconsistent LCU device data
      s390/dasd: fix list corruption of pavgroup group list
      s390/dasd: fix list corruption of lcu list

Yi Li (1):
      bcache:remove a superfluous check in register_bcache

Zheng Yongjun (1):
      md/bcache: convert comma to semicolon

 MAINTAINERS                            |  1 +
 block/blk-iocost.c                     |  3 ++
 block/blk-mq.c                         | 33 +++---------
 block/genhd.c                          |  2 +
 block/partitions/core.c                |  1 +
 drivers/block/nbd.c                    |  9 ++--
 drivers/block/rnbd/rnbd-clt-sysfs.c    |  5 +-
 drivers/block/rnbd/rnbd-clt.c          | 94 ++++++++++++++++++++--------------
 drivers/block/rnbd/rnbd-clt.h          | 12 ++++-
 drivers/block/rnbd/rnbd-proto.h        |  9 +++-
 drivers/block/rnbd/rnbd-srv.c          | 12 +++--
 drivers/infiniband/ulp/rtrs/rtrs-clt.c |  6 ---
 drivers/infiniband/ulp/rtrs/rtrs.h     |  7 ---
 drivers/md/bcache/super.c              |  2 -
 drivers/md/bcache/sysfs.c              |  2 +-
 drivers/s390/block/dasd_alias.c        | 22 +++++++-
 fs/block_dev.c                         |  3 +-
 include/trace/events/iocost.h          | 16 +++++-
 18 files changed, 145 insertions(+), 94 deletions(-)

-- 
Jens Axboe

