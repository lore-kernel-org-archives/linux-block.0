Return-Path: <SRS0=FxMo=OH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5052C43441
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 13:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CB33208E7
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 13:35:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ewC376kS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CB33208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbeK2Ah1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Nov 2018 19:37:27 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35454 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727802AbeK2Ah1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Nov 2018 19:37:27 -0500
Received: by mail-pg1-f196.google.com with SMTP id s198so9521867pgs.2
        for <linux-block@vger.kernel.org>; Wed, 28 Nov 2018 05:35:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JrqoU3peOrnIVekH1BfOdSNpERgLs0QRqKGQNsNb1lw=;
        b=ewC376kSdzyekNXjoOxpQAtkikUsQ5g4IeT2gT694CTqitVfzbx/goRr/CX/RxDyEP
         TlPSwswJZuv9q7aybbBP0PA3p7BrrhPw9C6vmRfdpA2WWHDxll+C76Ga2ECxWbkZXNhD
         Ny2E1TjmWawpJPRl1hpGHIeXUKkM0gNGMEzYL311C8dad3iOE66cDcs0RLNnekvDoGis
         N7aCindjFc1MjtDbSHoBV/Ut2uNSDJWh3ucmH5Hd7XbuvX9gRxhEdzBYOdAt9grpOxSA
         7r8NZmLMRSeI7g39jVVGQlMcjVuSbxinNNafOY7nqTjvSz9MqjAyWN/oj8gKOgDCJV0r
         ajaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JrqoU3peOrnIVekH1BfOdSNpERgLs0QRqKGQNsNb1lw=;
        b=b9Q/SySgzHkPu72KZKZG7UGPcrWVhWAG2EHn1v6ean6VQl7oupEjdfyNzs/1DPY9mO
         OI5ka2mBfLPvCM82giG+OWwLXWAQYkBnu2Ie1sjYnW+T6RFVlPWEW24zWOiramRVMe2w
         gGxAL2tRonVCqK6GkzGzFvZTN48H4VxSulJlzTqkZHjB1zC4VADV7utsWKKySF0FpwqU
         jvruZ5iiluQ9oTE85QF7mNbmm6KxzGZtBrM+XBpETtT+NWQvWn921pNQvxvKa0ueI5ls
         fv3+BTfft+thakgA1gP8HHvSN//kxJPwme5fAioLBZAHskApwuL0AsRB6Kknj8gfNdMM
         GlTg==
X-Gm-Message-State: AGRZ1gLpNNbiwjM4DPibAqKg7MngRza3sDJ5kSoIxcK+NBAxrpW2/5VS
        4OBwBk57JbaMfmoNARSNk9+GnFXEM9E=
X-Google-Smtp-Source: AJdET5fBNFDpn4fGf5LI8ekCIWUi82JACPlkjzjJNHiqOEMtqa6lTHyysxgC2eTyP64ZQ0dzoR2pXg==
X-Received: by 2002:a63:e247:: with SMTP id y7mr31776887pgj.84.1543412145167;
        Wed, 28 Nov 2018 05:35:45 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id q75sm4744925pfa.38.2018.11.28.05.35.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 05:35:43 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/7] block: improve logic around when to sort a plug list
Date:   Wed, 28 Nov 2018 06:35:32 -0700
Message-Id: <20181128133538.20329-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181128133538.20329-1-axboe@kernel.dk>
References: <20181128133538.20329-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Only do it if we have requests for multiple queues in the same
plug.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-core.c       |  1 +
 block/blk-mq.c         | 23 ++++++++++++++++++-----
 include/linux/blkdev.h |  1 +
 3 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index be9233400314..d107d016b92b 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1780,6 +1780,7 @@ void blk_start_plug(struct blk_plug *plug)
 	INIT_LIST_HEAD(&plug->mq_list);
 	INIT_LIST_HEAD(&plug->cb_list);
 	plug->rq_count = 0;
+	plug->multiple_queues = false;
 
 	/*
 	 * Store ordering should not be needed here, since a potential
diff --git a/block/blk-mq.c b/block/blk-mq.c
index a82830f39933..0e2663048d95 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1677,7 +1677,8 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 	list_splice_init(&plug->mq_list, &list);
 	plug->rq_count = 0;
 
-	list_sort(NULL, &list, plug_rq_cmp);
+	if (plug->rq_count > 2 && plug->multiple_queues)
+		list_sort(NULL, &list, plug_rq_cmp);
 
 	this_q = NULL;
 	this_hctx = NULL;
@@ -1866,6 +1867,20 @@ void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
 	}
 }
 
+static void blk_add_rq_to_plug(struct blk_plug *plug, struct request *rq)
+{
+	list_add_tail(&rq->queuelist, &plug->mq_list);
+	plug->rq_count++;
+	if (!plug->multiple_queues && !list_is_singular(&plug->mq_list)) {
+		struct request *tmp;
+
+		tmp = list_first_entry(&plug->mq_list, struct request,
+						queuelist);
+		if (tmp->q != rq->q)
+			plug->multiple_queues = true;
+	}
+}
+
 static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 {
 	const int is_sync = op_is_sync(bio->bi_opf);
@@ -1932,8 +1947,7 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 			trace_block_plug(q);
 		}
 
-		list_add_tail(&rq->queuelist, &plug->mq_list);
-		plug->rq_count++;
+		blk_add_rq_to_plug(plug, rq);
 	} else if (plug && !blk_queue_nomerges(q)) {
 		blk_mq_bio_to_request(rq, bio);
 
@@ -1950,8 +1964,7 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 			list_del_init(&same_queue_rq->queuelist);
 			plug->rq_count--;
 		}
-		list_add_tail(&rq->queuelist, &plug->mq_list);
-		plug->rq_count++;
+		blk_add_rq_to_plug(plug, rq);
 
 		blk_mq_put_ctx(data.ctx);
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 02732cae6080..08d940f85fa0 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1131,6 +1131,7 @@ struct blk_plug {
 	struct list_head mq_list; /* blk-mq requests */
 	struct list_head cb_list; /* md requires an unplug callback */
 	unsigned short rq_count;
+	bool multiple_queues;
 };
 #define BLK_MAX_REQUEST_COUNT 16
 #define BLK_PLUG_FLUSH_SIZE (128 * 1024)
-- 
2.17.1

