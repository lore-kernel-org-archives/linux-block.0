Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B2CC7EE2A
	for <linux-block@archiver.kernel.org>; Mon, 22 May 2023 22:26:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234725AbjEVW0L (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 May 2023 18:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234621AbjEVW0H (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 May 2023 18:26:07 -0400
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9315211F
        for <linux-block@vger.kernel.org>; Mon, 22 May 2023 15:26:00 -0700 (PDT)
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-25374c9be49so4095983a91.3
        for <linux-block@vger.kernel.org>; Mon, 22 May 2023 15:26:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684794360; x=1687386360;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DT/NKoStDLzfFNa7S+rTJHi0NRS3M4LeLCggKGvssl8=;
        b=Ff8z9kpLnFRamMyhKyQ6RJs8P3nL5gAYMz2Jt37kotjN6DX+8eXil721eDLgk69ggZ
         ARTcpU9se/r+GSczfMHdSTnnk1d0OFM2/nsQ/GffI+BiSUCzWvLTxtBeXG7I/5k8EwV9
         iw181nN0DwowEifGe5jXRte6pJC5ZlHmr0gYU9LY6e0iklmqmK7jLZwbugoiQHnn4MQN
         D1fZ9x7Xf3XwxsOoUEfyqnGcOKH/x15SKhKno16Q61VtPLQq3TX+QDfQIeXuU2vsQT/L
         wxs+yp56acrjH3zNRrZ0PSsJYBexVckg/aLtIgKU/+nVL0qNTAGpIyzAWUFyiakbrpo7
         S5Bg==
X-Gm-Message-State: AC+VfDxLxrDRQ3PghdD/0y5XzDHREisUtMTuOPmJAvIPnOqkJeQlIRWc
        P0CRi8O+KSGfifB6N7j337M=
X-Google-Smtp-Source: ACHHUZ5w+qbHnnJ387Y11YQfXgSIC2wl7nc5QhMvZWoe6LJUYniPFOGFB91YgxI/msjvFBhhKC8RnA==
X-Received: by 2002:a17:90a:a611:b0:253:2dc5:4e12 with SMTP id c17-20020a17090aa61100b002532dc54e12mr11088890pjq.46.1684794359862;
        Mon, 22 May 2023 15:25:59 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:642f:e57f:85fb:3794])
        by smtp.gmail.com with ESMTPSA id y8-20020a634b08000000b00520f4ecd71esm4725364pga.93.2023.05.22.15.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 15:25:59 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        jyescas@google.com, mcgrof@kernel.org,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v5 0/9] Support limits below the page size
Date:   Mon, 22 May 2023 15:25:32 -0700
Message-ID: <20230522222554.525229-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

We want to improve Android performance by increasing the page size from 4 KiB
to 16 KiB. However, some of the storage controllers we care about do not support
DMA segments larger than 4 KiB. Hence the need support for DMA segments that are
smaller than the size of one virtual memory page. This patch series implements
that support. Please consider this patch series for the next merge window.

Thanks,

Bart.

Changes compared to v4:
- Fixed the debugfs patch such that the behavior for creating the block
  debugfs directory is retained.
- Made the description of patch "Support configuring limits below the page
  size" more detailed. Split that patch into two patches.
- Added patch "Use pr_info() instead of printk(KERN_INFO ...)".

Changes compared to v3:
- Removed CONFIG_BLK_SUB_PAGE_SEGMENTS and QUEUE_FLAG_SUB_PAGE_SEGMENTS.
  Replaced these by a new member in struct queue_limits and a static branch.
- The static branch that controls whether or not sub-page limits are enabled
  is set by the block layer core instead of by block drivers.
- Dropped the patches that are no longer needed (SCSI core and UFS Exynos
  driver).

Changes compared to v2:
- For SCSI drivers, only set flag QUEUE_FLAG_SUB_PAGE_SEGMENTS if necessary.
- In the scsi_debug patch, sorted kernel module parameters alphabetically.
  Only set flag QUEUE_FLAG_SUB_PAGE_SEGMENTS if necessary.
- Added a patch for the UFS Exynos driver that enables
  CONFIG_BLK_SUB_PAGE_SEGMENTS if the page size exceeds 4 KiB.

Changes compared to v1:
- Added a CONFIG variable that controls whether or not small segment support
  is enabled.
- Improved patch descriptions.

Bart Van Assche (9):
  block: Use pr_info() instead of printk(KERN_INFO ...)
  block: Prepare for supporting sub-page limits
  block: Support configuring limits below the page size
  block: Make sub_page_limit_queues available in debugfs
  block: Support submitting passthrough requests with small segments
  block: Add support for filesystem requests and small segments
  block: Add support for small segments in blk_rq_map_user_iov()
  scsi_debug: Support configuring the maximum segment size
  null_blk: Support configuring the maximum segment size

 block/blk-core.c                  |  4 ++
 block/blk-map.c                   | 29 +++++++---
 block/blk-merge.c                 |  8 ++-
 block/blk-mq-debugfs.c            |  9 ++++
 block/blk-mq-debugfs.h            |  6 +++
 block/blk-mq.c                    |  2 +
 block/blk-settings.c              | 88 ++++++++++++++++++++++++++-----
 block/blk.h                       | 39 +++++++++++---
 drivers/block/null_blk/main.c     | 19 +++++--
 drivers/block/null_blk/null_blk.h |  1 +
 drivers/scsi/scsi_debug.c         |  4 ++
 include/linux/blkdev.h            |  2 +
 12 files changed, 182 insertions(+), 29 deletions(-)

