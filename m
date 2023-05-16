Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8EFAC77B7A
	for <linux-block@archiver.kernel.org>; Tue, 16 May 2023 22:33:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjEPWda (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 May 2023 18:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjEPWd3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 May 2023 18:33:29 -0400
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C9C3A80
        for <linux-block@vger.kernel.org>; Tue, 16 May 2023 15:33:28 -0700 (PDT)
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1aad5245632so1386045ad.3
        for <linux-block@vger.kernel.org>; Tue, 16 May 2023 15:33:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684276408; x=1686868408;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VIqAtwTOInucYJKgl2MSbXCFjY4zOdS0sd2xNkkxr/w=;
        b=bD741NOBkdwnN+fO9s5jgkA4cdgEyHihPn2oNxf3c6+DrLm4koO9ZCqetfy7dawlrK
         r4c/u+eP2RgR8p5bA+Xcm11Hy7P4bC2FLaFAPI5EiZbZGJC8TO5nK2CUzGwyWCBlVHYP
         jGdEB2FvRjPmjqaj6Vc1TQA64XU9atLiF4ckmz5kDubW7ZZLRvgDKcq4vb6Yh1d6wLa9
         h/ZcVue7DeXHKFcGQXtJOldxKkpYCX67nkpy5AsKOZZOxwhZPkvPT2Hjic15wYKfrvmY
         dyQo1MaBjnrez1kAZLoDB/s8c7PiH5Xj53CAez4x1foZYiwWMFXOmQXqN6lubqjFkdtx
         JUtg==
X-Gm-Message-State: AC+VfDwQj4MqXXvYJ0/ZqCU/IEReCLLn5tIEMjzI/t85LmSzvRg52yIy
        eZYGQk6SdChxyNbmbSnedylnJv++o+E=
X-Google-Smtp-Source: ACHHUZ5Xj/4DTYhCVmHHfMoxg7ryuSeywhmuyWGo8kKOYEY2g5XwcM2tV9Zdj2rYQ/XJRc00VHUxdA==
X-Received: by 2002:a17:902:dac2:b0:1ac:4d3e:1bf5 with SMTP id q2-20020a170902dac200b001ac4d3e1bf5mr51702415plx.23.1684276407584;
        Tue, 16 May 2023 15:33:27 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:baed:ee38:35e4:f97d])
        by smtp.gmail.com with ESMTPSA id d8-20020a170902654800b001ae48d441desm839255pln.148.2023.05.16.15.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 15:33:27 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v5 00/11] mq-deadline: Improve support for zoned block devices
Date:   Tue, 16 May 2023 15:33:09 -0700
Message-ID: <20230516223323.1383342-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

This patch series improves support for zoned block devices in the mq-deadline
scheduler by preserving the order of requeued writes (REQ_OP_WRITE and
REQ_OP_WRITE_ZEROES).

Please consider this patch series for the next merge window.

Thanks,

Bart.

Changes compared to v4:
- Changed blk_rq_is_seq_zoned_write() into an inline function.
- Reworked patch "Reduce lock contention" such that all merged requests are
  freed at once.

Changes compared to v3:
- Addressed Christoph's review feedback.
- Dropped patch "block: Micro-optimize blk_req_needs_zone_write_lock()".
- Added three new patches:
  * block: Fix the type of the second bdev_op_is_zoned_write() argument
  * block: Introduce op_is_zoned_write()
  * block: mq-deadline: Reduce lock contention

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

Bart Van Assche (11):
  block: Simplify blk_req_needs_zone_write_lock()
  block: Fix the type of the second bdev_op_is_zoned_write() argument
  block: Introduce op_is_zoned_write()
  block: Introduce blk_rq_is_seq_zoned_write()
  block: mq-deadline: Clean up deadline_check_fifo()
  block: mq-deadline: Simplify deadline_skip_seq_writes()
  block: mq-deadline: Improve deadline_skip_seq_writes()
  block: mq-deadline: Reduce lock contention
  block: mq-deadline: Track the dispatch position
  block: mq-deadline: Handle requeued requests correctly
  block: mq-deadline: Fix handling of at-head zoned writes

 block/blk-zoned.c      |   8 +--
 block/mq-deadline.c    | 123 +++++++++++++++++++++++++++--------------
 include/linux/blk-mq.h |  16 ++++++
 include/linux/blkdev.h |  13 +++--
 4 files changed, 108 insertions(+), 52 deletions(-)

