Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A33FC433B4
	for <linux-block@archiver.kernel.org>; Mon,  5 Apr 2021 00:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55C5661396
	for <linux-block@archiver.kernel.org>; Mon,  5 Apr 2021 00:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbhDEA2w (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 4 Apr 2021 20:28:52 -0400
Received: from mail-pj1-f44.google.com ([209.85.216.44]:36362 "EHLO
        mail-pj1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbhDEA2r (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 4 Apr 2021 20:28:47 -0400
Received: by mail-pj1-f44.google.com with SMTP id f2-20020a17090a4a82b02900c67bf8dc69so7047217pjh.1
        for <linux-block@vger.kernel.org>; Sun, 04 Apr 2021 17:28:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9/sUi89FP9CquLftW4U1hYfqJ8K9UAzgnKAAV2PkmZA=;
        b=rI0I01yML0V8ENS+0QL/1dobfFXlwjeFhabNfh9h1INt9najIFpaqBaJlWyDhCIh53
         Nq5n8QIMY8aEhT3MZIPsmcC27HeUbcsY33slz1sm3j0bVZhNH4pEtTcP23hirvnfjK5K
         Eo+iEgywO1RjM0BknpX9TzdbVtVdSE7wrBufYsJgdSzgo2+b30cT9u2Qvt8l+xBB8ASY
         NhZFv6qmKEKO5XKvx+M29jPOrqIwKAUaREvw70/3YfOK5qz286h+8aLckwD440kOeUN3
         Ne41vRYsSoMFlU9mR4agzD1aEkQVwm0dWoEPdJAlSbTzvOpHqlDBnugkv17YqPlo2HZS
         E9og==
X-Gm-Message-State: AOAM53015ag68UrHBffK01v9JaEMcw/ftwanP1XYh+1nlzs7wTtmXXbg
        aaPFHNW48mUu2vutG03k3PE=
X-Google-Smtp-Source: ABdhPJw7deuBOEjqAuAtO4j3TG9KlxXMbH7wm/1TiVND8lO86ZdaYsLU8767TKkBPjzv1U7onzhlZQ==
X-Received: by 2002:a17:90a:890f:: with SMTP id u15mr4662758pjn.25.1617582521104;
        Sun, 04 Apr 2021 17:28:41 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:91b0:bd58:a9d0:2f54])
        by smtp.gmail.com with ESMTPSA id x4sm13444254pfn.134.2021.04.04.17.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Apr 2021 17:28:40 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v5 0/3] blk-mq: Fix a race between iterating over requests and freeing requests
Date:   Sun,  4 Apr 2021 17:28:31 -0700
Message-Id: <20210405002834.32339-1-bvanassche@acm.org>
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

