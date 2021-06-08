Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D191C47082
	for <linux-block@archiver.kernel.org>; Tue,  8 Jun 2021 23:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78E866135D
	for <linux-block@archiver.kernel.org>; Tue,  8 Jun 2021 23:07:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235198AbhFHXJd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Jun 2021 19:09:33 -0400
Received: from mail-pl1-f178.google.com ([209.85.214.178]:43867 "EHLO
        mail-pl1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235116AbhFHXJc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Jun 2021 19:09:32 -0400
Received: by mail-pl1-f178.google.com with SMTP id v12so11509672plo.10
        for <linux-block@vger.kernel.org>; Tue, 08 Jun 2021 16:07:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hFU+v6PrYbG3GwJsak4IZ52nG2edvhdZ46b6T0mqhvA=;
        b=W7/wUjnU1uV4PZWHDRQE5Fx2ASrYwA7DN9lf4KxM5lYHs9O32NJc040ZUHNaLN6DNA
         YUu9NZm5i6zwOoexNY4nb9BNBHJ0CF1Ix3CcpG7eMi9MWiTeXRReJVTTEaU7jtj1efzn
         SXJJUt9XuRdKFRa4YC2ixmSvxIaNo+Y2RxWEzXoHmdUWembJmnmdq2y53xZogNT9+27C
         u9ptBpyJDbpbn2fOGJJY9fTDxX0N+gKcCRLLN7sRvQJSlUD3tJ8TxBwJXf9eR+cULi49
         DrVDUuf75nbrT22HKJov5yzi7+MELs71myrA8B4Y2d/I8dw1Y0SFqIhLSXGGNladCn4O
         MvEA==
X-Gm-Message-State: AOAM533j73i13lJ+6U1x1RwmfuCfHar9B8msSEmm5YrvW+bX1lvM8VKi
        06WPnlQIxIk0wni4z3+ngYA=
X-Google-Smtp-Source: ABdhPJwwauikGuzYrfCr4eZYGDSBY9DrDyFof9rAYmvnPaR4U89gMseMNZ/WTlwPYhX+igP9108mUw==
X-Received: by 2002:a17:902:b58d:b029:114:7f9a:efd9 with SMTP id a13-20020a170902b58db02901147f9aefd9mr2024090pls.63.1623193645461;
        Tue, 08 Jun 2021 16:07:25 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id s21sm11395838pfw.57.2021.06.08.16.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 16:07:24 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: [PATCH 10/14] block/mq-deadline: Improve the sysfs show and store macros
Date:   Tue,  8 Jun 2021 16:06:59 -0700
Message-Id: <20210608230703.19510-11-bvanassche@acm.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210608230703.19510-1-bvanassche@acm.org>
References: <20210608230703.19510-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Define separate macros for integers and jiffies to improve readability.
Use sysfs_emit() and kstrtoint() instead of sprintf() and simple_strtol()
since the former functions are the recommended functions.

Cc: Damien Le Moal <damien.lemoal@wdc.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/mq-deadline.c | 66 ++++++++++++++++++++-------------------------
 1 file changed, 29 insertions(+), 37 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 69126beff77d..1d1bb7a41d2a 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -605,58 +605,50 @@ static bool dd_has_work(struct blk_mq_hw_ctx *hctx)
 /*
  * sysfs parts below
  */
-static ssize_t
-deadline_var_show(int var, char *page)
-{
-	return sprintf(page, "%d\n", var);
-}
-
-static void
-deadline_var_store(int *var, const char *page)
-{
-	char *p = (char *) page;
-
-	*var = simple_strtol(p, &p, 10);
-}
-
-#define SHOW_FUNCTION(__FUNC, __VAR, __CONV)				\
+#define SHOW_INT(__FUNC, __VAR)						\
 static ssize_t __FUNC(struct elevator_queue *e, char *page)		\
 {									\
 	struct deadline_data *dd = e->elevator_data;			\
-	int __data = __VAR;						\
-	if (__CONV)							\
-		__data = jiffies_to_msecs(__data);			\
-	return deadline_var_show(__data, (page));			\
-}
-SHOW_FUNCTION(deadline_read_expire_show, dd->fifo_expire[DD_READ], 1);
-SHOW_FUNCTION(deadline_write_expire_show, dd->fifo_expire[DD_WRITE], 1);
-SHOW_FUNCTION(deadline_writes_starved_show, dd->writes_starved, 0);
-SHOW_FUNCTION(deadline_front_merges_show, dd->front_merges, 0);
-SHOW_FUNCTION(deadline_fifo_batch_show, dd->fifo_batch, 0);
-#undef SHOW_FUNCTION
+									\
+	return sysfs_emit((page), "%d\n", __VAR);			\
+}
+#define SHOW_JIFFIES(__FUNC, __VAR) SHOW_INT(__FUNC, jiffies_to_msecs(__VAR))
+SHOW_JIFFIES(deadline_read_expire_show, dd->fifo_expire[DD_READ]);
+SHOW_JIFFIES(deadline_write_expire_show, dd->fifo_expire[DD_WRITE]);
+SHOW_INT(deadline_writes_starved_show, dd->writes_starved);
+SHOW_INT(deadline_front_merges_show, dd->front_merges);
+SHOW_INT(deadline_fifo_batch_show, dd->fifo_batch);
+#undef SHOW_INT
+#undef SHOW_JIFFIES
 
 #define STORE_FUNCTION(__FUNC, __PTR, MIN, MAX, __CONV)			\
 static ssize_t __FUNC(struct elevator_queue *e, const char *page, size_t count)	\
 {									\
 	struct deadline_data *dd = e->elevator_data;			\
-	int __data;							\
-	deadline_var_store(&__data, (page));				\
+	int __data, __ret;						\
+									\
+	__ret = kstrtoint((page), 0, &__data);				\
+	if (__ret < 0)							\
+		return __ret;						\
 	if (__data < (MIN))						\
 		__data = (MIN);						\
 	else if (__data > (MAX))					\
 		__data = (MAX);						\
-	if (__CONV)							\
-		*(__PTR) = msecs_to_jiffies(__data);			\
-	else								\
-		*(__PTR) = __data;					\
+	*(__PTR) = __CONV(__data);					\
 	return count;							\
 }
-STORE_FUNCTION(deadline_read_expire_store, &dd->fifo_expire[DD_READ], 0, INT_MAX, 1);
-STORE_FUNCTION(deadline_write_expire_store, &dd->fifo_expire[DD_WRITE], 0, INT_MAX, 1);
-STORE_FUNCTION(deadline_writes_starved_store, &dd->writes_starved, INT_MIN, INT_MAX, 0);
-STORE_FUNCTION(deadline_front_merges_store, &dd->front_merges, 0, 1, 0);
-STORE_FUNCTION(deadline_fifo_batch_store, &dd->fifo_batch, 0, INT_MAX, 0);
+#define STORE_INT(__FUNC, __PTR, MIN, MAX)				\
+	STORE_FUNCTION(__FUNC, __PTR, MIN, MAX, )
+#define STORE_JIFFIES(__FUNC, __PTR, MIN, MAX)				\
+	STORE_FUNCTION(__FUNC, __PTR, MIN, MAX, msecs_to_jiffies)
+STORE_JIFFIES(deadline_read_expire_store, &dd->fifo_expire[DD_READ], 0, INT_MAX);
+STORE_JIFFIES(deadline_write_expire_store, &dd->fifo_expire[DD_WRITE], 0, INT_MAX);
+STORE_INT(deadline_writes_starved_store, &dd->writes_starved, INT_MIN, INT_MAX);
+STORE_INT(deadline_front_merges_store, &dd->front_merges, 0, 1);
+STORE_INT(deadline_fifo_batch_store, &dd->fifo_batch, 0, INT_MAX);
 #undef STORE_FUNCTION
+#undef STORE_INT
+#undef STORE_JIFFIES
 
 #define DD_ATTR(name) \
 	__ATTR(name, 0644, deadline_##name##_show, deadline_##name##_store)
