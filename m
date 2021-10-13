Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C3D1C433FE
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 16:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71E3361027
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 16:54:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237470AbhJMQ4Y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Oct 2021 12:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237193AbhJMQ4Y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 12:56:24 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EBD7C061570
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 09:54:20 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id s3so477520ild.0
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 09:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/HxmRu2SrFMjxnbbGwX0Q0a2H0TAm1oB9K6LjRRzJwo=;
        b=ge82IDkCAO34j14tCKoHv2ZrI1SAmm8yMepOnP8dufan9alc7mpGpJ+Bka9Eb3RX0J
         1PN1sx7T96kS661+CGew+EIqGCsr2KFAnvbXbUUOQJt773BgGZC4CcxEr8JYxsIKaBh3
         JkcM5ViegjazL91JsGCy2+keJYjR7CZV8nIk67HALx8cAenvKKh2uBS+57sku3jltB+o
         +QBrldav12tswZ4kbYSOwRmDB8bl+2v1SQnQbwKz09rM+iHH8FTl5ubHu/pxXJumR0q0
         Q30CagyAjngRIRNGuy6G9ZDsvy4rDByPhy1Jr/fti6J538DsrAlx+IlvVqKOlOO5te6X
         0R3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/HxmRu2SrFMjxnbbGwX0Q0a2H0TAm1oB9K6LjRRzJwo=;
        b=ECmsr4hvjT3yV9AfjeccBrcUastUmivpxIWIbWZEAkMQul2gUCSIQYQ2L5EjdI3nXj
         OGaUaV2iFRm/mlF0GyxeLCR7rdl+mKuHKugw/lEMUMnuxgakZ2Hk0tqQ7oPc4kLRaTbG
         +6nAc4TZ8/y7kP0+RKtdlpt7UOLHkqLeL3TyZDF2lc9SPJiAr8dyEtZrbauZKoR5vtaG
         pV4zpml0HIAD82m0Qd+7dzMQ+eb7W4GV/rDhvtUR8dHmlP47a4kDvD9SE3xhffeZ7qQ/
         stm7BoWfddMyJ9j/bRuROaalYFdVBNcCw1JI/AYuqpLtLsVs1sVyMdhPJXYvwBxL0HKH
         yLhQ==
X-Gm-Message-State: AOAM533PrWsqg5P08s5YS7At0CFozwgrq7EdcywzDTko0Dxzro46s+Tx
        D6S3XfJcKEku8CLmW71RjXnDGGeP95QgPA==
X-Google-Smtp-Source: ABdhPJzPUvV7QQuurN48GtuuWaEmZc9Vw6wdiL+DBGwzzGQ8R11U5u6Ax2AE3CU0J0xMF4VsvMrTMA==
X-Received: by 2002:a92:2001:: with SMTP id j1mr140876ile.84.1634144059768;
        Wed, 13 Oct 2021 09:54:19 -0700 (PDT)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id r7sm65023ior.25.2021.10.13.09.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 09:54:19 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/9] block: define io_batch structure
Date:   Wed, 13 Oct 2021 10:54:08 -0600
Message-Id: <20211013165416.985696-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211013165416.985696-1-axboe@kernel.dk>
References: <20211013165416.985696-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This adds the io_batch structure, and a helper for defining one on the
stack. It's meant to be used for collecting requests for completion,
with a completion handler defined to be called at the end.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/blkdev.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 2a8689e949b4..b39b19dbe7b6 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1298,4 +1298,14 @@ int fsync_bdev(struct block_device *bdev);
 int freeze_bdev(struct block_device *bdev);
 int thaw_bdev(struct block_device *bdev);
 
+struct io_batch {
+	struct request *req_list;
+	void (*complete)(struct io_batch *);
+};
+
+#define DEFINE_IO_BATCH(name)			\
+	struct io_batch name = {		\
+		.req_list = NULL		\
+	}
+
 #endif /* _LINUX_BLKDEV_H */
-- 
2.33.0

