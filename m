Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A78B2C7EE2A
	for <linux-block@archiver.kernel.org>; Mon, 22 May 2023 18:39:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233828AbjEVSjT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 May 2023 14:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233768AbjEVSjQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 May 2023 14:39:16 -0400
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8611019D
        for <linux-block@vger.kernel.org>; Mon, 22 May 2023 11:39:09 -0700 (PDT)
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2533d3acd5fso5629843a91.2
        for <linux-block@vger.kernel.org>; Mon, 22 May 2023 11:39:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684780748; x=1687372748;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PTVnj5zWRWZVfu5x9PGHIbSFZYkTc9UwdSYgVePDmfQ=;
        b=ckJgWZy5OytN0BKQzfYrkcJo0MfT9Yml7AG3ISDNDFeIr9MrqCigJW5DZTEOGgdXZN
         TK0DkuNhapAIlIg+PKEkHQXLWT8D/XOgHTBBnetGrwBVJId9KEoc/KFgBYy96XprU5vW
         WM+oxP/0FDUma7QuMFDGFfZ0739czdk+Y68m+cfbdtUPwantbK4FRjfJFKBJISq5NSNk
         qVA/9p+YJYnp1NYLxqcnxC0JdioRoP9v5jlKpdHVCzL2a+z5ad1ZZmfNkMp8hdtMc4J1
         by7fmrcABvZ7IUnK/nKbE7PrzZl5VD2/vSk7V+h3l2zxnO0WTILsAxxRaGM1XjGlWlu/
         8Dbw==
X-Gm-Message-State: AC+VfDxcITp5FT6MncsySO8Y3PQYbpoxPwF0FmqaoSpDYnBgnXY9p965
        wWf71Tu7CLlONDxznNy1Ivul5PIVNOQ=
X-Google-Smtp-Source: ACHHUZ5f49hChiRTV8oGjS+G43xEOTheupmR345wuyS0DNHFPr+hbjCWnHkhU5yiT3DRKZb3t/ErDQ==
X-Received: by 2002:a17:90b:d81:b0:249:6098:b068 with SMTP id bg1-20020a17090b0d8100b002496098b068mr11146772pjb.45.1684780748339;
        Mon, 22 May 2023 11:39:08 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:642f:e57f:85fb:3794])
        by smtp.gmail.com with ESMTPSA id d61-20020a17090a6f4300b0024dfbac9e2fsm6710335pjk.21.2023.05.22.11.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 11:39:07 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Mike Snitzer <snitzer@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v3 0/7] Submit zoned writes in order
Date:   Mon, 22 May 2023 11:38:35 -0700
Message-ID: <20230522183845.354920-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

Tests with a zoned UFS prototype have shown that there are plenty of
opportunities for reordering in the block layer for zoned writes (REQ_OP_WRITE).
The UFS driver is more likely to trigger reordering than other SCSI drivers
because it reports BLK_STS_DEV_RESOURCE more often, e.g. during clock scaling.
This patch series makes sure that zoned writes are submitted in order without
affecting other workloads significantly.

Please consider this patch series for the next merge window.

Thanks,

Bart.

Changes compared to v2:
- Changed the approach from one requeue list per hctx into preserving one
  requeue list per request queue.
- Rebased on top of Jens' for-next branch. Left out the mq-deadline patches
  since these are already in the for-next branch.
- Modified patch "block: Requeue requests if a CPU is unplugged" such that it
  always uses the requeue list.
- Added a patch that removes blk_mq_kick_requeue_list() and
  blk_mq_delay_kick_requeue_list().
- Dropped patch "block: mq-deadline: Disable head insertion for zoned writes".
- Dropped patch "block: mq-deadline: Introduce a local variable".

Changes compared to v1:
- Fixed two issues detected by the kernel test robot.

Bart Van Assche (7):
  block: Rename a local variable in blk_mq_requeue_work()
  block: Send requeued requests to the I/O scheduler
  block: Requeue requests if a CPU is unplugged
  block: Make it easier to debug zoned write reordering
  block: Preserve the order of requeued requests
  dm: Inline __dm_mq_kick_requeue_list()
  block: Inline blk_mq_{,delay_}kick_requeue_list()

 block/blk-flush.c            |   4 +-
 block/blk-mq-debugfs.c       |   2 +-
 block/blk-mq.c               | 107 ++++++++++++++++++-----------------
 drivers/block/ublk_drv.c     |   6 +-
 drivers/block/xen-blkfront.c |   1 -
 drivers/md/dm-rq.c           |  11 +---
 drivers/nvme/host/core.c     |   2 +-
 drivers/s390/block/scm_blk.c |   2 +-
 drivers/scsi/scsi_lib.c      |   2 +-
 include/linux/blk-mq.h       |   6 +-
 include/linux/blkdev.h       |   1 -
 11 files changed, 69 insertions(+), 75 deletions(-)

