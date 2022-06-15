Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A95C43334
	for <linux-block@archiver.kernel.org>; Wed, 15 Jun 2022 22:55:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348279AbiFOWz5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Jun 2022 18:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347441AbiFOWz5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Jun 2022 18:55:57 -0400
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0110E93
        for <linux-block@vger.kernel.org>; Wed, 15 Jun 2022 15:55:55 -0700 (PDT)
Received: by mail-pf1-f179.google.com with SMTP id e11so12726672pfj.5
        for <linux-block@vger.kernel.org>; Wed, 15 Jun 2022 15:55:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VwJU1ZgXBRhwkI8lYAX1KXv2IIbGa4mY0lxN3lqWlOI=;
        b=wzby969HLQW7rbiqCv7SrL5vzLO9kVBTwTLVwo3dltL41Wz2SenMH7uq8dy9Fi9jyz
         JtZhadxiqpRFSqcNpcJeB6ZAwafQq91jD2uJu+SOgHefK71u8gQsdSSPWJZSG8wX6LZe
         bsgLFwhSCSv8bx9c/XzH+Sedc5A1F+cuMLoedBEslL1cG3A/6FUaBXCD4wTZretOb/0s
         tD1x3QHgfB9P5NX8b2Bsemp+V9Wzku0Tof2kLa6hFOSyLLMbMMxX7P9HWLRZ3ss8eWfS
         KERXH/3BoF4w+4lMMheWQY5bCievfC0xmVea+BN+BkYlVZuuVW/c24DCK9ID4pXG14co
         L4zw==
X-Gm-Message-State: AJIora/iYXxfA1a8XfWMs0bBbhTeqiNni6FZpx4xlomG3EQcjq83i5OF
        CcxDxSISjRML22AF/wm5Y9ACkUlbhRs=
X-Google-Smtp-Source: AGRyM1vOS92sFgT+LeynmYrTVf7DDQSckqoC1EcwYOxF9HxIkX+BKxdIjfDE/nmdkj9LpVuqDuMzjA==
X-Received: by 2002:a63:b60a:0:b0:408:d61b:77ac with SMTP id j10-20020a63b60a000000b00408d61b77acmr1841982pgf.432.1655333754936;
        Wed, 15 Jun 2022 15:55:54 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:36ac:cabd:84b2:80f6])
        by smtp.gmail.com with ESMTPSA id f62-20020a17090a704400b001eae95c381fsm158611pjk.10.2022.06.15.15.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 15:55:53 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v3 0/3] Three small block layer patches
Date:   Wed, 15 Jun 2022 15:55:46 -0700
Message-Id: <20220615225549.1054905-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

These three patches are what I came up with while reading block layer code in
preparation of the patch series for improving zoned write performance.

Please consider this patch series for kernel v5.20.

Thanks,

Bart.

Changes between v2 and v3:
- Explained the "why" of patch 3/3 in its commit message as requested by Jens.

Changes between v1 and v2:
- Modified patch 3/3 as suggested by Ming Lei.

Bart Van Assche (3):
  blk-iocost: Simplify ioc_rqos_done()
  block: Rename a blk_mq_map_queue() argument
  block: Make blk_mq_get_sq_hctx() select the proper hardware queue type

 block/blk-iocost.c |  2 +-
 block/blk-mq.c     |  2 +-
 block/blk-mq.h     | 12 ++++++------
 3 files changed, 8 insertions(+), 8 deletions(-)

