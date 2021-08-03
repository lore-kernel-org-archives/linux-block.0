Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F01AC432BE
	for <linux-block@archiver.kernel.org>; Tue,  3 Aug 2021 00:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12FBC60F36
	for <linux-block@archiver.kernel.org>; Tue,  3 Aug 2021 00:02:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbhHCACW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 2 Aug 2021 20:02:22 -0400
Received: from mail-pj1-f45.google.com ([209.85.216.45]:52019 "EHLO
        mail-pj1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbhHCACV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 2 Aug 2021 20:02:21 -0400
Received: by mail-pj1-f45.google.com with SMTP id mt6so27453947pjb.1
        for <linux-block@vger.kernel.org>; Mon, 02 Aug 2021 17:02:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5VClwSe2etPXE/OSrx9J4imLXZEz3r6MKLZhHcSuv8c=;
        b=QYQQDNA+LZwp1Ct6xTSqxglWbtGzKI0HOy9uOKftmLbg1i/v6NZIpxKmDjR16cYiXf
         kK1Bjw4xnpiqDnr1EGD4AmGefWt1XGom3/0Xn0Iqf1WHtxlelZ+6gj4HwPiiEUmFZ6X4
         nyagbS8zROAr5bV+kLqWqiJU2SFcFSex3jZQeZiECi7io79KwSLKCtkjqAPI8ifj3fg8
         T9TUqqzU7FW/mKwY9sATN/aMjB21L5FY7FkR4F44VCcSqT+P9Pv/ZiWYaBrHnsuwPrCA
         mgw/jeOaXl8my48frjycV2IxuqGXSjRQD4ieuB6Mw2AdVDW88idEIFyWUrsdyC7K2tLY
         DwoQ==
X-Gm-Message-State: AOAM531QSD5jGNLQP1Lqz8sXfNn5cagwSJfIqtHrqGM8RmyRKDYyrJly
        BEXX/Te98MM+KhE6Wgil1a4=
X-Google-Smtp-Source: ABdhPJyEpYXgCKmbRuKgfHhtW3pBlWjwea9zJ16YPkknUiTzRWPbWGiUz99b74LbMQAfHYOqL7My3w==
X-Received: by 2002:a17:90a:f002:: with SMTP id bt2mr20363349pjb.142.1627948930701;
        Mon, 02 Aug 2021 17:02:10 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:1:bca4:545f:af00:8cbe])
        by smtp.gmail.com with ESMTPSA id s7sm12712988pfk.12.2021.08.02.17.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 17:02:10 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Martijn Coenen <maco@android.com>
Subject: [PATCH 1/2] loop: Prevent that an I/O scheduler is assigned
Date:   Mon,  2 Aug 2021 17:01:59 -0700
Message-Id: <20210803000200.4125318-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
In-Reply-To: <20210803000200.4125318-1-bvanassche@acm.org>
References: <20210803000200.4125318-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Loop devices have a single hardware queue. Hence, the block layer function
elevator_get_default() selects the mq-deadline scheduler for loop devices.
Using the mq-deadline scheduler or any other I/O scheduler for loop devices
incurs unnecessary overhead. Make the loop driver pass the flag
BLK_MQ_F_NOSCHED to the block layer core such that no I/O scheduler can be
associated with block devices. This approach has an advantage compared to
letting udevd change the loop I/O scheduler to none, namely that
synchronize_rcu() does not get called.

It is intentional that the flag BLK_MQ_F_SHOULD_MERGE is preserved.

This patch reduces the Android boot time on my test setup with 0.5 seconds.

Cc: Ming Lei <ming.lei@redhat.com>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Martijn Coenen <maco@android.com>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/loop.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index f8486d9b75a4..9fca3ab3988d 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -2333,7 +2333,8 @@ static int loop_add(int i)
 	lo->tag_set.queue_depth = 128;
 	lo->tag_set.numa_node = NUMA_NO_NODE;
 	lo->tag_set.cmd_size = sizeof(struct loop_cmd);
-	lo->tag_set.flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_STACKING;
+	lo->tag_set.flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_STACKING |
+		BLK_MQ_F_NO_SCHED;
 	lo->tag_set.driver_data = lo;
 
 	err = blk_mq_alloc_tag_set(&lo->tag_set);
