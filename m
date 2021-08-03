Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF19EC4338F
	for <linux-block@archiver.kernel.org>; Tue,  3 Aug 2021 18:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A769560F38
	for <linux-block@archiver.kernel.org>; Tue,  3 Aug 2021 18:23:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238471AbhHCSX1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Aug 2021 14:23:27 -0400
Received: from mail-pj1-f48.google.com ([209.85.216.48]:45886 "EHLO
        mail-pj1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238285AbhHCSX0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Aug 2021 14:23:26 -0400
Received: by mail-pj1-f48.google.com with SMTP id m10-20020a17090a34cab0290176b52c60ddso5933114pjf.4
        for <linux-block@vger.kernel.org>; Tue, 03 Aug 2021 11:23:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MedzByid45hPWlsWBY8HcRkcdGBJfhY+gJCqR53I97k=;
        b=XsYLxPXWErJ38Yhrnxv0vzdWhON/VMNQs90teW1AhTq+UDS7cwTq7FgwZqilueQ33X
         yDNLIk/6auYhDlHdc9QyzAlKgWbvsmpiXOqoMESvO+J3hhvZLggDvSMsVMcU5fJByo5i
         WDQhpB1hny+DwNTe9oD0ZZMFya6UJJfy4xC8gfEUQfm9Z07oZxF9WjvZvUsUnCzZvL7a
         APLKP9PtEEnhhuLSVYqvVKzFUSdXQ+bw0hFQsb6Z3OZ34BAorjKQc1QFxvXOb5HZu1ix
         94q0VQGsXGdLS6GAigWNRu+9YNoelzlw178+91RiwW5lHQICadVeUHic/tkyqEDkZk6Z
         wqvQ==
X-Gm-Message-State: AOAM5313xjFfZwy63126WrbEdSrJ1YN+mw+tLly8hUkWpe+6Ehup1qjx
        QAcPkguZEguFNRrsjegMAYs=
X-Google-Smtp-Source: ABdhPJybELZLOhdlydJHksJFcZ9hR80GQEi2rPrCRhSwL9ghhsRatHcAgNofLzh0bi3X9XV3kmGfKA==
X-Received: by 2002:a63:e0c:: with SMTP id d12mr1131046pgl.386.1628014995299;
        Tue, 03 Aug 2021 11:23:15 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:1:f630:1578:90bf:ff92])
        by smtp.gmail.com with ESMTPSA id ms8sm3476279pjb.36.2021.08.03.11.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 11:23:14 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Martijn Coenen <maco@android.com>
Subject: [PATCH v2 2/3] loop: Select I/O scheduler 'none' from inside add_disk()
Date:   Tue,  3 Aug 2021 11:23:03 -0700
Message-Id: <20210803182304.365053-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
In-Reply-To: <20210803182304.365053-1-bvanassche@acm.org>
References: <20210803182304.365053-1-bvanassche@acm.org>
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

This patch reduces the Android boot time on my test setup with 0.5 seconds
compared to configuring the loop I/O scheduler from user space.

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
