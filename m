Return-Path: <SRS0=lp7R=4I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B539C7619D
	for <linux-block@archiver.kernel.org>; Thu, 20 Feb 2020 02:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E68AB24670
	for <linux-block@archiver.kernel.org>; Thu, 20 Feb 2020 02:44:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbgBTCot (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Feb 2020 21:44:49 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42688 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727515AbgBTCot (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Feb 2020 21:44:49 -0500
Received: by mail-pg1-f193.google.com with SMTP id w21so1138548pgl.9
        for <linux-block@vger.kernel.org>; Wed, 19 Feb 2020 18:44:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nb5v1vwv/Mfw7K59HgrhfIO73gyMwnqFVdMo2/sPVcI=;
        b=H5c1AEBeGzZNGYzlAQvpzkfmH1Zk4m0zUqfhCk96svtuVs4Zn5hK7BbDRIPHne796y
         XERHBp1DEkk04zPA5dHANhYrJJgvCAHI4VLwhOKUCwJw/1pf6txQ37Ry/X6ULgC6Dl8z
         rn1bEOWcjJAcaY+48XiZvjX8+I6FYxPHK2TOjd0sGVrQi1g74qjdinVoIIsTKzkce2Qf
         XEx0vxPPX/+wEdR2r+cBqoSAs2pJBRcxjclohrvZ+F1Ez7yuB/HY1urfpfMAK+zHm3tZ
         GXeZ8TKFaR2CfF/cV4tR9a3sTk2JS+67NbPOBbyAqF/VhqFusmY6JKmTdY1OgjZAZopj
         VfHw==
X-Gm-Message-State: APjAAAXdbHAPdZ0moqBuw7tcD5c0BMwypRu8DesYNnlQSJAbMDaD1KKG
        pFn02A0KvH3oJ7wLGIIyC9c=
X-Google-Smtp-Source: APXvYqxsTbvDBJlgXM/adsHPnKv1CI385LwErbcqeP8qJqqwWJH+oHNix0C8BrGS+h+YQQO2npfAqQ==
X-Received: by 2002:a63:2bc3:: with SMTP id r186mr31027227pgr.294.1582166687167;
        Wed, 19 Feb 2020 18:44:47 -0800 (PST)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:29a7:b1bb:5b40:3d61])
        by smtp.gmail.com with ESMTPSA id t23sm1005466pfq.6.2020.02.19.18.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 18:44:46 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v2 0/8] Eight patches related to changing the number of hardware queues
Date:   Wed, 19 Feb 2020 18:44:33 -0800
Message-Id: <20200220024441.11558-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

These patches are what I came up with while analyzing syzbot and blktests
complaints related to dynamically changing the number of hardware queues.
Please consider these patches for the upstream kernel.

Thanks,

Bart.

Changes compared to v1:
- Reworked patch 2/8 as requested by Ming.
- Added three new null_blk patches.

Bart Van Assche (8):
  blk-mq: Fix a comment in include/linux/blk-mq.h
  blk-mq: Keep set->nr_hw_queues and set->map[].nr_queues in sync
  blk-mq: Fix a recently introduced regression in
    blk_mq_realloc_hw_ctxs()
  null_blk: Suppress an UBSAN complaint triggered when setting
    'memory_backed'
  null_blk: Fix changing the number of hardware queues
  null_blk: Fix the null_add_dev() error path
  null_blk: Handle null_add_dev() failures properly
  null_blk: Add support for init_hctx() fault injection

 block/blk-mq.c                |   8 ++-
 drivers/block/null_blk_main.c | 124 +++++++++++++++++++++++-----------
 include/linux/blk-mq.h        |   5 +-
 3 files changed, 96 insertions(+), 41 deletions(-)

