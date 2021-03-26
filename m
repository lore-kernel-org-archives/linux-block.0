Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77131C433C1
	for <linux-block@archiver.kernel.org>; Fri, 26 Mar 2021 02:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43C9461A3F
	for <linux-block@archiver.kernel.org>; Fri, 26 Mar 2021 02:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbhCZC3u (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Mar 2021 22:29:50 -0400
Received: from mail-pg1-f172.google.com ([209.85.215.172]:33790 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbhCZC33 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Mar 2021 22:29:29 -0400
Received: by mail-pg1-f172.google.com with SMTP id r17so3656685pgi.0
        for <linux-block@vger.kernel.org>; Thu, 25 Mar 2021 19:29:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+6/m+R2PFrtIeUq+ozI0mvfNDdovXHTwaMyEnAAjXLY=;
        b=bFMJQCbS45epCyBCmfeW2jphqNmaNv3rO5dikONjeoVYwEBwb9cCCtdk3Gn0H6PDU2
         igIvf7ss5pSgc580SgMZ0IwT9DpSrHxOm01wivslZ2nG1hcpVAwxrCptuzmfF6dZf0R5
         u6bBWysO1P3OOLUbQILAI0U8czGKgErdKT9uZBpbZFPDjuNRt4HZlSknvRzttVQ0W+CX
         vhPBL1GSrGsF4tGVFlJ+OcE+nVDo2jr7YCCPepN/lfjXE1LL5T6MPdMRtNC1UrZ3Erwc
         UdCWe+Ao/vhgwhJRm/xm77UWfbOZ6DMkq0L0W/n9cj+eWuekcMMgzy9/p6vGN9AAqWkv
         jT1g==
X-Gm-Message-State: AOAM530FQhO8OWHJKokhXr5Iv8FNVFNTUSKXWlQf2I1JwnJHgQtrHmO3
        4jOiDGoaHl9ukf/bcGefJzc=
X-Google-Smtp-Source: ABdhPJwirmRCZMxQ1EVWf4zUWM6b0NCv+cTTg+haiPaJDu3JHg6nBPlfbhJIv5vsfBGtm07RvZ6yTg==
X-Received: by 2002:a63:f95d:: with SMTP id q29mr10275722pgk.33.1616725769015;
        Thu, 25 Mar 2021 19:29:29 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:c5af:7b7c:edac:ee67])
        by smtp.gmail.com with ESMTPSA id v18sm7031135pfn.117.2021.03.25.19.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 19:29:28 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v3 0/3] blk-mq: Fix a race between iterating over requests and freeing requests
Date:   Thu, 25 Mar 2021 19:29:16 -0700
Message-Id: <20210326022919.19638-1-bvanassche@acm.org>
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

Changes compared to v2:
- Converted the single v2 patch into a series of three patches.
- Switched from SRCU to a combination of RCU and semaphores.

Changes compared to v1:
- Reformatted patch description.
- Added Tested-by/Reviewed-by tags.
- Changed srcu_barrier() calls into synchronize_srcu() calls.

Bart Van Assche (3):
  blk-mq: Move the elevator_exit() definition
  blk-mq: Introduce atomic variants of the tag iteration functions
  blk-mq: Fix races between iterating over requests and freeing requests

 block/blk-core.c          | 34 ++++++++++++++-
 block/blk-mq-tag.c        | 87 ++++++++++++++++++++++++++++++++++-----
 block/blk-mq-tag.h        |  8 ++--
 block/blk-mq.c            | 31 ++++++++++----
 block/blk-mq.h            |  1 +
 block/blk.h               | 11 +----
 block/elevator.c          |  9 ++++
 drivers/scsi/hosts.c      | 16 +++----
 drivers/scsi/ufs/ufshcd.c |  4 +-
 include/linux/blk-mq.h    |  2 +
 10 files changed, 160 insertions(+), 43 deletions(-)

