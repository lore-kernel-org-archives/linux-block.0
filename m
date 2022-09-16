Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3547DECAAD8
	for <linux-block@archiver.kernel.org>; Fri, 16 Sep 2022 09:08:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbiIPJIV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Sep 2022 05:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiIPJIU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Sep 2022 05:08:20 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E2729C96
        for <linux-block@vger.kernel.org>; Fri, 16 Sep 2022 02:08:19 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id n40-20020a05600c3ba800b003b49aefc35fso6165138wms.5
        for <linux-block@vger.kernel.org>; Fri, 16 Sep 2022 02:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date;
        bh=FIbPmibzQTRMTUkpa3IcFZ4WSAzHDHjA8c4r+3ZVTVo=;
        b=G0E7az8JhZmPZ+bc6a/ChreAWtXKM18EGZ8V4dPi+9oUkjeFJtRmhzmAKFeUCYddCb
         l8/YlIpP2OzdZyhxQlRcCVLqtL9vMcSyBMfcU5KVa0m/7KPC8uRHxvrONXGhPaLg3jQK
         aaepR9Gwr+ZLQn1oeeo8h79ksuBi3L5R4ow/n+cLNNoWwRMzzJn/Cj7pPSwo13qD4d9K
         Rh7VSDe7b+6ajPuDEj2MzBZGM7RwXHwh8W9kkogPkajFpBcOU0EQsw2rbXR6OshMRAIk
         gvTVls2dbKRlMFTzoY/BA2ARmqLFBGiDR6/97iPR1jzUKm3slj5Rqkz+zeVuHiQUuFNl
         9fMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=FIbPmibzQTRMTUkpa3IcFZ4WSAzHDHjA8c4r+3ZVTVo=;
        b=39EAo+UH+rR4l1UhnEKlyP2wcdy/jAmFUhgg0Ak2mozauEOIpIumAnEs6Woa+owzn7
         gn2S7rzFdpY+DviS4wJN+dAPXMjEUFLBuzo/z9pHPzxRbJt3/woYi3AGkqQErOUdMT8t
         f5fCTgAtkDqSHqS0gvc6d8uYvH1hzpGNIirgXishIDKX+dS3eIi33HgiB43ztk1rqvbi
         Q3zr0N6SjAXedeih8XVBJtpovsMlG4bP2LN6+xrbGIEmEwXDm7Gvz24MUVT5K3WGzFx8
         Twly/y0QibAgrHeRq/yWhI0Ks9fhFE4UUuy6DbtPu4ORmRydg0CTO5MYgdsrIX2A4IIG
         9zxQ==
X-Gm-Message-State: ACgBeo24XI/iDE8vRsOW1G8Icn/mdCeijpif9UUAOHGUru1iuXzspA29
        0X53PqYzCLh75XrHsxtsuxC8p0TD/5hORNU3
X-Google-Smtp-Source: AA6agR56k+omhfMUNHDVvKGb1kyOh7Bo+z+Gj80Zh6swteOrnq75MOKY/NKTpGIfRVoFNgwOTomDVg==
X-Received: by 2002:a1c:6a0b:0:b0:3b3:3ed4:9bef with SMTP id f11-20020a1c6a0b000000b003b33ed49befmr9969345wmc.84.1663319297632;
        Fri, 16 Sep 2022 02:08:17 -0700 (PDT)
Received: from [10.200.94.69] ([82.141.251.28])
        by smtp.gmail.com with ESMTPSA id v128-20020a1cac86000000b003b476bb2624sm1677897wme.6.2022.09.16.02.08.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Sep 2022 02:08:17 -0700 (PDT)
Message-ID: <654cd36f-a42b-3ae3-a92a-3bfc366277fc@kernel.dk>
Date:   Fri, 16 Sep 2022 03:08:16 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 6.0-rc6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Two fixes for -rc6:

- Fix a mixup of sectors and bytes in the secure erase ioctl (Mikulas)

- Fix for a bad return value for a non-blocking bio/blk queue enter call
  (me)

Please pull!


The following changes since commit 745ed37277c5a7202180aa276c87db1362c90fe5:

  block: add missing request flags to debugfs code (2022-09-09 05:57:52 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block-6.0-2022-09-16

for you to fetch changes up to c4fa368466cc1b60bb92f867741488930ddd6034:

  blk-lib: fix blkdev_issue_secure_erase (2022-09-15 00:25:17 -0600)

----------------------------------------------------------------
block-6.0-2022-09-16

----------------------------------------------------------------
Mikulas Patocka (1):
      blk-lib: fix blkdev_issue_secure_erase

Stefan Roesch (1):
      block: blk_queue_enter() / __bio_queue_enter() must return -EAGAIN for nowait

 block/blk-core.c |  4 ++--
 block/blk-lib.c  | 11 ++++++++---
 2 files changed, 10 insertions(+), 5 deletions(-)

-- 
Jens Axboe
