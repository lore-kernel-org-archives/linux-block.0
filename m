Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D10CCA480
	for <linux-block@archiver.kernel.org>; Tue, 21 Jun 2022 10:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346884AbiFUKZF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Jun 2022 06:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241404AbiFUKY7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Jun 2022 06:24:59 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ACFD28990
        for <linux-block@vger.kernel.org>; Tue, 21 Jun 2022 03:24:58 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 2B89F1FB2A;
        Tue, 21 Jun 2022 10:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655807097; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eEjbwCWVjPB/jpggmlLxEojbRYPZI/YTNH34t2fOtZ0=;
        b=ggDkfuQIob4HcgllOsZgxTko0EzW7ffQpxLVd8E32P4eS6v11Ve6DQcd9efR1vvDWsZiL5
        wVebt4vvnH+qJGdc926kNBHa5xYda6etZHMPR6FlUEpcsy/LrRMNio99XWfOOnCAERZFS0
        TdZt9zfkxlh2pU1RlJr64INiXu2auzQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655807097;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eEjbwCWVjPB/jpggmlLxEojbRYPZI/YTNH34t2fOtZ0=;
        b=HsY4Cjp9JTMTBgytiVhGaYxxOOHvTxfeDaSryiDWvmRH1zDlpId9CIecUlkRZWHYYhMnVM
        mtFd/jbRDYRmKeDA==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D2EE32C145;
        Tue, 21 Jun 2022 10:24:56 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id DD8B1A063A; Tue, 21 Jun 2022 12:24:55 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Niklas Cassel <Niklas.Cassel@wdc.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH 3/9] block: Generalize get_current_ioprio() for any task
Date:   Tue, 21 Jun 2022 12:24:40 +0200
Message-Id: <20220621102455.13183-3-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220621102201.26337-1-jack@suse.cz>
References: <20220621102201.26337-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2467; h=from:subject; bh=9440C2WTkt92Vhj6/OOVq67ucQ4XzuuTM1siEJfq8PQ=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBisZxoMiYKIwisSEU7NzSyNbINJH8//BHMjuVJWiPp oYv6MK6JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYrGcaAAKCRCcnaoHP2RA2WWSB/ wOAdNu13Djeoh/EwLx9qJlwGOw/qZ6e25XK5tTa7LW0okgK5n586yQq05cZwsmfZ56hnbD96zGcOiE qY9fjAUB5wp+XxfAWBf509ESFXUvwdReyqHVvjXp7Ccp5M2EnIdca533xAzEsb/gRauUWyTyQi79ZJ f9OiGAjWbNwx1j2lVJj224QXg0D4l9ThCoL2ZJ9ZWuRW/iAh61DvH++Vu5fTplQHt4+CrtzF/vFm8J JYxL7Fasdq0LFgDj9D9jWuMOUwawJaHGy+RoAfkxlPQGQQzgzrOdpO1hb4zatVlsz+uHOFS7NmrVuW 6JzAN1pd8hwYLrY0kW+i2Iw4VWae8K
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

get_current_ioprio() operates only on current task. We will need the
same functionality for other tasks as well. Generalize
get_current_ioprio() for that and also move the bulk out of the header
file because it is large enough.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/ioprio.c         | 26 ++++++++++++++++++++++++++
 include/linux/ioprio.h | 26 ++++++++++----------------
 2 files changed, 36 insertions(+), 16 deletions(-)

diff --git a/block/ioprio.c b/block/ioprio.c
index 2a34cbca18ae..c4e3476155a1 100644
--- a/block/ioprio.c
+++ b/block/ioprio.c
@@ -138,6 +138,32 @@ SYSCALL_DEFINE3(ioprio_set, int, which, int, who, int, ioprio)
 	return ret;
 }
 
+/*
+ * If the task has set an I/O priority, use that. Otherwise, return
+ * the default I/O priority.
+ *
+ * Expected to be called for current task or with task_lock() held to keep
+ * io_context stable.
+ */
+int __get_task_ioprio(struct task_struct *p)
+{
+	struct io_context *ioc = p->io_context;
+	int prio;
+
+	if (p != current)
+		lockdep_assert_held(&p->alloc_lock);
+	if (ioc)
+		prio = ioc->ioprio;
+	else
+		prio = IOPRIO_DEFAULT;
+
+	if (IOPRIO_PRIO_CLASS(prio) == IOPRIO_CLASS_NONE)
+		prio = IOPRIO_PRIO_VALUE(task_nice_ioclass(p),
+					 task_nice_ioprio(p));
+	return prio;
+}
+EXPORT_SYMBOL_GPL(__get_task_ioprio);
+
 static int get_task_ioprio(struct task_struct *p)
 {
 	int ret;
diff --git a/include/linux/ioprio.h b/include/linux/ioprio.h
index 61ed6bb4998e..788a8ff57068 100644
--- a/include/linux/ioprio.h
+++ b/include/linux/ioprio.h
@@ -46,24 +46,18 @@ static inline int task_nice_ioclass(struct task_struct *task)
 		return IOPRIO_CLASS_BE;
 }
 
-/*
- * If the calling process has set an I/O priority, use that. Otherwise, return
- * the default I/O priority.
- */
-static inline int get_current_ioprio(void)
+#ifdef CONFIG_BLOCK
+int __get_task_ioprio(struct task_struct *p);
+#else
+static inline int __get_task_ioprio(int ioprio)
 {
-	struct io_context *ioc = current->io_context;
-	int prio;
-
-	if (ioc)
-		prio = ioc->ioprio;
-	else
-		prio = IOPRIO_DEFAULT;
+	return IOPRIO_DEFAULT;
+}
+#endif /* CONFIG_BLOCK */
 
-	if (IOPRIO_PRIO_CLASS(prio) == IOPRIO_CLASS_NONE)
-		prio = IOPRIO_PRIO_VALUE(task_nice_ioclass(current),
-					 task_nice_ioprio(current));
-	return prio;
+static inline int get_current_ioprio(void)
+{
+	return __get_task_ioprio(current);
 }
 
 /*
-- 
2.35.3

