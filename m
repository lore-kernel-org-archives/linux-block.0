Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 572A9C433F5
	for <linux-block@archiver.kernel.org>; Sun, 16 Jan 2022 04:19:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234257AbiAPET0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 15 Jan 2022 23:19:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50664 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234255AbiAPETZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 15 Jan 2022 23:19:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642306765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=92IFX2d5XSfTX1sXMXKky0KtJWeq1mRVlebMW0rgnl8=;
        b=E/VBEQjDLtQi9lQ42+QyO6X5I19LEVM7I6ORkMhTCR3XY1+6UHD0Tj+e5E2YWWcg0Ycv2a
        3JjTFlZKB8202jcRFVf1YJGwLvxaJnyPgqdTf+zm3ZyDkog1iQG4JmbDgra25DoCUC4VL5
        nPs2srSUVgiVHTeTg2sldPkC73Jrr+k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-78-NqrjiOcANZmRcJyz_crwdQ-1; Sat, 15 Jan 2022 23:19:23 -0500
X-MC-Unique: NqrjiOcANZmRcJyz_crwdQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 884281006AA5;
        Sun, 16 Jan 2022 04:19:22 +0000 (UTC)
Received: from localhost (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 214B86AB9F;
        Sun, 16 Jan 2022 04:19:15 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 2/3] block: revert aec89dc5d421 block: keep q_usage_counter in atomic mode after del_gendisk
Date:   Sun, 16 Jan 2022 12:18:14 +0800
Message-Id: <20220116041815.1218170-3-ming.lei@redhat.com>
In-Reply-To: <20220116041815.1218170-1-ming.lei@redhat.com>
References: <20220116041815.1218170-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Prepare for revert commit 8e141f9eb803 ("block: drain file system I/O
on del_gendisk").

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 9 +--------
 block/blk.h    | 1 -
 block/genhd.c  | 3 +--
 3 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index a6d4780580fc..cb979dcf7986 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -215,11 +215,9 @@ void blk_mq_freeze_queue(struct request_queue *q)
 }
 EXPORT_SYMBOL_GPL(blk_mq_freeze_queue);
 
-void __blk_mq_unfreeze_queue(struct request_queue *q, bool force_atomic)
+void blk_mq_unfreeze_queue(struct request_queue *q)
 {
 	mutex_lock(&q->mq_freeze_lock);
-	if (force_atomic)
-		q->q_usage_counter.data->force_atomic = true;
 	q->mq_freeze_depth--;
 	WARN_ON_ONCE(q->mq_freeze_depth < 0);
 	if (!q->mq_freeze_depth) {
@@ -228,11 +226,6 @@ void __blk_mq_unfreeze_queue(struct request_queue *q, bool force_atomic)
 	}
 	mutex_unlock(&q->mq_freeze_lock);
 }
-
-void blk_mq_unfreeze_queue(struct request_queue *q)
-{
-	__blk_mq_unfreeze_queue(q, false);
-}
 EXPORT_SYMBOL_GPL(blk_mq_unfreeze_queue);
 
 /*
diff --git a/block/blk.h b/block/blk.h
index 8bd43b3ad33d..9ee7ab1c5572 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -43,7 +43,6 @@ struct blk_flush_queue *blk_alloc_flush_queue(int node, int cmd_size,
 void blk_free_flush_queue(struct blk_flush_queue *q);
 
 void blk_freeze_queue(struct request_queue *q);
-void __blk_mq_unfreeze_queue(struct request_queue *q, bool force_atomic);
 void blk_queue_start_drain(struct request_queue *q);
 int __bio_queue_enter(struct request_queue *q, struct bio *bio);
 bool submit_bio_checks(struct bio *bio);
diff --git a/block/genhd.c b/block/genhd.c
index 6357cab37eef..9842371904d6 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -628,8 +628,7 @@ void del_gendisk(struct gendisk *disk)
 	/*
 	 * Allow using passthrough request again after the queue is torn down.
 	 */
-	blk_queue_flag_clear(QUEUE_FLAG_INIT_DONE, q);
-	__blk_mq_unfreeze_queue(q, true);
+	blk_mq_unfreeze_queue(q);
 
 }
 EXPORT_SYMBOL(del_gendisk);
-- 
2.31.1

