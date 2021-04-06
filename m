Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B05E0C433B4
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 21:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89EBA6120E
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 21:49:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232623AbhDFVt3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Apr 2021 17:49:29 -0400
Received: from mail-pl1-f180.google.com ([209.85.214.180]:34506 "EHLO
        mail-pl1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243161AbhDFVt1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Apr 2021 17:49:27 -0400
Received: by mail-pl1-f180.google.com with SMTP id a6so4938831pls.1
        for <linux-block@vger.kernel.org>; Tue, 06 Apr 2021 14:49:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ESEEdwJwAJytm9mSDnVfnLBhohmbk4CAX/QvKz8v7mU=;
        b=luhIDX4QOHX2T82kluJdYPVDcEOjpVCSuz4HtZyZ1nq1hhBpgdD10Mp32ksNxh+UVK
         XPf33gvBNmpbT+Dsepn2ecZVtN1FX8TEng3bhzUl3xVpilR6GjEPn4El+lc042jWxqr9
         5bSTrTdMrOLZfDhCNpasYRuqRW48YAybEiBQ9wVhjdgFXE9v7JGC1gcpib1w+3dgtMkS
         lMlDKK66dFes73YhxeuNhDXyan5AeENsj7J05xQ+RvoPH5YwZrITu8b8NElCBL7eUy4b
         cPj1f5wjpRVgUxpqs4jdypC53gdAMJuP92gumuSiyqTXhJ8t3gPqbAIxgQmwlpgnUmik
         JUcA==
X-Gm-Message-State: AOAM531m4fLvHCkfcvTIRW5FvcUx/qsJ0w4grsI7nqx3Cv7ogEsrQ9Dk
        tF2PTYiWfK8FQHylXV2GEnI=
X-Google-Smtp-Source: ABdhPJySFBxoFVeE/CBYL9O3mG+LfBSe+uPpUeBNbS1asF82HkoMKsx28JTmBSG3qZHXAPSNYT/OmQ==
X-Received: by 2002:a17:902:263:b029:e7:35d8:4554 with SMTP id 90-20020a1709020263b02900e735d84554mr242356plc.83.1617745757604;
        Tue, 06 Apr 2021 14:49:17 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:277d:764e:de23:a2e8])
        by smtp.gmail.com with ESMTPSA id my18sm2866062pjb.38.2021.04.06.14.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 14:49:17 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Khazhy Kumykov <khazhy@google.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v6 5/5] blk-mq: Fix races between blk_mq_update_nr_hw_queues() and iterating over tags
Date:   Tue,  6 Apr 2021 14:49:05 -0700
Message-Id: <20210406214905.21622-6-bvanassche@acm.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210406214905.21622-1-bvanassche@acm.org>
References: <20210406214905.21622-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Serialize the tag set modifications performed by blk_mq_update_nr_hw_queues()
and iterating over a tag set to prevent that iterating over a tag set crashes
due to a tag set being examined while it is being modified.

Reported-by: Khazhy Kumykov <khazhy@google.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: John Garry <john.garry@huawei.com>
Cc: Khazhy Kumykov <khazhy@google.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq-tag.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index a73e81d75fb8..bb2b9d412c41 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -376,6 +376,31 @@ void blk_mq_all_tag_iter_atomic(struct blk_mq_tags *tags, busy_tag_iter_fn *fn,
 	__blk_mq_all_tag_iter(tags, fn, priv, BT_TAG_ITER_STATIC_RQS);
 }
 
+/*
+ * Iterate over all request queues in a tag set, find the first queue with a
+ * non-zero usage count, increment its usage count and return the pointer to
+ * that request queue. This prevents that blk_mq_update_nr_hw_queues() will
+ * modify @set->nr_hw_queues while iterating over tags since
+ * blk_mq_update_nr_hw_queues() only modifies @set->nr_hw_queues while the
+ * usage count of all queues associated with a tag set is zero.
+ */
+static struct request_queue *
+blk_mq_get_any_tagset_queue(struct blk_mq_tag_set *set)
+{
+	struct request_queue *q;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(q, &set->tag_list, tag_set_list) {
+		if (percpu_ref_tryget(&q->q_usage_counter)) {
+			rcu_read_unlock();
+			return q;
+		}
+	}
+	rcu_read_unlock();
+
+	return NULL;
+}
+
 /**
  * blk_mq_tagset_busy_iter - iterate over all started requests in a tag set
  * @tagset:	Tag set to iterate over.
@@ -391,15 +416,22 @@ void blk_mq_all_tag_iter_atomic(struct blk_mq_tags *tags, busy_tag_iter_fn *fn,
 void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
 		busy_tag_iter_fn *fn, void *priv)
 {
+	struct request_queue *q;
 	int i;
 
 	might_sleep();
 
+	q = blk_mq_get_any_tagset_queue(tagset);
+	if (!q)
+		return;
+
 	for (i = 0; i < tagset->nr_hw_queues; i++) {
 		if (tagset->tags && tagset->tags[i])
 			__blk_mq_all_tag_iter(tagset->tags[i], fn, priv,
 				BT_TAG_ITER_STARTED | BT_TAG_ITER_MAY_SLEEP);
 	}
+
+	blk_queue_exit(q);
 }
 EXPORT_SYMBOL(blk_mq_tagset_busy_iter);
 
@@ -418,13 +450,20 @@ EXPORT_SYMBOL(blk_mq_tagset_busy_iter);
 void blk_mq_tagset_busy_iter_atomic(struct blk_mq_tag_set *tagset,
 		busy_tag_iter_fn *fn, void *priv)
 {
+	struct request_queue *q;
 	int i;
 
+	q = blk_mq_get_any_tagset_queue(tagset);
+	if (!q)
+		return;
+
 	for (i = 0; i < tagset->nr_hw_queues; i++) {
 		if (tagset->tags && tagset->tags[i])
 			__blk_mq_all_tag_iter(tagset->tags[i], fn, priv,
 					      BT_TAG_ITER_STARTED);
 	}
+
+	blk_queue_exit(q);
 }
 EXPORT_SYMBOL(blk_mq_tagset_busy_iter_atomic);
 
