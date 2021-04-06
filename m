Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4984DC433ED
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 21:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18C026120E
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 21:49:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233022AbhDFVtU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Apr 2021 17:49:20 -0400
Received: from mail-pf1-f181.google.com ([209.85.210.181]:36540 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232623AbhDFVtT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Apr 2021 17:49:19 -0400
Received: by mail-pf1-f181.google.com with SMTP id g15so11434415pfq.3
        for <linux-block@vger.kernel.org>; Tue, 06 Apr 2021 14:49:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6HAJz9rAAl3yNLJs7p8VzvDK6gFco3yVX7BgzqlQZuk=;
        b=CrUtCDSwq8a6S7fjMAqDpoZIwikXkU+pLtDNoBp+XtP5lIbD8lg8QGrU5OIvQhauTh
         twjiLljfPenY9fQHB/BsnFxhZ5IN4/qSXerqDU0vMubWB25URGu5scP4s5wc8Fe9m3rx
         KVSU5VSS4BnvD8FmNJG3Pr8KGFLpECgRKurZKtPSTvF6XSA+9i0llSTC7i7cyg/fkE7b
         LfOChtlnIcGjQSDSQgcxPJX6WvC7R4cxmlwaB/kfEpb8d6U02IEipwi3StilPpeqsO0/
         fO/PzmzwwsanaisZ9X4GZO9tfmdM5wrZzaCxZyJBbBYqOnWQ29DFf1huaAFCqs+QY0PI
         dxeg==
X-Gm-Message-State: AOAM531sOM6Fl7ARHYgsU6DsiGer8sUL734iupkVJL8K61V4TfodEgQQ
        n3CSWR+52KFoZXIZ3bRqXMCyXHH8Jv0=
X-Google-Smtp-Source: ABdhPJzdoRmgv4YvnX25fSsW0+YcrgxFHqACeoLdSbHlFeaQcl8Nd7NTcQ82w7WrZYZSEok+YtHAKw==
X-Received: by 2002:a62:d45a:0:b029:218:669c:4f37 with SMTP id u26-20020a62d45a0000b0290218669c4f37mr280784pfl.48.1617745751222;
        Tue, 06 Apr 2021 14:49:11 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:277d:764e:de23:a2e8])
        by smtp.gmail.com with ESMTPSA id my18sm2866062pjb.38.2021.04.06.14.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 14:49:10 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v6 0/5] blk-mq: Fix a race between iterating over requests and freeing requests
Date:   Tue,  6 Apr 2021 14:49:00 -0700
Message-Id: <20210406214905.21622-1-bvanassche@acm.org>
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

Thanks,

Bart.

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
  blk-mq: Fix a race between blk_mq_update_nr_hw_queues() and iterating
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

