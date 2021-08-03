Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 831D9C4338F
	for <linux-block@archiver.kernel.org>; Tue,  3 Aug 2021 00:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6514160F36
	for <linux-block@archiver.kernel.org>; Tue,  3 Aug 2021 00:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232514AbhHCACX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 2 Aug 2021 20:02:23 -0400
Received: from mail-pl1-f171.google.com ([209.85.214.171]:34675 "EHLO
        mail-pl1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbhHCACX (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 2 Aug 2021 20:02:23 -0400
Received: by mail-pl1-f171.google.com with SMTP id d1so21626007pll.1
        for <linux-block@vger.kernel.org>; Mon, 02 Aug 2021 17:02:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qzq6NpQbMmEj7irKL65stYr9Dv2fD9PXCXXUb41F9xw=;
        b=S4TMGdIoW0tG6Bzcs1RvCrCF/cXM0WRN8w3vipVrNRVFYAGfKYAh9ocy0+bNoh7g7K
         Z85AjlgTTyeumEst2JMs9fxyo6ZIgnBvjTAJMM31ZfpPZl6QCu6QHWvvVm9zsT1ESQSz
         YXsvY2VSK3ogOVk2zt76Siyf2pHEPhuveYTOKz6X2zo38vGysebRc8O8VA/FaP/tYPJG
         BO6ZCpQatZDnlt29gqQ5LXqje5BPyWGQNS2B2aQ5KhATFtUljiRt1MRdGQnILgy+HixP
         9Tx/TbFh0hlmV9CtAzaZ7yANmF1oCVzahN/TJR+MFfF6VYTzHk0xN1Ambx4LR9I9T89U
         it3Q==
X-Gm-Message-State: AOAM5334wVHWPs/VoM7n1Zk8blkmsL9BTj2zWx48qvMwTo+gk62Lbj/9
        bM2HGZX5nWC1pVWs6vlA/+c=
X-Google-Smtp-Source: ABdhPJxUrdF/91hdqwelq/RQRYb52ioy49Usg0J2j5H4X8zYJKqjxTKUbHWvPnJIVwwdC+2n6nShbA==
X-Received: by 2002:a63:4a49:: with SMTP id j9mr31960pgl.20.1627948932061;
        Mon, 02 Aug 2021 17:02:12 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:1:bca4:545f:af00:8cbe])
        by smtp.gmail.com with ESMTPSA id s7sm12712988pfk.12.2021.08.02.17.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 17:02:11 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Martijn Coenen <maco@android.com>
Subject: [PATCH 2/2] loop: Add the default_queue_depth kernel module parameter
Date:   Mon,  2 Aug 2021 17:02:00 -0700
Message-Id: <20210803000200.4125318-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
In-Reply-To: <20210803000200.4125318-1-bvanassche@acm.org>
References: <20210803000200.4125318-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Recent versions of Android use the zram driver on top of the loop driver.
There is a mismatch between the default loop driver queue depth (128) and
the queue depth of the storage device in my test setup (32). That mismatch
results in write latencies that are higher than necessary. Address this
issue by making the default loop driver queue depth configurable. Compared
to configuring the queue depth by writing into the nr_requests sysfs
attribute, this approach does not involve calling synchronize_rcu() to
modify the queue depth.

Cc: Ming Lei <ming.lei@redhat.com>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Martijn Coenen <maco@android.com>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/loop.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 9fca3ab3988d..0f1f1ecd941a 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -2098,6 +2098,9 @@ module_param(max_loop, int, 0444);
 MODULE_PARM_DESC(max_loop, "Maximum number of loop devices");
 module_param(max_part, int, 0444);
 MODULE_PARM_DESC(max_part, "Maximum number of partitions per loop device");
+static uint32_t default_queue_depth = 128;
+module_param(default_queue_depth, uint, 0644);
+MODULE_PARM_DESC(default_queue_depth, "Default loop device queue depth");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_BLOCKDEV_MAJOR(LOOP_MAJOR);
 
@@ -2330,7 +2333,7 @@ static int loop_add(int i)
 	err = -ENOMEM;
 	lo->tag_set.ops = &loop_mq_ops;
 	lo->tag_set.nr_hw_queues = 1;
-	lo->tag_set.queue_depth = 128;
+	lo->tag_set.queue_depth = max(default_queue_depth, 2U);
 	lo->tag_set.numa_node = NUMA_NO_NODE;
 	lo->tag_set.cmd_size = sizeof(struct loop_cmd);
 	lo->tag_set.flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_STACKING |
