Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E08CC48BE5
	for <linux-block@archiver.kernel.org>; Fri, 18 Jun 2021 00:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 758C1613BF
	for <linux-block@archiver.kernel.org>; Fri, 18 Jun 2021 00:45:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233276AbhFRAr3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Jun 2021 20:47:29 -0400
Received: from mail-pf1-f173.google.com ([209.85.210.173]:41725 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233270AbhFRAr2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Jun 2021 20:47:28 -0400
Received: by mail-pf1-f173.google.com with SMTP id x73so6341485pfc.8
        for <linux-block@vger.kernel.org>; Thu, 17 Jun 2021 17:45:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h4MdZLvO+a1EQqlZZWJE2H5A8kXjY06+GUJgg8UyLpI=;
        b=rrUj9krsLSZ7S1M4c23iext2rUTZ9rCMKhPhWGv0r9GmOP5cY4xEz6UQ18jcgit5ur
         P0PWCpsgtXhof6kRN9inUxSD1bVSuNmU/Jky9zmIpcv3aGdhU07GUuS6LcugidNB19lW
         PpOdaZDdwhnPi4e3SMS5gE5Ft36PYvcvQJ9Tm8R3WE/V05ET4qg5ybkseO9YL3ttcmCo
         RBZcwiPMo2ymdTYXhjCnLnAPk/WgYJcJk4KMmgbjUCSsExFsFsmKlh6EBrEwr36E8DAB
         ExJFlwzOR5bBMexylBtlZmTDDfF9uvv72Yci48BA/BPg5QtcOjTcW0p4pN73qlSrpRVQ
         Q4Ew==
X-Gm-Message-State: AOAM532hrnzMquU1WUu5K26vUjHuyWCjtYFcIx8VSIddM/SwMuBFgNKX
        xGy5xgo6RNTrl1RE7H99tCg=
X-Google-Smtp-Source: ABdhPJy4AY31Ta481ZIG7trr5MBs9zdm5u8kiwxgst6+CZulumrzfi/hlKbpiJgxIxI3+7IFKg+uHA==
X-Received: by 2002:a63:dc06:: with SMTP id s6mr793191pgg.39.1623977120126;
        Thu, 17 Jun 2021 17:45:20 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id b10sm6215573pff.14.2021.06.17.17.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 17:45:19 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: [PATCH v3 10/16] block/mq-deadline: Improve the sysfs show and store macros
Date:   Thu, 17 Jun 2021 17:44:50 -0700
Message-Id: <20210618004456.7280-11-bvanassche@acm.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618004456.7280-1-bvanassche@acm.org>
References: <20210618004456.7280-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Define separate macros for integers and jiffies to improve readability.
Use sysfs_emit() and kstrtoint() instead of sprintf() and simple_strtol().
The former functions are the recommended functions.

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
index 69126beff77d..f92224ff0256 100644
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
+	return sysfs_emit(page, "%d\n", __VAR);				\
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
+	__ret = kstrtoint(page, 0, &__data);				\
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
