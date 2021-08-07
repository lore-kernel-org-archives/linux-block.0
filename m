Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 293F7C4338F
	for <linux-block@archiver.kernel.org>; Sat,  7 Aug 2021 16:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0043A61058
	for <linux-block@archiver.kernel.org>; Sat,  7 Aug 2021 16:50:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbhHGQus (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 7 Aug 2021 12:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbhHGQur (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 7 Aug 2021 12:50:47 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E69A6C0613CF
        for <linux-block@vger.kernel.org>; Sat,  7 Aug 2021 09:50:28 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id k11-20020a17090a62cbb02901786a5edc9aso3718018pjs.5
        for <linux-block@vger.kernel.org>; Sat, 07 Aug 2021 09:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=KEIPf8fDSuRzBO9mTHacLd2J105i7r0UjYGiZOvSaHg=;
        b=x4rpFuy2+M71OlDw81d0Jz86ODfw/SJA7eIpGCLl0hztTba6gH+jOA9U2lW4x1wQAB
         jGR1dzOnLieftV2AABD+HVz6JMlI5c0Thqj/NVnkiYaRxLPN26no43qjkDHoeS6WnWSA
         zb+UN50YcCsruTOMrpUn2nwbdaugSoN1kzKv8Y3o5FB9j3RlyBwUUhkBYeEiUn2SBxPN
         krmZoeoumrdiaK/ex+iRWp40lJvhKOTqX9+5i2qONnh9e07nDL1Q6Cs+ALIqlZ5oNV5l
         lro/d0n9xcdkKiqzzkDZmIoSrkpH+Nm9eZHIWafT88YC0nhmt9hVwMbxOjoVXpfAvTEy
         ykkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=KEIPf8fDSuRzBO9mTHacLd2J105i7r0UjYGiZOvSaHg=;
        b=YdP2zjmrIjn1UZxpMRLiwiF4Rr6rqA0jBXZ8t9mLTD84fEvOmlwk6rKb768ajyAP3L
         2P5p1llUGAZgEYorlX8znv+IP1vufJZ4Cf0Q+GoO8x7rcMwqlcCK1hsR/Ysr2eOMqfi8
         Uv63TNPAEwj1ok6eWapymzM+/RZvSKKcoJCST6j4jkbEQykmjbCV0o8uH9IX7eWIJeXI
         v+sHoqPHtZdcI6sPpX1c9tNLdlXmkV/YPCuJ2pOK35bpDkXt0cfqPyCs43/MLLX6Z3kr
         S4KoEr+BckleJfyYRA5qXgU8+HHIk6/T/97J18epTSYZtKYcCGCjb0jv4NpRZ3J9DIHl
         TsUQ==
X-Gm-Message-State: AOAM532G97+UPXoEuDzZdDoHzqwvRI5fJXIZiVB+ty3ZbJug27b/EKdz
        PaA0LjUCG4CKtZANSEQxLsIpMLHNcOFfX6Hk
X-Google-Smtp-Source: ABdhPJxOu785QpUCLdpeTJ2flEfk5O/uaQsQHrdxaAY+L6CFuZqAcww4ev5lGs141w4P7xbZE30f0g==
X-Received: by 2002:a05:6a00:2142:b029:3b9:e5df:77ab with SMTP id o2-20020a056a002142b02903b9e5df77abmr10536625pfk.52.1628355028089;
        Sat, 07 Aug 2021 09:50:28 -0700 (PDT)
Received: from [192.168.1.116] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id b15sm16522722pgm.15.2021.08.07.09.50.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Aug 2021 09:50:27 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.14-rc5
Message-ID: <9c6e6b8b-ef8e-6c14-1afd-e18569c3df45@kernel.dk>
Date:   Sat, 7 Aug 2021 10:50:26 -0600
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

A few minor fixes:

- Fix ldm kernel-doc warning (Bart)

- Fix adding offset twice for DMA address in n64cart (Christoph)

- Fix use-after-free in dasd path handling (Stefan)

- Order kyber insert trace correctly (Vincent)

- raid1 errored write handling fix (Wei)

- Fix blk-iolatency queue get failure handling (Yu)

Please pull!


The following changes since commit 340e84573878b2b9d63210482af46883366361b9:

  block: delay freeing the gendisk (2021-07-27 19:35:47 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block-5.14-2021-08-07

for you to fetch changes up to fb7b9b0231ba8f77587c23f5257a4fdb6df1219e:

  kyber: make trace_block_rq call consistent with documentation (2021-08-06 16:40:47 -0600)

----------------------------------------------------------------
block-5.14-2021-08-07

----------------------------------------------------------------
Bart Van Assche (1):
      block/partitions/ldm.c: Fix a kernel-doc warning

Christoph Hellwig (1):
      n64cart: fix the dma address in n64cart_do_bvec

Jens Axboe (1):
      Merge branch 'md-fixes' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into block-5.14

Stefan Haberland (1):
      s390/dasd: fix use after free in dasd path handling

Vincent Fu (1):
      kyber: make trace_block_rq call consistent with documentation

Wei Shuyu (1):
      md/raid10: properly indicate failure when ending a failed write request

Yu Kuai (1):
      blk-iolatency: error out if blk_get_queue() failed in iolatency_set_limit()

 block/blk-iolatency.c          |  6 +++++-
 block/kyber-iosched.c          |  2 +-
 block/partitions/ldm.c         |  2 +-
 drivers/block/n64cart.c        |  2 +-
 drivers/md/raid1.c             |  2 --
 drivers/md/raid10.c            |  4 ++--
 drivers/s390/block/dasd_eckd.c | 13 +++++++++++--
 7 files changed, 21 insertions(+), 10 deletions(-)

-- 
Jens Axboe

