Return-Path: <SRS0=cawq=TY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5ACAC282E1
	for <linux-block@archiver.kernel.org>; Fri, 24 May 2019 22:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B71820862
	for <linux-block@archiver.kernel.org>; Fri, 24 May 2019 22:19:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Nnkv01YP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404258AbfEXWTO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 May 2019 18:19:14 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36046 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404176AbfEXWTO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 May 2019 18:19:14 -0400
Received: by mail-pg1-f193.google.com with SMTP id a3so5765965pgb.3
        for <linux-block@vger.kernel.org>; Fri, 24 May 2019 15:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=z1aqfTZqf/AvwG/+lJF8nCA6z42cn8Osx+rYDn0FGI8=;
        b=Nnkv01YPqgqMK+yjWzV/uea4mAauZVynLg5+qU6PriWLCj1vMabRrVEJ+rblxKTR45
         5wz0HIH6eIAKpc7prUvVOP59htdqE8Bo1IpK7xr5txUh20s/q3klOThJ5OpPFu6AlMso
         Ia6DFsARloJ2lSXM/vVjfMOPqZV82GDlneH7ZlYEzIcN5ISiZ7xhQfV8/QgrjaBIPTbg
         fuTMOZtZoH6UMos9lJGFqq1R3z2JcU3WUrdXVXEkNx6S+eTGrii5ReXALLMWVI4PM1iP
         3K4vUxtAL7sOSQm8sbYuP4SvVGszawldBJYAniJV1Ac9D1RVzqbngTYdL2sCqXN4Sb3I
         W3mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=z1aqfTZqf/AvwG/+lJF8nCA6z42cn8Osx+rYDn0FGI8=;
        b=ot4khEkCxEsMIyUIgIl1LW2uyFpGhFp9yuHlihDMBKKHs+CLdo+6XwzaYkE7ZJY1dv
         PDyGYEaX7m+7x5B0tptUEW8xa0zPr0pd42C/RlLxH9vyzqWRhcPfUUVKEFFmOiU6fvD0
         7dL42UXtM+EHom9bVsiPrdYJJAyON0tcphuuCDG6BrO8EDJd+eeQFp+LBdA7GN7QIeZR
         //FJSW6syw3pSmJT7I5oMsCIEeEaS7YXEv5eyrYzDxk/XBPAc0ceL62iwphrUcxGEnvZ
         2LaGrLlD9xPPvX2UeIYcPL7NcIlWJfS5qPDzMze7g3y+tXwZjWGwX15Kfs0AXgZOp5CY
         c49A==
X-Gm-Message-State: APjAAAWJPeBFfTGkzxfxv8NY3DLrfYq5+DnUEScD8UIqj3KXCne5oWb3
        88hsGL3oDkdcAdhdjiYuKz2aA+7eInseWA==
X-Google-Smtp-Source: APXvYqxuD8KxKq/XOW7pqKtjvCXxia2V20LaknnTB/FQYCJtyVrVISdEVeEZ7CIeO34c7Ama/PV+hg==
X-Received: by 2002:a17:90a:a00a:: with SMTP id q10mr12488535pjp.102.1558736353414;
        Fri, 24 May 2019 15:19:13 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id g8sm4464273pfk.83.2019.05.24.15.19.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 15:19:12 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.2-rc2
Message-ID: <75a2e13c-1e40-6e36-393c-97383eb945f3@kernel.dk>
Date:   Fri, 24 May 2019 16:19:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Here are a set of fixes that should go into this release. This pull
request contains:

- NVMe pull request from Keith, with fixes from a few folks.

- bio and sbitmap before atomic barrier fixes (Andrea)

- Hang fix for blk-mq freeze and unfreeze (Bob)

- Single segment count regression fix (Christoph)

- AoE now has a new maintainer

- tools/io_uring/ Makefile fix, and sync with liburing (me)

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-linus-20190524


----------------------------------------------------------------
Andrea Parri (2):
      bio: fix improper use of smp_mb__before_atomic()
      sbitmap: fix improper use of smp_mb__before_atomic()

Bob Liu (1):
      blk-mq: fix hang caused by freeze/unfreeze sequence

Christoph Hellwig (8):
      nvme: fix srcu locking on error return in nvme_get_ns_from_disk
      nvme: remove the ifdef around nvme_nvm_ioctl
      nvme: merge nvme_ns_ioctl into nvme_ioctl
      nvme: release namespace SRCU protection before performing controller ioctls
      block: don't decrement nr_phys_segments for physically contigous segments
      block: force an unlimited segment size on queues with a virt boundary
      block: remove the segment size check in bio_will_gap
      block: remove the bi_seg_{front,back}_size fields in struct bio

Ed Cashin (1):
      aoe: list new maintainer for aoe driver

Jens Axboe (3):
      tools/io_uring: fix Makefile for pthread library link
      tools/io_uring: sync with liburing
      Merge branch 'nvme-5.2-rc2' of git://git.infradead.org/nvme into for-linus

Keith Busch (7):
      nvme-pci: Fix controller freeze wait disabling
      nvme-pci: Don't disable on timeout in reset state
      nvme-pci: Unblock reset_work on IO failure
      nvme-pci: Sync queues on reset
      nvme: Fix known effects
      nvme: update MAINTAINERS
      nvme-pci: use blk-mq mapping for unmanaged irqs

Laine Walker-Avina (1):
      nvme: copy MTFA field from identify controller

Yufen Yu (1):
      nvme: fix memory leak for power latency tolerance

 MAINTAINERS                  |   4 +-
 block/blk-core.c             |   3 +-
 block/blk-merge.c            | 134 +++++--------------------------------------
 block/blk-mq.c               |  19 +++---
 block/blk-settings.c         |  11 ++++
 drivers/nvme/host/core.c     |  89 +++++++++++++++++++---------
 drivers/nvme/host/nvme.h     |   1 +
 drivers/nvme/host/pci.c      |  27 ++++-----
 include/linux/bio.h          |   2 +-
 include/linux/blk_types.h    |   7 ---
 include/linux/blkdev.h       |   7 ++-
 lib/sbitmap.c                |   2 +-
 tools/io_uring/Makefile      |   2 +-
 tools/io_uring/io_uring-cp.c |  21 +++++--
 tools/io_uring/liburing.h    |  64 +++++++++++++++++----
 tools/io_uring/queue.c       |  36 +++++-------
 tools/io_uring/setup.c       |  10 +++-
 tools/io_uring/syscall.c     |  48 ++++++++++------
 18 files changed, 241 insertions(+), 246 deletions(-)

-- 
Jens Axboe

