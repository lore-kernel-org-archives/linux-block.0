Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C733C4332F
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 18:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 121CA60C4B
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 18:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232876AbhJLST4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Oct 2021 14:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232464AbhJLSTw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Oct 2021 14:19:52 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7CFC061746
        for <linux-block@vger.kernel.org>; Tue, 12 Oct 2021 11:17:50 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id i189so16998344ioa.1
        for <linux-block@vger.kernel.org>; Tue, 12 Oct 2021 11:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z2zeWlNcXzeDSXul25b1n8acHol/1mmQeUhHwlA41/8=;
        b=sXvotjt3S7ftEMTTNQ+B2Hsqq26xL9gBcJDd8i57vOQAzJiSqQXEREKRUSgOOi2VUt
         gjxd+hGSO/WP+0/SVKr8/uZiqkdO5NQnpAqLl7IZ+2/eJaJpFVoc2qCSF0DB7bUuIxmd
         7doW5VfQyo9v+rPAlNmPz3bqQX2zmJqzDoffeTjdrFdB+mez/hlWXIQ7VfDNWHFJN5cq
         r0lSwpRN07HlUl194FrfX8Qji8K+TSdq3L+ucBwuZFdwKIoVhNrJ5xTg6Q0dig0HEexi
         akvI34rD9/eWzjJN7xLs3j4zZpCdY1hxGLVpVunZtrpNN4ngcPuFBU+hcJDQRgvypVfp
         9egw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z2zeWlNcXzeDSXul25b1n8acHol/1mmQeUhHwlA41/8=;
        b=f3FnKLuL59GISKTCmNDX16RmWgZdHDKSr+HSyWH/MxaTqJcrNLu2N3wFB4FQbmmsw0
         JThO6WVgth+q1ooXzCMyFdArFLYuYKw1MYjGHl+BnD5hb3lbVc0e71La1pCCyqSWuBfm
         h5NeR4qaM9O23Ys/rZjxyZlfltg6mtQm3w3wiyvFxiq/Cfg4QYjbXu1INSuq7/cYtWs8
         hjaXT3xwkDWV/d1ni227PBvK9lEV7H6a8QvJspZQYTiHuHJbRO2ETERO9AeoVtgxZTZc
         Pt0zncgm1fm7ge8txz/jpuAMDlfPpX1nD26zYvFKjY/Pxj4ZqXpFE1fprM2x4KI/weQs
         NWRg==
X-Gm-Message-State: AOAM532RDy7GR+yCMc9Pe2xeuHPzrFtZIx5KlxfGSQGSKoRZiqJ5L+B4
        zulNRBAcSiUO8SiZ9zQIBrMw2ZQ4vEC30g==
X-Google-Smtp-Source: ABdhPJws3CbyoVL8ghQ9u/yKAbo7iQU/OIwCGEL3H0IiGdh5rLdXuo2sr3qcUU77cP2eKzMoIt/9Lg==
X-Received: by 2002:a05:6602:1542:: with SMTP id h2mr14375864iow.198.1634062669754;
        Tue, 12 Oct 2021 11:17:49 -0700 (PDT)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id x5sm2242476ioh.23.2021.10.12.11.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 11:17:49 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 7/9] block: assign batch completion handler in blk_poll()
Date:   Tue, 12 Oct 2021 12:17:40 -0600
Message-Id: <20211012181742.672391-8-axboe@kernel.dk>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211012181742.672391-1-axboe@kernel.dk>
References: <20211012181742.672391-1-axboe@kernel.dk>
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
index 9509c52a66a4..62fabc65d6b2 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4107,6 +4107,19 @@ static int blk_mq_poll_classic(struct request_queue *q, blk_qc_t cookie,
 
 	hctx->poll_considered++;
 
+	/*
+	 * If batching is requested but the target doesn't support batched
+	 * completions, then just clear ib and completions will be handled
+	 * normally.
+	 */
+	if (ib) {
+		ib->complete = q->mq_ops->complete_batch;
+		if (!ib->complete) {
+			WARN_ON_ONCE(ib->req_list);
+			ib = NULL;
+		}
+	}
+
 	do {
 		hctx->poll_invoked++;
 
-- 
2.33.0

