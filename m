Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCAB1C433B4
	for <linux-block@archiver.kernel.org>; Fri,  2 Apr 2021 21:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B14D610C9
	for <linux-block@archiver.kernel.org>; Fri,  2 Apr 2021 21:28:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbhDBV2T (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 2 Apr 2021 17:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbhDBV2T (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 2 Apr 2021 17:28:19 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5054AC0613E6
        for <linux-block@vger.kernel.org>; Fri,  2 Apr 2021 14:28:17 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id k25so6052263oic.4
        for <linux-block@vger.kernel.org>; Fri, 02 Apr 2021 14:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=ENeB9Srcy+jjhR62rwn56ueIrj1f4rsinbGdPqztEAc=;
        b=Aywnw5bS8LQ5uIb2043txOi0AH4c0wljOI92A+yNVjJBYsexzI++OwJ0PFhYSlfWfh
         mDdQlOKsbR4bq7LGDznIfT6jpvbk0FsM9AaBFMJXiuJJ8zcKJHNa8/wv27wDX6bhuWqn
         tiBOQyQkfCg1OWAW8ccENsTyXnpRANpHCsYiXn9jyT3ih7j4kev6ejMJkTCvq5BcjVZM
         104cS8xcRDsHhezkbp1Jj0ZXCFnQxlHHHBmu9IjZTdGHgdm5ZebDIj7XbplGQcRNdbxS
         2dP5jh+lzHxsMxKv4LFceC2GKPMQ9VDBUMMjaaPOR4yj6FOPjnB6sfVims7zYSsPcaiW
         Sppg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=ENeB9Srcy+jjhR62rwn56ueIrj1f4rsinbGdPqztEAc=;
        b=XL7+0JG9kek4HXPpiHGVtt3pADTcc1QM1XIU1Zv/MH0OOSX/r3OATX0znz6P2fN54x
         YGSbyPH6TI9O9olYHMTOHcr+pDmsC0K1P7cw2gR4G35ZmJ2KTkC74sQNilSLlGKfbx38
         JpWWy8hpg6jkhWsnm4F5Kl+Le3zYsI+FLLMTQNECfTL6EWY+FUqpG+De/PbTpELcraSm
         +l66u9f3YWnTIEuT+ElfPAOTcxw18kwAjax4XiW0l+1mJ6NZ+CiAMxSK6HhKf4NgxoWM
         FbmhsjaR202+gnMVHgT4W6lYOxsvp0Y1lceXIuNyH7pWcMM2Pp95GK7u7c7y2kUH771F
         Rz/w==
X-Gm-Message-State: AOAM533fPvYybAipZ0m5YMx3ze8tppe4mmoDeLs/99FToPoku8pRYrQw
        AV7AI+qs0oxchEIREB44BtUC+mDlz978Jg==
X-Google-Smtp-Source: ABdhPJwwKPtwwyr3pobASUWTfETFuUexQcUCwmDePUv9iOI9xZfiIG4l595OhOxNMcJrMcBIeTrLkA==
X-Received: by 2002:a54:409a:: with SMTP id i26mr11066176oii.41.1617398896247;
        Fri, 02 Apr 2021 14:28:16 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.233.147])
        by smtp.gmail.com with ESMTPSA id w199sm1833510oif.41.2021.04.02.14.28.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Apr 2021 14:28:15 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.12-rc6
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Message-ID: <979a3929-25ec-0b24-20fa-6803e6dfbe30@kernel.dk>
Date:   Fri, 2 Apr 2021 15:28:15 -0600
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

- Remove comment that never came to fruition in 22 years of development
  (Christoph)

- Remove unused request flag (Christoph)

- Fix for null_blk fake timeout handling (Damien)

- Fix for IOCB_NOWAIT being ignored for O_DIRECT on raw bdevs (Pavel)

- Error propagation fix for multiple split bios (Yufen)

Please pull!


The following changes since commit e82fc7855749aa197740a60ef22c492c41ea5d5f:

  block: don't create too many partitions (2021-03-27 09:22:18 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block-5.12-2021-04-02

for you to fetch changes up to f06c609645ecd043c79380fac94145926603fb33:

  block: remove the unused RQF_ALLOCED flag (2021-04-02 11:18:31 -0600)

----------------------------------------------------------------
block-5.12-2021-04-02

----------------------------------------------------------------
Christoph Hellwig (2):
      block: update a few comments in uapi/linux/blkpg.h
      block: remove the unused RQF_ALLOCED flag

Damien Le Moal (1):
      null_blk: fix command timeout completion handling

Pavel Begunkov (1):
      block: don't ignore REQ_NOWAIT for direct IO

Yufen Yu (1):
      block: only update parent bi_status when bio fail

 block/bio.c                       |  2 +-
 block/blk-mq-debugfs.c            |  1 -
 drivers/block/null_blk/main.c     | 26 +++++++++++++++++++++-----
 drivers/block/null_blk/null_blk.h |  1 +
 fs/block_dev.c                    |  4 ++++
 include/linux/blkdev.h            |  2 --
 include/uapi/linux/blkpg.h        | 28 ++--------------------------
 7 files changed, 29 insertions(+), 35 deletions(-)

-- 
Jens Axboe

