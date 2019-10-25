Return-Path: <SRS0=ZVtD=YS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A19CA9EBD
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 16:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB8682053B
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 16:50:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409519AbfJYQuc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Oct 2019 12:50:32 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34325 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440789AbfJYQuX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Oct 2019 12:50:23 -0400
Received: by mail-pf1-f195.google.com with SMTP id b128so1958685pfa.1
        for <linux-block@vger.kernel.org>; Fri, 25 Oct 2019 09:50:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CU0k9qROSs1SMECH5+HOGD2NHrqwUXVzrsyMYyRmrwk=;
        b=e/4jHcxBkrWMKyCQysBzsL1IYNbABmTvAcXCQUxKFDT9QMJyvOMPtJKa0xo1PGpTIj
         Kfcu6EAjIhhe6l09X5kkzO7b8ANvLUxFUPrSyj+Kdoa9u0otKInaTay9QB7lr5e1FvqX
         LOe00aZA4CU7iuqEdaz7P1fCUSmMD9ftMTVkQ/ZNlfC5aUfEseDsppzpKo5m2wnLEVDj
         5D6xBbPPClPxajpixMtiK9Awca9Kbv4GyEJEe3KB4e1OGvVt0M8SFUXTGaPNa0drHTh+
         eVCozkv/GxC/gNYHWNJWUtbQ8s7TcOs/z9bqkbWnuguguxCh7eTURYAfjp91szMa31om
         yOWw==
X-Gm-Message-State: APjAAAXo+fr/Xo9bOLxZzWSdbqJODro6JR2xYXt+tsh2kJErQ2Xpwtmr
        /+XfcOWfLRiJUDKV3Nh/BMI=
X-Google-Smtp-Source: APXvYqz8hQoUcMKExVT6fSqCyp43/UBP4sTyOcmuT14wy6Y9Ktkx8vlkDISQ5RWwWp6QTRkwm7UG/g==
X-Received: by 2002:a17:90b:153:: with SMTP id em19mr5390374pjb.22.1572022222551;
        Fri, 25 Oct 2019 09:50:22 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id c8sm4088158pfi.117.2019.10.25.09.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 09:50:21 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH v2 3/3] block: Reduce the amount of memory used for tag sets
Date:   Fri, 25 Oct 2019 09:50:10 -0700
Message-Id: <20191025165010.211462-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
In-Reply-To: <20191025165010.211462-1-bvanassche@acm.org>
References: <20191025165010.211462-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Instead of allocating an array of size nr_cpu_ids for set->tags, allocate
an array of size set->nr_hw_queues. This patch improves behavior that was
introduced by commit 868f2f0b7206 ("blk-mq: dynamic h/w context count").

Reallocating tag sets from inside __blk_mq_update_nr_hw_queues() is safe
because:
- All request queues that share the tag sets are frozen before the tag sets
  are reallocated.
- blk_mq_queue_tag_busy_iter() holds q->q_usage_counter while active and
  hence is serialized against __blk_mq_update_nr_hw_queues().

Cc: Keith Busch <keith.busch@intel.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq.c | 47 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 30 insertions(+), 17 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index ba09cda49953..df41b2d16261 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2833,19 +2833,6 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 	mutex_unlock(&q->sysfs_lock);
 }
 
-/*
- * Maximum number of hardware queues we support. For single sets, we'll never
- * have more than the CPUs (software queues). For multiple sets, the tag_set
- * user may have set ->nr_hw_queues larger.
- */
-static unsigned int nr_hw_queues(struct blk_mq_tag_set *set)
-{
-	if (set->nr_maps == 1)
-		return nr_cpu_ids;
-
-	return max(set->nr_hw_queues, nr_cpu_ids);
-}
-
 struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 						  struct request_queue *q,
 						  bool elevator_init)
@@ -3012,6 +2999,29 @@ static int blk_mq_update_queue_map(struct blk_mq_tag_set *set)
 	}
 }
 
+static int blk_mq_realloc_tag_set_tags(struct blk_mq_tag_set *set,
+				  int cur_nr_hw_queues, int new_nr_hw_queues)
+{
+	struct blk_mq_tags **new_tags;
+
+	if (cur_nr_hw_queues >= new_nr_hw_queues)
+		return 0;
+
+	new_tags = kcalloc_node(new_nr_hw_queues, sizeof(struct blk_mq_tags *),
+				GFP_KERNEL, set->numa_node);
+	if (!new_tags)
+		return -ENOMEM;
+
+	if (set->tags)
+		memcpy(new_tags, set->tags, cur_nr_hw_queues *
+		       sizeof(*set->tags));
+	kfree(set->tags);
+	set->tags = new_tags;
+	set->nr_hw_queues = new_nr_hw_queues;
+
+	return 0;
+}
+
 /*
  * Alloc a tag set to be associated with one or more request queues.
  * May fail with EINVAL for various error conditions. May adjust the
@@ -3065,9 +3075,7 @@ int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set)
 	if (set->nr_maps == 1 && set->nr_hw_queues > nr_cpu_ids)
 		set->nr_hw_queues = nr_cpu_ids;
 
-	set->tags = kcalloc_node(nr_hw_queues(set), sizeof(struct blk_mq_tags *),
-				 GFP_KERNEL, set->numa_node);
-	if (!set->tags)
+	if (blk_mq_realloc_tag_set_tags(set, 0, set->nr_hw_queues) < 0)
 		return -ENOMEM;
 
 	ret = -ENOMEM;
@@ -3108,7 +3116,7 @@ void blk_mq_free_tag_set(struct blk_mq_tag_set *set)
 {
 	int i, j;
 
-	for (i = 0; i < nr_hw_queues(set); i++)
+	for (i = 0; i < set->nr_hw_queues; i++)
 		blk_mq_free_map_and_requests(set, i);
 
 	for (j = 0; j < set->nr_maps; j++) {
@@ -3266,6 +3274,10 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 		blk_mq_sysfs_unregister(q);
 	}
 
+	if (blk_mq_realloc_tag_set_tags(set, set->nr_hw_queues, nr_hw_queues) <
+	    0)
+		goto reregister;
+
 	prev_nr_hw_queues = set->nr_hw_queues;
 	set->nr_hw_queues = nr_hw_queues;
 	blk_mq_update_queue_map(set);
@@ -3282,6 +3294,7 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 		blk_mq_map_swqueue(q);
 	}
 
+reregister:
 	list_for_each_entry(q, &set->tag_list, tag_set_list) {
 		blk_mq_sysfs_register(q);
 		blk_mq_debugfs_register_hctxs(q);
-- 
2.24.0.rc0.303.g954a862665-goog

