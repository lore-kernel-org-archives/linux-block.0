Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32612C77B75
	for <linux-block@archiver.kernel.org>; Wed, 17 May 2023 17:45:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbjEQRpa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 May 2023 13:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjEQRp2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 May 2023 13:45:28 -0400
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2BBFD2E8
        for <linux-block@vger.kernel.org>; Wed, 17 May 2023 10:44:55 -0700 (PDT)
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6439f186366so778982b3a.2
        for <linux-block@vger.kernel.org>; Wed, 17 May 2023 10:44:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684345469; x=1686937469;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4RtwH1xCJoRLi015w+Kr7vT1skML2DMyjxgN46fU0mQ=;
        b=F97hiJ56rEGLgpL6/NYhL5T3+wlWI+6q3frxmZByi7xTAI+08c6W1AbzoMbbhP7VhB
         eYyvJ/rd9973k1Le4VvFApzpwP+hSF3GiKeCDOYfP0A1+0wo7C28bfeKTuG27Pj9gBMy
         O0NR+emueM/KCmhAPcabr2m+huQ+KgarBLMxBrwm8u7dFUHbGrba3YkN/pmzTettiHo2
         GWbzBz/hNkHeZYF3v7S373Xy32hRlbJPVU+h1dFogrplaywzTap7cfjiLRVPUhcDGNVX
         CbQ5cQrym0Xv5UpbjZv5QN5E750qsUQ0OAlVytOF/aTU7PFngrAz0i8UGvh/51XSHk5A
         RdeQ==
X-Gm-Message-State: AC+VfDx5jKU7gzavioXYmvir+r32B1rASJfICfiSRv0FwkDvlBDGRU3R
        Rg3iALCooIn5ogOMyWpc40Q=
X-Google-Smtp-Source: ACHHUZ5rpvt5ocwKUiV43HlUzWBT91AuVukWndkVVBzSKNBfVOvkyP480g3K6udkGBVw65LQbxLnuQ==
X-Received: by 2002:a05:6a00:992:b0:643:440b:1af5 with SMTP id u18-20020a056a00099200b00643440b1af5mr699413pfg.16.1684345469281;
        Wed, 17 May 2023 10:44:29 -0700 (PDT)
Received: from bvanassche-glaptop2.roam.corp.google.com ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id d22-20020aa78e56000000b00646e7d2b5a7sm15334410pfr.112.2023.05.17.10.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 10:44:27 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v6 00/11] mq-deadline: Improve support for zoned block devices
Date:   Wed, 17 May 2023 10:42:18 -0700
Message-ID: <20230517174230.897144-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
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

Changes compared to v5:
- Added a patch with a grammar fix for a source code comment.
- Renamed op_is_zoned_write() into op_needs_zoned_write_locking().
- Dropped patch "block: mq-deadline: Improve deadline_skip_seq_writes()".

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
  block: mq-deadline: Add a word in a source code comment
  block: Simplify blk_req_needs_zone_write_lock()
  block: Fix the type of the second bdev_op_is_zoned_write() argument
  block: Introduce op_needs_zoned_write_locking()
  block: Introduce blk_rq_is_seq_zoned_write()
  block: mq-deadline: Clean up deadline_check_fifo()
  block: mq-deadline: Simplify deadline_skip_seq_writes()
  block: mq-deadline: Reduce lock contention
  block: mq-deadline: Track the dispatch position
  block: mq-deadline: Handle requeued requests correctly
  block: mq-deadline: Fix handling of at-head zoned writes

 block/blk-zoned.c      |   8 +--
 block/mq-deadline.c    | 125 +++++++++++++++++++++++++++--------------
 include/linux/blk-mq.h |  17 ++++++
 include/linux/blkdev.h |  13 +++--
 4 files changed, 110 insertions(+), 53 deletions(-)

