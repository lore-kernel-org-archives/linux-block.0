Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE7DC433ED
	for <linux-block@archiver.kernel.org>; Sat, 15 May 2021 03:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E89B76144A
	for <linux-block@archiver.kernel.org>; Sat, 15 May 2021 03:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233403AbhEODHQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 May 2021 23:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbhEODHP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 May 2021 23:07:15 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1746C06174A
        for <linux-block@vger.kernel.org>; Fri, 14 May 2021 20:06:02 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id h20so318398plr.4
        for <linux-block@vger.kernel.org>; Fri, 14 May 2021 20:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=DqjIqgNxxNeen65OsV1ZqaYieC1jVowlqfrY7aggzGc=;
        b=HStM25lVpZDIIW83OSZWMYETMVwyCeNt4qrFyLQMRQELUZkQOcmV5k4I32W2VHmaDQ
         U1M6UpUMtgB4WSw0rtTAkbBhD3/lwX9Zm4+dwp+7XC+25WhmoAGlUikh/+CuMfEWp60x
         f1uFlJrLo2K5BviLW+QymKjNSeGY0b6FC2oo0sb/R/34bt2flan78WiF+w6/c3sPSBtu
         r+3Q/6nqSdMHtUTquO/pPZ7w6GAWTyd3A9i8LpJy+a2OFYEBfFgEOd09OTtKnq7WEMWm
         ylV5UTQ/g8ra5A3CpdgyFoJARmTopDUvqLk0KJrBCg89MQuiS/pPR2ps1fBFHGg61tax
         NKgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=DqjIqgNxxNeen65OsV1ZqaYieC1jVowlqfrY7aggzGc=;
        b=D8WvxJqTlAHIqkraBOXOwxXC8ES5MMj2zeGNmyw5oo4Qgux86T+IZowAvleuJ9MmHh
         0YjE47bxsUqQsaXYlnELvi/eo0qyozOItYTJiAP3rPtdFOaxfjnQrssZw3oYXN/w5XWh
         64uQ9o0lOA7L3qVsEF3KSqsCxtGWY2gGsQr6caSk7F4iNligtgpDl8Q1lUTlhS4AJ4hU
         +6hEtntD2/fyCnZZFEUZqASf/qHtM9InQCdaHBrIkj3he4LUl56NpOHIRfQ0+QAbEibh
         wtc2DxYhrbokU2HGs4qscO6a8EMWcgGAybPfW839WAYQ7dmO3H7mk9mj7SSL/tEiO9tk
         CTdA==
X-Gm-Message-State: AOAM532wot2ThCCTUxviD+GLmJLoUIUWjHbPimGvinTsISgudyHx6oAU
        ijFZ47BnJL8/VW6rt2AhY7Vyk8cmklR1Uw==
X-Google-Smtp-Source: ABdhPJyln9QKncN9cRrqcD9TwbEjbKq1c+jmparYGnmL8czkSrirhMeclmGF3hiLpImHupwnAljV6g==
X-Received: by 2002:a17:90b:1bcd:: with SMTP id oa13mr14800273pjb.22.1621047962152;
        Fri, 14 May 2021 20:06:02 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id j16sm5579497pgh.69.2021.05.14.20.06.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 May 2021 20:06:01 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.13-rc
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Message-ID: <e1e84296-62d5-ba60-82f7-f33ff9988ca7@kernel.dk>
Date:   Fri, 14 May 2021 21:06:01 -0600
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

- Fix for shared tag set exit (Bart)

- Correct ioctl range for zoned ioctls (Damien)

- Removed dead/unused function (Lin)

- Fix perf regression for shared tags (Ming)

- Fix out-of-bounds issue with kyber and preemption (Omar)

- BFQ merge fix (Paolo)

- Two error handling fixes for nbd (Sun)

- Fix weight update in blk-iocost (Tejun)

- NVMe pull request (Christoph):
	- correct the check for using the inline bio in nvmet
	  (Chaitanya Kulkarni)
	- demote unsupported command warnings (Chaitanya Kulkarni)
	- fix corruption due to double initializing ANA state (me, Hou Pu)
	- reset ns->file when open fails (Daniel Wagner)
	- fix a NULL deref when SEND is completed with error in
	  nvmet-rdma (Michal Kalderon)

- Fix kernel-doc warning (Bart)

Please pull!


The following changes since commit 35c820e71565d1fa835b82499359218b219828ac:

  Revert "bio: limit bio max size" (2021-05-08 21:49:48 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block-5.13-2021-05-14

for you to fetch changes up to 4bc2082311311892742deb2ce04bc335f85ee27a:

  block/partitions/efi.c: Fix the efi_partition() kernel-doc header (2021-05-14 09:00:06 -0600)

----------------------------------------------------------------
block-5.13-2021-05-14

----------------------------------------------------------------
Bart Van Assche (2):
      blk-mq: Swap two calls in blk_mq_exit_queue()
      block/partitions/efi.c: Fix the efi_partition() kernel-doc header

Chaitanya Kulkarni (5):
      nvmet: fix inline bio check for bdev-ns
      nvmet: fix inline bio check for passthru
      nvmet: demote discovery cmd parse err msg to debug
      nvmet: use helper to remove the duplicate code
      nvmet: demote fabrics cmd parse err msg to debug

Christoph Hellwig (1):
      nvme-multipath: fix double initialization of ANA state

Damien Le Moal (1):
      block: uapi: fix comment about block device ioctl

Daniel Wagner (1):
      nvmet: seset ns->file when open fails

Hou Pu (1):
      nvmet: use new ana_log_size instead the old one

Jens Axboe (1):
      Merge tag 'nvme-5.13-2021-05-13' of git://git.infradead.org/nvme into block-5.13

Lin Feng (1):
      blkdev.h: remove unused codes blk_account_rq

Michal Kalderon (1):
      nvmet-rdma: Fix NULL deref when SEND is completed with error

Ming Lei (1):
      blk-mq: plug request for shared sbitmap

Omar Sandoval (1):
      kyber: fix out of bounds access when preempted

Paolo Valente (1):
      block, bfq: avoid circular stable merges

Sun Ke (2):
      nbd: Fix NULL pointer in flush_workqueue
      nbd: share nbd_put and return by goto put_nbd

Tejun Heo (1):
      blk-iocost: fix weight updates of inner active iocgs

 block/bfq-iosched.c               | 34 +++++++++++++++++++++---
 block/blk-iocost.c                | 14 ++++++++--
 block/blk-mq-sched.c              |  8 +++---
 block/blk-mq.c                    | 11 +++++---
 block/kyber-iosched.c             |  5 ++--
 block/mq-deadline.c               |  3 +--
 block/partitions/efi.c            |  2 +-
 drivers/block/nbd.c               | 10 +++----
 drivers/nvme/host/core.c          |  3 ++-
 drivers/nvme/host/multipath.c     | 55 +++++++++++++++++++++------------------
 drivers/nvme/host/nvme.h          |  8 ++++--
 drivers/nvme/target/admin-cmd.c   |  7 ++---
 drivers/nvme/target/discovery.c   |  2 +-
 drivers/nvme/target/fabrics-cmd.c |  6 ++---
 drivers/nvme/target/io-cmd-bdev.c |  2 +-
 drivers/nvme/target/io-cmd-file.c |  8 +++---
 drivers/nvme/target/nvmet.h       |  6 +++++
 drivers/nvme/target/passthru.c    |  2 +-
 drivers/nvme/target/rdma.c        |  4 +--
 include/linux/blkdev.h            |  5 ----
 include/linux/elevator.h          |  2 +-
 include/uapi/linux/fs.h           |  2 +-
 22 files changed, 124 insertions(+), 75 deletions(-)

-- 
Jens Axboe

