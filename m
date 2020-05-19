Return-Path: <SRS0=keWk=7B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C24DFC433E1
	for <linux-block@archiver.kernel.org>; Tue, 19 May 2020 04:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD9B120758
	for <linux-block@archiver.kernel.org>; Tue, 19 May 2020 04:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbgESEHx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 May 2020 00:07:53 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36393 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726153AbgESEHw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 May 2020 00:07:52 -0400
Received: by mail-pl1-f193.google.com with SMTP id f15so5088853plr.3
        for <linux-block@vger.kernel.org>; Mon, 18 May 2020 21:07:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bWPwaIykBWaovhKqKWdJsqRFaODGX9fdrq02yQf81tY=;
        b=dm4Zr1Qid4ARl+w2b011uxFamBboooW/Sk+jdeOpA6WH9wk6H8oDOf8rYslbxkFQ+7
         9Q5zfnTn+feMjGjdkXQwWF5+feHAWyt6g+DlpWdccrZDoRy+AzQmyyx9Hv2D8xIi7LgL
         YxoLOa+dK2YSMO21dHA0bRiMWCSLwRZZMN65z5ystJIQuqtuVy5hB+166KkX3F2vtcYK
         DRxdrsXLC1fQt3zDvKrdo9Mk/8DgHkQCHhMG6ukh5n6EKXS9BaPlXKASaigmPaIy2aP7
         0JPEfv0c+KNbuUfNkPRjS9WMKvI6RRwwJeZjgM7BYV/v7PJJDByWwy0g3/S8CSvHvP0L
         WQzg==
X-Gm-Message-State: AOAM532G7xUWgfVoti4j/4GMbbSlwpT+pM6RApVtvB1dyVLos4AEPVnE
        CaJO/wtGOGx6Kw9U6QiiFVw=
X-Google-Smtp-Source: ABdhPJzpC6b2XwKhStv7rHQh3mulgTNAFm6rPMbKjC7Dyb7INKsOQ5IRNIbL1Aa6gNs4WRpEc6HpjA==
X-Received: by 2002:a17:902:9697:: with SMTP id n23mr19507047plp.150.1589861271977;
        Mon, 18 May 2020 21:07:51 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4000:d7:dc5d:b628:d57b:164])
        by smtp.gmail.com with ESMTPSA id l3sm823479pju.38.2020.05.18.21.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 21:07:51 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        Alexander Potapenko <glider@google.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH v3 4/4] null_blk: Zero-initialize read buffers in non-memory-backed mode
Date:   Mon, 18 May 2020 21:07:37 -0700
Message-Id: <20200519040737.4531-5-bvanassche@acm.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200519040737.4531-1-bvanassche@acm.org>
References: <20200519040737.4531-1-bvanassche@acm.org>
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
 drivers/block/null_blk_main.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 06f5761fccb6..b06c85a9cff1 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -1250,8 +1250,34 @@ static inline blk_status_t null_handle_memory_backed(struct nullb_cmd *cmd,
 	return errno_to_blk_status(err);
 }
 
+static void nullb_zero_read_cmd_buffer(struct nullb_cmd *cmd)
+{
+	struct nullb_device *dev = cmd->nq->dev;
+	struct bio *bio;
+
+	if (dev->memory_backed)
+		return;
+
+	if (dev->queue_mode == NULL_Q_BIO && bio_op(cmd->bio) == REQ_OP_READ) {
+		zero_fill_bio(cmd->bio);
+	} else if (req_op(cmd->rq) == REQ_OP_READ) {
+		__rq_for_each_bio(bio, cmd->rq)
+			zero_fill_bio(bio);
+	}
+}
+
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
