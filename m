Return-Path: <SRS0=5Asf=UN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59008C31E4B
	for <linux-block@archiver.kernel.org>; Fri, 14 Jun 2019 16:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AC172184B
	for <linux-block@archiver.kernel.org>; Fri, 14 Jun 2019 16:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="oz3YWgre"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbfFNQor (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Jun 2019 12:44:47 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54329 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbfFNQor (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Jun 2019 12:44:47 -0400
Received: by mail-wm1-f66.google.com with SMTP id g135so3015782wme.4
        for <linux-block@vger.kernel.org>; Fri, 14 Jun 2019 09:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=7CH+WbdE07RSa/UhtiXmAA2jIRuDwjxPHDqup0lF5a4=;
        b=oz3YWgredI89AOVH/WxhOHYbChAD58dkSsaqW1PN6BhfT1D85kJlk3sQIyIfQWTdRi
         R7qy4a7GEp2QUS4Stoq/k3k495WjjGJe4CaVn2+jr3uOnnUoz3vyEzyRSm8qM2OjXXYq
         4dxIyBCXeCx5hjhzn/RhRMumrMcOxcL3F5RfBVuPAiX7cTvBIh6aLhvv8y5V69iwnNOU
         /ffMT2RGKtLeLMT8zGBL2UDsDsFknBM2SR36WTK7MkEuEgeODUaGA6idkCRA/vHFZuw+
         88Fpjphu6G0nsVwWTpCgqAca2sd/F72xWtR7Agr6Ng3DuOJIjoi8oRZLYcjtfiv/FgYJ
         HcFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=7CH+WbdE07RSa/UhtiXmAA2jIRuDwjxPHDqup0lF5a4=;
        b=Fq4w789YOH6wghS6P6T1wruFON3Rm3f3pw5KTzthRzO9mVKy/fvKkWzOaFmKBA68XV
         eml+mXeVP0vHfuPZ3OSjxz324K711uewjl/rkYoR+U0hrruq62G4yToOALaq6Hp2ndzX
         jHV+TRRdw/5CiuY91srDTt9TkbDNYfA/bNx2guEBPPB95x6tgCHTokcm/m+JvwTenaDC
         WJbd8CtWKWcjKqr6q1wQFpprga6I0GrqaWSbI19y2kGY2KchKse+QChgkjZPrRNAcAnb
         VZkH2Vu4PP+i7bNujHSMPDrCoK6MpuUH5jM8LhBTgV6Zew9P8Ztn/1H+J4L1ZtRBClD3
         uWDw==
X-Gm-Message-State: APjAAAXKRu7CdhpKycjyLlZzZ3Jaku0r53Oa+xoKAVOJSjBl9Wm6YfqP
        by50W/2QTydibQF7VKhUzpTspZVb4lWTrK3a
X-Google-Smtp-Source: APXvYqxUsnlqyG6An4P3lfFkwUH10IzO4O0gh80FXgexOplEpy/7qCOnHxG5BftxI0MblC/sAlG9Ew==
X-Received: by 2002:a1c:c003:: with SMTP id q3mr8657983wmf.42.1560530685013;
        Fri, 14 Jun 2019 09:44:45 -0700 (PDT)
Received: from [192.168.88.149] ([62.170.2.124])
        by smtp.gmail.com with ESMTPSA id n10sm4031606wrw.83.2019.06.14.09.44.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 09:44:44 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.2-rc5
Message-ID: <8247d8ee-9fce-6824-3a3e-886b0023bdc4@kernel.dk>
Date:   Fri, 14 Jun 2019 10:44:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Another set of fixes brought to you in vacation mode, that should go
into the next -rc. This pull request contains:

- Remove references to old schedulers for the scheduler switching and
  blkio controller documentation (Andreas)

- Kill duplicate check for report zone for null_blk (Chaitanya)

- Two bcache fixes (Coly)

- Ensure that mq-deadline is selected if zoned block device is enabled,
  as we need that to support them (Damien)

- Fix io_uring memory leak (Eric)

- ps3vram fallout from LBDAF removal (Geert)

- Redundant blk-mq debugfs debugfs_create return check cleanup (Greg)

- Extend NOPLM quirk for ST1000LM024 drives (Hans)

- Remove error path warning that can now trigger after the queue
  removal/addition fixes (Ming)

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-linus-20190614


----------------------------------------------------------------
Andreas Herrmann (2):
      block/switching-sched.txt: Update to blk-mq schedulers
      blkio-controller.txt: Remove references to CFQ

Chaitanya Kulkarni (1):
      null_blk: remove duplicate check for report zone

Coly Li (2):
      bcache: fix stack corruption by PRECEDING_KEY()
      bcache: only set BCACHE_DEV_WB_RUNNING when cached device attached

Damien Le Moal (1):
      block: force select mq-deadline for zoned block devices

Eric Biggers (1):
      io_uring: fix memory leak of UNIX domain socket inode

Geert Uytterhoeven (1):
      block/ps3vram: Use %llu to format sector_t after LBDAF removal

Greg Kroah-Hartman (1):
      blk-mq: no need to check return value of debugfs_create functions

Hans de Goede (1):
      libata: Extend quirks for the ST1000LM024 drives with NOLPM quirk

Ming Lei (1):
      blk-mq: remove WARN_ON(!q->elevator) from blk_mq_sched_free_requests

 Documentation/block/switching-sched.txt      |  18 ++--
 Documentation/cgroup-v1/blkio-controller.txt |  96 ++----------------
 block/Kconfig                                |   1 +
 block/blk-mq-debugfs.c                       | 145 +++++++--------------------
 block/blk-mq-debugfs.h                       |  36 +++----
 block/blk-mq-sched.c                         |   1 -
 drivers/ata/libata-core.c                    |   9 +-
 drivers/block/null_blk_zoned.c               |   4 -
 drivers/block/ps3vram.c                      |   2 +-
 drivers/md/bcache/bset.c                     |  16 ++-
 drivers/md/bcache/bset.h                     |  34 ++++---
 drivers/md/bcache/sysfs.c                    |   7 +-
 fs/io_uring.c                                |   4 +-
 13 files changed, 114 insertions(+), 259 deletions(-)

-- 
Jens Axboe

