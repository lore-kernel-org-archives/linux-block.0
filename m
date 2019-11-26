Return-Path: <SRS0=BQu2=ZS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A55C43215
	for <linux-block@archiver.kernel.org>; Tue, 26 Nov 2019 17:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE55B20684
	for <linux-block@archiver.kernel.org>; Tue, 26 Nov 2019 17:57:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbfKZR5L (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Nov 2019 12:57:11 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:45003 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbfKZR5L (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Nov 2019 12:57:11 -0500
Received: by mail-pj1-f68.google.com with SMTP id w8so8620759pjh.11
        for <linux-block@vger.kernel.org>; Tue, 26 Nov 2019 09:57:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6sYX/PuzZ4W11V+bVaVB6YqBrthJITB36bhwtzYqCfs=;
        b=Vp2J4rlSwSNf6ERqmFO79UDoWjrpxfFSjbZSZFUxb3YQsX/mO2dy7anOataAwF/ZWJ
         NwAGk0DOuZB3vk0Je5qeLL+LchAMU/zPrQWeKsZygf0mfIIjeUZHCioF3xOgfteSF13v
         xQ8hsdzEmB7WkblqgRMqXMhJ7h+wjtG9KdvBO0fg3sL1smZVhfUBYMY8GVWP+67wQZFY
         xpPS3bsF3u7Vl1yJaALuS8HO8ObJUK/sjsZLRczS6Hk+vtHbEjGDn51uZxLJYyF/0/+A
         mqVpQatqn9UCnw5pcWL0gXElXMS4BUMa4sy0X2lWo8hQHnIRCDvbW9R6UxmDtz2AvacK
         YuBg==
X-Gm-Message-State: APjAAAV+cDEoQnH4AUctjhcnAFvs9IXxbRKsfBilsPonC8trCRci6LdF
        kFY9lyxCxFQv062t863IGehOrSOH
X-Google-Smtp-Source: APXvYqwAdK3aCN1wCdtVq0MtB1PeDVcZsNUpCP8HuLehn2x3QRFpHHYrm49HbKp07az6EmgpUT9J2g==
X-Received: by 2002:a17:90a:a616:: with SMTP id c22mr429274pjq.46.1574791029692;
        Tue, 26 Nov 2019 09:57:09 -0800 (PST)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id 82sm13178715pfa.115.2019.11.26.09.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 09:57:08 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 3/3] block: Add support for sharing tags across hardware queues
Date:   Tue, 26 Nov 2019 09:56:56 -0800
Message-Id: <20191126175656.67638-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
In-Reply-To: <20191126175656.67638-1-bvanassche@acm.org>
References: <20191126175656.67638-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add a boolean member 'share_tags' in struct blk_mq_tag_set. If that member
variable is set, make all hctx->tags[] pointers identical. Implement the
necessary changes in the functions that allocate, free and resize tag sets.
Modify blk_mq_tagset_busy_iter() such that it continues to call the
callback function once per request. Modify blk_mq_queue_tag_busy_iter()
such that the callback function is only called with the correct hctx
as first argument. Modify the debugfs code such that it keeps showing only
matching tags per hctx.

This patch has been tested by running blktests on top of a kernel that
includes the following change to enable shared tags for all block drivers
except the NVMe drivers:

diff --git a/block/blk-mq.c b/block/blk-mq.c
@@ -3037,6 +3037,10 @@ int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set)

        BUILD_BUG_ON(BLK_MQ_MAX_DEPTH > 1 << BLK_MQ_UNIQUE_TAG_BITS);

+       /* Test code: enable tag sharing for all block drivers except NVMe */
+       if (!set->ops->poll)
+               set->share_tags = true;
+
        if (!set->nr_hw_queues)
                return -EINVAL;
        if (!set->queue_depth)

Cc: Christoph Hellwig <hch@infradead.org>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: John Garry <john.garry@huawei.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq-debugfs.c | 40 ++++++++++++++++++++++++++++++++++++++--
 block/blk-mq-tag.c     |  7 +++++--
 block/blk-mq.c         | 28 +++++++++++++++++++++-------
 include/linux/blk-mq.h |  8 ++++++--
 4 files changed, 70 insertions(+), 13 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 3678e95ec947..653e80ede3bd 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -472,20 +472,56 @@ static int hctx_tags_show(void *data, struct seq_file *m)
 	return res;
 }
 
+struct hctx_sb_data {
+	struct sbitmap		*sb;	/* output bitmap */
+	struct blk_mq_hw_ctx	*hctx;	/* input hctx */
+};
+
+static bool hctx_filter_fn(struct blk_mq_hw_ctx *hctx, struct request *req,
+			   void *priv, bool reserved)
+{
+	struct hctx_sb_data *hctx_sb_data = priv;
+
+	if (hctx == hctx_sb_data->hctx)
+		sbitmap_set_bit(hctx_sb_data->sb, req->tag);
+	return true;
+}
+
+static void hctx_filter_sb(struct sbitmap *sb, struct blk_mq_hw_ctx *hctx)
+{
+	struct hctx_sb_data hctx_sb_data = { .sb = sb, .hctx = hctx };
+
+	blk_mq_queue_tag_busy_iter(hctx->queue, hctx_filter_fn, &hctx_sb_data);
+}
+
 static int hctx_tags_bitmap_show(void *data, struct seq_file *m)
 {
 	struct blk_mq_hw_ctx *hctx = data;
 	struct request_queue *q = hctx->queue;
+	struct sbitmap sb, *hctx_sb;
 	int res;
 
+	if (!hctx->tags)
+		return 0;
+	hctx_sb = &hctx->tags->bitmap_tags.sb;
+	res = sbitmap_init_node(&sb, hctx_sb->depth, hctx_sb->shift, GFP_KERNEL,
+				NUMA_NO_NODE);
+	if (res)
+		return res;
+
 	res = mutex_lock_interruptible(&q->sysfs_lock);
 	if (res)
 		goto out;
-	if (hctx->tags)
-		sbitmap_bitmap_show(&hctx->tags->bitmap_tags.sb, m);
+	/*
+	 * If tags are shared across hardware queues, hctx_sb contains tags
+	 * for multiple hardware queues. Filter the tags for 'hctx' into 'sb'.
+	 */
+	hctx_filter_sb(&sb, hctx);
 	mutex_unlock(&q->sysfs_lock);
+	sbitmap_bitmap_show(&sb, m);
 
 out:
+	sbitmap_free(&sb);
 	return res;
 }
 
diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index a60e1b4a8158..770fe2324230 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -220,7 +220,7 @@ static bool bt_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
 	 * We can hit rq == NULL here, because the tagging functions
 	 * test and set the bit before assigning ->rqs[].
 	 */
-	if (rq && rq->q == hctx->queue)
+	if (rq && rq->q == hctx->queue && rq->mq_hctx == hctx)
 		return iter_data->fn(hctx, rq, iter_data->data, reserved);
 	return true;
 }
@@ -341,8 +341,11 @@ void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
 	int i;
 
 	for (i = 0; i < tagset->nr_hw_queues; i++) {
-		if (tagset->tags && tagset->tags[i])
+		if (tagset->tags && tagset->tags[i]) {
 			blk_mq_all_tag_busy_iter(tagset->tags[i], fn, priv);
+			if (tagset->share_tags)
+				break;
+		}
 	}
 }
 EXPORT_SYMBOL(blk_mq_tagset_busy_iter);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index fec4b82ff91c..fa4cfc4b7e7c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2404,6 +2404,12 @@ static bool __blk_mq_alloc_rq_map(struct blk_mq_tag_set *set, int hctx_idx)
 {
 	int ret = 0;
 
+	if (hctx_idx > 0 && set->share_tags) {
+		WARN_ON_ONCE(!set->tags[0]);
+		set->tags[hctx_idx] = set->tags[0];
+		return 0;
+	}
+
 	set->tags[hctx_idx] = blk_mq_alloc_rq_map(set, hctx_idx,
 					set->queue_depth, set->reserved_tags);
 	if (!set->tags[hctx_idx])
@@ -2423,8 +2429,10 @@ static void blk_mq_free_map_and_requests(struct blk_mq_tag_set *set,
 					 unsigned int hctx_idx)
 {
 	if (set->tags && set->tags[hctx_idx]) {
-		blk_mq_free_rqs(set, set->tags[hctx_idx], hctx_idx);
-		blk_mq_free_rq_map(set->tags[hctx_idx]);
+		if (hctx_idx == 0 || !set->share_tags) {
+			blk_mq_free_rqs(set, set->tags[hctx_idx], hctx_idx);
+			blk_mq_free_rq_map(set->tags[hctx_idx]);
+		}
 		set->tags[hctx_idx] = NULL;
 	}
 }
@@ -2568,7 +2576,7 @@ static void blk_mq_del_queue_tag_set(struct request_queue *q)
 
 	mutex_lock(&set->tag_list_lock);
 	list_del_rcu(&q->tag_set_list);
-	if (list_is_singular(&set->tag_list)) {
+	if (list_is_singular(&set->tag_list) && !set->share_tags) {
 		/* just transitioned to unshared */
 		set->flags &= ~BLK_MQ_F_TAG_SHARED;
 		/* update existing queue */
@@ -2586,7 +2594,7 @@ static void blk_mq_add_queue_tag_set(struct blk_mq_tag_set *set,
 	/*
 	 * Check to see if we're transitioning to shared (from 1 to 2 queues).
 	 */
-	if (!list_empty(&set->tag_list) &&
+	if ((!list_empty(&set->tag_list) || set->share_tags) &&
 	    !(set->flags & BLK_MQ_F_TAG_SHARED)) {
 		set->flags |= BLK_MQ_F_TAG_SHARED;
 		/* update existing queue */
@@ -2911,15 +2919,21 @@ static int __blk_mq_alloc_rq_maps(struct blk_mq_tag_set *set)
 {
 	int i;
 
-	for (i = 0; i < set->nr_hw_queues; i++)
-		if (!__blk_mq_alloc_rq_map(set, i))
+	for (i = 0; i < set->nr_hw_queues; i++) {
+		if (i > 0 && set->share_tags) {
+			set->tags[i] = set->tags[0];
+		} else if (!__blk_mq_alloc_rq_map(set, i))
 			goto out_unwind;
+	}
 
 	return 0;
 
 out_unwind:
-	while (--i >= 0)
+	while (--i >= 0) {
+		if (i > 0 && set->share_tags)
+			continue;
 		blk_mq_free_rq_map(set->tags[i]);
+	}
 
 	return -ENOMEM;
 }
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 522631d108af..dd5517476314 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -224,10 +224,13 @@ enum hctx_type {
  * @numa_node:	   NUMA node the storage adapter has been connected to.
  * @timeout:	   Request processing timeout in jiffies.
  * @flags:	   Zero or more BLK_MQ_F_* flags.
+ * @share_tags:	   Whether or not to share one tag set across hardware queues.
  * @driver_data:   Pointer to data owned by the block driver that created this
  *		   tag set.
- * @tags:	   Tag sets. One tag set per hardware queue. Has @nr_hw_queues
- *		   elements.
+ * @tags:	   Array of tag set pointers. Has @nr_hw_queues elements. If
+ *		   share_tags has not been set, all tag set pointers are
+ *		   different. If share_tags has been set, all tag_set pointers
+ *		   are identical.
  * @tag_list_lock: Serializes tag_list accesses.
  * @tag_list:	   List of the request queues that use this tag set. See also
  *		   request_queue.tag_set_list.
@@ -243,6 +246,7 @@ struct blk_mq_tag_set {
 	int			numa_node;
 	unsigned int		timeout;
 	unsigned int		flags;
+	bool			share_tags;
 	void			*driver_data;
 
 	struct blk_mq_tags	**tags;
