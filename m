Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5893AC433F5
	for <linux-block@archiver.kernel.org>; Sun, 17 Oct 2021 01:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B23461040
	for <linux-block@archiver.kernel.org>; Sun, 17 Oct 2021 01:38:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244810AbhJQBkI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 Oct 2021 21:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244797AbhJQBkG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 Oct 2021 21:40:06 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A25EC061767
        for <linux-block@vger.kernel.org>; Sat, 16 Oct 2021 18:37:58 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id b188so7295053iof.8
        for <linux-block@vger.kernel.org>; Sat, 16 Oct 2021 18:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KOK97BmCRNOTGss3t8cHBmzyYP2ZOzFLG8RYKaIBP7k=;
        b=VmSmQVW2upH3tu3v1uWW0vGNeXvKaQlesmgb8WkIx5Lpt5pnkgyNj5W+mHHiJcbWDY
         V46lVNiVJO6oyfqesP/LxshWJY3h/IKe977rpd6HgG1GvlmBOFAldwDExBe1ftXDx9zq
         PHVNWPYJ1qWg0Qp80ZQrKsxkg/GMACYopKMrDnbjMRrspR+sQ3XZpKNnEmG8IMh9HHQ4
         lvIzVNaZht70v8Hp+EPdQYn0rpudlCb+2NnJ6ZpZEr+IQv7IBENpfRbmrfhUUI9R9IrZ
         aLIYf4JsdVtVG+DBwaKROgBcqVX0VB/qBtnYc0j1lRjey28WwJRkilR2VEuh34Oe2Bcc
         MWFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KOK97BmCRNOTGss3t8cHBmzyYP2ZOzFLG8RYKaIBP7k=;
        b=THcUt0jKd5JcPbfH1B72EPKDxH0xJhQQwLWXBWmwhE1Tc8fXmN4VPbUsLPuFsE4Utp
         upxRshLQ9vE1ufP/a+nyjeOXaYX9K+NgRS3YDXkcu4E6kEgTuntS1qhT3q8LnBv83rzP
         Uzc+6G0Uy9Ppm05XcjSfbxNrCyZW574rucUlU8+pNtWiPkGa/M79c0T0rpU2E206wC1/
         c9NeiDzv0FRHlIc1Kqt8LLZrQu3YcZja0bzHG927HYBOrOmh3f6rFOLmRx00I4DYtqhk
         xX0LHUj5eXGgQZVQfbJh35Cgw/fdpPpOYDLAt58mKnKyTKPfJ+Emw2BFd1m5ZtChq5pd
         JEmw==
X-Gm-Message-State: AOAM530lyT8sPDUATgYBe7Tw89sxpy7aCHMEw5kInRCTzz/fPBIDfSTF
        J/2+cpyKpn8ogGxeQoheJtKrfPs7wOqSeA==
X-Google-Smtp-Source: ABdhPJwcF8LXC0F6/3ziYGxJOHgk934e+rzT5ikr7jJXYcbaU6vIkCJ4je3amzettZOxg2tHaWNW9g==
X-Received: by 2002:a05:6602:134d:: with SMTP id i13mr9379234iov.164.1634434677232;
        Sat, 16 Oct 2021 18:37:57 -0700 (PDT)
Received: from localhost.localdomain ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id j17sm4934383ilq.1.2021.10.16.18.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 18:37:56 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 08/14] block: improve layout of struct request
Date:   Sat, 16 Oct 2021 19:37:42 -0600
Message-Id: <20211017013748.76461-9-axboe@kernel.dk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211017013748.76461-1-axboe@kernel.dk>
References: <20211017013748.76461-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

It's been a while since this was analyzed, move some members around to
better flow with the use case. Initial state up top, and queued state
after that. This improves my peak case by about 1.5%, from 7750K to
7900K IOPS.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/blk-mq.h | 90 +++++++++++++++++++++---------------------
 1 file changed, 46 insertions(+), 44 deletions(-)

diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 3a399aa372b5..95c3bd3a008e 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -85,6 +85,8 @@ struct request {
 	int tag;
 	int internal_tag;
 
+	unsigned int timeout;
+
 	/* the following two fields are internal, NEVER access directly */
 	unsigned int __data_len;	/* total data len */
 	sector_t __sector;		/* sector cursor */
@@ -97,49 +99,6 @@ struct request {
 		struct request *rq_next;
 	};
 
-	/*
-	 * The hash is used inside the scheduler, and killed once the
-	 * request reaches the dispatch list. The ipi_list is only used
-	 * to queue the request for softirq completion, which is long
-	 * after the request has been unhashed (and even removed from
-	 * the dispatch list).
-	 */
-	union {
-		struct hlist_node hash;	/* merge hash */
-		struct llist_node ipi_list;
-	};
-
-	/*
-	 * The rb_node is only used inside the io scheduler, requests
-	 * are pruned when moved to the dispatch queue. So let the
-	 * completion_data share space with the rb_node.
-	 */
-	union {
-		struct rb_node rb_node;	/* sort/lookup */
-		struct bio_vec special_vec;
-		void *completion_data;
-		int error_count; /* for legacy drivers, don't use */
-	};
-
-	/*
-	 * Three pointers are available for the IO schedulers, if they need
-	 * more they have to dynamically allocate it.  Flush requests are
-	 * never put on the IO scheduler. So let the flush fields share
-	 * space with the elevator data.
-	 */
-	union {
-		struct {
-			struct io_cq		*icq;
-			void			*priv[2];
-		} elv;
-
-		struct {
-			unsigned int		seq;
-			struct list_head	list;
-			rq_end_io_fn		*saved_end_io;
-		} flush;
-	};
-
 	struct gendisk *rq_disk;
 	struct block_device *part;
 #ifdef CONFIG_BLK_RQ_ALLOC_TIME
@@ -182,9 +141,52 @@ struct request {
 	enum mq_rq_state state;
 	refcount_t ref;
 
-	unsigned int timeout;
 	unsigned long deadline;
 
+	/*
+	 * The hash is used inside the scheduler, and killed once the
+	 * request reaches the dispatch list. The ipi_list is only used
+	 * to queue the request for softirq completion, which is long
+	 * after the request has been unhashed (and even removed from
+	 * the dispatch list).
+	 */
+	union {
+		struct hlist_node hash;	/* merge hash */
+		struct llist_node ipi_list;
+	};
+
+	/*
+	 * The rb_node is only used inside the io scheduler, requests
+	 * are pruned when moved to the dispatch queue. So let the
+	 * completion_data share space with the rb_node.
+	 */
+	union {
+		struct rb_node rb_node;	/* sort/lookup */
+		struct bio_vec special_vec;
+		void *completion_data;
+		int error_count; /* for legacy drivers, don't use */
+	};
+
+
+	/*
+	 * Three pointers are available for the IO schedulers, if they need
+	 * more they have to dynamically allocate it.  Flush requests are
+	 * never put on the IO scheduler. So let the flush fields share
+	 * space with the elevator data.
+	 */
+	union {
+		struct {
+			struct io_cq		*icq;
+			void			*priv[2];
+		} elv;
+
+		struct {
+			unsigned int		seq;
+			struct list_head	list;
+			rq_end_io_fn		*saved_end_io;
+		} flush;
+	};
+
 	union {
 		struct __call_single_data csd;
 		u64 fifo_time;
-- 
2.33.1

