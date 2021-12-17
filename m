Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1695C433EF
	for <linux-block@archiver.kernel.org>; Fri, 17 Dec 2021 17:00:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236105AbhLQRA0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Dec 2021 12:00:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239553AbhLQRA0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Dec 2021 12:00:26 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40781C061574
        for <linux-block@vger.kernel.org>; Fri, 17 Dec 2021 09:00:26 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id k14so2105179ils.12
        for <linux-block@vger.kernel.org>; Fri, 17 Dec 2021 09:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=GZBwY2NbRuxbFYYDc91qDyWl8E5i42R8FRX/H+or41M=;
        b=nRz5zY7y0u6WGvjkaVgD4pI26dmMUJEzn95gHmiPdPq6PMMyC4nYmovoE+AX7rebRY
         9TBfyI0BtjNtG5Yr+DzPJqyl9KIW8GBOzBPQScS17wTl6OFnTT7Fp3g5xgAglOi9VAjh
         N8sTnqRFGa4q9TJF3fEo2LMQILSqioRvGWBpgiidOY10hOwD4TmVMB9v7m4GEQv3xqXZ
         cVLcCtPwAaAiNV50aRRxWT+K2Ge0M2H/bVTIFPZeHGU0Fz6ssLnlOa4kU4WdxrhaBmXp
         IzoQsxWazcUvTNex7e6M0zhuB7bi+PxGCvDjY5Weh+LPoq4g91eWGZmdZrnUMqC6vtoN
         2rOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=GZBwY2NbRuxbFYYDc91qDyWl8E5i42R8FRX/H+or41M=;
        b=NCwDHI5mJ8QJT+SxY3W4YX8pAI+o3OeXns34LKH8AkqtAlKvb/4i72M+NBifzF99pE
         nS/TPTFBhli2fM78eWW60vnoqpmETDIpgHqjHBzNikmt3m4cfZgtRONhuY4koZhQGQS6
         0ONYaq7+smrsjxUwVljtlSISYPnRlNa3wwmsK6/HFzs70GkAggfB2UQq4l2cc2F4EOCF
         T2UzT7uJ7/JWskHsOSJrsgnW90pzEAlmikD4LxeHHCPCY0eJ7NeMBRnisPgKRq7/Xs5c
         b7qHoVKjS85Vt6UQ8+kFTVYSStKiXKiWwdD9yemFEn9IMuvjDGcdlrWKISGGS1yqOnKD
         UceQ==
X-Gm-Message-State: AOAM530y8J7rvgVYoTqqnsWPkA2Woy3jkMc1nKPJWk5dgfNhLQl5v6sa
        siTAWq2yD0OHUZ2qQhxVAOro4KXYFUBtjg==
X-Google-Smtp-Source: ABdhPJzIBpmYa4UYCpKJ2/6Z67PDw9L3suZ9psFEOHzSGPI9GQNvpiJXkC5rVbkB3LB7EEEPBeHEvg==
X-Received: by 2002:a05:6e02:18cc:: with SMTP id s12mr2085057ilu.171.1639760425350;
        Fri, 17 Dec 2021 09:00:25 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id w11sm4874084ilv.18.2021.12.17.09.00.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Dec 2021 09:00:25 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.16-rc6
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Message-ID: <2a664593-191b-db70-7dde-0b02ef2b6e6a@kernel.dk>
Date:   Fri, 17 Dec 2021 10:00:24 -0700
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

A few fixes that should go into 5.16-rc6:

- Fix for hammering on the delayed run queue timer (me)

- bcache regression fix for this merge window (Lin)

- Fix a divide-by-zero in the blk-iocost code (Tejun)

Please pull!


The following changes since commit 5eff363838654790f67f4bd564c5782967f67bcc:

  Revert "mtd_blkdevs: don't scan partitions for plain mtdblock" (2021-12-10 11:52:34 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block-5.16-2021-12-17

for you to fetch changes up to aa97f6cdb7e92909e17c8ca63e622fcb81d57a57:

  bcache: fix NULL pointer reference in cached_dev_detach_finish (2021-12-14 20:32:54 -0700)

----------------------------------------------------------------
block-5.16-2021-12-17

----------------------------------------------------------------
Jens Axboe (1):
      block: reduce kblockd_mod_delayed_work_on() CPU consumption

Lin Feng (1):
      bcache: fix NULL pointer reference in cached_dev_detach_finish

Tejun Heo (1):
      iocost: Fix divide-by-zero on donation from low hweight cgroup

 block/blk-core.c          | 2 ++
 block/blk-iocost.c        | 9 ++++++++-
 drivers/md/bcache/super.c | 3 ++-
 3 files changed, 12 insertions(+), 2 deletions(-)

-- 
Jens Axboe

