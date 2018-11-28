Return-Path: <SRS0=FxMo=OH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD2DDC43441
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 13:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FCD32081B
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 13:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="zgbDTlS3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FCD32081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbeK2Ah3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Nov 2018 19:37:29 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39404 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727802AbeK2Ah3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Nov 2018 19:37:29 -0500
Received: by mail-pf1-f193.google.com with SMTP id c72so10181668pfc.6
        for <linux-block@vger.kernel.org>; Wed, 28 Nov 2018 05:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Auo7bxuoU3B9Y/we6rFKweZ9RhWC7hH2EBXNAlZK3k0=;
        b=zgbDTlS33qmTDl4Dl8ZqCtiJTiN8jxWi2+94yTRTE3AruSdleYAai5ikO0UCrtoC3i
         jHl6nPriZpKacXSlmg3SCusEMNDK0YG2RAJUojtUjSkgTSF1KXGmswRCsUsthMj/zbI0
         BUk0e7zKG39VuxkHBP5fE/6JPV4BhaC+iP3Rwvs4gKK5xNyPZlgOaAUdkexySVmrg9qO
         0cq6jbAqNWs4B3foh40HoTVLUcADsvsl6qd/4LD9h5tuu5RBoZ7TL7lRZ8eCnX5Mp0PJ
         qubYMTSXJFdBdmhaF7z0oVBecp859BFV4fBfGRsQfw4kUmjqrm/2Byd2wWlFROKpamwd
         e1HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Auo7bxuoU3B9Y/we6rFKweZ9RhWC7hH2EBXNAlZK3k0=;
        b=JekPe/69MUfDBu43v6E7LXeBpYaCQxmL3Dgh8kIHonlT3SiTN3XV4FORO2cmCke06X
         a1ZUBzlV+3LwkLSybBdRAPfdvHhm4373nICH+nMDKu30FvB6kBR3iXxPDdTBaBiJhtta
         uubjXFh6brAXwRsjbCYI/uYP8eFaC1dDrj1DDn4nJuvz9q4vQ196sChrIGrF1y8vwN/V
         XptQwuJVgziPOJJOOnT1vDDNyusul1ADcEkGhG6ZvHEmTBt7Zq6kRIgDKea7Sh5bmecN
         UhAXLZl1bJjvv69Yr5zm32Ha3Sal7hsfkocWa8aPxPJMANFNiuEC2em0PKcRdCnv9WAa
         fa8Q==
X-Gm-Message-State: AA+aEWZKUk98zi+KmYuYOUmqMvi4Hw+APYKCxpxgANQDlcjgE+ZZrGwF
        WZYBvk2xhF0aajr2Y9ipydUmv/zkXVE=
X-Google-Smtp-Source: AFSGD/XG4X1QsesWRt+W+LnsMIrN2PFRsCYz9SeOOx1R3Kc1rximifViKo2F8Uwi+XVnBVX4C27Wsw==
X-Received: by 2002:a63:d34a:: with SMTP id u10mr33733439pgi.301.1543412147201;
        Wed, 28 Nov 2018 05:35:47 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id q75sm4744925pfa.38.2018.11.28.05.35.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 05:35:46 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/7] blk-mq: add mq_ops->commit_rqs()
Date:   Wed, 28 Nov 2018 06:35:33 -0700
Message-Id: <20181128133538.20329-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181128133538.20329-1-axboe@kernel.dk>
References: <20181128133538.20329-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk-mq passes information to the hardware about any given request being
the last that we will issue in this sequence. The point is that hardware
can defer costly doorbell type writes to the last request. But if we run
into errors issuing a sequence of requests, we may never send the request
with bd->last == true set. For that case, we need a hook that tells the
hardware that nothing else is coming right now.

For failures returned by the drivers ->queue_rq() hook, the driver is
responsible for flushing pending requests, if it uses bd->last to
optimize that part. This works like before, no changes there.

Reviewed-by: Omar Sandoval <osandov@fb.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq.c         | 16 ++++++++++++++++
 include/linux/blk-mq.h | 10 ++++++++++
 2 files changed, 26 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 0e2663048d95..18ff47a85ad3 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1259,6 +1259,14 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
 	if (!list_empty(list)) {
 		bool needs_restart;
 
+		/*
+		 * If we didn't flush the entire list, we could have told
+		 * the driver there was more coming, but that turned out to
+		 * be a lie.
+		 */
+		if (q->mq_ops->commit_rqs)
+			q->mq_ops->commit_rqs(hctx);
+
 		spin_lock(&hctx->lock);
 		list_splice_init(list, &hctx->dispatch);
 		spin_unlock(&hctx->lock);
@@ -1865,6 +1873,14 @@ void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
 			blk_mq_end_request(rq, ret);
 		}
 	}
+
+	/*
+	 * If we didn't flush the entire list, we could have told
+	 * the driver there was more coming, but that turned out to
+	 * be a lie.
+	 */
+	if (!list_empty(list) && hctx->queue->mq_ops->commit_rqs)
+		hctx->queue->mq_ops->commit_rqs(hctx);
 }
 
 static void blk_add_rq_to_plug(struct blk_plug *plug, struct request *rq)
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index b8de11e0603b..467f1dd21ccf 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -117,6 +117,7 @@ struct blk_mq_queue_data {
 
 typedef blk_status_t (queue_rq_fn)(struct blk_mq_hw_ctx *,
 		const struct blk_mq_queue_data *);
+typedef void (commit_rqs_fn)(struct blk_mq_hw_ctx *);
 /* takes rq->cmd_flags as input, returns a hardware type index */
 typedef int (rq_flags_to_type_fn)(struct request_queue *, unsigned int);
 typedef bool (get_budget_fn)(struct blk_mq_hw_ctx *);
@@ -144,6 +145,15 @@ struct blk_mq_ops {
 	 */
 	queue_rq_fn		*queue_rq;
 
+	/*
+	 * If a driver uses bd->last to judge when to submit requests to
+	 * hardware, it must define this function. In case of errors that
+	 * make us stop issuing further requests, this hook serves the
+	 * purpose of kicking the hardware (which the last request otherwise
+	 * would have done).
+	 */
+	commit_rqs_fn		*commit_rqs;
+
 	/*
 	 * Return a queue map type for the given request/bio flags
 	 */
-- 
2.17.1

