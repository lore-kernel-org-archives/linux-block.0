Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D63BDC2B9F2
	for <linux-block@archiver.kernel.org>; Sat, 22 May 2021 17:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD13261132
	for <linux-block@archiver.kernel.org>; Sat, 22 May 2021 17:22:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbhEVRXv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 22 May 2021 13:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbhEVRXv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 22 May 2021 13:23:51 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B2FC061574
        for <linux-block@vger.kernel.org>; Sat, 22 May 2021 10:22:25 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id h12so399737plf.11
        for <linux-block@vger.kernel.org>; Sat, 22 May 2021 10:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=zfv7l+S5KgbM0xebPK40UI5dGcUVN6R6uhDoHwpqdV0=;
        b=I4hrT0lo8xPfthkAi+onOXzpFrzzxxx1ygdZiPjsYqH9gO3VMLtDgGG6P04MEXKGiV
         SWKfpCtQwLh/bKx3lfsq7AtqECOptU281sMdOHHIqLKO1o2ndm1gLZlnckWOBNe9W+0I
         kF61KXePq5Fz3z5pTT7yJTYiYDlFzdyarSdUg363rvXq9+fUq/Qf6Hz5SGR8ScTBL/ld
         Vm45xqdElxBfuQBINH+Ljh40/VXl2u5roOWa76wj3B6R4x+q3pHQlZNPzyl1Vk5+Dusn
         JPLSkFPnfF+nOkuYhjICyrx5IFLfpSZPvopou6BBssRaYiJP8ft44SXPQ5k8E0N53TLt
         6Iuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=zfv7l+S5KgbM0xebPK40UI5dGcUVN6R6uhDoHwpqdV0=;
        b=ucpaPwlVR+ShLHUtAbxlwoqV0FWqG/Uf9uhWRq/0933fTkNgQwpxh03kYjEW36jzbW
         DUhZN5+qE2uDgUqu1UQnSbxH5QRMYMaPPQ2ibGwnNr1x6TtiqFENK96RjwEqS+OSWQ+M
         vuYCDAu9aZlt4T5+LDKDuINPllfFYsGSpNbvJf1aJzax4C1QjYB2mi3hRfI9Kqk/Mnp8
         76NSIavXbcrsafQACUVi54U3q/EoznqxXiJLzVkg+eEEQ1TmqRt+QWGu+yWS7HssVRHe
         zF/lEFQPucU7QMLFNGKWWPTPY/bloc4gJ7fBBILQG6lfi4PVjlKpi97B4R5uo4kXQycN
         5zUg==
X-Gm-Message-State: AOAM532yB0goZZjhMP5jIOyvGOSfWk+Dh/VnS3nJz6EYfhBltC3vWdzJ
        17LFBVYMsXAWgu7tIMmmPQcPB40Ib8OgMg==
X-Google-Smtp-Source: ABdhPJxChFys6MaKdp3+7/Nr/uTIO+Ip9w/unbjgGRcO2un21wy7vEKfho31UY+cTvZ04HVi+ud1SA==
X-Received: by 2002:a17:90b:d98:: with SMTP id bg24mr16062992pjb.112.1621704144729;
        Sat, 22 May 2021 10:22:24 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id o9sm7704387pfh.217.2021.05.22.10.22.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 May 2021 10:22:24 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.13-rc3
Message-ID: <6b2a9507-a892-7c34-dd05-76ea55769a55@kernel.dk>
Date:   Sat, 22 May 2021 11:22:26 -0600
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

A few fixes for -rc3:

- Fix BLKRRPART and deletion race (Gulam, Christoph)

- NVMe pull request (Christoph):
	- nvme-tcp corruption and timeout fixes (Sagi Grimberg, Keith
	  Busch)
	- nvme-fc teardown fix (James Smart)
	- nvmet/nvme-loop memory leak fixes (Wu Bo)"

Please pull!


The following changes since commit 4bc2082311311892742deb2ce04bc335f85ee27a:

  block/partitions/efi.c: Fix the efi_partition() kernel-doc header (2021-05-14 09:00:06 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block-5.13-2021-05-22

for you to fetch changes up to bc6a385132601c29a6da1dbf8148c0d3c9ad36dc:

  block: fix a race between del_gendisk and BLKRRPART (2021-05-20 07:59:35 -0600)

----------------------------------------------------------------
block-5.13-2021-05-22

----------------------------------------------------------------
Christoph Hellwig (1):
      block: prevent block device lookups at the beginning of del_gendisk

Gulam Mohamed (1):
      block: fix a race between del_gendisk and BLKRRPART

James Smart (1):
      nvme-fc: clear q_live at beginning of association teardown

Jens Axboe (1):
      Merge tag 'nvme-5.13-2021-05-20' of git://git.infradead.org/nvme into block-5.13

Keith Busch (1):
      nvme-tcp: rerun io_work if req_list is not empty

Sagi Grimberg (1):
      nvme-tcp: fix possible use-after-completion

Wu Bo (2):
      nvmet: fix memory leak in nvmet_alloc_ctrl()
      nvme-loop: fix memory leak in nvme_loop_create_ctrl()

 block/genhd.c              | 11 +----------
 drivers/nvme/host/fc.c     | 12 ++++++++++++
 drivers/nvme/host/tcp.c    |  5 +++--
 drivers/nvme/target/core.c |  2 +-
 drivers/nvme/target/loop.c |  4 +++-
 fs/block_dev.c             | 18 ++++++++----------
 include/linux/genhd.h      |  2 --
 7 files changed, 28 insertions(+), 26 deletions(-)

-- 
Jens Axboe

