Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 323B1C43461
	for <linux-block@archiver.kernel.org>; Wed, 21 Apr 2021 00:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 068186141C
	for <linux-block@archiver.kernel.org>; Wed, 21 Apr 2021 00:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234359AbhDUADX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Apr 2021 20:03:23 -0400
Received: from mail-pf1-f179.google.com ([209.85.210.179]:44727 "EHLO
        mail-pf1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234482AbhDUADX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Apr 2021 20:03:23 -0400
Received: by mail-pf1-f179.google.com with SMTP id m11so26925449pfc.11
        for <linux-block@vger.kernel.org>; Tue, 20 Apr 2021 17:02:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=prTDGgcjhAdE1so8UkKaPIj7GZ7j1PwKMzFJXTRVK/o=;
        b=fbCgGottZuMzDoMw4IxwRh/ZLo1fdU5qQ7+gtOTGLEGX4kZC7hECsngbUAiabq+UTO
         5oznJ82T/CnD4eYME13CUh2opf/5j+7qRc3AvV0NREvG53cKsoV+KADJtHbEWmNHD5Gq
         6InmD9MA1ICzBtiKkYWQckjexUHUV/00Lj/WyH28/IwrMy3dvC2wMEKJ6uKck//Wja1m
         YZxHxMvwkp5z1FVKmSPb9HLk9M11uqbbqrsMRw1INAvY8WOG0QsIRMwDPcSXTwSu2l6w
         P3rNWBVfwRY0FwVvlIC7AlVTA6W+MEwJbNBCyZBS9hsaauBKx7V5n1Rx0Cixu+ZhZvp6
         mBAA==
X-Gm-Message-State: AOAM5317xEswwMm6yJ+8u/iC6lLY9+IMFKbMEor1cgh7hL5C9t/BlvYV
        54bfFc3IwPlVyVUH0ocz2Hg=
X-Google-Smtp-Source: ABdhPJz/XGMN6I7BAdH4EoM4t2QWzEbI2ifvKmqCws4dvT6wHHmCGzwTyO6LklAiT/myK3O11/9stA==
X-Received: by 2002:a62:2b03:0:b029:241:d147:2a79 with SMTP id r3-20020a622b030000b0290241d1472a79mr26904757pfr.53.1618963369827;
        Tue, 20 Apr 2021 17:02:49 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:6cb:4566:9005:c2af])
        by smtp.gmail.com with ESMTPSA id 33sm149560pgq.21.2021.04.20.17.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 17:02:49 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Daniel Wagner <dwagner@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Khazhy Kumykov <khazhy@google.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v7 5/5] blk-mq: Fix races between blk_mq_update_nr_hw_queues() and iterating over tags
Date:   Tue, 20 Apr 2021 17:02:35 -0700
Message-Id: <20210421000235.2028-6-bvanassche@acm.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421000235.2028-1-bvanassche@acm.org>
References: <20210421000235.2028-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Serialize the tag set modifications performed by blk_mq_update_nr_hw_queues()
and iterating over a tag set to prevent that iterating over a tag set crashes
due to a tag set being examined while it is being modified.

Reported-by: Khazhy Kumykov <khazhy@google.com>
Reviewed-by: Khazhismel Kumykov <khazhy@google.com>
Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
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
index 39d5c9190a6b..b0e0f074a864 100644
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
 
