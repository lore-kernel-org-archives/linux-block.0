Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1046FC4338F
	for <linux-block@archiver.kernel.org>; Tue,  3 Aug 2021 18:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7EE860EE8
	for <linux-block@archiver.kernel.org>; Tue,  3 Aug 2021 18:23:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238501AbhHCSX3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Aug 2021 14:23:29 -0400
Received: from mail-pj1-f47.google.com ([209.85.216.47]:37699 "EHLO
        mail-pj1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238486AbhHCSX2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Aug 2021 14:23:28 -0400
Received: by mail-pj1-f47.google.com with SMTP id dw2-20020a17090b0942b0290177cb475142so5114901pjb.2
        for <linux-block@vger.kernel.org>; Tue, 03 Aug 2021 11:23:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nL6bvEt5vlGnQxMjKGf+lIWLnGMZ6Pd7pjQssOksqoA=;
        b=GQJAeaUOvUmgjkPnqKWYGEQ4vjvMswOz2iyX13JQdf175tK8W8R+Llk/ryi0QJglhf
         o+upxcci8T9pnTbf5IvSIMzqJBGp9Y3L8ZTMfNpPjzYlF/TnPk//R6lbEsJSSoMgOkFD
         Wr5nmXKWCJdlyJcyijqg0zUo/MkjPEuj/oQURgSpG5IBy5IuGjaNN9QbhVdmuWbgsleP
         sS0woQ0DPralz/dmyckdC8xXfTEgLFD7Ojhpf2pCnskDN/gkSofEt0SMswgNwXs1962n
         0U3MJ2pnM6GULSVc35JLAOVMUSXrJQKLKrk30dWFrPjFr0ACKou5rfCVwlMM+8+Y3jhv
         QmBA==
X-Gm-Message-State: AOAM531U4xlK5AFQu7xBUdLxw2iHjJoRp/2PbN3jDou7ig6OJnOdPV6w
        1+3gM/uunVGOFAL7gZ+nuFzJxySJb4iivLQf
X-Google-Smtp-Source: ABdhPJy8ZeGKG57yL9KAa6H/Iiu8VV7M6xOOmU0QN39tnGn3yxM5KM3FVGICbiIyE1EPSkfkn8U1lg==
X-Received: by 2002:a17:902:a9c6:b029:129:8fdb:698f with SMTP id b6-20020a170902a9c6b02901298fdb698fmr19476017plr.15.1628014996678;
        Tue, 03 Aug 2021 11:23:16 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:1:f630:1578:90bf:ff92])
        by smtp.gmail.com with ESMTPSA id ms8sm3476279pjb.36.2021.08.03.11.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 11:23:16 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Martijn Coenen <maco@android.com>
Subject: [PATCH v2 3/3] loop: Add the default_queue_depth kernel module parameter
Date:   Tue,  3 Aug 2021 11:23:04 -0700
Message-Id: <20210803182304.365053-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
In-Reply-To: <20210803182304.365053-1-bvanassche@acm.org>
References: <20210803182304.365053-1-bvanassche@acm.org>
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

Reviewed-by: Ming Lei <ming.lei@redhat.com>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Martijn Coenen <maco@android.com>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/loop.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index fa1c298a8cfb..b5dbf2d7447e 100644
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
