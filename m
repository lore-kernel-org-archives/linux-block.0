Return-Path: <SRS0=73YH=66=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13908C433E0
	for <linux-block@archiver.kernel.org>; Sat, 16 May 2020 00:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3A5F2078B
	for <linux-block@archiver.kernel.org>; Sat, 16 May 2020 00:19:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbgEPATb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 May 2020 20:19:31 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42054 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbgEPATb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 May 2020 20:19:31 -0400
Received: by mail-pl1-f195.google.com with SMTP id k19so1565042pll.9
        for <linux-block@vger.kernel.org>; Fri, 15 May 2020 17:19:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yRqbqIbIrUE7sSefoqXH9DxGNNQRoVSHhtLGsgwmH68=;
        b=pu8Yi5+riIeIDcXfnU9/feEN23mrsHex/rkW9w7V4aSgjnSgNe8eBNmAAHawbwEUz5
         CJtYR80707Bs5zVaUGRG8Bqc+SnPBp7Q/a0I/9hj9N20wT6iuak2s0lPLgFMGjP20xjP
         tTYNcSKe93MkAEK6xLqWpexpdzZxecurEKSZHElrxy5d6LRYjGPl6UeZ7rFqNrK6aCoE
         wUs9epdKI+fTAIjNspTPYg/7AFe93x3L7IDlQJJk8KkuChSnW1KsK1T601sIoMEGlKJR
         lP9yc5vuvOcnZbNDDVhRuXf5bLyqJhKhPoLrmP3DuD4+99Z2SzdlAVp9ffLpJhV8lAz9
         NMqw==
X-Gm-Message-State: AOAM5317aA9hFeLP8poOXfXlwsV+6NE5JUrBOakQa1uugxYY97/zofNS
        KRtNbf2KhMJuBgGhdoOFXPM=
X-Google-Smtp-Source: ABdhPJzTR7eTdbcvZ5VUqNxbFQKgT80a66xa2dgQ8ujgCrbMEjXpSh8VzyUuGDv/8lSUUqbMuU1Dhw==
X-Received: by 2002:a17:902:9697:: with SMTP id n23mr6050660plp.150.1589588368996;
        Fri, 15 May 2020 17:19:28 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4000:d7:f99a:ee92:9332:42a])
        by smtp.gmail.com with ESMTPSA id 30sm2542383pgp.38.2020.05.15.17.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 17:19:28 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Alexander Potapenko <glider@google.com>
Subject: [PATCH 5/5] null_blk: Zero-initialize read buffers in non-memory-backed mode
Date:   Fri, 15 May 2020 17:19:14 -0700
Message-Id: <20200516001914.17138-6-bvanassche@acm.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200516001914.17138-1-bvanassche@acm.org>
References: <20200516001914.17138-1-bvanassche@acm.org>
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
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/null_blk_main.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 06f5761fccb6..df1e144eeaa4 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -1250,8 +1250,38 @@ static inline blk_status_t null_handle_memory_backed(struct nullb_cmd *cmd,
 	return errno_to_blk_status(err);
 }
 
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
