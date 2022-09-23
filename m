Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D64EC04A95
	for <linux-block@archiver.kernel.org>; Fri, 23 Sep 2022 21:07:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbiIWVHc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Sep 2022 17:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiIWVHb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Sep 2022 17:07:31 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0ED11ED65
        for <linux-block@vger.kernel.org>; Fri, 23 Sep 2022 14:07:30 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id g8so970896iob.0
        for <linux-block@vger.kernel.org>; Fri, 23 Sep 2022 14:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date;
        bh=3x+V1E7U78UlpVIC+T3n4kNYZZkA3jNo4WRUx82FC98=;
        b=QnhZE98RXl0g2uIS78pcvqolmqdrNXVxRdwcVz8DDaSSLI6wOh8fXJyYjHSH4cvZgh
         OtxDaqFlqyvRPe1dQHXG/EkveT3tbYPtcqLz3M06d/Vv84uAUIhpIrJqrktI6eWd82ls
         bnq1vGAozMxwHAOOGLcmsZljWHRyZFfcQFGpt1uKyR/SfBEU5Yvn1wmgryrxCtPOLC23
         vHYQy+yHq7tRcF2yN1o1fNo+op1ARhyHhLeoSpQXvHyBTXwhYx4CO2wZnLpRj//1PKQX
         ECSsqDjJX/7cOAXZ75WtJFFayt0j+7lBETbaXqH9p8QgnA9DUvm2u61TXwkGIy2r9ruu
         U/Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=3x+V1E7U78UlpVIC+T3n4kNYZZkA3jNo4WRUx82FC98=;
        b=e8G+/0eFnIfdSyCHUuqhHn9xtC3mogEJu2Yn6RIoYXHgECEido8AT5lygSNtb1dxoL
         lXJ9+4DSFx/rMtD4Ojzwul3MJ/z+o/o73pay8/VP7RGNwAeabS/2ivCfzBzj5Eu33NBU
         4iTW1fS08/50qmjOW9Lny+58S7o9BsHEJD0QhqNk8w7ftXYfoAsnZFT4m2N5AxIs4MMj
         297/Q4krUoHsPyrZh5lz7Dd+kWaU2fBxsyvi6hCUxHPuLUvDhgZBEHk7YVmXCgrsEO15
         hPBSM5dBRHmlLzarKneEdHVQj0+tCbMSEvmASfUnNwY1L9+r3OYsCXtEWwX5qblPa3Yf
         68UA==
X-Gm-Message-State: ACrzQf2DQucs9YSYwUHdT+FJIpRCY0YUEfLPmL5eGcPcR5moQrCKDoRt
        nS/ciYKnJNl1ZxWN4m8uAMZ7cTctvsiqSw==
X-Google-Smtp-Source: AMsMyM7RBnponTUvwIkM3lzd+blEfoZChnGUzk0RxBMI7pWO6hlsguOVRbXfiZ6FbrCIs03XWlCzhw==
X-Received: by 2002:a02:c72a:0:b0:35a:3fdd:d09a with SMTP id h10-20020a02c72a000000b0035a3fddd09amr5639325jao.89.1663967250303;
        Fri, 23 Sep 2022 14:07:30 -0700 (PDT)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id e26-20020a0566380cda00b003495b85a3b9sm3815743jak.178.2022.09.23.14.07.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 14:07:29 -0700 (PDT)
Message-ID: <0e2b98ab-dd42-074d-ebc3-b9bd3deb779a@kernel.dk>
Date:   Fri, 23 Sep 2022 15:07:29 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 6.0-rc7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Fix a regression that's been plaguing us by reverting the offending
commit, as attempts to both reproduce the issue and fix it in a saner
fashion have failed.

Fix for a potential oops condition in the s390 dasd block driver.

Please pull!


The following changes since commit c4fa368466cc1b60bb92f867741488930ddd6034:

  blk-lib: fix blkdev_issue_secure_erase (2022-09-15 00:25:17 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.0-2022-09-22

for you to fetch changes up to 4c66a326b5ab784cddd72de07ac5b6210e9e1b06:

  Revert "block: freeze the queue earlier in del_gendisk" (2022-09-20 08:15:44 -0600)

----------------------------------------------------------------
block-6.0-2022-09-22

----------------------------------------------------------------
Christoph Hellwig (1):
      Revert "block: freeze the queue earlier in del_gendisk"

Stefan Haberland (1):
      s390/dasd: fix Oops in dasd_alias_get_start_dev due to missing pavgroup

 block/genhd.c                   | 3 ++-
 drivers/s390/block/dasd_alias.c | 9 +++++++--
 2 files changed, 9 insertions(+), 3 deletions(-)

-- 
Jens Axboe
