Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF317C433FE
	for <linux-block@archiver.kernel.org>; Sat, 23 Oct 2021 16:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6421610A6
	for <linux-block@archiver.kernel.org>; Sat, 23 Oct 2021 16:21:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbhJWQYM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 23 Oct 2021 12:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbhJWQYL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 23 Oct 2021 12:24:11 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196DFC061764
        for <linux-block@vger.kernel.org>; Sat, 23 Oct 2021 09:21:52 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id v17so2517422wrv.9
        for <linux-block@vger.kernel.org>; Sat, 23 Oct 2021 09:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4M1lw0oXTZ8+DVGrY/pbRVuISTz3oZ6JQgweXSxGY2Y=;
        b=KodvKt5qiS4nEb1Vb8dVCxloMUQoq3Z3jeuAcx9IUhdhiPooLKHxbSR/ctGenZ26eM
         hU9I6Zh65k2KUjM101/Fwxc0pf2U0jpzwD3Cw161MJbqklKKvlDcfpM+8jfvgYRxhB5H
         gwtmoWxgG1LLuQPYPN/zNA5ST8U/RYVoMLbpFQz298DMXQs78xWMPW/I6Rr0HNV/ZLOq
         Eqof/8Tq2+X8aPLtiIvVUwfUKDmnnZa94ph+NLGFjqdhyBUhOMJWh89Ocb0KoyAbFiq7
         4riJceRf4H5EfmvWJvXIex2zEIsP8GrCdVDtLInDZMtQ020M4VwI+4tY58Ta+kBkYJX2
         kDsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4M1lw0oXTZ8+DVGrY/pbRVuISTz3oZ6JQgweXSxGY2Y=;
        b=NyQZ9Ca9gCZK8em5thSL0Pc8N+8ZB3zDV/E8cXj1X1dgJin3U/VfEnFM0c6PijgwVD
         s1q8J4EOnagOyPccK87CnuHaPdW0OYebJsqEHP5C0JVIrE3BtYP90xpSpCSt1+XdiJU4
         UBBhKKLbI/FmBmG1UFB2DwhUKJFEo/pvw65l/AxLn0/zVCdLvkdBMDemPE00bOSjrahJ
         tvTqCPHawB7mmUry73VtSndJdJOg4Z4Hgfn07yZkScWqFzP0ZzJx/pZ82LxO5gLkDRTW
         m6RrtjpYr3oaS/AC7wrk5t6raxBQIVQUVSd6sb95ZOHVfkBUrq/qAnsa1xvULqYzLADZ
         ksKA==
X-Gm-Message-State: AOAM5315COhFz37ed3E7U2NlVgSX4ppDvU99W1DuXKss281dllYfNsie
        aKzZ5zeO2Ha+lrA+S+0yAy165yvQBkY=
X-Google-Smtp-Source: ABdhPJwBAKpSfirIC9/OuAAXwiMNHMinGVaNq/CboS7GHbs8S0/wt9IqHE3j5PElg/wMTAVCjtdKmQ==
X-Received: by 2002:adf:f208:: with SMTP id p8mr8589955wro.209.1635006110551;
        Sat, 23 Oct 2021 09:21:50 -0700 (PDT)
Received: from 127.0.0.1localhost ([148.252.133.195])
        by smtp.gmail.com with ESMTPSA id c16sm2174799wrt.43.2021.10.23.09.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Oct 2021 09:21:50 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH 5/5] block: add async version of bio_set_polled
Date:   Sat, 23 Oct 2021 17:21:36 +0100
Message-Id: <b766a125d417b3675f0abcdf32ac038c3c235ce9.1635006010.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1635006010.git.asml.silence@gmail.com>
References: <cover.1635006010.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If we know that a iocb is async we can optimise bio_set_polled() a bit,
add a new helper bio_set_polled_async().

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/fops.c        | 7 +++----
 include/linux/bio.h | 5 +++++
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index 997904963a9d..9cb436de92bb 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -367,14 +367,13 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
 		task_io_account_write(bio->bi_iter.bi_size);
 	}
 
-	if (iocb->ki_flags & IOCB_NOWAIT)
-		bio->bi_opf |= REQ_NOWAIT;
-
 	if (iocb->ki_flags & IOCB_HIPRI) {
-		bio_set_polled(bio, iocb);
+		bio_set_polled_async(bio, iocb);
 		submit_bio(bio);
 		WRITE_ONCE(iocb->private, bio);
 	} else {
+		if (iocb->ki_flags & IOCB_NOWAIT)
+			bio->bi_opf |= REQ_NOWAIT;
 		submit_bio(bio);
 	}
 	return -EIOCBQUEUED;
diff --git a/include/linux/bio.h b/include/linux/bio.h
index fe6bdfbbef66..b64161473f3e 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -738,6 +738,11 @@ static inline void bio_set_polled(struct bio *bio, struct kiocb *kiocb)
 		bio->bi_opf |= REQ_NOWAIT;
 }
 
+static inline void bio_set_polled_async(struct bio *bio, struct kiocb *kiocb)
+{
+	bio->bi_opf |= REQ_POLLED | REQ_NOWAIT;
+}
+
 struct bio *blk_next_bio(struct bio *bio, unsigned int nr_pages, gfp_t gfp);
 
 #endif /* __LINUX_BIO_H */
-- 
2.33.1

