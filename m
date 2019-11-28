Return-Path: <SRS0=c8VV=ZU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FFD6C432C3
	for <linux-block@archiver.kernel.org>; Thu, 28 Nov 2019 21:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48F4A21774
	for <linux-block@archiver.kernel.org>; Thu, 28 Nov 2019 21:12:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oScINBvj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbfK1VM3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Nov 2019 16:12:29 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39429 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbfK1VM0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Nov 2019 16:12:26 -0500
Received: by mail-wr1-f66.google.com with SMTP id y11so29515744wrt.6;
        Thu, 28 Nov 2019 13:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=OJIbPjHQmKLscXvEELpJQJK3dKB4Msg/Vy9NKsHE9co=;
        b=oScINBvjs475mEFUHeEgMihefU3ksmRy37nar6Vl5ofyc3H8GsvODLgyv7EbjbTTAu
         C7qJftZnPwY8JsCeJ54p3BT0xdQc0lP3hqzPV1Sb1IgFn6s+wrjbpdUIHs8+VERyREG/
         YQxYsQ5Gvlv9EPlyx425Fx8oVieuiTLqKwP/nkg59M4nixZKMdsN+MnEoSGSN2Q2GG5x
         BXw708vtdD/OMP5J0g4wpWghf9ueR4unYLV1QdQRcpEPZWtG3jiAAZyasSBXa3y4Ibq2
         9eLm8uiT0aAXlBX4TWK6dTAHADdQYzpgLPJY5TTKsWWfAaiFEU+Eypxy8NosMsFMKrNj
         9OZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OJIbPjHQmKLscXvEELpJQJK3dKB4Msg/Vy9NKsHE9co=;
        b=e75Fbj1SkZ2y6noyFotdFmY9w6x3EEBWeVRm+iG18GnHBI4w2W6jtjbaZe6DFFKutt
         uQrlVRwXVPIZVZa7i3ttugackS3x9WnHn0ofNwJxi3ojDuuzOHeXMWrgBO5CwP8HH+tu
         LhiYTNsp5C5SS5yZk4bPciJH3rl05gurDVB0H5TT4vUw9NYO9DnS/iA2xVE/UnEixCvB
         goP1uYHQyowDrsqZijS2K6IOuajTSMO6t8LGqb52ud16f5N+JTiLAgfPV8KRwy5ERCm1
         CRrF6Z/L+YcPN0su8+LjnIujcGUCtiq0j/XnkItWlNIp5UdXs/0BXmQBKavS1STgfhH2
         Y6cg==
X-Gm-Message-State: APjAAAXIQKFplENd94lggtxU6ryjPxoCtrvDGTDchaAYdkzLLLjwd4ii
        I7Gu91hrNfpr8D886XjrxhU=
X-Google-Smtp-Source: APXvYqywCK1v1R526VWzc1R7MqbdJ8g7i/DSrkXD9DaShCzlSMYNArDB3n7VzKCAm4r2B0I3W65amQ==
X-Received: by 2002:adf:dc02:: with SMTP id t2mr8725230wri.39.1574975543344;
        Thu, 28 Nov 2019 13:12:23 -0800 (PST)
Received: from localhost.localdomain ([109.126.143.74])
        by smtp.gmail.com with ESMTPSA id l26sm11620809wmj.48.2019.11.28.13.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 13:12:22 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] blk-mq: optimise blk_mq_flush_plug_list()
Date:   Fri, 29 Nov 2019 00:11:55 +0300
Message-Id: <021a4aad9f3f9ee13661006e945d642eafd69d9d.1574974577.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1574974577.git.asml.silence@gmail.com>
References: <cover.1574974577.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Instead of using list_del_init() in a loop, that generates a lot of
unnecessary memory read/writes, iterate from the first request of a
batch and cut out a sublist with list_cut_before().

Apart from removing the list node initialisation part, this is more
register-friendly, and the assembly uses the stack less intensively.

list_empty() at the beginning is done with hope, that the compiler can
optimise out the same check in the following list_splice_init().

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/blk-mq.c | 57 +++++++++++++++++---------------------------------
 1 file changed, 19 insertions(+), 38 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index f32a3cfdd34e..3c71d52b6401 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1678,14 +1678,10 @@ static int plug_rq_cmp(void *priv, struct list_head *a, struct list_head *b)
 
 void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 {
-	struct blk_mq_hw_ctx *this_hctx;
-	struct blk_mq_ctx *this_ctx;
-	struct request_queue *this_q;
-	struct request *rq;
 	LIST_HEAD(list);
-	LIST_HEAD(rq_list);
-	unsigned int depth;
 
+	if (list_empty(&plug->mq_list))
+		return;
 	list_splice_init(&plug->mq_list, &list);
 
 	if (plug->rq_count > 2 && plug->multiple_queues)
@@ -1693,42 +1689,27 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 
 	plug->rq_count = 0;
 
-	this_q = NULL;
-	this_hctx = NULL;
-	this_ctx = NULL;
-	depth = 0;
-
-	while (!list_empty(&list)) {
-		rq = list_entry_rq(list.next);
-		list_del_init(&rq->queuelist);
-		BUG_ON(!rq->q);
-		if (rq->mq_hctx != this_hctx || rq->mq_ctx != this_ctx) {
-			if (this_hctx) {
-				trace_block_unplug(this_q, depth, !from_schedule);
-				blk_mq_sched_insert_requests(this_hctx, this_ctx,
-								&rq_list,
-								from_schedule);
-			}
-
-			this_q = rq->q;
-			this_ctx = rq->mq_ctx;
-			this_hctx = rq->mq_hctx;
-			depth = 0;
+	do {
+		struct list_head rq_list;
+		struct request *rq, *head_rq = list_entry_rq(list.next);
+		struct list_head *pos = &head_rq->queuelist; /* skip first */
+		struct blk_mq_hw_ctx *this_hctx = head_rq->mq_hctx;
+		struct blk_mq_ctx *this_ctx = head_rq->mq_ctx;
+		unsigned int depth = 1;
+
+		list_for_each_continue(pos, &list) {
+			rq = list_entry_rq(pos);
+			BUG_ON(!rq->q);
+			if (rq->mq_hctx != this_hctx || rq->mq_ctx != this_ctx)
+				break;
+			depth++;
 		}
 
-		depth++;
-		list_add_tail(&rq->queuelist, &rq_list);
-	}
-
-	/*
-	 * If 'this_hctx' is set, we know we have entries to complete
-	 * on 'rq_list'. Do those.
-	 */
-	if (this_hctx) {
-		trace_block_unplug(this_q, depth, !from_schedule);
+		list_cut_before(&rq_list, &list, pos);
+		trace_block_unplug(head_rq->q, depth, !from_schedule);
 		blk_mq_sched_insert_requests(this_hctx, this_ctx, &rq_list,
 						from_schedule);
-	}
+	} while(!list_empty(&list));
 }
 
 static void blk_mq_bio_to_request(struct request *rq, struct bio *bio,
-- 
2.24.0

