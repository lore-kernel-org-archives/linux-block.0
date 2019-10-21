Return-Path: <SRS0=zBYI=YO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11899CA9EB9
	for <linux-block@archiver.kernel.org>; Mon, 21 Oct 2019 22:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E20472089C
	for <linux-block@archiver.kernel.org>; Mon, 21 Oct 2019 22:43:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730304AbfJUWnM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Oct 2019 18:43:12 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36666 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730276AbfJUWnM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Oct 2019 18:43:12 -0400
Received: by mail-pg1-f196.google.com with SMTP id 23so8691395pgk.3
        for <linux-block@vger.kernel.org>; Mon, 21 Oct 2019 15:43:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iOoP7x/uL+UUHCxeNCIbvREN3P8PxzS++rPEUCMI99Y=;
        b=svL8YXRlZqezJW+5Y9EcUjUEtjhMWkKkjGWm+djFS7dSxcR1gx4ifWzgfjchdUCZFw
         T8dX1upQyAF/i+32mRLmcL2f99Vh8v1Bw8C11qk5+QH3oHMfXjTXGv0pxU9e8y3HGMtn
         Fjgchd51JbEOnIwRrHnU2KbLDc+iQeqPIJJ5toLu5z+PatBupsVFMs33mWQTkl7bteVL
         85Zni7UJW9cNyPbGLDezvDCQKpu2Qdex46IIMCtF1sR+TQeoBhtm8wTCyTTY2+WEvXT7
         ETsXSscGgFgWyopNYr8Dqli/kCVxpNIsNbLmRs0PbhOhQseXjcvd9VZdvFmU9n3H3EaC
         UY4g==
X-Gm-Message-State: APjAAAWEBWj5cZ4lZfRa2GUDHnTRW779ubSPvz8xBD6j4gzVhN29FXkA
        3P3rOMcYhcuqHJX3CPsso4U=
X-Google-Smtp-Source: APXvYqwQRGWb+OqJe7jCcakOTl3eEkkVGbc9EUy5zBl7hNywwtca0rOWaH+N2U9U+Yy1bdtgU17gOg==
X-Received: by 2002:a63:934d:: with SMTP id w13mr231433pgm.185.1571697791320;
        Mon, 21 Oct 2019 15:43:11 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id u9sm15944763pjb.4.2019.10.21.15.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 15:43:10 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 4/4] block: Reduce the amount of memory used for tag sets
Date:   Mon, 21 Oct 2019 15:42:59 -0700
Message-Id: <20191021224259.209542-5-bvanassche@acm.org>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
In-Reply-To: <20191021224259.209542-1-bvanassche@acm.org>
References: <20191021224259.209542-1-bvanassche@acm.org>
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
index 86f6852130fc..1279db579fa2 100644
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
2.23.0.866.gb869b98d4c-goog

