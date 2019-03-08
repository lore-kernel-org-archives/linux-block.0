Return-Path: <SRS0=/NKK=RL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 022AAC10F09
	for <linux-block@archiver.kernel.org>; Fri,  8 Mar 2019 17:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC91B208E4
	for <linux-block@archiver.kernel.org>; Fri,  8 Mar 2019 17:39:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbfCHRjg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Mar 2019 12:39:36 -0500
Received: from mga01.intel.com ([192.55.52.88]:33276 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726581AbfCHRjf (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 8 Mar 2019 12:39:35 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Mar 2019 09:39:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,456,1544515200"; 
   d="scan'208";a="132430643"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.112.69])
  by orsmga003.jf.intel.com with ESMTP; 08 Mar 2019 09:39:35 -0800
From:   Keith Busch <keith.busch@intel.com>
To:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH 2/5] blk-mq: Export iterating queue requests
Date:   Fri,  8 Mar 2019 10:40:03 -0700
Message-Id: <20190308174006.5032-2-keith.busch@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20190308174006.5032-1-keith.busch@intel.com>
References: <20190308174006.5032-1-keith.busch@intel.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

A driver may need to iterate a particular queue's tagged request rather
than the whole tagset.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 block/blk-mq-tag.c     | 1 +
 block/blk-mq-tag.h     | 2 --
 include/linux/blk-mq.h | 2 ++
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index a4931fc7be8a..a4ba91b332b0 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -407,6 +407,7 @@ void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
 	}
 	blk_queue_exit(q);
 }
+EXPORT_SYMBOL(blk_mq_queue_tag_busy_iter);
 
 static int bt_alloc(struct sbitmap_queue *bt, unsigned int depth,
 		    bool round_robin, int node)
diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
index 61deab0b5a5a..5af7ff94b400 100644
--- a/block/blk-mq-tag.h
+++ b/block/blk-mq-tag.h
@@ -33,8 +33,6 @@ extern int blk_mq_tag_update_depth(struct blk_mq_hw_ctx *hctx,
 					struct blk_mq_tags **tags,
 					unsigned int depth, bool can_grow);
 extern void blk_mq_tag_wakeup_all(struct blk_mq_tags *tags, bool);
-void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
-		void *priv);
 
 static inline struct sbq_wait_state *bt_wait_ptr(struct sbitmap_queue *bt,
 						 struct blk_mq_hw_ctx *hctx)
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index b0c814bcc7e3..a64b3fdce0b0 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -321,6 +321,8 @@ bool blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async);
 void blk_mq_run_hw_queues(struct request_queue *q, bool async);
 void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
 		busy_tag_iter_fn *fn, void *priv);
+void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
+		void *priv);
 void blk_mq_freeze_queue(struct request_queue *q);
 void blk_mq_unfreeze_queue(struct request_queue *q);
 void blk_freeze_queue_start(struct request_queue *q);
-- 
2.14.4

