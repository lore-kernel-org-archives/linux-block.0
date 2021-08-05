Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 744FEC4320A
	for <linux-block@archiver.kernel.org>; Thu,  5 Aug 2021 17:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D4116112F
	for <linux-block@archiver.kernel.org>; Thu,  5 Aug 2021 17:42:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbhHERmZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Aug 2021 13:42:25 -0400
Received: from mail-pj1-f50.google.com ([209.85.216.50]:35835 "EHLO
        mail-pj1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232441AbhHERmZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 5 Aug 2021 13:42:25 -0400
Received: by mail-pj1-f50.google.com with SMTP id s22-20020a17090a1c16b0290177caeba067so16695405pjs.0
        for <linux-block@vger.kernel.org>; Thu, 05 Aug 2021 10:42:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lLWNU9TyS6kZiUYgcinRCx8/FTMFK+wMonF0fm+iApE=;
        b=IsblKbWz/oZHIEX/84BbOcLrLJ4otC928Qq5RnltYv47cX4n4U4xq39Sf/YAeFL7i/
         dT1cH4U26HWVYdCI4xiWQm4Tqrb/i2FCBs0wj9aWSB2rw7y2DbjhV5RbeMi9C4CnMS3O
         cZEcPzW4imzAr1xR5F+aL5Pu0XdJ9+Oxkpcg8t+0zhUL3xndMwT7mjJo7Qjh/Ls/1vPv
         N9tvgczBtJDpcfmQidqaQ5ooD90ltd9icIX/YEjchbxbzts+ymIxg8P+5MR7i2yOUS54
         tWNOpEdmINDeIZdV1Ui7rKsy3KhrJSmC18xlSZaNnrwSdx/nD0yIYAufD0HeO/QvXYsp
         2UpA==
X-Gm-Message-State: AOAM533ewNElAykP9o8oJUQUgGYIzwJBYp8qR9DXVUq5Ddhbrw1ThMNN
        JuMveUEBqEEhF9EyfUifCZw=
X-Google-Smtp-Source: ABdhPJzZueCBzQ/9LX9afv7Ll0BXDmUDq+nUQyPBSGS8pq7fDml8RKfKxIHfUgs0cii14YxiCkByQQ==
X-Received: by 2002:a63:5619:: with SMTP id k25mr288555pgb.92.1628185330880;
        Thu, 05 Aug 2021 10:42:10 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:1:93c2:eaf5:530d:627d])
        by smtp.gmail.com with ESMTPSA id m11sm10381834pjn.2.2021.08.05.10.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 10:42:10 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Martijn Coenen <maco@android.com>
Subject: [PATCH v3 2/2] loop: Select I/O scheduler 'none' from inside add_disk()
Date:   Thu,  5 Aug 2021 10:42:00 -0700
Message-Id: <20210805174200.3250718-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
In-Reply-To: <20210805174200.3250718-1-bvanassche@acm.org>
References: <20210805174200.3250718-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We noticed that the user interface of Android devices becomes very slow
under memory pressure. This is because Android uses the zram driver on top
of the loop driver for swapping, because under memory pressure the swap
code alternates reads and writes quickly, because mq-deadline is the
default scheduler for loop devices and because mq-deadline delays writes by
five seconds for such a workload with default settings. Fix this by making
the kernel select I/O scheduler 'none' from inside add_disk() for loop
devices. This default can be overridden at any time from user space,
e.g. via a udev rule. This approach has an advantage compared to changing
the I/O scheduler from userspace from 'mq-deadline' into 'none', namely
that synchronize_rcu() does not get called.

This patch changes the default I/O scheduler for loop devices from
'mq-deadline' into 'none'.

Additionally, this patch reduces the Android boot time on my test setup
with 0.5 seconds compared to configuring the loop I/O scheduler from user
space.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Martijn Coenen <maco@android.com>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/loop.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index f8486d9b75a4..fa1c298a8cfb 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -2333,7 +2333,8 @@ static int loop_add(int i)
 	lo->tag_set.queue_depth = 128;
 	lo->tag_set.numa_node = NUMA_NO_NODE;
 	lo->tag_set.cmd_size = sizeof(struct loop_cmd);
-	lo->tag_set.flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_STACKING;
+	lo->tag_set.flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_STACKING |
+		BLK_MQ_F_NO_SCHED_BY_DEFAULT;
 	lo->tag_set.driver_data = lo;
 
 	err = blk_mq_alloc_tag_set(&lo->tag_set);
