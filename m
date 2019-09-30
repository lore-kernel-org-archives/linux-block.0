Return-Path: <SRS0=9W5b=XZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE7F3C35280
	for <linux-block@archiver.kernel.org>; Mon, 30 Sep 2019 23:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD4A12081B
	for <linux-block@archiver.kernel.org>; Mon, 30 Sep 2019 23:01:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbfI3XBE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Sep 2019 19:01:04 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41084 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbfI3XBE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Sep 2019 19:01:04 -0400
Received: by mail-pg1-f193.google.com with SMTP id s1so8208032pgv.8
        for <linux-block@vger.kernel.org>; Mon, 30 Sep 2019 16:01:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gmFkOESs1LB3Zda4bDleeNTmC8QYNSpewjw/YIoHv9Y=;
        b=cKG2rmC/IdrT3FX7XiK872tyADCutYr4cEh9+XN5NPEDDTYtQKSnKqKCQvKvcJyBm8
         w4sA3CJ40cxOQkfAK/dQEkNJmQN3ERHqvwgfM6AAfJNRkMppAgnzN46eFRd2yVwX0wDG
         jf7NXoe2q4dozAA2LcXq9qWcwhBHhyGduPEBLyYTnOTEMvQB3aiXq88BrOEHYKEvkzIx
         u6sUon2G+GMUcodq4F07VVz0t5Xgs7yHj7evpGVPOFbbWcSkIes+5OAWIBQupVAvRkwc
         PXqzCEW9TWuUBsh3jqYegRCg7XWmdBDPLo9/s58ftTG/TeS77XRFG0BVYRW4du6tw1i4
         2epg==
X-Gm-Message-State: APjAAAXfbJ+XKM+SxOK00o9lP9dIZrsGgz7CGfbaM8Us6nngZCWETOjo
        s4ngH1UmVfFRyy2TwI06K8g=
X-Google-Smtp-Source: APXvYqzeW9yK1lmCI680SbQePVNZVFed55CSJ0hgAY4O152Bmp1wDELG2LE3/QYVOPNGix6PTFRz4w==
X-Received: by 2002:a62:1888:: with SMTP id 130mr24423832pfy.72.1569884463254;
        Mon, 30 Sep 2019 16:01:03 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id 74sm15071747pfy.78.2019.09.30.16.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 16:01:02 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 6/8] block: Document all members of blk_mq_tag_set and bkl_mq_queue_map
Date:   Mon, 30 Sep 2019 16:00:45 -0700
Message-Id: <20190930230047.44113-7-bvanassche@acm.org>
X-Mailer: git-send-email 2.23.0.444.g18eeb5a265-goog
In-Reply-To: <20190930230047.44113-1-bvanassche@acm.org>
References: <20190930230047.44113-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The meaning of several member variables of these two data structures is
nontrivial. Hence document all member variables using the kernel-doc
syntax.

Cc: Christoph Hellwig <hch@infradead.org>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 include/linux/blk-mq.h | 54 +++++++++++++++++++++++++++++++++---------
 1 file changed, 43 insertions(+), 11 deletions(-)

diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 0bf056de5cc3..a96b5cc957ab 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -76,6 +76,16 @@ struct blk_mq_hw_ctx {
 	struct srcu_struct	srcu[0];
 };
 
+/**
+ * struct blk_mq_queue_map - ctx -> hctx mapping
+ * @mq_map:       CPU ID to hardware queue index map. This is an array
+ *	with nr_cpu_ids elements. Each element has a value in the range
+ *	[@queue_offset, @queue_offset + @nr_queues).
+ * @nr_queues:    Number of hardware queues to map CPU IDs onto.
+ * @queue_offset: First hardware queue to map onto. Used by the PCIe NVMe
+ *	driver to map each hardware queue type (enum hctx_type) onto a distinct
+ *	set of hardware queues.
+ */
 struct blk_mq_queue_map {
 	unsigned int *mq_map;
 	unsigned int nr_queues;
@@ -90,23 +100,45 @@ enum hctx_type {
 	HCTX_MAX_TYPES,
 };
 
+/**
+ * struct blk_mq_tag_set - tag set that can be shared between request queues
+ * @map:	   One or more ctx -> hctx mappings. One map exists for each
+ *		   hardware queue type (enum hctx_type) that the driver wishes
+ *		   to support. There are no restrictions on maps being of the
+ *		   same size, and it's perfectly legal to share maps between
+ *		   types.
+ * @nr_maps:	   Number of elements in the @map array. A number in the range
+ *		   [1, HCTX_MAX_TYPES].
+ * @ops:	   Pointers to functions that implement block driver behavior.
+ * @nr_hw_queues:  Number of hardware queues supported by the block driver that
+ *		   owns this data structure.
+ * @queue_depth:   Number of tags per hardware queue, reserved tags included.
+ * @reserved_tags: Number of tags to set aside for BLK_MQ_REQ_RESERVED tag
+ *		   allocations.
+ * @cmd_size:	   Number of additional bytes to allocate per request. The block
+ *		   driver owns these additional bytes.
+ * @numa_node:	   NUMA node the storage adapter has been connected to.
+ * @timeout:	   Request processing timeout in jiffies.
+ * @flags:	   Zero or more BLK_MQ_F_* flags.
+ * @driver_data:   Pointer to data owned by the block driver that created this
+ *		   tag set.
+ * @tags:	   Tag sets. One tag set per hardware queue. Has @nr_hw_queues
+ *		   elements.
+ * @tag_list_lock: Serializes tag_list accesses.
+ * @tag_list:	   List of the request queues that use this tag set. See also
+ *		   request_queue.tag_set_list.
+ */
 struct blk_mq_tag_set {
-	/*
-	 * map[] holds ctx -> hctx mappings, one map exists for each type
-	 * that the driver wishes to support. There are no restrictions
-	 * on maps being of the same size, and it's perfectly legal to
-	 * share maps between types.
-	 */
 	struct blk_mq_queue_map	map[HCTX_MAX_TYPES];
-	unsigned int		nr_maps;	/* nr entries in map[] */
+	unsigned int		nr_maps;
 	const struct blk_mq_ops	*ops;
-	unsigned int		nr_hw_queues;	/* nr hw queues across maps */
-	unsigned int		queue_depth;	/* max hw supported */
+	unsigned int		nr_hw_queues;
+	unsigned int		queue_depth;
 	unsigned int		reserved_tags;
-	unsigned int		cmd_size;	/* per-request extra data */
+	unsigned int		cmd_size;
 	int			numa_node;
 	unsigned int		timeout;
-	unsigned int		flags;		/* BLK_MQ_F_* */
+	unsigned int		flags;
 	void			*driver_data;
 
 	struct blk_mq_tags	**tags;
-- 
2.23.0.444.g18eeb5a265-goog

