Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 489B8C4338F
	for <linux-block@archiver.kernel.org>; Fri, 30 Jul 2021 15:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FC736044F
	for <linux-block@archiver.kernel.org>; Fri, 30 Jul 2021 15:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239602AbhG3PQr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Jul 2021 11:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239248AbhG3PQr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Jul 2021 11:16:47 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8DEC06175F
        for <linux-block@vger.kernel.org>; Fri, 30 Jul 2021 08:16:41 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id q2so11431595plr.11
        for <linux-block@vger.kernel.org>; Fri, 30 Jul 2021 08:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=AxSqjmVEMemIruWqQgppQh6tEJamQ360x/VbgPQZr10=;
        b=Mzf/W1UM8nSBvIDz84F5NgE7uTrEKjfSBrIQFE2KGYPVWJH4iVdvCmxOeyx5/XwUIt
         4EiKmefO4GFOz2bGCr2UXerqdDdE8UVGf+18DXlsT15Utx5/kyskG1YejvwKqNaEB/wM
         DQcsxE3BDjKjDtT+Kz1BOd4OIp7YqdEcw8QPIa48VGgS+vAblCZMw5sjnp22mOEk2FSh
         0vHqU9SId5NlFNJpnipoHILN9a5QhP2lkA2BrHenxxLoKTS9MSLqpGxALUU13T4EBnRv
         rt9slIIJjryHAnw4RauvMV4NeqKdy2M2LgqDD2kb9cBlbBfBakYnWpjAuc8p0pEdfldC
         zPRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=AxSqjmVEMemIruWqQgppQh6tEJamQ360x/VbgPQZr10=;
        b=Gxr1/YFmXaWmzNII+Rtxy6uVEKxez5Mc9972UWzk2AA8meKBnUcHwwgBrW584lojwN
         rqX3cXLEOSwcSSL89u8pw8CyE/1sIBWRLlvzWHDrXsYaJm67dyUHvPBRZ9KBe7Fd/dN2
         6/Qg89ku1IKrCRWHrc56XxfP01PwqJhQXmQTZp8REAyunUSwkseTPfuHhrHa8gvPSFzw
         s/EZ/LoPtRGioVNNWvE8SK3k0Elc/Kfx3Z2UafgtfC1GdlqIvuNxeRLTInbiwSPbAH5q
         nKMkAijasHi5KKHVzFsexlVsC2+02YjS7AyHpEkKW0NgliDrB0JwwFPY1s5zjAtqlmiM
         jKFw==
X-Gm-Message-State: AOAM533pWqOB8xhzZjGlbFfTgInWp03hR+mzCoYYFrhXFz2gZp9Xh2E5
        gGPZs9tnYOTTf5U926owCuBV0E0iHH9bArxy
X-Google-Smtp-Source: ABdhPJxDnm2xiyhwFpiocb7QXs2GMc92QzX3RWcU/FpmUAO4kE8nXBahxwVhk+I4DMpPkqqqekKMZA==
X-Received: by 2002:a63:e841:: with SMTP id a1mr2796083pgk.197.1627658201254;
        Fri, 30 Jul 2021 08:16:41 -0700 (PDT)
Received: from [192.168.1.116] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id nl2sm2525336pjb.10.2021.07.30.08.16.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jul 2021 08:16:40 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.14-rc
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Message-ID: <c230e91a-74a0-5a78-a538-826ed0c40b94@kernel.dk>
Date:   Fri, 30 Jul 2021 09:16:39 -0600
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

- gendisk freeing fix (Christoph)

- blk-iocost wake ordering fix (Tejun)

- Tag allocation error handling fix (John)

- Loop locking fix. While this isn't the prettiest fix in the world,
  nobody has any good alternatives for 5.14. Something to likely revisit
  for 5.15. (Tetsuo)

Please pull!


The following changes since commit 7054133da39a82c1dc44ce796f13a7cb0d6a0b3c:

  Merge tag 'nvme-5.14-2021-07-22' of git://git.infradead.org/nvme into block-5.14 (2021-07-22 14:23:55 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block-5.14-2021-07-30

for you to fetch changes up to 340e84573878b2b9d63210482af46883366361b9:

  block: delay freeing the gendisk (2021-07-27 19:35:47 -0600)

----------------------------------------------------------------
block-5.14-2021-07-30

----------------------------------------------------------------
Christoph Hellwig (1):
      block: delay freeing the gendisk

John Garry (1):
      blk-mq-sched: Fix blk_mq_sched_alloc_tags() error handling

Tejun Heo (1):
      blk-iocost: fix operation ordering in iocg_wake_fn()

Tetsuo Handa (1):
      loop: reintroduce global lock for safe loop_validate_file() traversal

 block/blk-iocost.c   |  11 +++--
 block/blk-mq-sched.c |  17 ++-----
 block/genhd.c        |   3 +-
 drivers/block/loop.c | 128 ++++++++++++++++++++++++++++++++++++++-------------
 fs/block_dev.c       |   2 +
 5 files changed, 110 insertions(+), 51 deletions(-)

-- 
Jens Axboe

