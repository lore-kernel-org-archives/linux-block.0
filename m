Return-Path: <SRS0=7JUc=SS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F034C10F12
	for <linux-block@archiver.kernel.org>; Tue, 16 Apr 2019 03:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3A962075B
	for <linux-block@archiver.kernel.org>; Tue, 16 Apr 2019 03:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kmCGGJ9J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbfDPD2W (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Apr 2019 23:28:22 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42899 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbfDPD2V (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Apr 2019 23:28:21 -0400
Received: by mail-qt1-f196.google.com with SMTP id p20so21739887qtc.9;
        Mon, 15 Apr 2019 20:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cUB3G7OaQfdrxLlctGQ4Z6HvVW/8bG6i4wnrDGn5MTU=;
        b=kmCGGJ9JCG7ZglpFvB1Ziy7QjGpJPw76ZsbEcXFIYQKRUOqKwOcbwMFLVntHvp8rU2
         R/I11nl1KxYD90Qr2hUMe0yjmHAFzLfxiYguNJAVBHM/jgPde+uNqJprdqnw5vncoVg5
         AyNtHv1YwOA0J/1E0+XuRbTU8OXNj+TqBHoErJiQ9bz4WpdrItYZVV89yzlO+UCr+W7K
         6zc1CKQguuwB0VcrtSNUq6SgnZpwA6wIVXbkIKVsffmPnj8RM+MTf+ntHIqN0JU+C4pO
         1B4r3/Vp0EB5P4dYQtQhKG5RxelnjqLNVQP9aW1BZvZkVtN+K2Ikd+iXngzuPrQTcHuE
         kpvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cUB3G7OaQfdrxLlctGQ4Z6HvVW/8bG6i4wnrDGn5MTU=;
        b=SsN7WY51/GYxYrMLCk7gptxJ7ExydK7Lm8lcbgJGZnASF27F/goc5y8juQLKqUfTOS
         ABYLqqIFDQ2XKXllxH/oavgesRQyL7FeoukJ9RCvjdfY7c5ap5gVcKh5vnyaDkYEtKTn
         vEYiT8P/7HX977lVhF4i1mRU5T5Qr8xUt58A5R1wNIOkYPyX2VDodU8ls43s56r96z7o
         NgJlJ2HwwbwUDE0DQjseC6w0LlSNy4PPJE3vhFD6XsaDweeMjSTt7D5d2ieaLCVLSNAE
         pAXmMLAGWHZz0+UixpNMWqoiP1rZdC+x6OtXbXyiayjGcTUqjbhpaple6xJuZWr+oxhQ
         3fhQ==
X-Gm-Message-State: APjAAAWvSVonbJhVbzMf/JjeJeyrpbq50RxYcoYgfDjK4n/66kw2w1lO
        OJlG64ISaLD8LaiYrNiuQa63aDXvlO0=
X-Google-Smtp-Source: APXvYqzdoxIANRcn2klC6GBaD6WIXBo5bZkeLmicw/WwOPSrGJbgJhf39zhXDtEOShXaMsvDlIFYIg==
X-Received: by 2002:a0c:c11c:: with SMTP id f28mr62828060qvh.106.1555385300295;
        Mon, 15 Apr 2019 20:28:20 -0700 (PDT)
Received: from localhost.localdomain (189.26.177.132.dynamic.adsl.gvt.net.br. [189.26.177.132])
        by smtp.gmail.com with ESMTPSA id z16sm21501299qti.53.2019.04.15.20.28.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 20:28:19 -0700 (PDT)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     linux-kernel@vger.kernel.org, marcos.souza.org@gmail.com
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk,
        Chaitanya.Kulkarni@wdc.com
Subject: [PATCH v2 2/3] blk-mq.c: Rework documention of blk_mq_init_sq_queue function
Date:   Tue, 16 Apr 2019 00:28:00 -0300
Message-Id: <20190416032801.200694-2-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190416032801.200694-1-marcos.souza.org@gmail.com>
References: <20190416032801.200694-1-marcos.souza.org@gmail.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Describing better what the function does, what the arguments are meant for, and
what SQ stands for.

Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
---

 Changes from v1:
 * Change "SQ" to "only one hw_queue (SQ)" in the function signature
 	documentation (suggested by Chaitanya)

 block/blk-mq.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4a8277a54c03..3f13cfb47cf0 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2675,9 +2675,20 @@ struct request_queue *blk_mq_init_queue(struct blk_mq_tag_set *set)
 }
 EXPORT_SYMBOL(blk_mq_init_queue);
 
-/*
- * Helper for setting up a queue with mq ops, given queue depth, and
- * the passed in mq ops flags.
+/**
+ * blk_mq_init_sq_queue - Create a new request queue with only one hw_queue (SQ)
+ * @set: tag set to be associated by the newly created request queue
+ * @ops: operations to be associated with @set
+ * @queue_depth: number of tags of @set
+ * @set_flags: flags of @set
+ *
+ * Description:
+ * @set is initialized using @ops, @queue_depth, @set_flags, and using only one
+ * hw_queue (SQ). Later on blk_mq_alloc_tag_set() is called to validate and/or
+ * adjust values of the tag set. blk_mq_init_queue() is called passing @set as
+ * argument, returning a new request queue with @set associated.
+ *
+ * Returns the newly created request queue on success, or ERR_PTR() on failure.
  */
 struct request_queue *blk_mq_init_sq_queue(struct blk_mq_tag_set *set,
 					   const struct blk_mq_ops *ops,
-- 
2.16.4

