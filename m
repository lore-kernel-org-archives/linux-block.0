Return-Path: <SRS0=RDeE=T7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 326C4C28CC0
	for <linux-block@archiver.kernel.org>; Fri, 31 May 2019 02:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0940E25F06
	for <linux-block@archiver.kernel.org>; Fri, 31 May 2019 02:28:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbfEaC2c (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 May 2019 22:28:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34834 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726372AbfEaC2c (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 May 2019 22:28:32 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6118E3083392;
        Fri, 31 May 2019 02:28:31 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BA8EE60CAD;
        Fri, 31 May 2019 02:28:27 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        John Garry <john.garry@huawei.com>,
        Don Brace <don.brace@microsemi.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 1/9] blk-mq: allow hw queues to share hostwide tags
Date:   Fri, 31 May 2019 10:27:53 +0800
Message-Id: <20190531022801.10003-2-ming.lei@redhat.com>
In-Reply-To: <20190531022801.10003-1-ming.lei@redhat.com>
References: <20190531022801.10003-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Fri, 31 May 2019 02:28:31 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Some SCSI HBAs(such as HPSA, megaraid, mpt3sas, hisi_sas_v3 ..) support
multiple reply queues with single hostwide tags, and the reply queue
is used for delievery & complete request, and one MSI-X vector is
assigned to each reply queue.

Now drivers have switched to use pci_alloc_irq_vectors(PCI_IRQ_AFFINITY)
for automatic affinity assignment. Given there is only single blk-mq hw
queue, these drivers have to setup private reply queue mapping for
figuring out which reply queue is selected for delivery request, and
the queue mapping is based on managed IRQ affinity, and it is generic,
should have been done inside blk-mq.

Based on the following Hannes's patch, introduce BLK_MQ_F_HOST_TAGS for
converting reply queue into blk-mq hw queue.

	https://marc.info/?l=linux-block&m=149132580511346&w=2

Once driver sets BLK_MQ_F_HOST_TAGS, the hostwide tags & request pool is
shared among all blk-mq hw queues.

The following patches will map driver's reply queue into blk-mq hw queue
by applying BLK_MQ_F_HOST_TAGS.

Compared with the current implementation by single hw queue, performance
shouldn't be affected by this patch in theory.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-debugfs.c |  1 +
 block/blk-mq-sched.c   |  8 ++++++++
 block/blk-mq-tag.c     |  6 ++++++
 block/blk-mq.c         | 14 ++++++++++++++
 block/elevator.c       |  5 +++--
 include/linux/blk-mq.h |  1 +
 6 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 6aea0ebc3a73..3d6780504dcb 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -237,6 +237,7 @@ static const char *const alloc_policy_name[] = {
 static const char *const hctx_flag_name[] = {
 	HCTX_FLAG_NAME(SHOULD_MERGE),
 	HCTX_FLAG_NAME(TAG_SHARED),
+	HCTX_FLAG_NAME(HOST_TAGS),
 	HCTX_FLAG_NAME(BLOCKING),
 	HCTX_FLAG_NAME(NO_SCHED),
 };
diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 74c6bb871f7e..3a4d9ad63e7b 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -449,6 +449,9 @@ static void blk_mq_sched_free_tags(struct blk_mq_tag_set *set,
 				   struct blk_mq_hw_ctx *hctx,
 				   unsigned int hctx_idx)
 {
+	if ((set->flags & BLK_MQ_F_HOST_TAGS) && hctx_idx)
+		return;
+
 	if (hctx->sched_tags) {
 		blk_mq_free_rqs(set, hctx->sched_tags, hctx_idx);
 		blk_mq_free_rq_map(hctx->sched_tags);
@@ -463,6 +466,11 @@ static int blk_mq_sched_alloc_tags(struct request_queue *q,
 	struct blk_mq_tag_set *set = q->tag_set;
 	int ret;
 
+	if ((set->flags & BLK_MQ_F_HOST_TAGS) && hctx_idx) {
+		hctx->sched_tags = q->queue_hw_ctx[0]->sched_tags;
+		return 0;
+	}
+
 	hctx->sched_tags = blk_mq_alloc_rq_map(set, hctx_idx, q->nr_requests,
 					       set->reserved_tags);
 	if (!hctx->sched_tags)
diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 7513c8eaabee..309ec5079f3f 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -358,6 +358,9 @@ void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
 	for (i = 0; i < tagset->nr_hw_queues; i++) {
 		if (tagset->tags && tagset->tags[i])
 			blk_mq_all_tag_busy_iter(tagset->tags[i], fn, priv);
+
+		if (tagset->flags & BLK_MQ_F_HOST_TAGS)
+			break;
 	}
 }
 EXPORT_SYMBOL(blk_mq_tagset_busy_iter);
@@ -405,6 +408,9 @@ void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
 		if (tags->nr_reserved_tags)
 			bt_for_each(hctx, &tags->breserved_tags, fn, priv, true);
 		bt_for_each(hctx, &tags->bitmap_tags, fn, priv, false);
+
+		if (hctx->flags & BLK_MQ_F_HOST_TAGS)
+			break;
 	}
 	blk_queue_exit(q);
 }
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 32b8ad3d341b..49d73d979cb3 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2433,6 +2433,11 @@ static bool __blk_mq_alloc_rq_map(struct blk_mq_tag_set *set, int hctx_idx)
 {
 	int ret = 0;
 
+	if ((set->flags & BLK_MQ_F_HOST_TAGS) && hctx_idx) {
+		set->tags[hctx_idx] = set->tags[0];
+		return true;
+	}
+
 	set->tags[hctx_idx] = blk_mq_alloc_rq_map(set, hctx_idx,
 					set->queue_depth, set->reserved_tags);
 	if (!set->tags[hctx_idx])
@@ -2451,6 +2456,9 @@ static bool __blk_mq_alloc_rq_map(struct blk_mq_tag_set *set, int hctx_idx)
 static void blk_mq_free_map_and_requests(struct blk_mq_tag_set *set,
 					 unsigned int hctx_idx)
 {
+	if ((set->flags & BLK_MQ_F_HOST_TAGS) && hctx_idx)
+		return;
+
 	if (set->tags && set->tags[hctx_idx]) {
 		blk_mq_free_rqs(set, set->tags[hctx_idx], hctx_idx);
 		blk_mq_free_rq_map(set->tags[hctx_idx]);
@@ -3166,6 +3174,12 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
 		}
 		if (ret)
 			break;
+
+		if (set->flags & BLK_MQ_F_HOST_TAGS)
+			break;
+	}
+
+	queue_for_each_hw_ctx(q, hctx, i) {
 		if (q->elevator && q->elevator->type->ops.depth_updated)
 			q->elevator->type->ops.depth_updated(hctx);
 	}
diff --git a/block/elevator.c b/block/elevator.c
index ec55d5fc0b3e..ed553d9bc53e 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -596,7 +596,8 @@ int elevator_switch_mq(struct request_queue *q,
 
 /*
  * For blk-mq devices, we default to using mq-deadline, if available, for single
- * queue devices.  If deadline isn't available OR we have multiple queues,
+ * queue devices or multiple queue device with hostwide tags.  If deadline isn't
+ * available OR we have multiple queues,
  * default to "none".
  */
 int elevator_init_mq(struct request_queue *q)
@@ -604,7 +605,7 @@ int elevator_init_mq(struct request_queue *q)
 	struct elevator_type *e;
 	int err = 0;
 
-	if (q->nr_hw_queues != 1)
+	if (q->nr_hw_queues != 1 && !(q->tag_set->flags & BLK_MQ_F_HOST_TAGS))
 		return 0;
 
 	/*
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 15d1aa53d96c..b4e33b509229 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -219,6 +219,7 @@ struct blk_mq_ops {
 enum {
 	BLK_MQ_F_SHOULD_MERGE	= 1 << 0,
 	BLK_MQ_F_TAG_SHARED	= 1 << 1,
+	BLK_MQ_F_HOST_TAGS	= 1 << 2,
 	BLK_MQ_F_BLOCKING	= 1 << 5,
 	BLK_MQ_F_NO_SCHED	= 1 << 6,
 	BLK_MQ_F_ALLOC_POLICY_START_BIT = 8,
-- 
2.20.1

