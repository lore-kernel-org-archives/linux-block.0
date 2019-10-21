Return-Path: <SRS0=zBYI=YO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA39FCA9EB7
	for <linux-block@archiver.kernel.org>; Mon, 21 Oct 2019 22:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B90DA20B7C
	for <linux-block@archiver.kernel.org>; Mon, 21 Oct 2019 22:43:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbfJUWnL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Oct 2019 18:43:11 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39890 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730276AbfJUWnL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Oct 2019 18:43:11 -0400
Received: by mail-pf1-f193.google.com with SMTP id v4so9332253pff.6
        for <linux-block@vger.kernel.org>; Mon, 21 Oct 2019 15:43:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K03SxJG5UM5QLbF/Apnz7RCTvF9NtEiDW4IzmGypazw=;
        b=MmLf0mRGD9CodF/T9HX6f5m4CEBXyVtZEkI/0Xxx5sJs6LG3WbV3xtw2LR1AB10viu
         DoJPTxSdZ4sLm6XAjaPIxUD5McchzxknWMfYor+2bPV2rDazlKqYFIn/pNnW8XfkFuhE
         zAacLVhnu/bWqj4Sc+tX9sLQKuStWdx1nyaPTR4kU/ndZRBSV4yA6JUM5DyxiV5ykJC3
         vk4BzW1mHRnM/Trlj38u0iz3CXGK3QkD5na1S+icdzjqguAFsDpxwPyu6OqH6adGzkI/
         ILP0Y1AYBpl5f0r/nZQqDINl4s0UmvRSJBKLsh87FwrYmu7XDXAZpy2S5jQsLKzymrbc
         naog==
X-Gm-Message-State: APjAAAWaD3HG280VWzQ/ZlsCWnsm8N0+CQtgZdOfPyfg7jvBCM2W9hOh
        VdhlTcaq9vtlNGRMyWJsmhfMSqhHMd0=
X-Google-Smtp-Source: APXvYqw+oxZDfXFKLck8hk+qGu21exc/GLYHCRDm/JguV1JgrDJ907UAZGMtnfQc+d4dRl8knQj3ig==
X-Received: by 2002:a63:dd11:: with SMTP id t17mr266772pgg.242.1571697788920;
        Mon, 21 Oct 2019 15:43:08 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id u9sm15944763pjb.4.2019.10.21.15.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 15:43:08 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 2/4] block: Fix a race between blk_poll() and blk_mq_update_nr_hw_queues()
Date:   Mon, 21 Oct 2019 15:42:57 -0700
Message-Id: <20191021224259.209542-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
In-Reply-To: <20191021224259.209542-1-bvanassche@acm.org>
References: <20191021224259.209542-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If blk_poll() is called if no requests are in progress, it may happen that
blk_mq_update_nr_hw_queues() modifies the data structures used by blk_poll(),
e.g. q->queue_hw_ctx[]. Fix this race by serializing blk_poll() against
blk_mq_update_nr_hw_queues().

Cc: Christoph Hellwig <hch@infradead.org>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq.c | 38 +++++++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 13 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 7528678ef41f..ea64d951f411 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3439,19 +3439,7 @@ static bool blk_mq_poll_hybrid(struct request_queue *q,
 	return blk_mq_poll_hybrid_sleep(q, hctx, rq);
 }
 
-/**
- * blk_poll - poll for IO completions
- * @q:  the queue
- * @cookie: cookie passed back at IO submission time
- * @spin: whether to spin for completions
- *
- * Description:
- *    Poll for completions on the passed in queue. Returns number of
- *    completed entries found. If @spin is true, then blk_poll will continue
- *    looping until at least one completion is found, unless the task is
- *    otherwise marked running (or we need to reschedule).
- */
-int blk_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
+static int __blk_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
 {
 	struct blk_mq_hw_ctx *hctx;
 	long state;
@@ -3503,6 +3491,30 @@ int blk_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
 	__set_current_state(TASK_RUNNING);
 	return 0;
 }
+
+/**
+ * blk_poll - poll for IO completions
+ * @q:  the queue
+ * @cookie: cookie passed back at IO submission time
+ * @spin: whether to spin for completions
+ *
+ * Description:
+ *    Poll for completions on the passed in queue. Returns number of
+ *    completed entries found. If @spin is true, then blk_poll will continue
+ *    looping until at least one completion is found, unless the task is
+ *    otherwise marked running (or we need to reschedule).
+ */
+int blk_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
+{
+	int ret;
+
+	if (!percpu_ref_tryget(&q->q_usage_counter))
+		return 0;
+	ret = __blk_poll(q, cookie, spin);
+	blk_queue_exit(q);
+
+	return ret;
+}
 EXPORT_SYMBOL_GPL(blk_poll);
 
 unsigned int blk_mq_rq_cpu(struct request *rq)
-- 
2.23.0.866.gb869b98d4c-goog

