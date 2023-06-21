Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC057EB64DC
	for <linux-block@archiver.kernel.org>; Wed, 21 Jun 2023 20:12:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjFUUMq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Jun 2023 16:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbjFUUMp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Jun 2023 16:12:45 -0400
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31AAA19A8
        for <linux-block@vger.kernel.org>; Wed, 21 Jun 2023 13:12:44 -0700 (PDT)
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-55ab0f777afso4294660eaf.1
        for <linux-block@vger.kernel.org>; Wed, 21 Jun 2023 13:12:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687378363; x=1689970363;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=onRJCe2+oK73GfiHXNhALwHWKuNShCr8xafFOkbZonI=;
        b=Rl2H23V3pTak/5cOp9wEqroiw4GpDZH+LaciorxgANaDuUdzXaqWBIjx7e7bptzCPL
         mELF6TNdIcG9ggPc5IYglwCT4NDPHS79gcldkCBKwlKOZ9S98/Z73XEa98nCOnnQ/L5l
         mZlwU5aEfy+8czjXnDl5e26t62Jxh6yk9nx/qTXpRJ0iiTI+cZaS5rcv+irMt/MXeyUZ
         3Vz0A44Bp46ZJB7t3TnCaXwBGf6RqcA5emjjD3qfPJMkNlvK1WAVT3jFQvkSOF8nzd4i
         w00DY+kO4eRxABZ0o0qAR0NxX0YCS1vH8il08FrdZgC0he7kSzqbNiMkDfF9hqZ3j89V
         kWEQ==
X-Gm-Message-State: AC+VfDw0jCh0kaCc0Q4J8lQS7iZ6ib/co7ZimoRQzNXVrKIJD9E6MMLx
        Hc8N6NbvHOZH0eAwNQ4k52p8KjyLi1s=
X-Google-Smtp-Source: ACHHUZ4rYYoa3/e3Pahw7U4FexycXb6MG+w5+ypwLZVVlqq6kWvkkl05bQ7mnzJ/6h9va7QU+F1F9w==
X-Received: by 2002:a05:6359:293:b0:132:cd9b:7837 with SMTP id ek19-20020a056359029300b00132cd9b7837mr560292rwb.14.1687378361908;
        Wed, 21 Jun 2023 13:12:41 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:c0b7:6a6f:751b:b854])
        by smtp.gmail.com with ESMTPSA id h8-20020a63df48000000b00548fb73874asm3522983pgj.37.2023.06.21.13.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 13:12:41 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v4 0/7] Submit zoned writes in order
Date:   Wed, 21 Jun 2023 13:12:27 -0700
Message-ID: <20230621201237.796902-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

Tests with a zoned UFS prototype have shown that the block layer may reorder
zoned writes (REQ_OP_WRITE). The UFS driver is more likely to trigger reordering
than other SCSI drivers because it reports BLK_STS_DEV_RESOURCE more often, e.g.
during clock scaling. This patch series makes sure that zoned writes are
submitted in order without affecting other workloads significantly.

Please consider this patch series for the next merge window.

Thanks,

Bart.

Changes compared to v3:
- Dropped the changes for sending already dispatched requests back to the I/O
  scheduler if the block driver is busy.
- Dropped several patches that aren't needed to preserve the order of zoned
  writes.
- Only send requeued writes to the I/O scheduler. Send requeued reads straight
  to the dispatch queue.
- Changed the approach from one requeue list per request queue into one requeue
  list per hardware queue.

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
  block: Simplify blk_mq_requeue_work()
  block: Send requeued requests to the I/O scheduler
  block: One requeue list per hctx
  block: Preserve the order of requeued requests
  dm: Inline __dm_mq_kick_requeue_list()
  block: Inline blk_mq_{,delay_}kick_requeue_list()

 block/blk-flush.c            | 28 +++++++------
 block/blk-mq-debugfs.c       | 66 ++++++++++++++---------------
 block/blk-mq.c               | 81 ++++++++++++++----------------------
 drivers/block/ublk_drv.c     |  6 +--
 drivers/block/xen-blkfront.c |  1 -
 drivers/md/dm-rq.c           | 11 ++---
 drivers/nvme/host/core.c     |  2 +-
 drivers/s390/block/scm_blk.c |  2 +-
 drivers/scsi/scsi_lib.c      |  2 +-
 include/linux/blk-mq.h       | 11 +++--
 include/linux/blkdev.h       |  5 ---
 11 files changed, 96 insertions(+), 119 deletions(-)

