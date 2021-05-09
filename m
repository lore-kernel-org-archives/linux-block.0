Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69438C433B4
	for <linux-block@archiver.kernel.org>; Sun,  9 May 2021 16:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B80261040
	for <linux-block@archiver.kernel.org>; Sun,  9 May 2021 16:16:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbhEIQRj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 9 May 2021 12:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbhEIQRi (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 9 May 2021 12:17:38 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B78C061573
        for <linux-block@vger.kernel.org>; Sun,  9 May 2021 09:16:35 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id a11so7954017plh.3
        for <linux-block@vger.kernel.org>; Sun, 09 May 2021 09:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=dzZLMbLcFU1uD7feNvhY8lQJ1DFpZxdpStbb2+FnDZo=;
        b=utIcLQhfQAlR/3kxJKjjClu3aTNEPA+vIjvFvVPR6tdPTVNLixkVE61ez0ioqiDZaN
         A/gQ91+agpdMUWsyZtAwko2GlRLvk/marutGsygLhpNX54PSBrcPnvLi5+KkFWKrWNAd
         xB9TdJpGN+Ouib86ISyrf/qgZZQ/yVtKG3cV1Fi6Ttf+GjwpEwLpfHGNRyw5MgvuPvOW
         Tt69B5n4Rl3w64ZRuwhI+X7DV9JlMutgnSxZPK7PiQRhcoOdBoaXG1VFWi+Z18TAcweH
         GC4Y79K2TDCewuBzzirgY/wxYkUnFRCbOgbNha8i+np1uuJX+L+On+z+GoS2ABG9VCY1
         OCug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=dzZLMbLcFU1uD7feNvhY8lQJ1DFpZxdpStbb2+FnDZo=;
        b=ZlsPOJICHg/a4m//cK7rJ3BXOoSftai5VlPNmXwYZwIzqgVc7BIjevCDTduSuqRdjG
         4kSmtYZWa079/fcd5xApzkhURRz/sLqKvEsZZuyhuBAZ3vfrXie5wAwtPilnoQHwDx1P
         SA6ZB7vOwWSO1JIZbJCSoiV8votfvUrn3wyex8jDHFJNYEGpSEVGYmgkwYO64zwPO+HU
         KZj3H/sgRC39T48B1dslNzfSl9WlM+cUWODB5+uULQQ8CDd7H4FZtodXzCww1h9Zqnlt
         g0Mh98+uhZZObIMdCyyrZ2ExTszOIA94FleUatSOH8mcZ/TBhHKJQnBRLFvwd/QCG8et
         f37Q==
X-Gm-Message-State: AOAM530OiqCx+nG5v1D9SkoSqiMswrYIbwqgr/JzBNVW/Y8RVV5Ilb6Y
        kyDQDeLcYkpjLyrPHssMyuQObO3MzYfx4A==
X-Google-Smtp-Source: ABdhPJzpNqsqwOwvN00vIME4w5sYqJI1y/akw7cPqTggUurjmiEUJbVCFBXJyB//2YTtEh5YKTA6lQ==
X-Received: by 2002:a17:902:7c8a:b029:e6:f010:a4f4 with SMTP id y10-20020a1709027c8ab02900e6f010a4f4mr20402064pll.17.1620576995157;
        Sun, 09 May 2021 09:16:35 -0700 (PDT)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id 66sm9599610pgj.9.2021.05.09.09.16.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 May 2021 09:16:34 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>,
        Changheun Lee <nanich.lee@samsung.com>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fix for 5.13-rc1
Message-ID: <2ddc94ae-e805-f0fa-b18a-879c422435cb@kernel.dk>
Date:   Sun, 9 May 2021 10:16:32 -0600
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

Turns out the bio max size change still has issues, so let's get it
reverted for 5.13-rc1. We'll shake out the issues there and defer it to
5.14 instead.

Please pull!


The following changes since commit cf7b39a0cbf6bf57aa07a008d46cf695add05b4c:

  block: reexpand iov_iter after read/write (2021-05-06 09:24:03 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block-5.13-2021-05-09

for you to fetch changes up to 35c820e71565d1fa835b82499359218b219828ac:

  Revert "bio: limit bio max size" (2021-05-08 21:49:48 -0600)

----------------------------------------------------------------
block-5.13-2021-05-09

----------------------------------------------------------------
Jens Axboe (1):
      Revert "bio: limit bio max size"

 block/bio.c            | 13 ++-----------
 block/blk-settings.c   |  5 -----
 include/linux/bio.h    |  4 +---
 include/linux/blkdev.h |  2 --
 4 files changed, 3 insertions(+), 21 deletions(-)


-- 
Jens Axboe

