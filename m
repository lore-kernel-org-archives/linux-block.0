Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 046CAC433F5
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 16:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBB596052B
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 16:54:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237763AbhJMQ4b (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Oct 2021 12:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237650AbhJMQ43 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 12:56:29 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2E6C061570
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 09:54:25 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id 5so435532iov.9
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 09:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JoLh29ngTtiaznbE3jjvzkQQaGtKKfQvQt74EVggIEg=;
        b=ojflR0MeYp8GskxfZ4BThN1zUppaAVA4lOkPGpGCfYKft+2ELg5/bkgwffXeuwECCr
         Nq4jg6szTxj/VIsNT2qtWYPyp0ZM6MrPiJebuL4ThQq2tYsOQqD7HnlzAIClKGUYlDXm
         lPZMbiPqEksiP2wqu0QEMOeJP4tDxUAO33S8blp4t+fzfBdNPwjYGs97/Ai9qho5vGw2
         OHqDZhFefSwBDWZOp8GDBLPGreBUGpt3LXlgsyDOAEHCPg37vGpqGBi6glBIEQM+RJgF
         2IuwRkaE4RuKf2OmGeQJIqL2mANeSH7PGwx7yT527Bw5w4Sp0IxqVwtZTSOFjw5VCu0c
         8qOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JoLh29ngTtiaznbE3jjvzkQQaGtKKfQvQt74EVggIEg=;
        b=esVgsN98nmpZGTrMGp56oBDgTu7prqM1bIbbFAFqdop8Z2h8VMKRAb7OG6dgozXT99
         1PV6T0NqhM9+cnt/PNUc/IgdipykbCON/V+900q1by6Vw1n3XMrITu6s1Mp/s42zKb60
         O/1zbGK+GXnxrb9B4nzTHG2yhWR3nLNTTm891EgxpDwV1guF1UUwHaHYqMZw3LsvuLoA
         0DWwCK8vAOm1kKMM3vIaTzXzwEYzw5cf9WjWX9+Qo7UNDDAXoMrbp/LRtAtz4My2qbYB
         cdk927XEb8rD59e3H4fUuP9D1Z+zwtQ9KIZP7AP4N55im9/vYEFQW8WY5iIlpAsKgvh2
         Ac8w==
X-Gm-Message-State: AOAM532fLfywv8p4SVjlThxIKD6W6uOuV77WWPuaHGhbT4kf8L8wvzff
        zOH/QlRgNXnr9RY19jTnarZgnZeWkxIstA==
X-Google-Smtp-Source: ABdhPJwap4nbDUwXK8iiUx0ok2sTq8nOtjmolPqIuC5/koPY9Cjcx2UfkEWIk00d4nbRyFZSWm7LlA==
X-Received: by 2002:a05:6602:2c07:: with SMTP id w7mr320453iov.122.1634144064610;
        Wed, 13 Oct 2021 09:54:24 -0700 (PDT)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id r7sm65023ior.25.2021.10.13.09.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 09:54:24 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 7/9] block: assign batch completion handler in blk_poll()
Date:   Wed, 13 Oct 2021 10:54:14 -0600
Message-Id: <20211013165416.985696-8-axboe@kernel.dk>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211013165416.985696-1-axboe@kernel.dk>
References: <20211013165416.985696-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If an io_batch is passed in to blk_poll(), we need to assign the batch
handler associated with this queue. This allows callers to complete
an io_batch handler on by calling it.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index d603703cf272..deafd444761d 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4302,6 +4302,19 @@ static int blk_mq_poll_classic(struct request_queue *q, blk_qc_t cookie,
 
 	hctx->poll_considered++;
 
+	/*
+	 * If batching is requested but the target doesn't support batched
+	 * completions, then just clear ib and completions will be handled
+	 * normally.
+	 */
+	if (iob) {
+		iob->complete = q->mq_ops->complete_batch;
+		if (!iob->complete) {
+			WARN_ON_ONCE(iob->req_list);
+			iob = NULL;
+		}
+	}
+
 	do {
 		hctx->poll_invoked++;
 
-- 
2.33.0

