Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB8BEC76196
	for <linux-block@archiver.kernel.org>; Fri,  7 Apr 2023 00:17:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbjDGART (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Apr 2023 20:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbjDGARS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2023 20:17:18 -0400
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 199038A55
        for <linux-block@vger.kernel.org>; Thu,  6 Apr 2023 17:17:17 -0700 (PDT)
Received: by mail-pj1-f45.google.com with SMTP id q102so38611076pjq.3
        for <linux-block@vger.kernel.org>; Thu, 06 Apr 2023 17:17:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680826636; x=1683418636;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=owO9GwTpufMJvZtom8FocWQVruY8gA12/ruhEXHOesg=;
        b=7xvptHnmtYZcMmPVRNuTymubQzUb30rdxgEPnd4Aa8DxjdndmtaCJ7aWIYhUp7h+0y
         8xjbRtWoqnBpFE5rqappjmXYU3MKwpc9P2BbMjjICafsUW7+HnM0zIQmI02qIQx8XpyN
         IHoNjUsLS1fcYgdWZKfqZ01MppA7nPQqJDaBmiyGbiyEWK35h6MTXAkgeYGQLwGy7Nsc
         qZVt99uIqc52oDsObikEOkBaBPi5MkbtJJNSQ/g30uh3rK5iTKEMdON3TRHPrgA6tLZt
         iWgBYuC6DPga5HPIqN04NhwqqyNh8euJSEI7HaaqrBkjnNVypnruxup4r2FJbMR1u836
         QeDQ==
X-Gm-Message-State: AAQBX9cx1gmHGqXgCSJXi//FxY5/HH9naKMQaWntoVL9vrQlI41D3NE2
        ZxilnbHTyzt9Y4yz3kOSdVo=
X-Google-Smtp-Source: AKy350YYs1WArtI+5Yzh7ybA9VzScUlLBPoWSCU9WtK/2b2UAm0vi1Y0aeW85/YF0yPNRvwlclX22A==
X-Received: by 2002:a17:903:280b:b0:1a2:8fa7:7b9f with SMTP id kp11-20020a170903280b00b001a28fa77b9fmr798381plb.22.1680826636032;
        Thu, 06 Apr 2023 17:17:16 -0700 (PDT)
Received: from bvanassche-glaptop2.roam.corp.google.com ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id x9-20020a1709028ec900b0019a773419a6sm1873676plo.170.2023.04.06.17.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 17:17:15 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 00/12] Submit zoned writes in order
Date:   Thu,  6 Apr 2023 17:16:58 -0700
Message-Id: <20230407001710.104169-1-bvanassche@acm.org>
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
 block/mq-deadline.c    |  67 +++++++++++++++++++-----
 include/linux/blk-mq.h |  35 ++++++-------
 include/linux/blkdev.h |   4 --
 7 files changed, 192 insertions(+), 117 deletions(-)

