Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75487C7618E
	for <linux-block@archiver.kernel.org>; Mon, 24 Apr 2023 20:33:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbjDXUdg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Apr 2023 16:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbjDXUdf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Apr 2023 16:33:35 -0400
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C25855AE
        for <linux-block@vger.kernel.org>; Mon, 24 Apr 2023 13:33:34 -0700 (PDT)
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-63b73203e0aso30789632b3a.1
        for <linux-block@vger.kernel.org>; Mon, 24 Apr 2023 13:33:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682368414; x=1684960414;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7TtGnjYWBb/HSJwi+jPEjTEx/+KHYw0qC+vfPVPlv+w=;
        b=hNDWufkSYQAGNiLHw/bPDZOtsjLm0c9lk2Mp0qV9hokOSEVyq+u0a7lxuex6NYhPBb
         QGYt0izTDjW1SI6CO3A4fCBAOSLBrcOy3ZpzKLcNFuNO6cYHXIzWawPW5TaiXkkvPkrS
         qgJ/JRgDcXYjwQZpoEIicHlpV0gyB4Flg4RscfV/NLUp3aVgMZJDQuTAKFGknLYQMTc1
         SWZNX5PEH2kC4HdfisC5zVMDzNUJv0D5QOW3roIyX7Ku0PFJphPNHIkG+VoLLevLkLUf
         Ujys98xEFrpFhA4B0+tOZpDMoIT6unU3zpMJrZ6NLjSGsOHFkuDxErqhIQiDLOcvgWJt
         yXqA==
X-Gm-Message-State: AAQBX9fVX4oDooRlNWNtcvMmjhEnlUBS/WbQ7NfJMftY/+5i5n5LBd2b
        YBghqsmjqcTxBOH8AZvAoOw=
X-Google-Smtp-Source: AKy350ZVD5TWIQEHEpwWl6ggdvhhg6WT7V2eViNHJFgJS3e2x+iL8AukR3+nlVyizztGqOnbUbXoMg==
X-Received: by 2002:a05:6a00:2450:b0:634:c34f:e214 with SMTP id d16-20020a056a00245000b00634c34fe214mr21268977pfj.10.1682368413684;
        Mon, 24 Apr 2023 13:33:33 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:56cb:b39a:c8b:8c37])
        by smtp.gmail.com with ESMTPSA id k16-20020aa788d0000000b00625616f59a1sm7417505pff.73.2023.04.24.13.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 13:33:33 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v3 0/9] mq-deadline: Improve support for zoned block devices
Date:   Mon, 24 Apr 2023 13:33:20 -0700
Message-ID: <20230424203329.2369688-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

This patch series improves support for zoned block devices in the mq-deadline
scheduler as follows:
* The order of requeued writes (REQ_OP_WRITE*) is preserved.
* The active zone limit is enforced.

Please consider this patch series for the next merge window.

Thanks,

Bart.

Changes compared to v2:
- In the patch that micro-optimizes blk_req_needs_zone_write_lock(), inline
  bdev_op_is_zoned_write() instead of modifying it.
- In patch "block: Introduce blk_rq_is_seq_zoned_write()", converted "case
  REQ_OP_ZONE_APPEND" into a source code comment.
- Reworked deadline_skip_seq_writes() as suggested by Christoph.
- Dropped the patch that disabled head insertion for zoned writes.
- Dropped patch "mq-deadline: Fix a race condition related to zoned writes".
- Reworked handling of requeued requests: the 'next_rq' pointer has been
  removed and instead the position of the most recently dispatched request is
  tracked.
- Dropped the patches for tracking zone capacity and for restricting the number
  of active zones.

Changes compared to v1:
- Left out the patches related to request insertion and requeuing since
  Christoph is busy with reworking these patches.
- Added a patch for enforcing the active zone limit.

Bart Van Assche (9):
  block: Simplify blk_req_needs_zone_write_lock()
  block: Micro-optimize blk_req_needs_zone_write_lock()
  block: Introduce blk_rq_is_seq_zoned_write()
  block: mq-deadline: Clean up deadline_check_fifo()
  block: mq-deadline: Simplify deadline_skip_seq_writes()
  block: mq-deadline: Improve deadline_skip_seq_writes()
  block: mq-deadline: Track the dispatch position
  block: mq-deadline: Handle requeued requests correctly
  block: mq-deadline: Fix handling of at-head zoned writes

 block/blk-mq.h         |   4 +-
 block/blk-zoned.c      |  28 ++++++----
 block/mq-deadline.c    | 114 +++++++++++++++++++++++++++--------------
 include/linux/blk-mq.h |   6 +++
 include/linux/blkdev.h |   9 ----
 5 files changed, 102 insertions(+), 59 deletions(-)

