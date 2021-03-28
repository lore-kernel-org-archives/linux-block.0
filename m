Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08057C433DB
	for <linux-block@archiver.kernel.org>; Sun, 28 Mar 2021 01:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B86DD6199F
	for <linux-block@archiver.kernel.org>; Sun, 28 Mar 2021 01:05:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbhC1BEj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 27 Mar 2021 21:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbhC1BEj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 27 Mar 2021 21:04:39 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE26C0613B1
        for <linux-block@vger.kernel.org>; Sat, 27 Mar 2021 18:04:38 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id w10so2758287pgh.5
        for <linux-block@vger.kernel.org>; Sat, 27 Mar 2021 18:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=uSz45k+ySg/4GOnTQtSDVIKY24b8xB0NODKFBWgDbs8=;
        b=jwdXrgVh6etOO380BvEYW2JrQfrv6IIpvQdnSqu07/pYqO9E9V/mRs5Le0jOi+7wMe
         5mlt5aEu8hBsvkFTTk+yzcGKmTC2oI8TcxW6iDIi31d+AUbkTNs0KuQNTVKORXE47suS
         X26R7uQFTwTI9LxJuSlADObyTAuGB1hlv85Bs1+1vZwzns+PuhyfgVZyhOPxKTdFozsu
         bL4+f//tr6GIuCpXnb/Ga+3+QAEbWiloNJqmzMtEV49VbyVxjFLF6e2fkXrT0cZKlSm+
         S8Z2yoBjhnPUZ13PIpn+QB7R1b9TYPnD05kL7xDWV3cH5HuaGdG+eiRHwUmmrQdAitZp
         XfIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=uSz45k+ySg/4GOnTQtSDVIKY24b8xB0NODKFBWgDbs8=;
        b=SZsfi4UU+lz73MNg7+EGMGiaqEovQ0xyfXj7FTjEGzEax3qL0AAIphq4JIu8XMRz4j
         C4ec9MDliEMdqIUJNpi/sV/6LqiwqlYwp02vU0//52nqF+Af7uChTEyoopc/x4Nzvq6f
         Lh2my1GdEXKrg6eHLO6Mx7ptkOrb3IKNQjpe+4e3hfZxB/eHnBsNeBCe03UrkIVA1QH7
         5NzAe/EMEYmTLqvudvHn5K1YI0xbInjZehvlALmIK9BvXWcZsqPoC8dZ3RxZN+bvh0b3
         833gCy01rJ+wpa+xiWQHu+XZnGjsvRvbRh6lZ9lxeI9neYlAdHvlBVepXtqhgr2H7sUJ
         U+TA==
X-Gm-Message-State: AOAM533rgJXd9ZQsx3G4qDsuloQwlViypUUzAGSVCYbFFmPEvJ28OhM+
        +YzC4hVZIKyCH4QyCevA/7fv+4rBRH0GJg==
X-Google-Smtp-Source: ABdhPJxZzOfy/fs8/YImaYTIlE8nKnWcV8babIlPDD1rJ8VSX01BQ2t1y8t7elSs/Q2d98aHq1z+Gw==
X-Received: by 2002:aa7:952c:0:b029:1f1:533c:40d7 with SMTP id c12-20020aa7952c0000b02901f1533c40d7mr19475120pfp.81.1616893478090;
        Sat, 27 Mar 2021 18:04:38 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id v23sm12569027pfn.71.2021.03.27.18.04.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Mar 2021 18:04:37 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.12-rc5
Message-ID: <e5bb408c-534d-4255-8a97-e525e686c596@kernel.dk>
Date:   Sat, 27 Mar 2021 19:04:37 -0600
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

- Fix regression from this merge window with the xarray partition
  change, which allowed partition counts that overflow the u8 that holds
  the partition number (Ming)

- Fix zone append warning (Johannes)

- Segmentation count fix for multipage bvecs (David)

- Partition scan fix (Chris)

Please pull!


The following changes since commit d38b4d289486daee01c1fdf056b46b7cdfe72e9e:

  Merge tag 'nvme-5.12-20210319' of git://git.infradead.org/nvme into block-5.12 (2021-03-19 06:40:47 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block-5.12-2021-03-27

for you to fetch changes up to e82fc7855749aa197740a60ef22c492c41ea5d5f:

  block: don't create too many partitions (2021-03-27 09:22:18 -0600)

----------------------------------------------------------------
block-5.12-2021-03-27

----------------------------------------------------------------
Chris Chiu (1):
      block: clear GD_NEED_PART_SCAN later in bdev_disk_changed

David Jeffery (1):
      block: recalculate segment count for multi-segment discards correctly

Johannes Thumshirn (1):
      block: support zone append bvecs

Ming Lei (1):
      block: don't create too many partitions

 block/bio.c             | 21 ++++++++++++++++++---
 block/blk-merge.c       |  8 ++++++++
 block/partitions/core.c |  7 +++++++
 fs/block_dev.c          |  4 ++--
 4 files changed, 35 insertions(+), 5 deletions(-)

-- 
Jens Axboe

