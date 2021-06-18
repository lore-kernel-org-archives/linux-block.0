Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1347FC49361
	for <linux-block@archiver.kernel.org>; Fri, 18 Jun 2021 00:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5500613BD
	for <linux-block@archiver.kernel.org>; Fri, 18 Jun 2021 00:45:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233225AbhFRArQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Jun 2021 20:47:16 -0400
Received: from mail-pl1-f170.google.com ([209.85.214.170]:36396 "EHLO
        mail-pl1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232027AbhFRArQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Jun 2021 20:47:16 -0400
Received: by mail-pl1-f170.google.com with SMTP id x10so3819542plg.3
        for <linux-block@vger.kernel.org>; Thu, 17 Jun 2021 17:45:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B/JQqC8iFVFqngfeHIPJhakkt3ud5vF9Nk1WXj8QyWc=;
        b=EdxMRKR6xXwkLe7HtkbUShDM2bGRdkIt115OTwlgKjedGxLX+SA5GHpNPkcMb2uVnC
         GFjpp/JxAhOF9ik71hffsDYGAJiLY57tb1DMFDuxsMV64SOWS9jNVya871++WWNxagwl
         ic/8y8HaOsDAA5UwT94Gh1EQzUM+PoboCb3uiSWDwfyS70/96LHyT2iNzL5FkHM0Kusw
         02ag4q1SzceJjhRWS7a82KyOrmS3VQmrQwVgKtbHJz5cn7alLQN/9sVIP2G114oJzymZ
         TRmEbsOKhJACbnHSgGAKpLqhkMqfCg6pwnKm0Qhv8BBxbeSjyiNfwUryRYGScegmCvFD
         eUvQ==
X-Gm-Message-State: AOAM533fZABULKcN7EHEo5kcXDzDkS0DJApZg6QAf0nNW1NJPmnPNV4L
        jjHnl2z1wX4mlqSTCWQy9H0=
X-Google-Smtp-Source: ABdhPJxQ47GOLPtv+YTsLpb3qMz4zgYvqnp3roMEldS4tFzly0zsGI49/37rKOjFQhGm1tLsI407lQ==
X-Received: by 2002:a17:90a:17c6:: with SMTP id q64mr19508477pja.56.1623977106813;
        Thu, 17 Jun 2021 17:45:06 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id b10sm6215573pff.14.2021.06.17.17.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 17:45:06 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.de>, Tejun Heo <tj@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: [PATCH v3 02/16] block/blk-cgroup: Swap the blk_throtl_init() and blk_iolatency_init() calls
Date:   Thu, 17 Jun 2021 17:44:42 -0700
Message-Id: <20210618004456.7280-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618004456.7280-1-bvanassche@acm.org>
References: <20210618004456.7280-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Before adding more calls in this function, simplify the error path.

Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Cc: Tejun Heo <tj@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
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
