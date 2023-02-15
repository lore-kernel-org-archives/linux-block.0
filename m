Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 063BDC636CC
	for <linux-block@archiver.kernel.org>; Wed, 15 Feb 2023 20:16:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjBOUQp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Feb 2023 15:16:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjBOUQo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Feb 2023 15:16:44 -0500
Received: from mail-vk1-xa63.google.com (mail-vk1-xa63.google.com [IPv6:2607:f8b0:4864:20::a63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96893D926
        for <linux-block@vger.kernel.org>; Wed, 15 Feb 2023 12:16:34 -0800 (PST)
Received: by mail-vk1-xa63.google.com with SMTP id t74so47111vkc.7
        for <linux-block@vger.kernel.org>; Wed, 15 Feb 2023 12:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M98UXpjVEYt3NGAko84ajoRVrAGXqIjcE9iQT0L9hMg=;
        b=V0Qaxn0TzzHK/pTv1oFvQoJynS7unfSO1JMXWvjsLbrJztE7IzNhEEbvXlmZ6aqMp/
         wgLdN8+QJ0nkOFDm2I1uDJ7szohjUrl55Q/fP/Nyuxq04D8Gbo9M4AAQz8Wlx/OsKDpJ
         pY+ngf2JnFnkuCng5ULti31Y/s6XX0xjjrbqhdzmWjxWc1UgqKt/FffmBfT4jaxbZMQh
         DPdgcPc2jUlm69pe8egxA3CNTpuwEvksGMHYpb9DP5lqdXt1rKXTuikQbS5uRDwrfksI
         uYkROvTwDgQmVVlmgtzpYtzlQuH2H9YV4Q1I4bBpbeN2ArQier3XISsbeN0VvEbOFoyh
         W0eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M98UXpjVEYt3NGAko84ajoRVrAGXqIjcE9iQT0L9hMg=;
        b=M/YkZk3oyR864Y7Qytf7AyyUx95HBAYUo66x8CpCmXzJwufSjlwb64RxewxBSew+hw
         MQ5bj/Eg+fS+9Mi+C3qXLu+CYbxlIMRMS5H6pD39A+Z8AVVHnJfGZq9Qr24SZrdsznNa
         LGGlkvsEfeaI3gP3NkX1y8IjH7eD4VahTUNw0BSZ66icaq+DP5Q583gA1awHYApHoiYg
         korgDvKLowwKuxSclyUSWaAoaGTjxYe56Rh5sc9kPHM9oErvUqAZ8Aa2XQMvoX7FTsLm
         bhI2zy7gdgLJ2ZP5HiklxtWCEA31t5bes+icejqqNKLv8Sl/Ry4wf4FADizbFQLQRgyv
         xQuA==
X-Gm-Message-State: AO0yUKVEVhP2gMeIMI9Yvmwsh3N0UuTiQuoHyfacI3kbdSyOkXyXRaFc
        QYgPuhUTBems8Fv9x2oSQiv05DtOqW2lkA7kG9i58xNB28P0FSTYailZgdBc2dvO9w==
X-Google-Smtp-Source: AK7set+L2VaJ+F9yYULVy/1uMoVkccBGgHj5CvDuYddgZqqFytg8xjmZz8Ekq53o6SMFFkOa//ziVXXyNRL+
X-Received: by 2002:a1f:1689:0:b0:401:41ff:4052 with SMTP id 131-20020a1f1689000000b0040141ff4052mr2767209vkw.16.1676492193979;
        Wed, 15 Feb 2023 12:16:33 -0800 (PST)
Received: from c7-smtp.dev.purestorage.com ([2620:125:9007:320:7:32:106:0])
        by smtp-relay.gmail.com with ESMTPS id v15-20020ab07c8f000000b006863f81db24sm1296969uaw.17.2023.02.15.12.16.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Feb 2023 12:16:33 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev5.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
        by c7-smtp.dev.purestorage.com (Postfix) with ESMTP id 493C020951;
        Wed, 15 Feb 2023 13:16:33 -0700 (MST)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
        id 44FA4E406AB; Wed, 15 Feb 2023 13:16:33 -0700 (MST)
From:   Uday Shankar <ushankar@purestorage.com>
To:     Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com,
        Uday Shankar <ushankar@purestorage.com>
Subject: [PATCH] blk-mq: enforce op-specific segment limits in blk_insert_cloned_request
Date:   Wed, 15 Feb 2023 13:15:08 -0700
Message-Id: <20230215201507.494152-1-ushankar@purestorage.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The block layer might merge together discard requests up until the
max_discard_segments limit is hit, but blk_insert_cloned_request checks
the segment count against max_segments regardless of the req op. This
can result in errors like the following when discards are issued through
a DM device and max_discard_segments exceeds max_segments for the queue
of the chosen underlying device.

blk_insert_cloned_request: over max segments limit. (256 > 129)

Fix this by looking at the req_op and enforcing the appropriate segment
limit - max_discard_segments for REQ_OP_DISCARDs and max_segments for
everything else.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
 block/blk-merge.c | 4 +---
 block/blk-mq.c    | 5 +++--
 block/blk.h       | 8 ++++++++
 3 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index b7c193d67..7f663c2d3 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -588,9 +588,7 @@ EXPORT_SYMBOL(__blk_rq_map_sg);
 
 static inline unsigned int blk_rq_get_max_segments(struct request *rq)
 {
-	if (req_op(rq) == REQ_OP_DISCARD)
-		return queue_max_discard_segments(rq->q);
-	return queue_max_segments(rq->q);
+	return blk_queue_get_max_segments(rq->q, req_op(rq));
 }
 
 static inline unsigned int blk_rq_get_max_sectors(struct request *rq,
diff --git a/block/blk-mq.c b/block/blk-mq.c
index d3494a796..121b20230 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3000,6 +3000,7 @@ blk_status_t blk_insert_cloned_request(struct request *rq)
 {
 	struct request_queue *q = rq->q;
 	unsigned int max_sectors = blk_queue_get_max_sectors(q, req_op(rq));
+	unsigned int max_segments = blk_queue_get_max_segments(q, req_op(rq));
 	blk_status_t ret;
 
 	if (blk_rq_sectors(rq) > max_sectors) {
@@ -3026,9 +3027,9 @@ blk_status_t blk_insert_cloned_request(struct request *rq)
 	 * original queue.
 	 */
 	rq->nr_phys_segments = blk_recalc_rq_segments(rq);
-	if (rq->nr_phys_segments > queue_max_segments(q)) {
+	if (rq->nr_phys_segments > max_segments) {
 		printk(KERN_ERR "%s: over max segments limit. (%hu > %hu)\n",
-			__func__, rq->nr_phys_segments, queue_max_segments(q));
+			__func__, rq->nr_phys_segments, max_segments);
 		return BLK_STS_IOERR;
 	}
 
diff --git a/block/blk.h b/block/blk.h
index f02381405..8d705c13a 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -169,6 +169,14 @@ static inline unsigned int blk_queue_get_max_sectors(struct request_queue *q,
 	return q->limits.max_sectors;
 }
 
+static inline unsigned int blk_queue_get_max_segments(struct request_queue *q,
+						      enum req_op op)
+{
+	if (op == REQ_OP_DISCARD)
+		return queue_max_discard_segments(q);
+	return queue_max_segments(q);
+}
+
 #ifdef CONFIG_BLK_DEV_INTEGRITY
 void blk_flush_integrity(void);
 bool __bio_integrity_endio(struct bio *);

base-commit: 6bea9ac7c6481c09eb2b61d7cd844fc64a526e3e
-- 
2.25.1

