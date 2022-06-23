Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A02FC43334
	for <linux-block@archiver.kernel.org>; Thu, 23 Jun 2022 07:49:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbiFWHtA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 03:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbiFWHso (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 03:48:44 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E452BB13
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 00:48:42 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 191261FD3D;
        Thu, 23 Jun 2022 07:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655970521; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4Fe7KrmHSZpLPz9yJPwVaEgjCjeMQ+t/dg6ntxma6pE=;
        b=rrJQ5vVkRFmA2g+Vak7spCALqHy3PMyYpj/KCufIT3JaNE9rtdi6bShFJut5ptIG1E89OM
        IfbXqpZzIkiXZxHWokJ+EoMgdnped2ItUI8S/0n4D4U+RpGvYL4WzB7qGEXhYKPaV32xGE
        MKhmCyrjSmsh9TxSg7OloNlSuzH5lxc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655970521;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4Fe7KrmHSZpLPz9yJPwVaEgjCjeMQ+t/dg6ntxma6pE=;
        b=mSYPJrtzMHLyCwGBAHDcqGkHNz2n+WcSoTnXQblD5a3ZZfndIvNCEE1X4T0rvJ6lQYMt2p
        Ww2UILlfIFHBjECw==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 6FD7B2C16B;
        Thu, 23 Jun 2022 07:48:35 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id BE02DA063A; Thu, 23 Jun 2022 09:48:40 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Niklas Cassel <Niklas.Cassel@wdc.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH 3/9] block: Generalize get_current_ioprio() for any task
Date:   Thu, 23 Jun 2022 09:48:28 +0200
Message-Id: <20220623074840.5960-3-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220623074450.30550-1-jack@suse.cz>
References: <20220623074450.30550-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2604; h=from:subject; bh=nnEJuXFVsjIzIcp2wWmkBloBi4x4LTLaOeRvPsp51v8=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBitBrMr/1fdXsdLendb3WGbhiZPjMfKbhCF/13DeyJ +BUIk6WJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYrQazAAKCRCcnaoHP2RA2RPRB/ 4kNNFm3u44aGb0Dqb5GvWfUjJWJgzZ3D0fBi4cwHZjb2BWHHVN2rfr484rL0UazdCJ8GnvBFMY/2IF qbbrq4X5XSMlUqWWfjZbcBpE1knQUyYIzZOubeicTu5LO9Jc2UR1NF2/Li3XOepethsg/hcfJx9dGe xl0Yx0O1DGqAt5BLItQRelft+A+JvvtdnzYwZP09C53GgWkJEB/RJfAPe3p6L8ZU+zzhZ0ZtZVsYjA wit0Ka+/Px9QvIjqLMa3vwj7kMkmoyAyNKgMz4Kt7sALetw1XnkqhuGJhhML2BO5/ORPj7NEs/P2ev up/8dAjFBkqTmFN8cf1Ghik7GGAisH
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

get_current_ioprio() operates only on current task. We will need the
same functionality for other tasks as well. Generalize
get_current_ioprio() for that and also move the bulk out of the header
file because it is large enough.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Tested-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
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
index 61ed6bb4998e..9752cf4a9c7c 100644
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
+static inline int __get_task_ioprio(struct task_struct *p)
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

