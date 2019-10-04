Return-Path: <SRS0=jhC6=X5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B010C32792
	for <linux-block@archiver.kernel.org>; Fri,  4 Oct 2019 02:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1CDD21783
	for <linux-block@archiver.kernel.org>; Fri,  4 Oct 2019 02:33:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="elMgZVVI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730977AbfJDCdF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Oct 2019 22:33:05 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39854 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730554AbfJDCdF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Oct 2019 22:33:05 -0400
Received: by mail-pf1-f193.google.com with SMTP id v4so2943541pff.6
        for <linux-block@vger.kernel.org>; Thu, 03 Oct 2019 19:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=8dCq6KbZ9ASS8UtMWGLbwu/CrYZ5J/LFvunkziXSoj0=;
        b=elMgZVVI1I5QyvHzhUFJwhmLQIukWwOUbSc2OEMmDJPNka4R5AMmkbSYS7YrOuSbMe
         xxhRP66yYiERZ9IucgB0yKMZLnX2JVlZiUihD469CzHcsqosm7WsbZrfXrZRPL6mYf5x
         u0qmJfV5/Cc/QuZv1IcH0ejKUv2+HTZ3o8WIx1wFtK8wyDtW37c0xSqQ4KFf1O7W9UAv
         VoANbIR1ENtlyOAJeaFMOD54gmNrETfWaX/k0l699HzsC6ODDywDzwNX6jhqSkx0Jhr3
         WUFWTclZ1TFOVAPFw68M6tgXeCGOQSfusHE17Q+UC1t9TfNCv7Br/TJIKH2V7B4vVA2o
         bDYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=8dCq6KbZ9ASS8UtMWGLbwu/CrYZ5J/LFvunkziXSoj0=;
        b=t/XNOPTmaTdDduorEQyH5BAsfR0hX7KBY3uFzmIYxZn0a3xuiZ0nAtz0wvKqEfHION
         NACXSMTfpWwEJM5wHn6mCCiF1zr+IaBamHFnuPYYWa4p4RQXUepw4ZOxuR3oxAkUyVDH
         8rgdrd2/rMGOyEDLECbkF1LWh7djmI+0o22/U4lrcZ+NNxAmf7J9ZDPzkGs60YLUXcp8
         wHlazP+1XLVTU2dUQMll0HDTL0qKJayBtN49adBQimfvxiYiV460OBs0FAExT8jYvKLl
         cgO1LeHZ3dw/Ks2gSmlrkF6Nsosu10x6sjTEv5YLycypnzyr3zccDgXPK82sVeE6s+Db
         FuDg==
X-Gm-Message-State: APjAAAViU83/16AYheZGfl12uTC71z1zQW3DhlFD/oDH4rmQ11rL4IrR
        8vdUFVY4YRJQwbgwPY9L7i0dlxenwiVjSA==
X-Google-Smtp-Source: APXvYqyxW9F6eSVzphTXELYOhDjJIYoB8mSbGoMwJfYyEmXh85BxKSmdp9f9MNcqZaX7NwxWRGwYsQ==
X-Received: by 2002:a63:4652:: with SMTP id v18mr13130390pgk.364.1570156382345;
        Thu, 03 Oct 2019 19:33:02 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id 7sm3371788pgj.35.2019.10.03.19.33.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Oct 2019 19:33:01 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.4-rc2
Message-ID: <0aa232d8-6765-b088-b0da-64e95d58d78c@kernel.dk>
Date:   Thu, 3 Oct 2019 20:33:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Here are a set of changes that should go into this release. This pull
request contains:

- Mandate timespec64 for the io_uring timeout ABI (Arnd)

- Set of NVMe changes via Sagi:
     - controller removal race fix from Balbir
     - quirk additions from Gabriel and Jian-Hong
     - nvme-pci power state save fix from Mario
     - Add 64bit user commands (for 64bit registers) from Marta
     - nvme-rdma/nvme-tcp fixes from Max, Mark and Me
     - Minor cleanups and nits from James, Dan and John

- Two s390 dasd fixes (Jan, Stefan)

- Have loop change block size in DIO mode (Martijn)

- paride pg header ifdef guard (Masahiro)

- Two blk-mq queue scheduler tweaks, fixing an ordering issue on zoned
  devices and suboptimal performance on others (Ming)

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-linus-2019-10-03


----------------------------------------------------------------
Arnd Bergmann (1):
      io_uring: use __kernel_timespec in timeout ABI

Balbir Singh (1):
      nvme-pci: Fix a race in controller removal

Dan Carpenter (1):
      nvme: fix an error code in nvme_init_subsystem()

Gabriel Craciunescu (1):
      Added QUIRKs for ADATA XPG SX8200 Pro 512GB

James Smart (1):
      nvme: Add ctrl attributes for queue_count and sqsize

Jan Höppner (1):
      s390/dasd: Fix error handling during online processing

Jens Axboe (1):
      Merge branch 'nvme-5.4' of git://git.infradead.org/nvme into for-linus

Jian-Hong Pan (1):
      nvme: Add quirk for Kingston NVME SSD running FW E8FK11.T

John Pittman (1):
      nvmet: change ppl to lpp

Keith Busch (1):
      nvme: Move ctrl sqsize to generic space

Mario Limonciello (1):
      nvme-pci: Save PCI state before putting drive into deepest state

Marta Rybczynska (1):
      nvme: allow 64-bit results in passthru commands

Martijn Coenen (1):
      loop: change queue block size to match when using DIO

Masahiro Yamada (1):
      block: pg: add header include guard

Max Gurtovoy (1):
      nvme-rdma: Fix max_hw_sectors calculation

Ming Lei (2):
      blk-mq: honor IO scheduler for multiqueue devices
      blk-mq: apply normal plugging for HDD

Randy Dunlap (2):
      block: sed-opal: fix sparse warning: obsolete array init.
      block: sed-opal: fix sparse warning: convert __be64 data

Sagi Grimberg (2):
      nvmet-tcp: remove superflous check on request sgl
      nvme-rdma: fix possible use-after-free in connect timeout

Stefan Haberland (1):
      Revert "s390/dasd: Add discard support for ESE volumes"

Wunderlich, Mark (1):
      nvme-tcp: fix wrong stop condition in io_work

 block/blk-mq.c                    |  12 +++-
 block/sed-opal.c                  |   6 +-
 drivers/block/loop.c              |  10 +++
 drivers/nvme/host/core.c          | 132 ++++++++++++++++++++++++++++++++------
 drivers/nvme/host/nvme.h          |   2 +-
 drivers/nvme/host/pci.c           |  20 ++++--
 drivers/nvme/host/rdma.c          |  19 ++++--
 drivers/nvme/host/tcp.c           |   4 +-
 drivers/nvme/target/io-cmd-bdev.c |  16 ++---
 drivers/nvme/target/tcp.c         |  12 ++--
 drivers/s390/block/dasd_eckd.c    |  81 ++++-------------------
 fs/io_uring.c                     |   8 +--
 include/uapi/linux/nvme_ioctl.h   |  23 +++++++
 include/uapi/linux/pg.h           |   5 +-
 14 files changed, 218 insertions(+), 132 deletions(-)

-- 
Jens Axboe

