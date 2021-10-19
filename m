Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC3EDC433F5
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 12:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D75660FD8
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 12:08:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235583AbhJSMK6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Oct 2021 08:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235547AbhJSMKx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Oct 2021 08:10:53 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD5DC06161C
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 05:08:40 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id j8so18085177ila.11
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 05:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xykfp3xsL7he8s8o32UwNPMXTpE6xllfWYGuyAOr/bs=;
        b=KaxJOCeupsJ15ZD9E92npoYEKvIF7zOLp9GVFjtTZUsUaox8Q/nEL1q474PSMM2jzV
         jdveC4UKsBS+nvBZ4f939czMaIT0rr+7RoMr+3gJNhgLCsYk1JwlUKVse1zBe0t5sLRm
         5YzbuqivjAaUMx3+AAdBks0Dy76OqJ27oOrZ78IwpMdcqrMTGJGl++5tpi4BSJPS7T4C
         0LSa+tl7Xf1wnH+vj4Ho8xKdSJgDw0L/Re8aesYXYU6+uLz2AMHBqxKcNezsTEV/3K+x
         bqVTwdI36EhqX/GSMyo1Bch7ny6O5yWHAbP72lHU9xxn9scSNHpfhJYjH5873/xfINvP
         bbSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xykfp3xsL7he8s8o32UwNPMXTpE6xllfWYGuyAOr/bs=;
        b=2psEgPQHAzSzbVveZ+wmvZqhP1oq9e0wjW7i9jZp5hx/sK9uMM09nBvCAuFwTCJhHB
         uUFDWxNlYP01X8+jL27fUkcvTobc0G+JDw8Yz0BIUXkxal1IDIusIV76lQ7mWOzZ6x78
         2hPgK02E8uX4TfbFaNsmvL39h2K1D7QF7CVKmOHkAOeF8MyKbfAK05gKbuBjcrMt8vqy
         D/r4HnoS78cH2ptWHk/GzgsDEufDAdrwYJKC77BoO66FNUJ9SkBEo40ESNBIP+MGt3s5
         Kz4HgA3tVnY58kXNgzOA66FRVKPSoWD4PT684g/no6jPf0PfSzx8a++W26CXe0iszM36
         zZlg==
X-Gm-Message-State: AOAM532wHgkmfXfuJcefHwDPX0o1OaMT+pR+dvMniBJXxh7PY8Lyyora
        nah48LAjo8R6J8MSYXoSb7dRSzLXEoFYRw==
X-Google-Smtp-Source: ABdhPJzErLfj0eiHyhMi/E3iMFjKHWkdYOLUujE6R2KjzGgUps0qrKvFgM2befII+6qJr+bTorzPCQ==
X-Received: by 2002:a05:6e02:16c8:: with SMTP id 8mr17714221ilx.169.1634645319984;
        Tue, 19 Oct 2021 05:08:39 -0700 (PDT)
Received: from localhost.localdomain ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id m10sm8622544ila.13.2021.10.19.05.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 05:08:39 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     hch@lst.de, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/2] block: attempt direct issue of plug list
Date:   Tue, 19 Oct 2021 06:08:34 -0600
Message-Id: <20211019120834.595160-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211019120834.595160-1-axboe@kernel.dk>
References: <20211019120834.595160-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If we have just one queue type in the plug list, then we can extend our
direct issue to cover a full plug list as well.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-core.c       |  1 +
 block/blk-mq.c         | 60 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/blkdev.h |  1 +
 3 files changed, 62 insertions(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index 14d20909f61a..e6ad5b51d0c3 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1555,6 +1555,7 @@ void blk_start_plug_nr_ios(struct blk_plug *plug, unsigned short nr_ios)
 	plug->nr_ios = min_t(unsigned short, nr_ios, BLK_MAX_REQUEST_COUNT);
 	plug->rq_count = 0;
 	plug->multiple_queues = false;
+	plug->has_elevator = false;
 	plug->nowait = false;
 	INIT_LIST_HEAD(&plug->cb_list);
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 620233b85af2..d0fe86b46d1b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2147,6 +2147,58 @@ void blk_mq_insert_requests(struct blk_mq_hw_ctx *hctx, struct blk_mq_ctx *ctx,
 	spin_unlock(&ctx->lock);
 }
 
+static void blk_mq_commit_rqs(struct blk_mq_hw_ctx *hctx, int *queued,
+			      bool from_schedule)
+{
+	if (hctx->queue->mq_ops->commit_rqs) {
+		trace_block_unplug(hctx->queue, *queued, !from_schedule);
+		hctx->queue->mq_ops->commit_rqs(hctx);
+	}
+	*queued = 0;
+}
+
+static void blk_mq_plug_issue_direct(struct blk_plug *plug, bool from_schedule)
+{
+	struct blk_mq_hw_ctx *hctx = NULL;
+	struct request *rq;
+	int queued = 0;
+	int errors = 0;
+
+	while ((rq = rq_list_pop(&plug->mq_list))) {
+		bool last = rq_list_empty(plug->mq_list);
+		blk_status_t ret;
+
+		if (hctx != rq->mq_hctx) {
+			if (hctx)
+				blk_mq_commit_rqs(hctx, &queued, from_schedule);
+			hctx = rq->mq_hctx;
+		}
+
+		ret = blk_mq_request_issue_directly(rq, last);
+		switch (ret) {
+		case BLK_STS_OK:
+			queued++;
+			break;
+		case BLK_STS_RESOURCE:
+		case BLK_STS_DEV_RESOURCE:
+			blk_mq_request_bypass_insert(rq, false, last);
+			blk_mq_commit_rqs(hctx, &queued, from_schedule);
+			return;
+		default:
+			blk_mq_end_request(rq, ret);
+			errors++;
+			break;
+		}
+	}
+
+	/*
+	 * If we didn't flush the entire list, we could have told the driver
+	 * there was more coming, but that turned out to be a lie.
+	 */
+	if (errors)
+		blk_mq_commit_rqs(hctx, &queued, from_schedule);
+}
+
 void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 {
 	struct blk_mq_hw_ctx *this_hctx;
@@ -2158,6 +2210,12 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 		return;
 	plug->rq_count = 0;
 
+	if (!plug->multiple_queues && !plug->has_elevator) {
+		blk_mq_plug_issue_direct(plug, from_schedule);
+		if (rq_list_empty(plug->mq_list))
+			return;
+	}
+
 	this_hctx = NULL;
 	this_ctx = NULL;
 	depth = 0;
@@ -2374,6 +2432,8 @@ static void blk_add_rq_to_plug(struct blk_plug *plug, struct request *rq)
 		if (nxt && nxt->q != rq->q)
 			plug->multiple_queues = true;
 	}
+	if (!plug->has_elevator && (rq->rq_flags & RQF_ELV))
+		plug->has_elevator = true;
 	rq->rq_next = NULL;
 	rq_list_add(&plug->mq_list, rq);
 	plug->rq_count++;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 80668e316eea..2e93682f8f68 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -720,6 +720,7 @@ struct blk_plug {
 	unsigned short rq_count;
 
 	bool multiple_queues;
+	bool has_elevator;
 	bool nowait;
 
 	struct list_head cb_list; /* md requires an unplug callback */
-- 
2.33.1

