Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 139F5C433B4
	for <linux-block@archiver.kernel.org>; Wed, 21 Apr 2021 00:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3D2B61418
	for <linux-block@archiver.kernel.org>; Wed, 21 Apr 2021 00:02:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234186AbhDUADP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Apr 2021 20:03:15 -0400
Received: from mail-pg1-f172.google.com ([209.85.215.172]:35541 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233992AbhDUADP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Apr 2021 20:03:15 -0400
Received: by mail-pg1-f172.google.com with SMTP id q10so28004470pgj.2
        for <linux-block@vger.kernel.org>; Tue, 20 Apr 2021 17:02:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CsjTF/SyMZ66uE1gHZVzl2El46Tz+5pGkG/io2k1Ki0=;
        b=SJ54t2JOvxuvffcvAgis5E2i1ItGU//tnEjQicJyC7I9O7A+cuHs84ZePjjMUlOOA7
         N1OTjeWeyuFLEHZ2hPivDKcE6BMYw4rpuajXyOF36daD3xDG0ULn4PQJALMD6b9hsUcA
         StKaindb1R4dRYf0s9BGg1zemgqrGuC7BZKbH3j45fF6X/ElcTfMLI1ckN2yyJ1gYkdf
         0YWPHNI2UKFLLTBhOPi/xhK2VyFXQgFQfxtMPAldR4bVuKXZseFwJtmQMc5cyzMImB50
         sM7n5/hAB4iVlLLfq+81he8ZYPGbeP+EuB3IibbZyXRc8GcxKga72wvdSCH+xWFrqET0
         MHDQ==
X-Gm-Message-State: AOAM533PuS+yeziSO9SoVDfGpDkwOOi+hC9pcrCzQrEbOy4LQ/9taOgo
        EzoBZvBNWgQ7KsFQSJrcvKk=
X-Google-Smtp-Source: ABdhPJywD5z9Zd2AdJfBW9sBJE81FaIQcEYaKa4TfvM4L1VzwuAS10NmvzE69WBPSKp1zj+St84e7w==
X-Received: by 2002:a65:584e:: with SMTP id s14mr18896341pgr.229.1618963363115;
        Tue, 20 Apr 2021 17:02:43 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:6cb:4566:9005:c2af])
        by smtp.gmail.com with ESMTPSA id 33sm149560pgq.21.2021.04.20.17.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 17:02:42 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Daniel Wagner <dwagner@suse.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v7 0/5] blk-mq: Fix a race between iterating over requests and freeing requests
Date:   Tue, 20 Apr 2021 17:02:30 -0700
Message-Id: <20210421000235.2028-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

This patch series fixes the race between iterating over requests and
freeing requests that has been reported by multiple different users over
the past two years. Please consider this patch series for kernel v5.13.

Thanks,

Bart.

Changes between v6 and v7:
- Changed one comment.
- Updated Reviewed-by / Tested-by tags.

Changes between v5 and v6:
- Fixed an additional race between iterating over tags and freeing scheduler
  requests that was spotted by Khazhy.
- Added two patches to fix the race conditions between updating the number of
  hardware queues and iterating over a tag set.

Changes between v4 and v5:
- Addressed Khazhy's review comments. Note: the changes that have been made
  in v5 only change behavior in case CONFIG_PROVE_RCU=y.

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

Bart Van Assche (5):
  blk-mq: Move the elevator_exit() definition
  blk-mq: Introduce atomic variants of blk_mq_(all_tag|tagset_busy)_iter
  blk-mq: Fix races between iterating over requests and freeing requests
  blk-mq: Make it safe to use RCU to iterate over
    blk_mq_tag_set.tag_list
  blk-mq: Fix races between blk_mq_update_nr_hw_queues() and iterating
    over tags

 block/blk-core.c          |  34 +++++++++-
 block/blk-mq-tag.c        | 128 ++++++++++++++++++++++++++++++++++----
 block/blk-mq-tag.h        |   6 +-
 block/blk-mq.c            |  31 ++++++---
 block/blk-mq.h            |   1 +
 block/blk.h               |  11 +---
 block/elevator.c          |   9 +++
 drivers/scsi/hosts.c      |  16 ++---
 drivers/scsi/ufs/ufshcd.c |   4 +-
 include/linux/blk-mq.h    |   2 +
 10 files changed, 202 insertions(+), 40 deletions(-)

