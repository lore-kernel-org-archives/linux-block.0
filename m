Return-Path: <SRS0=pPwc=SA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D089AC43381
	for <linux-block@archiver.kernel.org>; Fri, 29 Mar 2019 16:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B2E521871
	for <linux-block@archiver.kernel.org>; Fri, 29 Mar 2019 16:09:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="mAX/Amp8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729736AbfC2QJi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Mar 2019 12:09:38 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:54380 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729383AbfC2QJi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Mar 2019 12:09:38 -0400
Received: by mail-it1-f195.google.com with SMTP id w18so4529707itj.4
        for <linux-block@vger.kernel.org>; Fri, 29 Mar 2019 09:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=ZrnzosejC9fSRRnJeaarEW+w5WSBNVATKL00Lc5owwY=;
        b=mAX/Amp8G4nwoLeU/i3stfaEyDHYt5F7sRrzxubQd7NcJmHV89wNXKR8zxY+LExVMq
         sO+6uhSsAS6OIYnQi/VqvVxAy/pR01OvhpXXT98d4LBnJe5/42rWNF9nrxvMfuHvMnER
         h1d0RG4usfPQPZ3GvzEjtuKV95xh+RrUQ77ubneqnQHiCw8km4eF1Bdg5iOYfxJCvebt
         0/yRu5MI77XBc80l/M/ArjSHILuW26aDGvSVIqTpsV0sfC7KiA+DlW5swjdI0RpP6YVa
         BfqhP29cG6otJxyTy4rGA2rJ4L0hVja0Nt3dk4pawXw5to4uIoJYL+1GV+Y+/cQsOVmg
         Sy3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=ZrnzosejC9fSRRnJeaarEW+w5WSBNVATKL00Lc5owwY=;
        b=p0no2bBFUVIz5ERNl30+BqznaCI3o19vU44SVTkWUm+OYNym+cixgDhnuFZrYSLmRh
         jdBouAkA0PGzP+jaT/Dd9LJtUGk4+0WAODDZkSvgYLl4NPcuXpSD4/pdMUd7h6VeBp+9
         4mgVixmQxwGhXTaxtV1QayRsbT9Zv/q6Qz49LeDGV7a/xBk9kob9hcU7NpGc3iJNeHW9
         SQKZkR1kM/PtOnIJQCgSr9UUYZd3tJ1SPlZ8sWORo/EaqIv9fvGkF56hJdQgh2gSUz+7
         Qa7GN2Q3nduRl5z/E9im7jlFA18i8peCMGqofyD0mvbAYB6x4gIdsRuT2488p6Jq895K
         zRKA==
X-Gm-Message-State: APjAAAXXguGq/lQBRSTAojy6SXJCVejcxEZSx+6m6fsXqwbSSp9Mlv22
        rsMxRL58ExJERhdO+FVl1ASKc1gBq4njpQ==
X-Google-Smtp-Source: APXvYqwlKYof6vnPeCmHlNWGmnqEDbG+v1V+a/QsZ9XdRSwrTuT8SMQFSi9wO/sc0p3wSxCBZzb01w==
X-Received: by 2002:a05:660c:111:: with SMTP id w17mr4841539itj.62.1553875776696;
        Fri, 29 Mar 2019 09:09:36 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id f197sm1288635itf.5.2019.03.29.09.09.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 09:09:35 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.1-rc3
Message-ID: <16a4b76d-7a6c-f4b4-7e6a-21f51e4ca527@kernel.dk>
Date:   Fri, 29 Mar 2019 10:09:34 -0600
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

Small set of fixes that should go into this series. This pull request
contains:

- Compat signal mask fix for io_uring (Arnd)
- EAGAIN corner case for direct vs buffered writes for io_uring (Roman)
- NVMe pull request from Christoph with various little fixes
- sbitmap ws_active fix, which caused a perf regression for shared tags
  (me)
- sbitmap bit ordering fix (Ming)
- libata on-stack DMA fix (Raymond)

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-linus-20190329


----------------------------------------------------------------
Arnd Bergmann (1):
      io_uring: fix big-endian compat signal mask handling

Christoph Hellwig (1):
      nvme-tcp: fix an endianess miss-annotation

Jens Axboe (2):
      blk-mq: fix sbitmap ws_active for shared tags
      Merge branch 'nvme-5.1' of git://git.infradead.org/nvme into for-linus

Martin George (1):
      nvme-multipath: relax ANA state check

Max Gurtovoy (1):
      nvmet: fix error flow during ns enable

Ming Lei (2):
      sbitmap: order READ/WRITE freed instance and setting clear bit
      nvmet: fix building bvec from sg list

Roman Penyaev (1):
      io_uring: offload write to async worker in case of -EAGAIN

Yufen Yu (2):
      blk-mq: use blk_mq_put_driver_tag() to put tag
      blk-mq: update comment for blk_mq_hctx_has_pending()

raymond pang (1):
      libata: fix using DMA buffers on stack

 block/blk-flush.c                 |  4 ++--
 block/blk-mq.c                    | 16 +++++++++++++---
 block/blk-mq.h                    |  9 ---------
 drivers/ata/libata-zpodd.c        | 34 ++++++++++++++++++++++++----------
 drivers/nvme/host/multipath.c     |  5 +----
 drivers/nvme/host/tcp.c           |  2 +-
 drivers/nvme/target/core.c        |  4 ++--
 drivers/nvme/target/io-cmd-file.c | 20 ++++++++++----------
 fs/io_uring.c                     | 26 ++++++++++++++++++++++++--
 lib/sbitmap.c                     | 11 +++++++++++
 10 files changed, 88 insertions(+), 43 deletions(-)

-- 
Jens Axboe

