Return-Path: <SRS0=wMiD=WR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB3DCC3A59E
	for <linux-block@archiver.kernel.org>; Wed, 21 Aug 2019 09:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79BB322DA7
	for <linux-block@archiver.kernel.org>; Wed, 21 Aug 2019 09:15:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbfHUJPW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Aug 2019 05:15:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50372 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726317AbfHUJPV (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Aug 2019 05:15:21 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D1F27A2E0E8;
        Wed, 21 Aug 2019 09:15:21 +0000 (UTC)
Received: from localhost (ovpn-8-29.pek2.redhat.com [10.72.8.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B1226799C;
        Wed, 21 Aug 2019 09:15:18 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.com>
Subject: [PATCH V2 1/6] block: Remove blk_mq_register_dev()
Date:   Wed, 21 Aug 2019 17:15:01 +0800
Message-Id: <20190821091506.21196-2-ming.lei@redhat.com>
In-Reply-To: <20190821091506.21196-1-ming.lei@redhat.com>
References: <20190821091506.21196-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.68]); Wed, 21 Aug 2019 09:15:21 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Bart Van Assche <bvanassche@acm.org>

This function has no callers. Hence remove it.

Cc: Christoph Hellwig <hch@infradead.org>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Hannes Reinecke <hare@suse.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq-sysfs.c   | 11 -----------
 include/linux/blk-mq.h |  1 -
 2 files changed, 12 deletions(-)

diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
index e0b97c22726c..31bbf10d8149 100644
--- a/block/blk-mq-sysfs.c
+++ b/block/blk-mq-sysfs.c
@@ -326,17 +326,6 @@ int __blk_mq_register_dev(struct device *dev, struct request_queue *q)
 	return ret;
 }
 
-int blk_mq_register_dev(struct device *dev, struct request_queue *q)
-{
-	int ret;
-
-	mutex_lock(&q->sysfs_lock);
-	ret = __blk_mq_register_dev(dev, q);
-	mutex_unlock(&q->sysfs_lock);
-
-	return ret;
-}
-
 void blk_mq_sysfs_unregister(struct request_queue *q)
 {
 	struct blk_mq_hw_ctx *hctx;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 21cebe901ac0..62a3bb715899 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -253,7 +253,6 @@ struct request_queue *blk_mq_init_sq_queue(struct blk_mq_tag_set *set,
 						const struct blk_mq_ops *ops,
 						unsigned int queue_depth,
 						unsigned int set_flags);
-int blk_mq_register_dev(struct device *, struct request_queue *);
 void blk_mq_unregister_dev(struct device *, struct request_queue *);
 
 int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set);
-- 
2.20.1

