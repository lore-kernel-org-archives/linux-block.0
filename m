Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A2AC433EF
	for <linux-block@archiver.kernel.org>; Fri, 17 Jun 2022 20:44:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233622AbiFQUoj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Jun 2022 16:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232380AbiFQUoi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Jun 2022 16:44:38 -0400
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D8DEE006
        for <linux-block@vger.kernel.org>; Fri, 17 Jun 2022 13:44:38 -0700 (PDT)
Received: by mail-pj1-f42.google.com with SMTP id mh16-20020a17090b4ad000b001e8313301f1so7842930pjb.1
        for <linux-block@vger.kernel.org>; Fri, 17 Jun 2022 13:44:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s3LCzo9+Xp7IujTzn/HYA2MWpND56eY4jQGiRDoWqqM=;
        b=IPSga4JS5Oc+mUKzd0OcrPSFrOtJ9hCQobod3+uz48VvyKnzCzgjzgWYCFyQkj7eEI
         y/6wo6taFdonI265KU5UNJFPQGhlaH9exjaz476abMJT9SaX2jYWU5f5fVcqmN/ULkz9
         KLr9myF8ZDeNWp2OkEZaZ4iYR/4bFZhUSQQ6YcnbuMN1hQLMesV1CXnclXiel1tvEy2F
         djYVVUw0snPPZfm3zKBGPD7xKb0TJVyT6uxWMwXlN/yyK0WL5QfoAtTUWhydAiqQjbok
         zkmuRKcmQV/L1SsmG46l9J1UwHyj94RkEBEZfki8jptrdzf+YjhGXeZxsVq9asttGN/k
         ODuA==
X-Gm-Message-State: AJIora8kCQ/EvHODjCcAje3edE+SaYKFutxmFjRbXbGHitZBafXm4b03
        xmD6SDvCteEE91mTxjo3u2BWHAlFjMw=
X-Google-Smtp-Source: AGRyM1ue5jNGu8q2J3xzUIIe14eafwgyllST03JkBvYVKVndl1K2GvsPg9ZL0gvp2Cz0EVC3Mknzqw==
X-Received: by 2002:a17:90b:1c8f:b0:1b8:c6dc:ca61 with SMTP id oo15-20020a17090b1c8f00b001b8c6dcca61mr12577073pjb.13.1655498677410;
        Fri, 17 Jun 2022 13:44:37 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:49d9:1d0f:f325:18fe])
        by smtp.gmail.com with ESMTPSA id u11-20020a170902e80b00b0016a0858b25dsm1652462plg.152.2022.06.17.13.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 13:44:36 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH] block: bfq: Remove an unused function definition
Date:   Fri, 17 Jun 2022 13:44:33 -0700
Message-Id: <20220617204433.102022-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch is the result of the analysis of a sparse report.

Cc: Jan Kara <jack@suse.cz>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/bfq-cgroup.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 09574af83566..dc0fa93219df 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -1471,8 +1471,6 @@ struct bfq_group *bfqq_group(struct bfq_queue *bfqq)
 	return bfqq->bfqd->root_group;
 }
 
-void bfqg_and_blkg_get(struct bfq_group *bfqg) {}
-
 void bfqg_and_blkg_put(struct bfq_group *bfqg) {}
 
 struct bfq_group *bfq_create_group_hierarchy(struct bfq_data *bfqd, int node)
