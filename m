Return-Path: <SRS0=9W5b=XZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 123F8C32792
	for <linux-block@archiver.kernel.org>; Mon, 30 Sep 2019 23:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCFA52053B
	for <linux-block@archiver.kernel.org>; Mon, 30 Sep 2019 23:00:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfI3XA4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Sep 2019 19:00:56 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39272 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbfI3XA4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Sep 2019 19:00:56 -0400
Received: by mail-pl1-f196.google.com with SMTP id s17so4480763plp.6
        for <linux-block@vger.kernel.org>; Mon, 30 Sep 2019 16:00:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zOeHvHzlaJVIkRlVy98J9tAJWyEto/bKHnX1FHcTsAg=;
        b=SilhoLpq2qpSQoo83kyuAc7G4pxPhuPewKcVYSOTSWlkuVdQkki80dd7DceKBJiXKz
         Tvl3mr/zJMzqfVjrBbMotiBIZ3vBNEcFmb1+hwMtCpJeGGF8gu8Whvms6XPmx4me9Ps2
         1pBJhoRvs4iM8e4ZIUHzSbaXFEez4d80X94Z5mM2JZRC7n5evuYhwNBN28dmjZNsWIGx
         Ru1d34ZLQEVOPuAgyHB4RZ8nMhBZHxDFFY29Q7e45m30IOMed6B9yJp5KmgHbcW5nwol
         ziS1zZfYwgPdkT0TmyTcFJPdUFh0UcNOMYSBW1Bm56CNi3nLWWNEHHzd8OrfcThJ6sKU
         Q46A==
X-Gm-Message-State: APjAAAW8Ao2O4UYvSAcCVS68MXbwSssxGxRgfRZDA5Gd3YSjdNiss8r5
        2HPqhAbAVpQF2aqK7v9HmllYbc1r
X-Google-Smtp-Source: APXvYqyzL+RUqtvyZHT48XND+jtEz5lM47Omph+QPmvymPTkw9ckO+RvsqcjMyWpaHgOfdLRSSpYEg==
X-Received: by 2002:a17:902:5983:: with SMTP id p3mr23208682pli.156.1569884455367;
        Mon, 30 Sep 2019 16:00:55 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id 74sm15071747pfy.78.2019.09.30.16.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 16:00:54 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 0/8] Block layer patches for kernel v5.5
Date:   Mon, 30 Sep 2019 16:00:39 -0700
Message-Id: <20190930230047.44113-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.23.0.444.g18eeb5a265-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

This patch series includes the patches I prepared for kernel v5.5. Please
consider these patches for inclusion in the upstream kernel.

Thanks,

Bart.

Bart Van Assche (8):
  block: Fix three kernel-doc warnings
  block: Fix writeback throttling W=1 compiler warnings
  block: Remove request_queue.nr_queues
  block: Remove "dying" checks from sysfs callbacks
  block: Reduce sysfs_lock locking inside blk_cleanup_queue()
  block: Document all members of blk_mq_tag_set and bkl_mq_queue_map
  null_blk: Improve nullb_device_##NAME##_store() readability
  null_blk: Enable modifying 'submit_queues' after an instance has been
    configured

 block/blk-core.c              |  4 +-
 block/blk-mq-sysfs.c          | 16 ++-----
 block/blk-mq.c                |  6 +--
 block/blk-sysfs.c             |  8 ----
 block/t10-pi.c                |  8 +---
 drivers/block/null_blk_main.c | 78 +++++++++++++++++++++++------------
 include/linux/blk-mq.h        | 54 +++++++++++++++++++-----
 include/linux/blkdev.h        |  1 -
 include/trace/events/wbt.h    | 12 ++++--
 9 files changed, 114 insertions(+), 73 deletions(-)


