Return-Path: <SRS0=EWmM=7A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4FF0C433E1
	for <linux-block@archiver.kernel.org>; Mon, 18 May 2020 01:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F1D620758
	for <linux-block@archiver.kernel.org>; Mon, 18 May 2020 01:48:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgERBsY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 17 May 2020 21:48:24 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39625 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbgERBsX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 17 May 2020 21:48:23 -0400
Received: by mail-pf1-f194.google.com with SMTP id b190so4224977pfg.6
        for <linux-block@vger.kernel.org>; Sun, 17 May 2020 18:48:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hZk3WOh1XQ/Ua3gxYc1u1zp1HhQMy6Q8TjX/oueGnSA=;
        b=Etzh5T4TShchGi9oYvHFQhxQZZWVBG6QLfSGDGwJAA12p5nAVvOv4ZLtgws4yH5a9R
         GkckLrnk1PTzmFopAxLoN4W67oWkhlAIDVbjhbfw7Nd/oKdd406OWyJ7SupwsXDOXEzr
         ihf52NcT97gD+VdBF8Vb11ffLUAjsB+HSU4uh7b14T7i1o3QmqyBiPXe8VoUVRcjwkSR
         KgZFtud0sQgP6ChF84CnbI03vy2d/0PoLdVjjcu5XcOtl21uVOmCV7GIfza8mjGIVj/x
         E+jkbXN1TplDiZ3tzQeDfcWvE95oPfEWtokV4ThNocCq1pb9/21hU8V9aS9G6sp8Nqq/
         5ZbA==
X-Gm-Message-State: AOAM531v0WoUP5d8fpMF99zSrPYf6AfRanL7rz271EQsnqsTXngWWr1l
        F5WNd0KSvjRPmr0IQksfiEc=
X-Google-Smtp-Source: ABdhPJy9gr4E4YmL+SGk1cEf2U0/bV96SEB16NEz96b0tn8JY0UbDSwGlorxZHyOl1/CGlXrl01gBA==
X-Received: by 2002:a63:dd11:: with SMTP id t17mr13286769pgg.348.1589766501903;
        Sun, 17 May 2020 18:48:21 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4000:d7:1c3f:56a2:fad2:fca1])
        by smtp.gmail.com with ESMTPSA id m2sm3778353pjl.45.2020.05.17.18.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2020 18:48:21 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        Alexander Potapenko <glider@google.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH v2 4/4] null_blk: Zero-initialize read buffers in non-memory-backed mode
Date:   Sun, 17 May 2020 18:48:07 -0700
Message-Id: <20200518014807.7749-5-bvanassche@acm.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518014807.7749-1-bvanassche@acm.org>
References: <20200518014807.7749-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch suppresses an uninteresting KMSAN complaint without affecting
performance of the null_blk driver if CONFIG_KMSAN is disabled.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Damien Le Moal <damien.lemoal@wdc.com>
Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc: Alexander Potapenko <glider@google.com>
Reported-by: Alexander Potapenko <glider@google.com>
Tested-by: Alexander Potapenko <glider@google.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/null_blk_main.c | 50 +++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 06f5761fccb6..0c1df6ecb30b 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -1250,8 +1250,58 @@ static inline blk_status_t null_handle_memory_backed(struct nullb_cmd *cmd,
 	return errno_to_blk_status(err);
 }
 
+static void zero_fill_bvec(const struct bio_vec *bvec)
+{
+	struct page *page = bvec->bv_page;
+	u32 offset = bvec->bv_offset;
+	u32 left = bvec->bv_len;
+
+	while (left) {
+		u32 len = min_t(u32, left, PAGE_SIZE - offset);
+		void *kaddr;
+
+		kaddr = kmap_atomic(page);
+		memset(kaddr + offset, 0, len);
+		flush_dcache_page(page);
+		kunmap_atomic(kaddr);
+		page++;
+		left -= len;
+		offset = 0;
+	}
+}
+
+static void nullb_zero_rq_data_buffer(const struct request *rq)
+{
+	struct req_iterator iter;
+	struct bio_vec bvec;
+
+	rq_for_each_bvec(bvec, rq, iter)
+		zero_fill_bvec(&bvec);
+}
+
+static void nullb_zero_read_cmd_buffer(struct nullb_cmd *cmd)
+{
+	struct nullb_device *dev = cmd->nq->dev;
+
+	if (dev->queue_mode == NULL_Q_BIO && bio_op(cmd->bio) == REQ_OP_READ)
+		zero_fill_bio(cmd->bio);
+	else if (req_op(cmd->rq) == REQ_OP_READ)
+		nullb_zero_rq_data_buffer(cmd->rq);
+}
+
+/* Complete a request. Only called if dev->memory_backed == 0. */
 static inline void nullb_complete_cmd(struct nullb_cmd *cmd)
 {
+	/*
+	 * Since root privileges are required to configure the null_blk
+	 * driver, it is fine that this driver does not initialize the
+	 * data buffers of read commands. Zero-initialize these buffers
+	 * anyway if KMSAN is enabled to prevent that KMSAN complains
+	 * about null_blk not initializing read data buffers.
+	 */
+	if (IS_ENABLED(CONFIG_KMSAN))
+		nullb_zero_read_cmd_buffer(cmd);
+
 	/* Complete IO by inline, softirq or timer */
 	switch (cmd->nq->dev->irqmode) {
 	case NULL_IRQ_SOFTIRQ:
