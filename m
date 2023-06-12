Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 425E9C7EE2E
	for <linux-block@archiver.kernel.org>; Mon, 12 Jun 2023 20:33:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236013AbjFLUdW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Jun 2023 16:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjFLUdW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Jun 2023 16:33:22 -0400
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BDEAE57
        for <linux-block@vger.kernel.org>; Mon, 12 Jun 2023 13:33:20 -0700 (PDT)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1b3ce6607cbso13131875ad.2
        for <linux-block@vger.kernel.org>; Mon, 12 Jun 2023 13:33:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686601999; x=1689193999;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6gwlNlSludwmmwPw7ux9zT2qNHcHNp42Vd8OqQlYgis=;
        b=g5+EcNibTG1BSUQyOnjOySD77nVsrHB6m/pEsTX9pTNwR/MA1kJnZoyJMTvY6YB4Go
         nf+vS2bq+obRWxceEHke6w/Zw8iYiQR8pPgBZPw6XzhGjjvddCN6f6MbSr5+cr/sD71B
         1hpnq1nLdp/fowxgBQl7byrTjpLnBuAUUAhevAnR5/RbdqjBLUQg8u6SzXdxTWZsxtjC
         iTrs8NiX5ZAR+la6AXYUqli9VzHIxQI0FA70tyw92J3WJIac8qc8yq07usOPLVT9Dfi2
         uVwxFHV0FxKzD1UW2FjPJai/QsHGD3pycVbgSdl0XNPhx88VgH430sqa0UTf79vFUFnR
         vX4g==
X-Gm-Message-State: AC+VfDxykdxd8m6Yt72dqTqa0P4kUoAkxBM3y2/ONbHJZFPDTl2x0ON5
        cdrOR9u1R2k5Ux042dDaH0U=
X-Google-Smtp-Source: ACHHUZ6H1OEPsiihuOoVGPymTNx+7jS/YLnJw5kqYWlFWCsTbRuFzfihu+DU19lgxjcork1HdGPL4A==
X-Received: by 2002:a17:903:18e:b0:1b0:295b:f192 with SMTP id z14-20020a170903018e00b001b0295bf192mr7956443plg.3.1686601999282;
        Mon, 12 Jun 2023 13:33:19 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id ji1-20020a170903324100b001b016313b1dsm3324767plb.86.2023.06.12.13.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 13:33:18 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Sandeep Dhavale <dhavale@google.com>,
        Juan Yescas <jyescas@google.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v6 0/8] Support limits below the page size
Date:   Mon, 12 Jun 2023 13:33:06 -0700
Message-Id: <20230612203314.17820-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.1
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

Changes compared to v5:
- Rebased the entire series on top of the block layer for-next branch.
- Dropped patch "block: Add support for small segments in blk_rq_map_user_iov()"
  because that patch prepares for a patch that has already been dropped.
- Modified a source code comment in patch 3/9 such that it fits in 80 columns.

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

Bart Van Assche (8):
  block: Use pr_info() instead of printk(KERN_INFO ...)
  block: Prepare for supporting sub-page limits
  block: Support configuring limits below the page size
  block: Make sub_page_limit_queues available in debugfs
  block: Support submitting passthrough requests with small segments
  block: Add support for filesystem requests and small segments
  scsi_debug: Support configuring the maximum segment size
  null_blk: Support configuring the maximum segment size

 block/blk-core.c                  |  4 ++
 block/blk-map.c                   |  2 +-
 block/blk-merge.c                 |  8 ++-
 block/blk-mq-debugfs.c            |  9 +++
 block/blk-mq-debugfs.h            |  6 ++
 block/blk-mq.c                    |  2 +
 block/blk-settings.c              | 91 +++++++++++++++++++++++++++----
 block/blk.h                       | 39 +++++++++++--
 drivers/block/null_blk/main.c     | 19 ++++++-
 drivers/block/null_blk/null_blk.h |  1 +
 drivers/scsi/scsi_debug.c         |  4 ++
 include/linux/blkdev.h            |  2 +
 12 files changed, 163 insertions(+), 24 deletions(-)

