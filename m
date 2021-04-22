Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D459C433B4
	for <linux-block@archiver.kernel.org>; Thu, 22 Apr 2021 12:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0772761164
	for <linux-block@archiver.kernel.org>; Thu, 22 Apr 2021 12:22:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236150AbhDVMXW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Apr 2021 08:23:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45538 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236229AbhDVMXW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Apr 2021 08:23:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619094167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bPE0aK0hYyLui7Dz+EqTzEynhJk5Yj9ljyFTTWvuWYE=;
        b=bQdeP332wZlaFUawpKF7iyTB66g98gGw8Jsb8UN0PZFqadomDDK0+hDpmjk8jVTFpiubj+
        PIERDQH0NXpX6aQnYYN0Q33W06c2ZwJTyX9OUO5/X1m/O2+IVtVJKc6D6EyyaH7Cd8WHFf
        B632QVzGmmrw1fm5CYrmXICszu2WJoI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368-ZzSkpEQ3PCSAfjiHHJufKw-1; Thu, 22 Apr 2021 08:22:45 -0400
X-MC-Unique: ZzSkpEQ3PCSAfjiHHJufKw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2CA6A10866BC;
        Thu, 22 Apr 2021 12:22:44 +0000 (UTC)
Received: from localhost (ovpn-13-243.pek2.redhat.com [10.72.13.243])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5DDC762688;
        Thu, 22 Apr 2021 12:22:32 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V6 10/12] block: limit hw queues to be polled in each blk_poll()
Date:   Thu, 22 Apr 2021 20:20:36 +0800
Message-Id: <20210422122038.2192933-11-ming.lei@redhat.com>
In-Reply-To: <20210422122038.2192933-1-ming.lei@redhat.com>
References: <20210422122038.2192933-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Limit at most 8 queues are polled in each blk_pull(), avoid to
add extra latency when queue depth is high.

Reviewed-by: Jeffle Xu <jefflexu@linux.alibaba.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-poll.c | 78 ++++++++++++++++++++++++++++++++++--------------
 1 file changed, 55 insertions(+), 23 deletions(-)

diff --git a/block/blk-poll.c b/block/blk-poll.c
index 249d73ff6f81..20e7c47cc984 100644
--- a/block/blk-poll.c
+++ b/block/blk-poll.c
@@ -288,36 +288,32 @@ static void bio_grp_list_move(struct bio_grp_list *dst,
 	src->nr_grps -= cnt;
 }
 
-static int blk_mq_poll_io(struct bio *bio)
+#define POLL_HCTX_MAX_CNT 8
+
+static bool blk_add_unique_hctx(struct blk_mq_hw_ctx **data, int *cnt,
+		struct blk_mq_hw_ctx *hctx)
 {
-	struct request_queue *q = bio->bi_bdev->bd_disk->queue;
-	blk_qc_t cookie = bio_get_poll_data(bio);
-	int ret = 0;
+	int i;
 
-	/* wait until the bio is submitted really */
-	if (!blk_qc_t_ready(cookie))
-		return 0;
 
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
 
-static int blk_bio_poll_and_end_io(struct bio_grp_list *grps)
+static void blk_build_poll_queues(struct bio_grp_list *grps,
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
 	for (i = 0; i < grps->nr_grps; i++) {
 		struct bio_grp_list_data *grp = &grps->head[i];
 		struct bio *bio;
@@ -325,11 +321,31 @@ static int blk_bio_poll_and_end_io(struct bio_grp_list *grps)
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
+
+			/* wait until the bio is submitted really */
+			cookie = bio_get_poll_data(bio);
+			if (!blk_qc_t_ready(cookie) || !blk_qc_t_valid(cookie))
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
+static void blk_bio_poll_reap_ios(struct bio_grp_list *grps)
+{
+	int i;
 
-	/* reap bios */
 	for (i = 0; i < grps->nr_grps; i++) {
 		struct bio_grp_list_data *grp = &grps->head[i];
 		struct bio *bio;
@@ -354,6 +370,22 @@ static int blk_bio_poll_and_end_io(struct bio_grp_list *grps)
 		}
 		__bio_grp_list_merge(&grp->list, &bl);
 	}
+}
+
+static int blk_bio_poll_and_end_io(struct bio_grp_list *grps)
+{
+	int ret = 0;
+	int i;
+	struct blk_mq_hw_ctx *hctx[POLL_HCTX_MAX_CNT];
+	int cnt = 0;
+
+	blk_build_poll_queues(grps, hctx, &cnt);
+
+	for (i = 0; i < cnt; i++)
+		ret += blk_mq_poll_hctx(hctx[i]->queue, hctx[i]);
+
+	blk_bio_poll_reap_ios(grps);
+
 	return ret;
 }
 
-- 
2.29.2

