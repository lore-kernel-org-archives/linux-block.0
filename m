Return-Path: <SRS0=SSPg=VX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3577EC7618B
	for <linux-block@archiver.kernel.org>; Fri, 26 Jul 2019 15:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F142A22BE8
	for <linux-block@archiver.kernel.org>; Fri, 26 Jul 2019 15:12:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="VsAvZdIK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbfGZPMr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Jul 2019 11:12:47 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37717 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727645AbfGZPMq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Jul 2019 11:12:46 -0400
Received: by mail-pf1-f194.google.com with SMTP id 19so24665358pfa.4
        for <linux-block@vger.kernel.org>; Fri, 26 Jul 2019 08:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=I5DsDEyV2yxyI2v2SguGq7UaXW+3rRKHattoa2L53Kw=;
        b=VsAvZdIKiGtRLnDN6KBt8w2SoC0pSe9daUVzSCSZLULaKYed+blB7vIK7DiXMZr56+
         TeWDQrcS0eRzuM0Pv4NkPmvt/zmAMil6zNRUVdFQgZ9+Sx8SFMwESneXjj89b3crKplO
         dL3P0mdxWNBAYqR4j/XldGXRmuC/wNUXOm8/cMYRyPE/m+uyazDaq4z8/mssXsoyRgCJ
         mopy2ZnnGNWVKP7TnRmcT8grAhSOcwqVZiIhSaqx1/Z8ngBZu4g5+e+pGrYeMn54a9I1
         n8z2GWV6uqXFxyZMbYmVmR35IRod39NlaoJQrNf6N5z9wzWNqnS/ASht61Aw6dqwV9V3
         Tmdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=I5DsDEyV2yxyI2v2SguGq7UaXW+3rRKHattoa2L53Kw=;
        b=JBXJWtz2rd24ohEUxQGzVriUMdMw2b3OGYNJ3/nBOacpEqvj+G5XaCFdWzKM2iKqBz
         F9/8iXLkaPdpEQ3uVbw0s6hRUSlE5+tyDeqqMG38SYBKI9o8oEi06QhRQihc45h5+Qjw
         1bjbvzTsfSwHXCr6T6+ILOqjJ1YiflwZrW76Y/yuYChb3p6QjLSnAJ4rrerJFHqqlfvK
         w3aypu9gy2y/aKHV/3P8uO6Qweoo0R6MOagSIERf7vWLtNm4m8an6pcLz5/XfkwIIMMV
         0mEnVy288KA9rqYbtsZiLgjxVIj6kPnOPqJK/F5SGpaONa4KfFKL+/t7wdWizVBm2KC8
         l55w==
X-Gm-Message-State: APjAAAU26Q9GSQV0AojUruoEhBW+IDsgWQFs6ZzV3hCsBUO+tF2XKAjc
        POyl0KivtpOyEZfYu3nOL7nMCs8N6NU=
X-Google-Smtp-Source: APXvYqyLrDdPeRkHSTWuBUw8qt7zMA/qtAhkniTa5e+us5BDvgpgb1Wzzr3qEHhOk8CqIDFJS5VVeg==
X-Received: by 2002:a65:684c:: with SMTP id q12mr48722697pgt.405.1564153964884;
        Fri, 26 Jul 2019 08:12:44 -0700 (PDT)
Received: from [192.168.1.188] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id i74sm99850043pje.16.2019.07.26.08.12.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jul 2019 08:12:43 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.3-rc2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Message-ID: <2b22063e-660c-a238-f109-fcf3f1b888b5@kernel.dk>
Date:   Fri, 26 Jul 2019 09:12:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

A set of fixes that should make it into this release. This pull request
contains:

- Several io_uring fixes/improvements:
	- Blocking fix for O_DIRECT (me)
	- Latter page slowness for registered buffers (me)
	- Fix poll hang under certain conditions (me)
	- Defer sequence check fix for wrapped rings (Zhengyuan)
	- Mismatch in async inc/dec accounting (Zhengyuan)
	- Memory ordering issue that could cause stall (Zhengyuan)
	- Track sequential defer in bytes, not pages (Zhengyuan)

- NVMe pull request from Christoph

- Set of hang fixes for wbt (Josef)

- Redundant error message kill for libahci (Ding)

- Remove unused blk_mq_sched_started_request() and related ops (Marcos)

- drbd dynamic alloc shash descriptor to reduce stack use (Arnd)

- blkcg ->pd_stat() non-debug print (Tejun)

- bcache memory leak fix (Wei)

- Comment fix (Akinobu)

- BFQ perf regression fix (Paolo)

Please pull!
 

  git://git.kernel.dk/linux-block.git tags/for-linus-20190726


----------------------------------------------------------------
Akinobu Mita (1):
      block: fix sysfs module parameters directory path in comment

Arnd Bergmann (1):
      drbd: dynamically allocate shash descriptor

Ding Xiang (1):
      ata: libahci_platform: remove redundant dev_err message

Jens Axboe (5):
      blk-mq: allow REQ_NOWAIT to return an error inline
      block: properly handle IOCB_NOWAIT for async O_DIRECT IO
      io_uring: don't use iov_iter_advance() for fixed buffers
      io_uring: ensure ->list is initialized for poll commands
      Merge branch 'nvme-5.3' of git://git.infradead.org/nvme into for-linus

Josef Bacik (5):
      wait: add wq_has_single_sleeper helper
      rq-qos: fix missed wake-ups in rq_qos_throttle
      rq-qos: don't reset has_sleepers on spurious wakeups
      rq-qos: set ourself TASK_UNINTERRUPTIBLE after we schedule
      rq-qos: use a mb for got_token

Logan Gunthorpe (1):
      nvme: fix memory leak caused by incorrect subsystem free

Marcos Paulo de Souza (1):
      block: blk-mq: Remove blk_mq_sched_started_request and started_request

Marta Rybczynska (1):
      nvme: fix multipath crash when ANA is deactivated

Misha Nasledov (1):
      nvme: ignore subnqn for ADATA SX6000LNP

Paolo Valente (1):
      block, bfq: check also in-flight I/O in dispatch plugging

Tejun Heo (1):
      blkcg: allow blkcg_policy->pd_stat() to print non-debug info too

Wei Yongjun (1):
      bcache: fix possible memory leak in bch_cached_dev_run()

Zhengyuan Liu (4):
      io_uring: fix the sequence comparison in io_sequence_defer
      io_uring: fix counter inc/dec mismatch in async_list
      io_uring: add a memory barrier before atomic_read
      io_uring: track io length in async_list based on bytes

yangerkun (1):
      Revert "nvme-pci: don't create a read hctx mapping without read queues"

 block/bfq-iosched.c                | 67 ++++++++++++++++++++-----------
 block/blk-cgroup.c                 |  9 ++---
 block/blk-iolatency.c              |  3 ++
 block/blk-mq-sched.h               |  9 -----
 block/blk-mq.c                     | 10 +++--
 block/blk-rq-qos.c                 |  7 +++-
 block/genhd.c                      |  2 +-
 drivers/ata/libahci_platform.c     |  1 -
 drivers/block/drbd/drbd_receiver.c | 14 ++++++-
 drivers/md/bcache/super.c          |  3 ++
 drivers/nvme/host/core.c           | 12 +++---
 drivers/nvme/host/multipath.c      |  8 +---
 drivers/nvme/host/nvme.h           |  6 ++-
 drivers/nvme/host/pci.c            |  6 +--
 fs/block_dev.c                     | 58 +++++++++++++++++++++++----
 fs/io_uring.c                      | 81 ++++++++++++++++++++++++++++++--------
 include/linux/blk-cgroup.h         |  1 +
 include/linux/blk_types.h          |  5 ++-
 include/linux/elevator.h           |  1 -
 include/linux/wait.h               | 13 ++++++
 20 files changed, 224 insertions(+), 92 deletions(-)

-- 
Jens Axboe

