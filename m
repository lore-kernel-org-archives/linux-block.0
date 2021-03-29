Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61355C433E4
	for <linux-block@archiver.kernel.org>; Mon, 29 Mar 2021 02:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4013261949
	for <linux-block@archiver.kernel.org>; Mon, 29 Mar 2021 02:01:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbhC2CAp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 28 Mar 2021 22:00:45 -0400
Received: from mail-pg1-f169.google.com ([209.85.215.169]:34767 "EHLO
        mail-pg1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231195AbhC2CAf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 28 Mar 2021 22:00:35 -0400
Received: by mail-pg1-f169.google.com with SMTP id i6so1270568pgs.1
        for <linux-block@vger.kernel.org>; Sun, 28 Mar 2021 19:00:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=znQQMvHjubrWucDtKVM4arblRFfmMMDu2f/7m0/Isjw=;
        b=M1U2yuXRVegsjNgk7bcZro6gtEI70IRWaGoqa2MY8j4PAeK9jYzlQ9GwZV/H/lVVPQ
         Tvul2cTswfinN2Jp4FNWOdOzegJlxFN4/T/UQgWWnKzdWxCrDau+bYZT79TZKtUTBHoD
         IIxWLdYdQ4eF55EUyHxuWaXT8jTj52wb7iXKcigIZLaykAeurD44I6EgAugoDfftlg+6
         QfjNhXQ23YcTbzNWN4kxpZ8zKg6rmyFzxNqHg8fOy6btl8FoH/Q3E8OHCBhC/0Mdatrk
         8E7e/dghMiLKDUfRJVZ8Um8LjQqCPqSjcWjLVU4+pIH3b+GgjeN2b5QPWYw0rYogaWjU
         Rj7w==
X-Gm-Message-State: AOAM533qAHvDQApDTvn7S5TcXN9AwgdXU1ecJOJ+NsRDCOFQZy7519gl
        hBE85ff4o+twN3JA9ygSv+k=
X-Google-Smtp-Source: ABdhPJwgAEyN89K8u+dTUCPvQe1B3kGGsxwY88CHTkfDTiTXzf38fBzWITjsNN66D6Eq5LfLbkJLCg==
X-Received: by 2002:a65:4344:: with SMTP id k4mr22141100pgq.48.1616983234864;
        Sun, 28 Mar 2021 19:00:34 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:7123:9470:fec5:1a3a])
        by smtp.gmail.com with ESMTPSA id x125sm15784979pfd.124.2021.03.28.19.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 19:00:34 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v4 0/3] blk-mq: Fix a race between iterating over requests and freeing requests
Date:   Sun, 28 Mar 2021 19:00:25 -0700
Message-Id: <20210329020028.18241-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

This patch series fixes the race between iterating over requests and
freeing requests that has been reported by multiple different users over
the past two years. Please consider this patch series for kernel v5.13.

Thank you,

Bart.

Changes between v3 and v4:
- Fixed support for tag sets shared across hardware queues.
- Renamed blk_mq_wait_for_tag_readers() into blk_mq_wait_for_tag_iter().
- Removed the fourth argument of blk_mq_queue_tag_busy_iter() again.

Changes between v2 and v3:
- Converted the single v2 patch into a series of three patches.
- Switched from SRCU to a combination of RCU and semaphores.

Changes between v1 and v2:
- Reformatted patch description.
- Added Tested-by/Reviewed-by tags.
- Changed srcu_barrier() calls into synchronize_srcu() calls.

Bart Van Assche (3):
  blk-mq: Move the elevator_exit() definition
  blk-mq: Introduce atomic variants of the tag iteration functions
  blk-mq: Fix a race between iterating over requests and freeing
    requests

 block/blk-core.c          | 34 ++++++++++++++++-
 block/blk-mq-tag.c        | 79 ++++++++++++++++++++++++++++++++++-----
 block/blk-mq-tag.h        |  6 ++-
 block/blk-mq.c            | 23 +++++++++---
 block/blk-mq.h            |  1 +
 block/blk.h               | 11 +-----
 block/elevator.c          |  9 +++++
 drivers/scsi/hosts.c      | 16 ++++----
 drivers/scsi/ufs/ufshcd.c |  4 +-
 include/linux/blk-mq.h    |  2 +
 10 files changed, 149 insertions(+), 36 deletions(-)

