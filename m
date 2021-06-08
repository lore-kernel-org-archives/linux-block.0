Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 501B7C47082
	for <linux-block@archiver.kernel.org>; Tue,  8 Jun 2021 23:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30B9A61361
	for <linux-block@archiver.kernel.org>; Tue,  8 Jun 2021 23:07:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234060AbhFHXJR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Jun 2021 19:09:17 -0400
Received: from mail-pg1-f169.google.com ([209.85.215.169]:34575 "EHLO
        mail-pg1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233927AbhFHXJQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Jun 2021 19:09:16 -0400
Received: by mail-pg1-f169.google.com with SMTP id l1so17826199pgm.1
        for <linux-block@vger.kernel.org>; Tue, 08 Jun 2021 16:07:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4qLgR9vvJmrAZEerRG4VFRoyx7aAeQCali5c03o+eYw=;
        b=KS0BcRHNUEpduW00BC/Fs1LJxtKiW4i5xDoyoWWSIr5SPSReunxqWKdOcnX7lY+IU2
         i8JAgUxea5+/h9KGPycEy6Mzn+aurOR7sKSAch4DEc0TAg2SW5L6sv4Z+mrTqhu9/XBt
         yzyIFMEdR/Se7/34Ptlk3p62cNUFLkIxswm43rjRASTqTvhq69HvXHEJ8yDm4ETG2efz
         nSiSgDQJutACS4Y04oeQheUod/pFspc3yX6rKRz52wUNHmJyXjy+ybFSUGZZ8xEiIHgs
         HW8SrBULdz2gtjCf1SXEgf/rqHh2CYZKLJuxVZfBvH+l6Wjr/INPQVEAh3hbGc5hTXqg
         4JdQ==
X-Gm-Message-State: AOAM531at2pXOmsumpc/+ssX2X7V5MLX5TGUeV0UBA2gFmCeHX9X/nuV
        V4a9k4jHV85AkHC12JSQ/k0=
X-Google-Smtp-Source: ABdhPJz//lQjT8Ia79YujdTPyd1bi87zHCr/FOF0pYKNEcOGAhO1WDkNqB+SUkGG7uFEtdqeMCSXTQ==
X-Received: by 2002:aa7:8c02:0:b029:2e9:c513:1e10 with SMTP id c2-20020aa78c020000b02902e9c5131e10mr2133250pfd.2.1623193633977;
        Tue, 08 Jun 2021 16:07:13 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id s21sm11395838pfw.57.2021.06.08.16.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 16:07:13 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Tejun Heo <tj@kernel.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: [PATCH 02/14] block/blk-cgroup: Swap the blk_throtl_init() and blk_iolatency_init() calls
Date:   Tue,  8 Jun 2021 16:06:51 -0700
Message-Id: <20210608230703.19510-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210608230703.19510-1-bvanassche@acm.org>
References: <20210608230703.19510-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Before adding more calls in this function, simplify the error path.

Cc: Tejun Heo <tj@kernel.org>
Cc: Damien Le Moal <damien.lemoal@wdc.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-cgroup.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index d169e2055158..3b0f6efaa2b6 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1183,15 +1183,14 @@ int blkcg_init_queue(struct request_queue *q)
 	if (preloaded)
 		radix_tree_preload_end();
 
-	ret = blk_throtl_init(q);
+	ret = blk_iolatency_init(q);
 	if (ret)
 		goto err_destroy_all;
 
-	ret = blk_iolatency_init(q);
-	if (ret) {
-		blk_throtl_exit(q);
+	ret = blk_throtl_init(q);
+	if (ret)
 		goto err_destroy_all;
-	}
+
 	return 0;
 
 err_destroy_all:
