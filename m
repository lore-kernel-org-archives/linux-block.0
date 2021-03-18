Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D2EC433DB
	for <linux-block@archiver.kernel.org>; Thu, 18 Mar 2021 16:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0EC964F11
	for <linux-block@archiver.kernel.org>; Thu, 18 Mar 2021 16:51:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbhCRQvG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Mar 2021 12:51:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44910 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232081AbhCRQvD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Mar 2021 12:51:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616086263;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f69OIa68/yWZJmKkNaVcALAf0WMBU4y3Tg9QmS97MsM=;
        b=HA1KXwruJYWP0FiO8azU6AEenThOjiYWLzUcYE0rOmDGrsVaL4PRFupUktJZY7PbK/PUAy
        XipbcbX93/NThuYHCjAUKt+9JGsahAw7piHd6tpzngeoTISqS32VockvZFkUdLJ434+RSi
        fy195/EEX8Jz6SyWyq+6FjJqueibOXM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-589-9F2tKCQgO-y3pjM05UXjDw-1; Thu, 18 Mar 2021 12:50:02 -0400
X-MC-Unique: 9F2tKCQgO-y3pjM05UXjDw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 79AF51085944;
        Thu, 18 Mar 2021 16:50:01 +0000 (UTC)
Received: from localhost (ovpn-12-24.pek2.redhat.com [10.72.12.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B9E61610F1;
        Thu, 18 Mar 2021 16:50:00 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Ming Lei <ming.lei@redhat.com>
Subject: [RFC PATCH V2 13/13] blk-mq: limit hw queues to be polled in each blk_poll()
Date:   Fri, 19 Mar 2021 00:48:27 +0800
Message-Id: <20210318164827.1481133-14-ming.lei@redhat.com>
In-Reply-To: <20210318164827.1481133-1-ming.lei@redhat.com>
References: <20210318164827.1481133-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Limit at most 8 queues are polled in each blk_pull(), avoid to
add extra latency when queue depth is high.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 66 +++++++++++++++++++++++++++++++++++---------------
 1 file changed, 46 insertions(+), 20 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index f26950a51f4a..9c94b7f0bf4b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3870,33 +3870,31 @@ static blk_qc_t bio_get_poll_cookie(struct bio *bio)
 	return bio->bi_iter.bi_private_data;
 }
 
-static int blk_mq_poll_io(struct bio *bio)
+#define POLL_HCTX_MAX_CNT 8
+
+static bool blk_add_unique_hctx(struct blk_mq_hw_ctx **data, int *cnt,
+		struct blk_mq_hw_ctx *hctx)
 {
-	struct request_queue *q = bio->bi_bdev->bd_disk->queue;
-	blk_qc_t cookie = bio_get_poll_cookie(bio);
-	int ret = 0;
+	int i;
 
-	if (!bio_flagged(bio, BIO_DONE) && blk_qc_t_valid(cookie)) {
-		struct blk_mq_hw_ctx *hctx =
-			q->queue_hw_ctx[blk_qc_t_to_queue_num(cookie)];
+	for (i = 0; i < *cnt; i++) {
+		if (data[i] == hctx)
+			goto exit;
+	}
 
-		ret += blk_mq_poll_hctx(q, hctx);
+	if (i < POLL_HCTX_MAX_CNT) {
+		data[i] = hctx;
+		(*cnt)++;
 	}
-	return ret;
+ exit:
+	return *cnt == POLL_HCTX_MAX_CNT;
 }
 
-static int blk_bio_poll_and_end_io(struct request_queue *q,
-		struct blk_bio_poll_ctx *poll_ctx)
+static void blk_build_poll_queues(struct blk_bio_poll_ctx *poll_ctx,
+		struct blk_mq_hw_ctx **data, int *cnt)
 {
-	int ret = 0;
 	int i;
 
-	/*
-	 * Poll hw queue first.
-	 *
-	 * TODO: limit max poll times and make sure to not poll same
-	 * hw queue one more time.
-	 */
 	for (i = 0; i < poll_ctx->pq->max_nr_grps; i++) {
 		struct bio_grp_list_data *grp = &poll_ctx->pq->head[i];
 		struct bio *bio;
@@ -3904,9 +3902,37 @@ static int blk_bio_poll_and_end_io(struct request_queue *q,
 		if (bio_grp_list_grp_empty(grp))
 			continue;
 
-		for (bio = grp->list.head; bio; bio = bio->bi_poll)
-			ret += blk_mq_poll_io(bio);
+		for (bio = grp->list.head; bio; bio = bio->bi_poll) {
+			blk_qc_t  cookie;
+			struct blk_mq_hw_ctx *hctx;
+			struct request_queue *q;
+
+			if (bio_flagged(bio, BIO_DONE))
+				continue;
+			cookie = bio_get_poll_cookie(bio);
+			if (!blk_qc_t_valid(cookie))
+				continue;
+
+			q = bio->bi_bdev->bd_disk->queue;
+			hctx = q->queue_hw_ctx[blk_qc_t_to_queue_num(cookie)];
+			if (blk_add_unique_hctx(data, cnt, hctx))
+				return;
+		}
 	}
+}
+
+static int blk_bio_poll_and_end_io(struct request_queue *q,
+		struct blk_bio_poll_ctx *poll_ctx)
+{
+	int ret = 0;
+	int i;
+	struct blk_mq_hw_ctx *hctx[POLL_HCTX_MAX_CNT];
+	int cnt = 0;
+
+	blk_build_poll_queues(poll_ctx, hctx, &cnt);
+
+	for (i = 0; i < cnt; i++)
+		ret += blk_mq_poll_hctx(hctx[i]->queue, hctx[i]);
 
 	/* reap bios */
 	for (i = 0; i < poll_ctx->pq->max_nr_grps; i++) {
-- 
2.29.2

