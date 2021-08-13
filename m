Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66504C4338F
	for <linux-block@archiver.kernel.org>; Fri, 13 Aug 2021 19:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 336D860234
	for <linux-block@archiver.kernel.org>; Fri, 13 Aug 2021 19:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233046AbhHMTNT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Aug 2021 15:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbhHMTNT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Aug 2021 15:13:19 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 013E7C061756
        for <linux-block@vger.kernel.org>; Fri, 13 Aug 2021 12:12:51 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id w13-20020a17090aea0db029017897a5f7bcso17321474pjy.5
        for <linux-block@vger.kernel.org>; Fri, 13 Aug 2021 12:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=ofMfAiE5wxKIVNV2jFx5TZ229q+yHEAfZ2NYKdy5B5c=;
        b=wvl0V6WnKqR4BQ6+weuV5WCYTsKjf4f/RdyRHbzNFzSfzNJ60oIdpA4oL71L2KE/T4
         CLPMCxVMWqr3dKlfkgj3EKmHqeXl4e2jTXg/oJZO75qTE+GcNBLrPp7mTzuFPSPk5Kie
         EnZjGop8u7UJFtaRHM6zJclVu/PDBkQaYHpM9mYQuJgxjXQhiSiOjl2VlTW34eWJhpgf
         qUqpLWL9Wn/Ot8Xsl/9K37fq2ja2Bm9dI0lgDQR1Puw9dkSkIAcZTArpJ+DXvhfOOmuv
         8JbKoIaHkBYhdDiW3vFxQtEgWl6eWQYeSCRea6QQ+Tdzz9CDex7ZIo+/VCXGvg+09Kfx
         g7rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=ofMfAiE5wxKIVNV2jFx5TZ229q+yHEAfZ2NYKdy5B5c=;
        b=Z0Q4FrO05cnF1jlRNO2yDT2rJjagoT9L1cb4zTPHjylTiTjq1deZhaaUmTlCFida0q
         BlCG/JRJ4bPYvSvqCEB2lNXSBCs7mMW6vCaAgYgB4ozJCFWroyOaHgjTpLu3XvyTGidU
         EBuPMsYf9KRCgtQt2PBJNZ4lOoc0sS3aP/JN6cDXs7D3mPF75CgW46mXEKdAAuFBHswg
         Be07sREU5Oa044ULQ26AhK5CMfdr6CEALcoR+sap/6CAIfKWpGZ0yLcfZreT69OVuuFJ
         ut0POKsRuJQbi4hat9fsTMXtF7MRNzpwRlJHJ4K2r2LgLxJx4GOq9zkYxh77xSqJUrgt
         417A==
X-Gm-Message-State: AOAM531Zx/ia9bnbKNVlIINs69jxQH/sI3VSpT09ebhhektsJbqhjky6
        hQdYCt/4x51POoWIpM4JsCnvImQPGtFPjbnB
X-Google-Smtp-Source: ABdhPJyGlSH7cbh2AVXJC3tlq/egyzmsSTYB72PBLB794EG4NZzZHMYFs/+8fcKZkArOFf95tfqyTA==
X-Received: by 2002:a63:595f:: with SMTP id j31mr3601484pgm.109.1628881969865;
        Fri, 13 Aug 2021 12:12:49 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id p30sm3039628pfh.116.2021.08.13.12.12.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Aug 2021 12:12:49 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.14-rc6
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Message-ID: <07a53f5d-0b2d-0fd3-8d50-098726bb7650@kernel.dk>
Date:   Fri, 13 Aug 2021 13:12:48 -0600
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

A few fixes for block that should go into 5.14:

- Revert the mq-deadline cgroup addition. More work is needed on this
  front, let's revert it for now and get it right before having it in a
  released kernel (Tejun)

- blk-iocost lockdep fix (Ming)

- nbd double completion fix (Xie)

- Fix for non-idling when clearing the shared tag flag (Yu)

Please pull!


The following changes since commit fb7b9b0231ba8f77587c23f5257a4fdb6df1219e:

  kyber: make trace_block_rq call consistent with documentation (2021-08-06 16:40:47 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block-5.14-2021-08-13

for you to fetch changes up to cddce01160582a5f52ada3da9626c052d852ec42:

  nbd: Aovid double completion of a request (2021-08-13 09:46:48 -0600)

----------------------------------------------------------------
block-5.14-2021-08-13

----------------------------------------------------------------
Ming Lei (1):
      blk-iocost: fix lockdep warning on blkcg->lock

Tejun Heo (1):
      Revert "block/mq-deadline: Add cgroup support"

Xie Yongji (1):
      nbd: Aovid double completion of a request

Yu Kuai (1):
      blk-mq: clear active_queues before clearing BLK_MQ_F_TAG_QUEUE_SHARED

 block/Kconfig.iosched                       |   6 --
 block/Makefile                              |   2 -
 block/blk-iocost.c                          |   8 +-
 block/blk-mq.c                              |   6 +-
 block/mq-deadline-cgroup.c                  | 126 ----------------------------
 block/mq-deadline-cgroup.h                  | 114 -------------------------
 block/{mq-deadline-main.c => mq-deadline.c} |  73 ++++------------
 drivers/block/nbd.c                         |  14 +++-
 8 files changed, 33 insertions(+), 316 deletions(-)
 delete mode 100644 block/mq-deadline-cgroup.c
 delete mode 100644 block/mq-deadline-cgroup.h
 rename block/{mq-deadline-main.c => mq-deadline.c} (95%)

-- 
Jens Axboe

