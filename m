Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7DABC0015E
	for <linux-block@archiver.kernel.org>; Wed, 26 Jul 2023 19:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjGZTfD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Jul 2023 15:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbjGZTfC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jul 2023 15:35:02 -0400
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6CF1BD9
        for <linux-block@vger.kernel.org>; Wed, 26 Jul 2023 12:35:02 -0700 (PDT)
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-686b91c2744so193623b3a.0
        for <linux-block@vger.kernel.org>; Wed, 26 Jul 2023 12:35:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690400101; x=1691004901;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oAt48CKtJAMWLwz8enPrXAe6gtv4jmHqeRc2LSUhY+E=;
        b=QSg5wvIoyiifRUQdWRdB6bQJgff15oG7VENOKNiW6vtQnXcZMX811xvfwEvO8syAnR
         yRzm6scEJQKr4xUgS0eYvW2iwVahb+DJ7zcPWk5Qc1wA6dxaa4aFjxcPAaL8Atiaq3rp
         OdPYqwXROpBSW6TCtDNBraj1CIJX+UY6FT+LEHYmkxvooKmY/Ek5vL0h75rnJgycRYjb
         jVdAh6x7+TbSx7MY7hJkqsfmQioHgRYxtbL788O+JaDi6VQaksj+TDLRCaol8IEwAq0S
         8M+wdGgDK91EGPQHY9MaiXvmYWFVODRVcG6IqpCpzKK+MGmBX4SZX7A0DxtjC6cBEXnm
         UKPQ==
X-Gm-Message-State: ABy/qLbQ91L5Xk134LRTHjlCyXoN5EL7O97sBCdO/PGt1XWDuoek8AHL
        BbzK8YHOABEQycUSeKgzLe0=
X-Google-Smtp-Source: APBJJlHQ9JL4LFyx+6zMvqGXfAHWZvV0m916Teob3vJlyWoPEHYKI83AQTAVZhOd1Lyj3OWL17/XOg==
X-Received: by 2002:a05:6a00:1a4f:b0:682:d2af:218 with SMTP id h15-20020a056a001a4f00b00682d2af0218mr2898156pfv.24.1690400101406;
        Wed, 26 Jul 2023 12:35:01 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:32d2:d535:b137:7ba3])
        by smtp.gmail.com with ESMTPSA id x52-20020a056a000bf400b00682ba300cd1sm11846685pfu.29.2023.07.26.12.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 12:35:00 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v4 0/7] Improve the performance of F2FS on zoned UFS
Date:   Wed, 26 Jul 2023 12:34:04 -0700
Message-ID: <20230726193440.1655149-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

This patch series improves small write IOPS by a factor of four (+300%) for
zoned UFS devices on my test setup with a UFSHCI 3.0 controller. Please
consider this patch series for the next merge window.

Thank you,

Bart.

Changes compared to v3:
 - Restored the patch that introduces QUEUE_FLAG_NO_ZONE_WRITE_LOCK. That patch
   had accidentally been left out from v2.
 - In patch "block: Introduce the flag REQ_NO_ZONE_WRITE_LOCK", improved the
   patch description and added the function blk_no_zone_write_lock().
 - In patch "block/mq-deadline: Only use zone locking if necessary", moved the
   blk_queue_is_zoned() call into dd_use_write_locking().
 - In patch "fs/f2fs: Disable zone write locking", set REQ_NO_ZONE_WRITE_LOCK
   from inside __bio_alloc() instead of in f2fs_submit_write_bio().

Changes compared to v2:
 - Renamed the request queue flag for disabling zone write locking.
 - Introduced a new request flag for disabling zone write locking.
 - Modified the mq-deadline scheduler such that zone write locking is only
   disabled if both flags are set.
 - Added an F2FS patch that sets the request flag for disabling zone write
   locking.
 - Only disable zone write locking in the UFS driver if auto-hibernation is
   disabled.

Changes compared to v1:
 - Left out the patches that are already upstream.
 - Switched the approach in patch "scsi: Retry unaligned zoned writes" from
   retrying immediately to sending unaligned write commands to the SCSI error
   handler.


Bart Van Assche (7):
  block: Introduce the flag QUEUE_FLAG_NO_ZONE_WRITE_LOCK
  block: Introduce the flag REQ_NO_ZONE_WRITE_LOCK
  block/mq-deadline: Only use zone locking if necessary
  block/null_blk: Support disabling zone write locking
  scsi: Retry unaligned zoned writes
  scsi: ufs: Disable zone write locking
  fs/f2fs: Disable zone write locking

 block/blk-flush.c                 |  3 ++-
 block/mq-deadline.c               | 25 ++++++++++++-----
 drivers/block/null_blk/main.c     |  2 ++
 drivers/block/null_blk/null_blk.h |  1 +
 drivers/block/null_blk/zoned.c    |  3 +++
 drivers/scsi/scsi_error.c         | 38 ++++++++++++++++++++++++++
 drivers/scsi/scsi_lib.c           |  1 +
 drivers/scsi/sd.c                 |  2 ++
 drivers/ufs/core/ufshcd.c         | 45 ++++++++++++++++++++++++++++---
 fs/f2fs/data.c                    |  4 +--
 include/linux/blk-mq.h            | 11 ++++++++
 include/linux/blk_types.h         |  8 ++++++
 include/linux/blkdev.h            | 10 +++++++
 include/scsi/scsi.h               |  1 +
 14 files changed, 142 insertions(+), 12 deletions(-)

