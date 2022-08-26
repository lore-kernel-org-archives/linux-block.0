Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 527E2ECAAA3
	for <linux-block@archiver.kernel.org>; Fri, 26 Aug 2022 16:38:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbiHZQi4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Aug 2022 12:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbiHZQiw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Aug 2022 12:38:52 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07DD3DF08D
        for <linux-block@vger.kernel.org>; Fri, 26 Aug 2022 09:38:52 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id h78so1564486iof.13
        for <linux-block@vger.kernel.org>; Fri, 26 Aug 2022 09:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc;
        bh=xqGCslTmg1hNhHNkHjUjeGHjE7VfxM3tmXwqrP+wX1M=;
        b=3mikIyEBxwBl3TndaecUeO2XWepCSxN6MfOa6ZuDyirvN0ld9b0XGaVSqEPUP4B9Si
         VEz7E/iXHyWTpIpffm3TnKz5ygH94B5cW6i2veece3yiMlrO2CcqL1CFbwXmdA23RuMB
         uLhAEI5e4+Ied33wl+wEu07EPwCZta2ykWKiDWVfxEk5HO5TsLh7AzlWHj8Tct8+/08h
         kSajJ0lhTjt9a8vT6WcRNaJDXJ2eckqPQWcGMM0u1B86ETM/7JoUAHGFvCywuP+Jytp+
         gRZz+ChCwMQEG9OvuoMmZhl5Cc8FBQqDhjhm//BRvMBLW/Rlm81WfMkT9iz0Lsb6Gg5T
         h9IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc;
        bh=xqGCslTmg1hNhHNkHjUjeGHjE7VfxM3tmXwqrP+wX1M=;
        b=kQ1CEJxEwGRwv31dHOee8Ub74YUHHw58iRqQR7S5IWuh7w3aDd0qNmtIdZ6zxk3zED
         1QboNuwxCHujiAdjDQ0/RPEuNXCi6//DkoZGSBdz4Smi913QuTm1MHRkV6caxmjQI339
         RGV9x9UDwSz+BLh8g8CnZaWE7/z9ZsFtYf4LgAwVlzXNtLxZPYtJuuQb6++SAb95APTn
         4tddkymAkFoN+4p6dwAMFDuXdILKe9mdxwPmYCPFIojgm8IEIsqvQQphVHfrld5qsOkB
         73dZee3KMydMInHNWgwr6W0K5XqIQi1jijzYRvdqMfI4xEaKn1GWZfChCZDoFrIKsheP
         ZOwg==
X-Gm-Message-State: ACgBeo2SN9DzqAjtjOf3WBg1eeHjJxInCk1eWiZjO7cT7NsFK8gxoakt
        u+LiikTfoQ4qeDJEaEZ2Zl1MXaJQumLLuQ==
X-Google-Smtp-Source: AA6agR516OAlRpVj6U2MOquAlVCRCcyvSngyF6Dhv/BsgM/zXHLxeML/SK2sjAPU28Mnw6QUDCx2EA==
X-Received: by 2002:a05:6638:258c:b0:346:c185:1146 with SMTP id s12-20020a056638258c00b00346c1851146mr4449362jat.68.1661531931314;
        Fri, 26 Aug 2022 09:38:51 -0700 (PDT)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id b30-20020a026f5e000000b00349bfd5a61bsm1061933jae.78.2022.08.26.09.38.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 09:38:50 -0700 (PDT)
Message-ID: <4dd058e9-1b1f-365e-1b6f-caa330a6500c@kernel.dk>
Date:   Fri, 26 Aug 2022 10:38:49 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 6.0-rc3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

A few block fixes for this release:

- MD pull request via Song
	- Fix for clustered raid (Guoqing Jiang)
	- req_op fix (Bart Van Assche)
	- Fix race condition in raid recreate (David Sloan)

- loop configuration overflow fix (Siddh)

- Fix missing commit_rqs call for certain conditions (Yu)

Please pull!


The following changes since commit d3b38596875dbc709b4e721a5873f4663d8a9ea2:

  blk-mq: run queue no matter whether the request is the last request (2022-08-18 07:39:01 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block-6.0-2022-08-26

for you to fetch changes up to 645b5ed871f408c9826a61276b97ea14048d439c:

  Merge branch 'md-fixes' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into block-6.0 (2022-08-24 13:58:37 -0600)

----------------------------------------------------------------
block-6.0-2022-08-26

----------------------------------------------------------------
Bart Van Assche (1):
      md/raid10: Fix the data type of an r10_sync_page_io() argument

David Sloan (1):
      md: Flush workqueue md_rdev_misc_wq in md_alloc()

Guoqing Jiang (2):
      Revert "md-raid: destroy the bitmap after destroying the thread"
      md: call __md_stop_writes in md_stop

Jens Axboe (1):
      Merge branch 'md-fixes' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into block-6.0

Siddh Raman Pant (1):
      loop: Check for overflow while configuring loop

Yu Kuai (1):
      blk-mq: fix io hung due to missing commit_rqs

 block/blk-mq.c       |  5 +++--
 drivers/block/loop.c |  5 +++++
 drivers/md/md.c      |  4 +++-
 drivers/md/raid10.c  | 13 ++++++-------
 4 files changed, 17 insertions(+), 10 deletions(-)

-- 
Jens Axboe
