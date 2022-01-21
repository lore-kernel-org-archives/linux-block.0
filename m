Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D89C433F5
	for <linux-block@archiver.kernel.org>; Fri, 21 Jan 2022 13:41:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350636AbiAUNlF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Jan 2022 08:41:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235175AbiAUNlF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Jan 2022 08:41:05 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B6E6C061574
        for <linux-block@vger.kernel.org>; Fri, 21 Jan 2022 05:41:05 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id r15so7642713ilj.7
        for <linux-block@vger.kernel.org>; Fri, 21 Jan 2022 05:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=cDr3vNomNDCKFdF35ALOQFuIyi3whzLCi+09XJGyqjY=;
        b=n0esj85hKlwZauXumWyd9Od5Bsomq/9rbEdxLVp5ZKHIZuaxDDbMSttnRgdD/n77J2
         GUdV6nAzL90uldVsKs5XeqFJBI21KSi5LH/3mSgTg9c5Fmnu2Co+4EUHtqchzA9pUzPi
         rr3Lxq7tLK6eJniEA/zONuCCynQKgQUvu8/9lKS/tmuat2RfrogHfY+5wzU3IJLR+/u1
         6bwWjzASt63V6IhA6N7aY7PJNPsa4I8ipQPPZ43V+5aAwmG3pUilveY5QDA22h9xYYJa
         M/aMODwwCIGxEibnyaLaQoe2yXbS/tYA3yiB6AF1xL+gLZOMTIeVRgOCqJkOrvyKbpSE
         AISA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=cDr3vNomNDCKFdF35ALOQFuIyi3whzLCi+09XJGyqjY=;
        b=drvgxyACrKUqIR4SRAyppVixALaNVNh6FV9OAkIuIKIQqoOaqDnvYhj1aXb/BpI52t
         nAObRpldZjgjG47Wr0yfO9HMIY4diblPBJwMMePAleQQixxJV/Ci7x5+HiNhugtgNYwW
         ybmh3x2ByD7K5FQS1Sg4GwEp4nsTi8cBuSB6e6gGocECvJCeFymubnTSdbKRsSo0KU3i
         6LeL5i5A0zVFjSp3Zkkr/2Xcur4X+ECkBffspT5tzCHnFLGMu8tNB3t8CiqD1bk7VcIu
         Xjc1cfkVZwqP/6MivyHzLKWfkCQBMzVrbpl3tEI+F0+EzrXZM3Qvl7dxg6eHFQHfRiFs
         LYfg==
X-Gm-Message-State: AOAM533kwCNv7djOFwYSKJdOz9cwRomiDg6DNKRWECuH8XWD4R0GDNYv
        H8AAKhgFlSOTu5cB9wvuTxgnERZRjDugog==
X-Google-Smtp-Source: ABdhPJy5ih13FXzK7UJUVn8KvUOxrBsNimxHCJUKwtOO2YYxbkGKK1qa/0Z9ppqH7ZOTeBBYGKSYFA==
X-Received: by 2002:a05:6e02:170d:: with SMTP id u13mr1892858ill.321.1642772464314;
        Fri, 21 Jan 2022 05:41:04 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id g6sm1518302iow.4.2022.01.21.05.41.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jan 2022 05:41:03 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.17-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Message-ID: <bc78bf16-3c07-66a3-fa1b-a07cbc95ac84@kernel.dk>
Date:   Fri, 21 Jan 2022 06:41:01 -0700
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

Various little minor fixes that should go into this release:

- Fix issue with cloned bios and IO accounting (Christoph)

- Remove redundant assignments (Colin, GuoYong)

- Fix an issue with the mq-deadline async_depth sysfs interface (me)

- Fix brd module loading race (Tetsuo)

- Shared tag map wakeup fix (Laibin)

- End of bdev read fix (OGAWA)

- srcu leak fix (Ming)

Please pull!


The following changes since commit fb3b0673b7d5b477ed104949450cd511337ba3c6:

  Merge tag 'mailbox-v5.17' of git://git.linaro.org/landing-teams/working/fujitsu/integration (2022-01-13 11:19:07 -0800)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block-5.17-2022-01-21

for you to fetch changes up to 46cdc45acb089c811d9a54fd50af33b96e5fae9d:

  block: fix async_depth sysfs interface for mq-deadline (2022-01-20 10:54:02 -0700)

----------------------------------------------------------------
block-5.17-2022-01-21

----------------------------------------------------------------
Christoph Hellwig (1):
      block: assign bi_bdev for cloned bios in blk_rq_prep_clone

Colin Ian King (2):
      loop: remove redundant initialization of pointer node
      aoe: remove redundant assignment on variable n

GuoYong Zheng (1):
      block: Remove unnecessary variable assignment

Jens Axboe (1):
      block: fix async_depth sysfs interface for mq-deadline

Laibin Qiu (1):
      blk-mq: fix tag_get wait task can't be awakened

Ming Lei (1):
      block: cleanup q->srcu

OGAWA Hirofumi (1):
      block: Fix wrong offset in bio_truncate()

Tetsuo Handa (1):
      brd: remove brd_devices_mutex mutex

 block/bio.c                |  3 +-
 block/blk-mq-tag.c         | 40 ++++++++++++++++++++-----
 block/blk-mq.c             |  1 +
 block/blk-sysfs.c          |  4 ++-
 block/mq-deadline.c        |  4 +--
 drivers/block/aoe/aoecmd.c |  2 +-
 drivers/block/brd.c        | 73 +++++++++++++++++++---------------------------
 drivers/block/loop.c       |  2 +-
 include/linux/sbitmap.h    | 11 +++++++
 lib/sbitmap.c              | 25 ++++++++++++++--
 10 files changed, 106 insertions(+), 59 deletions(-)

-- 
Jens Axboe

