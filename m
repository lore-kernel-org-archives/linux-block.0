Return-Path: <SRS0=t3nT=CY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6046EC43461
	for <linux-block@archiver.kernel.org>; Tue, 15 Sep 2020 18:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15F78206E6
	for <linux-block@archiver.kernel.org>; Tue, 15 Sep 2020 18:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SK7DSLbW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbgIOSts (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Sep 2020 14:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727833AbgIORZO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Sep 2020 13:25:14 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94DD2C06174A
        for <linux-block@vger.kernel.org>; Tue, 15 Sep 2020 10:23:59 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id z2so3745325qtv.12
        for <linux-block@vger.kernel.org>; Tue, 15 Sep 2020 10:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=2hqoRFYX4/RLa6tKmbcUnG/L6B7zQSKyUsPW11aTc3A=;
        b=SK7DSLbWANHGcpF7n6P7domaDQaWsd2y/XihDFOlfxaJnz6x3JmAqQivxK+d17hzY/
         1p5nQ6WZY/cVRvN1CIh4DlmzobA/xwK8eylVTk4my39zSTH3wQwMPTsCd+Hwnx2BEi9u
         glYqbhEsDLARAkmy1BkT9TMqOkb0bFOW+KCGwrn1OgRwp4sn0v7FsGTbm0KWYGgn+8ri
         6oT5nPvgyJot3zYUgQy64YlLLHA0RTQ8DhGxa+9c9Qc+S7DkG3c2CpR/l6aizUpEwD+h
         5O+mUEO5LmY3vOvNbvkHKsjIa3UMTikODX95eIsB7Wza1mSOYGDXkeKWvNpLRo7hcS1v
         3rMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=2hqoRFYX4/RLa6tKmbcUnG/L6B7zQSKyUsPW11aTc3A=;
        b=RLQUThUO+EmxPs/1FMvGgCw1PgZqg+ZwVmCYXzAS/9/DUDQE7mvbE+NyCdVbRxudme
         Caz0BqpP33y0NPi5e331j0S4UXeDEAoa1HIjg4h61uugJU9v+BdTWQcePdSgyiraiUKg
         m5xkTSqVDTAroY3u8y/6G+t1FaJLPXTqqq1IivqEZnH0jpdjmZAhoGdIG3CWuS8y55V1
         1eoCljAWTRD7S2Xhbf/ZuZr/axo3gHDEJXH3vp0r98m58DiaSQvPhCfkn0CRfc3hFF9I
         iKzGzYwggyuonoVVBq6WaHwGr31/NP11w02DA1WgcPCuHv+mRtt0F4VxU5wqCVdcPkr0
         z+kw==
X-Gm-Message-State: AOAM532ZOd1OdVEJjljQqkivumsd9vxJQr2iIe7TNnDMjKI+NCkR0Wbn
        c1he4gKzrbAfK/JM1Es5F0o=
X-Google-Smtp-Source: ABdhPJzZDP79Xa1eA9O3rLpFxo16n8Rt8qBfBiXWHYs06WJdGl0dSfSX70HgwPO0HKeXuPrEQLG+4A==
X-Received: by 2002:ac8:424a:: with SMTP id r10mr18525300qtm.211.1600190638803;
        Tue, 15 Sep 2020 10:23:58 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id n11sm17088902qkk.105.2020.09.15.10.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 10:23:57 -0700 (PDT)
From:   Mike Snitzer <snitzer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Ming Lei <ming.lei@redhat.com>,
        Vijayendra Suman <vijayendra.suman@oracle.com>,
        dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: [PATCH v2 0/4] block: a couple chunk_sectors fixes/improvements
Date:   Tue, 15 Sep 2020 13:23:53 -0400
Message-Id: <20200915172357.83215-1-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

This v2 drops a patch from v1 and fixes the chunk_sectprs check added to
blk_stack_limits to convert chubk_sectors to bytes before comparing with
physical_block_size.

Jens, please feel free to pick up patches 1 and 2.

DM patches 3 and 4 are provided just to give context for how DM will be
updated to use chunk_sectors.

Mike Snitzer (4):
  block: use lcm_not_zero() when stacking chunk_sectors
  block: allow 'chunk_sectors' to be non-power-of-2
  dm table: stack 'chunk_sectors' limit to account for target-specific splitting
  dm: unconditionally call blk_queue_split() in dm_process_bio()

 block/blk-settings.c   | 22 ++++++++++++----------
 drivers/md/dm-table.c  |  5 +++++
 drivers/md/dm.c        | 45 +--------------------------------------------
 include/linux/blkdev.h | 12 +++++++++---
 4 files changed, 27 insertions(+), 57 deletions(-)

-- 
2.15.0

