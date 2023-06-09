Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A619CC7EE25
	for <linux-block@archiver.kernel.org>; Fri,  9 Jun 2023 20:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232465AbjFIUV6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 9 Jun 2023 16:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjFIUVg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 9 Jun 2023 16:21:36 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B07422F
        for <linux-block@vger.kernel.org>; Fri,  9 Jun 2023 13:20:38 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-77ad566f7fbso18570239f.1
        for <linux-block@vger.kernel.org>; Fri, 09 Jun 2023 13:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1686342019; x=1688934019;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v3DLcpk3UcHISJgBg0wNxB82l3aLFWCna+oxTSr88k4=;
        b=UfhmWUw/Dzx1GVDpFJ0YFhGO0921WYkh7E28L6wNqbq74mkBjAZbmgyQ1aR0t6NbD5
         o4qgV0jxQaHvIoRag5Sd4OPDIb9YF0Ryssx60MHtrQfmtzJ4yPJ6jxfDg3oE74wgihMj
         Pp7NbqGxgtyV2fuzxSC42zIkxoIfAh53va8zbyQc8H4zYZVRvlr5pBPtgPMgpZV4ZKk/
         ExdoRCwD3IqfcHa7MctVQ4Jk9M7Dw+4ZxcTbFIhQsN2BWxW3jBwUo3DZCbVH287u4AzX
         4g1b+x413qISM9NAmzmK4m4r0zA72Bnz6JofR9Vjq7ssrlhy0/OdgLFi4CuzeOEXaT6B
         om0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686342019; x=1688934019;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=v3DLcpk3UcHISJgBg0wNxB82l3aLFWCna+oxTSr88k4=;
        b=NDLgqQ1nDS0aUOspn7HMw4n1rzQCeaGss+7DyGm7mBd+EM7ErvRb7n400xZHK5PgaT
         Sg6kIVKN2EFzEIo41zabLRvBmnys4K+a218bS4OC9vAof/3w5su/8q/2sbvTrKMzEVDS
         eegB8sbLKJFLOj+Wtb/Z+HQ+GKqISrGl+CmDR9r2h/n62lnMYspNTE/VMW4BpD2O3ezm
         Nxz2dZSpRuezONTDg44KAV0LMuFijsHvvMWNL9OS7kExUK15h6ojPwklhsiAd61Hw8XR
         q4GjaaGCLn2CTNwE2rf3s9Jrk1owqa20ZGkL5P5q0yxFrWd1KVJ8F/HQT9cD8s3fGpVC
         iYCQ==
X-Gm-Message-State: AC+VfDxzBnrDNQC+EKyiduEbkdtWKoHaV7JYIVbZN5y6JyyajSqXccyz
        m5n7f8w77IYHUxVtNp9DmdrZrw==
X-Google-Smtp-Source: ACHHUZ6wYvO+aKId9kQoH+OsDlNxz65Exh4nvQ5uC/E+NDSCsF/Oe7lAyZ3vkZIpqsDx6QW6LZj1Kg==
X-Received: by 2002:a6b:5810:0:b0:777:b7c8:ad32 with SMTP id m16-20020a6b5810000000b00777b7c8ad32mr1886269iob.0.1686342019487;
        Fri, 09 Jun 2023 13:20:19 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id n17-20020a6b7211000000b0077ac2261248sm1262082ioc.5.2023.06.09.13.20.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jun 2023 13:20:18 -0700 (PDT)
Message-ID: <54b8e861-a1a9-32b7-3160-60e323327008@kernel.dk>
Date:   Fri, 9 Jun 2023 14:20:18 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 6.4-rc6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Just a few minor fixes for this release:

- Fix an issue with the hardware queue nr_active, causing it to become
  imbalanced (Tian)

- Fix an issue with null_blk not releasing pages if configured as memory
  backed (Nitesh)

- Fix a locking issue in dasd (Jan)

Please pull!


The following changes since commit 2e45a49531fef55f4abbd6738c052545f53f43d4:

  Merge tag 'nvme-6.4-2023-06-01' of git://git.infradead.org/nvme into block-6.4 (2023-06-01 11:12:46 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.4-2023-06-09

for you to fetch changes up to ccc45cb4e7271c74dbb27776ae8f73d84557f5c6:

  s390/dasd: Use correct lock while counting channel queue length (2023-06-09 11:35:52 -0600)

----------------------------------------------------------------
block-6.4-2023-06-09

----------------------------------------------------------------
Jan Höppner (1):
      s390/dasd: Use correct lock while counting channel queue length

Nitesh Shetty (1):
      null_blk: Fix: memory release when memory_backed=1

Tian Lan (1):
      blk-mq: fix blk_mq_hw_ctx active request accounting

 block/blk-mq.c                  | 8 ++++----
 drivers/block/null_blk/main.c   | 1 +
 drivers/s390/block/dasd_ioctl.c | 4 ++--
 3 files changed, 7 insertions(+), 6 deletions(-)

-- 
Jens Axboe

