Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A11C48BDF
	for <linux-block@archiver.kernel.org>; Thu, 24 Jun 2021 08:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD1AB613E7
	for <linux-block@archiver.kernel.org>; Thu, 24 Jun 2021 08:12:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbhFXIPF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Jun 2021 04:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbhFXIPE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Jun 2021 04:15:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0238C061574
        for <linux-block@vger.kernel.org>; Thu, 24 Jun 2021 01:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=Z6YxTZRTlMwIZZj94BHw7YI+Gi/pnmJm++NTOWQIKvU=; b=eSWwsWLCppVXIbYPAnNKjwQW7y
        1nArULjIEDT7zrBhSOMypT+xwvSVNTUqb8WwgUS2I2CUe27W5FVCRlUj34VQytjZrkR3YOvLUrEXA
        RrXAO3sc7pO/8F4jU03UCd5LgwoB5TknY3hImujs8hjd1oYYhzZc7uEIAzdRxJpmqm0UywaL93dae
        yRHxHsVDMDHqPs0vTm94Gyq3QcnOJSD4BDXH5bZYmI+dINi2s1XddGaRpsIdQWoyyQvyB5oCChkI+
        StUuu8BujyZWicnp4FGeu+QvgNylQslW9yUz/Tr1zpaUVRhgvgqZN4Z44shrQOojKmT9JnHJwdDQs
        Ci0m+gBg==;
Received: from 089144193030.atnat0002.highway.a1.net ([89.144.193.30] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lwKTH-00GLLe-Ix; Thu, 24 Jun 2021 08:12:32 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH] block: mark blk_mq_init_queue_data static
Date:   Thu, 24 Jun 2021 10:10:12 +0200
Message-Id: <20210624081012.256464-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

All driver uses are gone now.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c         | 3 +--
 include/linux/blk-mq.h | 2 --
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 3115ea2d0990..12abff5eb63e 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3112,7 +3112,7 @@ void blk_mq_release(struct request_queue *q)
 	blk_mq_sysfs_deinit(q);
 }
 
-struct request_queue *blk_mq_init_queue_data(struct blk_mq_tag_set *set,
+static struct request_queue *blk_mq_init_queue_data(struct blk_mq_tag_set *set,
 		void *queuedata)
 {
 	struct request_queue *q;
@@ -3129,7 +3129,6 @@ struct request_queue *blk_mq_init_queue_data(struct blk_mq_tag_set *set,
 	}
 	return q;
 }
-EXPORT_SYMBOL_GPL(blk_mq_init_queue_data);
 
 struct request_queue *blk_mq_init_queue(struct blk_mq_tag_set *set)
 {
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index fd2de2b422ed..1d18447ebebc 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -439,8 +439,6 @@ enum {
 struct gendisk *__blk_mq_alloc_disk(struct blk_mq_tag_set *set,
 		void *queuedata);
 struct request_queue *blk_mq_init_queue(struct blk_mq_tag_set *);
-struct request_queue *blk_mq_init_queue_data(struct blk_mq_tag_set *set,
-		void *queuedata);
 int blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 		struct request_queue *q);
 void blk_mq_unregister_dev(struct device *, struct request_queue *);
-- 
2.30.2

