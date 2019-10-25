Return-Path: <SRS0=ZVtD=YS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A94CA9EBC
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 16:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09DC521D81
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 16:50:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409600AbfJYQuh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Oct 2019 12:50:37 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44106 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440697AbfJYQuW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Oct 2019 12:50:22 -0400
Received: by mail-pl1-f195.google.com with SMTP id q16so1277413pll.11
        for <linux-block@vger.kernel.org>; Fri, 25 Oct 2019 09:50:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R6y7GYeP0zUmbxzTjL5a6O2gfkXfcoR6unQQzw6yRVc=;
        b=U6/FHT0c3LRpKFkP58764nBCcMpRh77Purnvu1NJSiGfWlsUzG4leXErEAQD2bEkVz
         XjwyONf0CphA1B96MXIUXm1u/JPZyKByue6DjyVRZh3WYFosbzcCDvvPM4UFlIgaB8xz
         VcvzRaara067+d1TbqrlfCNF6vUG7hpuHVH18k8helWliHgXm8EJHB1hjfnqZAhRzmxx
         XflYw73HK+jUDT3Pp3+ySSX4u8FYLXqUUnL1mWa8t9f05KQEIl+5oMI/Et1E66TAkgIl
         /ndlJcTk5B0S3wxwB6Gkhn4H6xesqTUdBiJdabIf/GRjYMAT/GtjF0Orx+8jtYuJDN7w
         eyUw==
X-Gm-Message-State: APjAAAXYvd07Gb9mNNYTo64l/QNpPnCYjmy8u4933UbMgq5mTAnDDugL
        xmQ4Am6BW2MZGpWZ0F3UH94=
X-Google-Smtp-Source: APXvYqzLhozGHH0NFkxTf+fwwMg2TnoelXwhRxp3Fkt0kkm+HqIevKjCD7NH/WLcHxZco+i+Ga6Xrg==
X-Received: by 2002:a17:902:a581:: with SMTP id az1mr4801891plb.311.1572022221364;
        Fri, 25 Oct 2019 09:50:21 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id c8sm4088158pfi.117.2019.10.25.09.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 09:50:20 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH v2 2/3] block: Reduce the amount of memory required per request queue
Date:   Fri, 25 Oct 2019 09:50:09 -0700
Message-Id: <20191025165010.211462-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
In-Reply-To: <20191025165010.211462-1-bvanassche@acm.org>
References: <20191025165010.211462-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Instead of always allocating at least nr_cpu_ids hardware queues per request
queue, reallocate q->queue_hw_ctx if it has to grow. This patch improves
behavior that was introduced by commit 868f2f0b7206 ("blk-mq: dynamic h/w
context count").

Cc: Keith Busch <keith.busch@intel.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 7528678ef41f..ba09cda49953 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2761,6 +2761,23 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 	int i, j, end;
 	struct blk_mq_hw_ctx **hctxs = q->queue_hw_ctx;
 
+	if (q->nr_hw_queues < set->nr_hw_queues) {
+		struct blk_mq_hw_ctx **new_hctxs;
+
+		new_hctxs = kcalloc_node(set->nr_hw_queues,
+				       sizeof(*new_hctxs), GFP_KERNEL,
+				       set->numa_node);
+		if (!new_hctxs)
+			return;
+		if (hctxs)
+			memcpy(new_hctxs, hctxs, q->nr_hw_queues *
+			       sizeof(*hctxs));
+		q->queue_hw_ctx = new_hctxs;
+		q->nr_hw_queues = set->nr_hw_queues;
+		kfree(hctxs);
+		hctxs = new_hctxs;
+	}
+
 	/* protect against switching io scheduler  */
 	mutex_lock(&q->sysfs_lock);
 	for (i = 0; i < set->nr_hw_queues; i++) {
@@ -2848,12 +2865,6 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	/* init q->mq_kobj and sw queues' kobjects */
 	blk_mq_sysfs_init(q);
 
-	q->queue_hw_ctx = kcalloc_node(nr_hw_queues(set),
-				       sizeof(*(q->queue_hw_ctx)), GFP_KERNEL,
-				       set->numa_node);
-	if (!q->queue_hw_ctx)
-		goto err_sys_init;
-
 	INIT_LIST_HEAD(&q->unused_hctx_list);
 	spin_lock_init(&q->unused_hctx_lock);
 
@@ -2901,7 +2912,6 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 err_hctxs:
 	kfree(q->queue_hw_ctx);
 	q->nr_hw_queues = 0;
-err_sys_init:
 	blk_mq_sysfs_deinit(q);
 err_poll:
 	blk_stat_free_callback(q->poll_cb);
-- 
2.24.0.rc0.303.g954a862665-goog

