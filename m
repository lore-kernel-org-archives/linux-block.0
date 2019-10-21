Return-Path: <SRS0=zBYI=YO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9954ECA9EAF
	for <linux-block@archiver.kernel.org>; Mon, 21 Oct 2019 22:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76EAB20882
	for <linux-block@archiver.kernel.org>; Mon, 21 Oct 2019 22:43:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730289AbfJUWnL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Oct 2019 18:43:11 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42783 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbfJUWnK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Oct 2019 18:43:10 -0400
Received: by mail-pf1-f196.google.com with SMTP id q12so9324929pff.9
        for <linux-block@vger.kernel.org>; Mon, 21 Oct 2019 15:43:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f8rxoisaPFhyyWWqrkbV3n8HS8qyHhu9JwL53xw7tZ8=;
        b=DJC7rKhe5cKlid2pHsA78xFB1l9hHrbkXDqi44kqmnygJZrWRMi9BI6KRwKVBPoIvf
         k2WenRTD7hYfABCayftuzBaXcz6TP7MARG1OnJP5QN4oea8kkv35BDH9SS0DdBo7ZLUz
         7Sk66kNl0gOzwJBX5MhIM53t2W+J1wKat6NJ17+iWJ3GXvFbbjpXVvw9LjiO3LvGc3pc
         PANdMh+U+K4ojv0kEsWU5ijXPkb9igZLQdQdsjGNXYk3QA/wlu2TPptESzWyQ4d8GWKu
         71gYIv3+U+tM5OWzjc2Dea9lr2XsryXvHx7hCEgYbOSGV4ZwOQeu1Qs93sEU8SUpavjV
         nP0w==
X-Gm-Message-State: APjAAAXFB2+Q4VN3h0SLzSTIQsTUCRwseR1jH9a1h2D5+iPRy4QwYp/y
        8rZBRPk5BMBD6AGIwuQoKgLEME66rtA=
X-Google-Smtp-Source: APXvYqw53SLMCtaUJknOG0dec3io/QHQpVFf/7V63NydWBZgM4yVY6scnM00zdouriE+50L57E0vcQ==
X-Received: by 2002:a17:90a:17ad:: with SMTP id q42mr634276pja.100.1571697790211;
        Mon, 21 Oct 2019 15:43:10 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id u9sm15944763pjb.4.2019.10.21.15.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 15:43:09 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 3/4] block: Reduce the amount of memory required per request queue
Date:   Mon, 21 Oct 2019 15:42:58 -0700
Message-Id: <20191021224259.209542-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
In-Reply-To: <20191021224259.209542-1-bvanassche@acm.org>
References: <20191021224259.209542-1-bvanassche@acm.org>
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
index ea64d951f411..86f6852130fc 100644
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
2.23.0.866.gb869b98d4c-goog

