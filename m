Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 696B6C77B6C
	for <linux-block@archiver.kernel.org>; Fri,  7 Apr 2023 23:58:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbjDGX6m (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Apr 2023 19:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjDGX6m (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Apr 2023 19:58:42 -0400
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B835EE1A1
        for <linux-block@vger.kernel.org>; Fri,  7 Apr 2023 16:58:40 -0700 (PDT)
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1a4fe31ee82so1477335ad.2
        for <linux-block@vger.kernel.org>; Fri, 07 Apr 2023 16:58:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680911920; x=1683503920;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=81rb+uadv0Injv+1H61b3blwVCa1jbmfSjDNjIopk1E=;
        b=sK3EGRcICLmmb3ZWc1oGLNCfXA36XnTF1YLqtgqNw+YiqjcfkrpvQiYAIAKKPuSxrt
         n1eF+jCEgRKWmkid+Rpcc314CNR5HUV363DxwjyDXYuh7Zg+xPGSVsvcjItoDDwnHBRj
         QRV6Nh9/cwPH3WHFWqwlwLa7iZ11QRLDkyp1PN/6aWlQGTE9mQy/seq/4hRkI//SjEti
         z7E/OBCwJalCpOZAZMiCRmv8Z5DzgmnaLQSXe6bwDOekGgIOHkkH71K3HKmRRfLqdS0C
         kh0uoPs4rbP2nfaC7Nk6fclh0jWL614jN9jomrtz/pRHmmDoYbIc5QoE7mpezvOSm5fi
         HYyw==
X-Gm-Message-State: AAQBX9eFsKHC8pzh3v7T3Hh9EI1F7+a70elakOhYEBrbzi/m6+vtcBB6
        brUMVLAmnbYbPULM23WM2dM=
X-Google-Smtp-Source: AKy350Z7PZg8LExm5SMaeWjaiIGPHFrR6kE4MOgjv3Rn8tkCwZoS5ZzKdjarpMvLUC7SzlFj4k66ig==
X-Received: by 2002:a62:1746:0:b0:628:642:c533 with SMTP id 67-20020a621746000000b006280642c533mr3578019pfx.31.1680911919758;
        Fri, 07 Apr 2023 16:58:39 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:f2c:4ac2:6000:5900])
        by smtp.gmail.com with ESMTPSA id j16-20020a62e910000000b006258dd63a3fsm3556003pfh.56.2023.04.07.16.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 16:58:39 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v2 00/12] Submit zoned writes in order
Date:   Fri,  7 Apr 2023 16:58:10 -0700
Message-Id: <20230407235822.1672286-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
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

Changes compared to v1:
- Fixed two issues detected by the kernel test robot.

Bart Van Assche (12):
  block: Send zoned writes to the I/O scheduler
  block: Send flush requests to the I/O scheduler
  block: Send requeued requests to the I/O scheduler
  block: Requeue requests if a CPU is unplugged
  block: One requeue list per hctx
  block: Preserve the order of requeued requests
  block: Make it easier to debug zoned write reordering
  block: mq-deadline: Simplify deadline_skip_seq_writes()
  block: mq-deadline: Disable head insertion for zoned writes
  block: mq-deadline: Introduce a local variable
  block: mq-deadline: Fix a race condition related to zoned writes
  block: mq-deadline: Handle requeued requests correctly

 block/blk-flush.c      |   3 +-
 block/blk-mq-debugfs.c |  66 +++++++++++------------
 block/blk-mq.c         | 115 +++++++++++++++++++++++------------------
 block/blk.h            |  19 +++++++
 block/mq-deadline.c    |  65 ++++++++++++++++++-----
 include/linux/blk-mq.h |  40 +++++++-------
 include/linux/blkdev.h |   4 --
 7 files changed, 194 insertions(+), 118 deletions(-)

