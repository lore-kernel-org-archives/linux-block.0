Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC0DC48BC2
	for <linux-block@archiver.kernel.org>; Sun, 27 Jun 2021 21:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9FA46199B
	for <linux-block@archiver.kernel.org>; Sun, 27 Jun 2021 21:11:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbhF0VNo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 27 Jun 2021 17:13:44 -0400
Received: from mail-pf1-f171.google.com ([209.85.210.171]:39610 "EHLO
        mail-pf1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbhF0VNn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 27 Jun 2021 17:13:43 -0400
Received: by mail-pf1-f171.google.com with SMTP id g192so12363853pfb.6
        for <linux-block@vger.kernel.org>; Sun, 27 Jun 2021 14:11:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ar3J8bLcBmQVY4JvybZrVxdWsrvVW7zt2iHF3YckoKk=;
        b=FG3GxveOKgwjuI6+VelWJaQndN9F539nJQouFH46IAdk0Kfwo4pf7KtBrpJU0surX4
         FGmhllzxegrgztfrbsBu051hBxVUIRFH5dYiwGmoL2U+bMCMyvMMXH8BDwaRUD1GiUWB
         bwA3yyg7J5+LqQCNV4fbel76Q4VItKBPdF46ajZ/HoJ4o+bw5yhzJpVD4dHCzwJWiwjA
         Nm8dgvCqbYtutbhElCB7S5UAzedUO7Qq8TEtUKI3YiVwAvcMWG8/Yv0FxlGHQcckOLFX
         P9E5bDohlPG0kR3eJl3iwq8VXwcXoQv31+IInwsWvAAzqE/ogCom9FmE9J/3HBROpD9U
         sq8A==
X-Gm-Message-State: AOAM531XonUFl4eo6I7KyeHEDSxRS/C9BYvlaw6m9FLTD5dJ34nkIGCJ
        xFy8A6cRzJgccXQD7QM9wPQ=
X-Google-Smtp-Source: ABdhPJwbMsPm/MGlVPk71+AN1Wk5aWZzjPCECopuAp7nP1P0A/GO1pZzcwGkauq7Pg9TkxOWWYow2A==
X-Received: by 2002:a05:6a00:2184:b029:300:8e27:14fa with SMTP id h4-20020a056a002184b02903008e2714famr21618109pfi.8.1624828278869;
        Sun, 27 Jun 2021 14:11:18 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id i27sm11528126pgl.78.2021.06.27.14.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jun 2021 14:11:17 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Sachin Sant <sachinp@linux.vnet.ibm.com>
Subject: [PATCH] block/mq-deadline: Remove a WARN_ON_ONCE() call
Date:   Sun, 27 Jun 2021 14:11:12 -0700
Message-Id: <20210627211112.12720-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The purpose of the WARN_ON_ONCE() statement in dd_insert_request() is to
verify that dd_prepare_request() cleared rq->elv.priv[0]. Since
dd_prepare_request() is called during request initialization but not if a
request is requeued, a warning is triggered if a request is requeued. Fix
this by removing the WARN_ON_ONCE() statement. This patch suppresses the
following kernel warning:

WARNING: CPU: 28 PID: 432 at block/mq-deadline-main.c:740 dd_insert_request+0x4d4/0x5b0
Workqueue: kblockd blk_mq_requeue_work
Call Trace:
 dd_insert_requests+0xfa/0x130
 blk_mq_sched_insert_request+0x22c/0x240
 blk_mq_requeue_work+0x21c/0x2d0
 process_one_work+0x4c2/0xa70
 worker_thread+0x2e5/0x6d0
 kthread+0x21c/0x250
 ret_from_fork+0x1f/0x30

Reported-by: Sachin Sant <sachinp@linux.vnet.ibm.com>
Fixes: 08a9ad8bf607 ("block/mq-deadline: Add cgroup support")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/mq-deadline-main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/mq-deadline-main.c b/block/mq-deadline-main.c
index 9db6da9ef4c6..6f612e6dc82b 100644
--- a/block/mq-deadline-main.c
+++ b/block/mq-deadline-main.c
@@ -740,7 +740,6 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 	dd_count(dd, inserted, prio);
 	blkcg = dd_blkcg_from_bio(rq->bio);
 	ddcg_count(blkcg, inserted, ioprio_class);
-	WARN_ON_ONCE(rq->elv.priv[0]);
 	rq->elv.priv[0] = blkcg;
 
 	if (blk_mq_sched_try_insert_merge(q, rq, &free)) {
