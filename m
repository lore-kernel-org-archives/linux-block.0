Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 125B5C43217
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 21:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF25A60F46
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 21:24:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbhJSV0v (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Oct 2021 17:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbhJSV0u (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Oct 2021 17:26:50 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E28E2C06161C
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 14:24:36 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id o24so7117480wms.0
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 14:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3jjrhInz/WqiiR8qYl275+vzOFnsIrXYK8DzELi3dlQ=;
        b=DT2vc44OEuKXkbYsltEQNdNRkVYPVatKlMLdY4zbJrHdG1EI2qEDFGKLzUjunmJpEB
         f79AFBWrYNm3yNt13p3/xoSqndq5cmwOiUsvCvayDIr8F+hQJZqW0BUvesupUoM/ivRu
         75pn8PEjKTRsvFx6unl+lSFWdtsg/uNnBsTAIbTSSaU4lnSssz2IirAl5WQhCa7+N3PD
         l/JoCAx/eyOdhYOJ/mC7nqhBykf/51Eykvk7PoEmsaomf69tMmuFsCOhaD7afquLCxIw
         Xwv3+OUpLc3Z8IOIcsgvvN4jxIgSRsJkrpdZwuZcm04aU8GyeBCfJUs19MyQPp37gXh/
         QraQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3jjrhInz/WqiiR8qYl275+vzOFnsIrXYK8DzELi3dlQ=;
        b=kuODyP/p8LnHbmadjfYIUoZYHVogMY8d1uTwJnAk8uMWrN/JZE/csO++LymaBC1Ymt
         MmdHMeps7HAzapplBBMWSm9jmT9ReajcF+GPsnmleHdJPwnFp84Xu0XDxjVwV78qOM0r
         Y+sGvl0T2wM7ie52niSl2ryBYsN5BJ0mQG7gheMhjf23LuNgF3yB+UJ5BTUNdg0f82Jl
         jafgOuJ6z76jxxKK9FzbhcgkR9CN0Dm569CCUVt7RNfmqRN9BLZoBHaRmzUfSg8DiEBq
         Jdz3APLxCh0RXwM9fEKhhL/oU0FKVG/8pJL2IOWEJBh7ZdU53TWzmrBRwaDHlsrEK17u
         tvPg==
X-Gm-Message-State: AOAM532d/3F9yXLJucq9fr60S8EQn8zLQdm7tlTdPAyNI6t8VWgFVSw/
        HTHqce9kZebY5ED+7O0igEdDldf9P5ML3A==
X-Google-Smtp-Source: ABdhPJzC+fC2rwyVRzuti65Sk9EkYYqpF4wmhCOLRiyrwX8n1+0mp2wg9cPmWoyDfFaVcqUQS6rbsA==
X-Received: by 2002:a05:600c:1d1a:: with SMTP id l26mr8817741wms.98.1634678675233;
        Tue, 19 Oct 2021 14:24:35 -0700 (PDT)
Received: from 127.0.0.1localhost ([185.69.145.194])
        by smtp.gmail.com with ESMTPSA id m14sm216020wms.25.2021.10.19.14.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 14:24:34 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH 03/16] block: optimise req_bio_endio()
Date:   Tue, 19 Oct 2021 22:24:12 +0100
Message-Id: <8061fa49096e1a0e44849aa204a0a1ae57c4423a.1634676157.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1634676157.git.asml.silence@gmail.com>
References: <cover.1634676157.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

First, get rid of an extra branch and chain error checks. Also reshuffle
it with bio_advance(), so it goes closer to the final check, with that
the compiler loads rq->rq_flags only once, and also doesn't reload
bio->bi_iter.bi_size if bio_advance() didn't actually advanced the iter.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/blk-mq.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 3481a8712234..bab1fccda6ca 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -617,25 +617,23 @@ void blk_mq_free_plug_rqs(struct blk_plug *plug)
 static void req_bio_endio(struct request *rq, struct bio *bio,
 			  unsigned int nbytes, blk_status_t error)
 {
-	if (error)
+	if (unlikely(error)) {
 		bio->bi_status = error;
-
-	if (unlikely(rq->rq_flags & RQF_QUIET))
-		bio_set_flag(bio, BIO_QUIET);
-
-	bio_advance(bio, nbytes);
-
-	if (req_op(rq) == REQ_OP_ZONE_APPEND && error == BLK_STS_OK) {
+	} else if (req_op(rq) == REQ_OP_ZONE_APPEND) {
 		/*
 		 * Partial zone append completions cannot be supported as the
 		 * BIO fragments may end up not being written sequentially.
 		 */
-		if (bio->bi_iter.bi_size)
+		if (bio->bi_iter.bi_size == nbytes)
 			bio->bi_status = BLK_STS_IOERR;
 		else
 			bio->bi_iter.bi_sector = rq->__sector;
 	}
 
+	bio_advance(bio, nbytes);
+
+	if (unlikely(rq->rq_flags & RQF_QUIET))
+		bio_set_flag(bio, BIO_QUIET);
 	/* don't actually finish bio if it's part of flush sequence */
 	if (bio->bi_iter.bi_size == 0 && !(rq->rq_flags & RQF_FLUSH_SEQ))
 		bio_endio(bio);
-- 
2.33.1

