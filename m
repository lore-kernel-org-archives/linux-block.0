Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE20C433EF
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 14:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A104C610D0
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 14:04:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbhJNOGX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Oct 2021 10:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbhJNOGW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Oct 2021 10:06:22 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC669C061570;
        Thu, 14 Oct 2021 07:04:17 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id t2so19875824wrb.8;
        Thu, 14 Oct 2021 07:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TAvj72ssH3qXxf9L5Wa/RK1md3eRNO3vwTLM1pn35pE=;
        b=SSoaq5s8cjVoFC5qeOAUw8UEqSp6iU2fHaQqbkg6pgVeo85DDHtBZ86WIPo6b+JCQv
         jI/QkHjLJZdnY7xL5wMLHzFRLcSWaDE7zmcpZSBjV+vArCKPZdz4sLdFBr2vRQroSvKN
         IwpjFCeUDOijQ9klB7KrV1YywhMrCVh97p5Wh+bAy01m8WF6F/Dd52vnl8CZSgNKMxOm
         QF7IUVpZIAc+dJJbKc8lmGwdw8La0HvhQc3Af/QLcm2a/0lbPdO9QT5CGHk5pMopdm8U
         WVBIPPCxaAWnbyibsSQUKoDHEqorn0NtIvuFjb3Gn59qhN0969c3/9fHgE53/uW+Jgd5
         CY6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TAvj72ssH3qXxf9L5Wa/RK1md3eRNO3vwTLM1pn35pE=;
        b=2nOPcLIuyHuKn4svBsWQ531L/lrIW8EMKcsJeLvsBYQcn9SU4gxolAHxgyDp51ydEg
         2A/t0O8tKirrw+plsAoKlADRmAG+uDO16ya5c6liOsmyAp0eYwD+Pj2rCy73tmQpvbjn
         gqymruGg4yzx+OGnXN1CRgI/wkru/v9dk1F7f7+4R1FfpCP/yJx2a0bnz/c6dOf1rb6o
         JLcGvo7bNvjVX71pHU0mxqUBqOWLVThBnoooy6mJiyn6r6tKrS5l1ZXyTSX3queNtjyI
         iuRbCkUZRoHq/+oH2hgOLQ7OPZwbxus7lRv6AdD9505KjOBQNL8jqhlCrDdlUQxOUeub
         KzsA==
X-Gm-Message-State: AOAM531ykpT7RPNkprgSLlN2pqesEccRg705xGFJfuo5A4qE7ZZSRf2H
        +dYnSEVBHCb00bgMIDhp60Q=
X-Google-Smtp-Source: ABdhPJx68bIUdjpdx7E+uRfIhB/CK9n1gbNxslort4U69IiL30mAmnI+hodkBleh7Tx6k0QrsoGa5Q==
X-Received: by 2002:adf:ab43:: with SMTP id r3mr7041228wrc.225.1634220256431;
        Thu, 14 Oct 2021 07:04:16 -0700 (PDT)
Received: from localhost.localdomain ([185.69.145.214])
        by smtp.gmail.com with ESMTPSA id p8sm2273461wmg.15.2021.10.14.07.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 07:04:16 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Christoph Hellwig <hch@infradead.org>, asml.silence@gmail.com
Subject: [PATCH 0/5] cache request_queue pointer
Date:   Thu, 14 Oct 2021 15:03:25 +0100
Message-Id: <cover.1634219547.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Cache request_queue in bdev and replace two derefs in
bdev->bd_disk->queue with bdev->bd_queue. Benchmarking
with nullblk gave me around +1% to peak perf.

All patches are self contained and don't rely on others from
the set including 1/5 and can be taken separately. And some
changes go in separate patches to minimise conflicts. When
we agree on the approach, I'll send the rest converting some
other spots out of block.

note: based on for-5.16/block-io_uring

Pavel Begunkov (5):
  block: cache request queue in bdev
  block: use bdev_get_queue() in bdev.c
  block: use bdev_get_queue() in bio.c
  block: use bdev_get_queue() in blk-core.c
  block: convert the rest of block to bdev_get_queue

 block/bdev.c              |  9 +++++----
 block/bio-integrity.c     |  2 +-
 block/bio.c               | 10 +++++-----
 block/blk-cgroup.c        | 16 ++++++++--------
 block/blk-core.c          | 10 +++++-----
 block/blk-crypto.c        |  2 +-
 block/blk-iocost.c        | 12 ++++++------
 block/blk-merge.c         |  2 +-
 block/blk-mq.c            |  2 +-
 block/blk-throttle.c      |  2 +-
 block/genhd.c             |  8 +++++---
 block/partitions/core.c   |  4 ++--
 include/linux/blk_types.h |  1 +
 include/linux/blkdev.h    |  2 +-
 14 files changed, 43 insertions(+), 39 deletions(-)

-- 
2.33.0

