Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD5DC433E0
	for <linux-block@archiver.kernel.org>; Fri, 19 Mar 2021 22:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57C9E61932
	for <linux-block@archiver.kernel.org>; Fri, 19 Mar 2021 22:31:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbhCSWbP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Mar 2021 18:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbhCSWbC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Mar 2021 18:31:02 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A70AC061760
        for <linux-block@vger.kernel.org>; Fri, 19 Mar 2021 15:31:02 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id q5so6865622pfh.10
        for <linux-block@vger.kernel.org>; Fri, 19 Mar 2021 15:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=h4T1QO/eWVa2RE7FWa5A8e2KGY1PxnacN1N1AEKDkW8=;
        b=S1QQHrEIzvEi8SKQFxSCUoaDF7C+O8b0cN8KNje/Ol9yQT6EWrX7ne8lqbExlOVVfL
         1SZBX+Bo5mTyjziMe2G42CgO+0W1JyvTNIIt2GS+8oiHE1M5oU13Jqtza452+hV+y+HJ
         rblFO3dKKogUgkHVY/PTnxou2Uhev9gV675gL8u63QWoqk9wUXYnRfVFIpD8EzeZi948
         kCYXcjwUWeI3BsQPsxwX6XUwExibzT7MPYA4cqsCOGV/lYcF+voIjRU89QRHX02h1Vhg
         A3QKd/1M/mUBR3g/CdnuI7fjTFANv657zTVhLhI73vhnY/mkr19510WUx7ywR/BokHl3
         DYHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=h4T1QO/eWVa2RE7FWa5A8e2KGY1PxnacN1N1AEKDkW8=;
        b=NNltCc00u7HxqjiWj92A13dJ5nUWSQ6A0/mMqd5emZEHNDNtFh08WePQ5zB76PuGnn
         oNLfpCw2j4VHbSwkjLwcoOZbTPPmB9SD07z7YH7fJv6LONqcaiYNHAsCa37x1fLTsD80
         Oy2cGCgm2vdktnZFlxPtxI7f7iMC1ks8bhIXJaGTXyWH+PZIVysIf09jBZ+45Jn+zxYw
         LOAqvDnkS/R18xzfZO1etWy5dYFVvl1Ee3Oz+tPVaipqm9b9QqC9Ef/HdTT31CJz1zNY
         tArPIiOwPWnehHD2OhlUmvXf7WXYIzmowCe30EOZypCI2PFQf6CKLZNtAn9rB8woPkv7
         RYzw==
X-Gm-Message-State: AOAM533mHnO5+EdWdDcXXEXCQ8HYtP5Pjvn2MNF0QG1uw3+qqqOxW+p0
        +/q/dULZe5BGVz5ZqfJswKg3hGCLLgLxDQ==
X-Google-Smtp-Source: ABdhPJw8FOPgYwI2qg2Rmw6A/2gCY73YWYbY5tqMZ+zdZs9rsA5fr+o+W2SbKk5HJacdpXXsFHo5YQ==
X-Received: by 2002:a63:3189:: with SMTP id x131mr127416pgx.430.1616193061902;
        Fri, 19 Mar 2021 15:31:01 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id f15sm6288145pgr.90.2021.03.19.15.31.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Mar 2021 15:31:01 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.12-rc4
Message-ID: <d68738f1-c8c7-c0ee-9d04-1e9d913fd742@kernel.dk>
Date:   Fri, 19 Mar 2021 16:31:00 -0600
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

Just an NVMe pull request this week:

- fix tag allocation for keep alive
- fix a unit mismatch for the Write Zeroes limits
- various TCP transport fixes (Sagi Grimberg, Elad Grupi)
- fix iosqes and iocqes validation for discovery controllers (Sagi Grimberg)

Please pull!


The following changes since commit 1e28eed17697bcf343c6743f0028cc3b5dd88bf0:

  Linux 5.12-rc3 (2021-03-14 14:41:02 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block-5.12-2021-03-19

for you to fetch changes up to d38b4d289486daee01c1fdf056b46b7cdfe72e9e:

  Merge tag 'nvme-5.12-20210319' of git://git.infradead.org/nvme into block-5.12 (2021-03-19 06:40:47 -0600)

----------------------------------------------------------------
block-5.12-2021-03-19

----------------------------------------------------------------
Christoph Hellwig (4):
      nvme-fabrics: only reserve a single tag
      nvme: merge nvme_keep_alive into nvme_keep_alive_work
      nvme: allocate the keep alive request using BLK_MQ_REQ_NOWAIT
      nvme: fix Write Zeroes limitations

Elad Grupi (1):
      nvmet-tcp: fix kmap leak when data digest in use

Jens Axboe (1):
      Merge tag 'nvme-5.12-20210319' of git://git.infradead.org/nvme into block-5.12

Sagi Grimberg (5):
      nvme-tcp: fix a NULL deref when receiving a 0-length r2t PDU
      nvme-tcp: fix misuse of __smp_processor_id with preemption enabled
      nvme-tcp: fix possible hang when failing to set io queues
      nvme-rdma: fix possible hang when failing to set io queues
      nvmet: don't check iosqes,iocqes for discovery controllers

 drivers/nvme/host/core.c    | 64 +++++++++++++++------------------------------
 drivers/nvme/host/fabrics.h |  7 +++++
 drivers/nvme/host/fc.c      |  4 +--
 drivers/nvme/host/rdma.c    | 11 +++++---
 drivers/nvme/host/tcp.c     | 20 ++++++++++----
 drivers/nvme/target/core.c  | 17 +++++++++---
 drivers/nvme/target/loop.c  |  4 +--
 drivers/nvme/target/tcp.c   |  2 +-
 8 files changed, 69 insertions(+), 60 deletions(-)

-- 
Jens Axboe

