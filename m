Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ABC2C0015E
	for <linux-block@archiver.kernel.org>; Mon, 10 Jul 2023 18:02:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjGJSCX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Jul 2023 14:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233056AbjGJSCX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Jul 2023 14:02:23 -0400
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28804AB
        for <linux-block@vger.kernel.org>; Mon, 10 Jul 2023 11:02:22 -0700 (PDT)
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-262d33fa37cso2333505a91.3
        for <linux-block@vger.kernel.org>; Mon, 10 Jul 2023 11:02:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689012141; x=1691604141;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ecX+K8mh3siE1w8inFF8ptq+PUJOOnHFXWSsdf/aS2s=;
        b=BVQSHUxvhU7uGpg+de6SXn71H7puFMjPf4Y+o4gvI4E/sdN7HZtPEmLCsXu2BKi0xZ
         0YjdGv4bZXKvn7JBKsNBMZ6BP+ZUJAbLmu2lRhp7tjYK4pxYbz4bbjge/2zeQj+mGR2p
         ZXKNTzXquCuDAHXrAvWR2RoAWXDmcZ5UruXBWAuy9YSNXhSpz0C37/SS+MKaKoshPrXS
         qlLvchwRofmXQu6UeNzjPlbY1oSHrKTidSPo+G7NLue6S3yUbBATE+mDCPGmvQRom4o4
         I85LMkdSF0hcV7UyQHbWbMrrO36FcXGKRv97PFnAven/EW5BVvLBsINeiJ3TTfkAbXWp
         pktw==
X-Gm-Message-State: ABy/qLanjTV4OipcqQJ0mrvX94oifnoybVUbTQh3rNimypisGifeN8Kd
        JCt6vwoQNyJchC+pxWTx0sE=
X-Google-Smtp-Source: APBJJlHKRmSxa14jvm5AZCTHlO57by8bKMHmJNMNCkwc/Di3XfwxSxAgZccGdO6D7BbsN13orKmBVw==
X-Received: by 2002:a17:90a:c85:b0:263:9e9b:5586 with SMTP id v5-20020a17090a0c8500b002639e9b5586mr10759406pja.44.1689012141313;
        Mon, 10 Jul 2023 11:02:21 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:e582:53b1:a691:ab70])
        by smtp.gmail.com with ESMTPSA id gt4-20020a17090af2c400b00263f446d432sm6531846pjb.43.2023.07.10.11.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 11:02:20 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v2 0/5] Enable zoned write pipelining for UFS devices
Date:   Mon, 10 Jul 2023 11:01:37 -0700
Message-ID: <20230710180210.1582299-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

This patch series improves write performance for zoned UFS devices. Please
consider these patches for the next merge window.

Thank you,

Bart.

Changes compared to v1:
 - Left out the patches that are already upstream.
 - Switched the approach in patch "scsi: Retry unaligned zoned writes" from
   retrying immediately to sending unaligned write commands to the SCSI error
   handler.

Bart Van Assche (5):
  block: Introduce a request queue flag for pipelining zoned writes
  block/mq-deadline: Only use zone locking if necessary
  block/null_blk: Add support for pipelining zoned writes
  scsi: Retry unaligned zoned writes
  scsi: ufs: Enable zoned write pipelining

 block/blk-zoned.c                 |  3 ++-
 block/mq-deadline.c               | 14 +++++++-----
 drivers/block/null_blk/main.c     |  2 ++
 drivers/block/null_blk/null_blk.h |  1 +
 drivers/block/null_blk/zoned.c    |  3 +++
 drivers/scsi/scsi_error.c         | 37 +++++++++++++++++++++++++++++++
 drivers/scsi/scsi_lib.c           |  1 +
 drivers/scsi/sd.c                 |  3 +++
 drivers/ufs/core/ufshcd.c         |  1 +
 include/linux/blkdev.h            |  7 ++++++
 include/scsi/scsi.h               |  1 +
 11 files changed, 67 insertions(+), 6 deletions(-)

