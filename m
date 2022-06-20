Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C04C9C433EF
	for <linux-block@archiver.kernel.org>; Mon, 20 Jun 2022 16:12:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242145AbiFTQL7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Jun 2022 12:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242503AbiFTQL5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Jun 2022 12:11:57 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF37820BCD
        for <linux-block@vger.kernel.org>; Mon, 20 Jun 2022 09:11:55 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 3AFFE1F90B;
        Mon, 20 Jun 2022 16:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655741514; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O1blor4dVx/YleKP6DMl9anfpk9m5dHQbKtzreVHPY0=;
        b=FdyLjcHF4rQ552Arv1WN+Jm7DzbClqvR1DcHnmyXeo1RF82FAC0AX+CnRd8aNBjQrXgrAv
        FPxe6untZNQ3jHAcf6ogqItPVldVCOVh5s7z8MOS9rRlVt8xiaJeBfyaPnDpc6/1Vb6I/g
        g7fP9nDiMP25Xr9ujOjIhlN1TABxZo0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655741514;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O1blor4dVx/YleKP6DMl9anfpk9m5dHQbKtzreVHPY0=;
        b=soZYGLl77prtMloKS2OT+RhBEKTIFzYl7DtkX98fkJvXdB/xii0pLhJQ+GF+q5f8bLmyy3
        +MRIxFrtL+Hsu2DQ==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B16FB2C146;
        Mon, 20 Jun 2022 16:11:53 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 4B3A3A063A; Mon, 20 Jun 2022 18:11:53 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Niklas Cassel <Niklas.Cassel@wdc.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH 4/8] block: Fix handling of tasks without ioprio in ioprio_get(2)
Date:   Mon, 20 Jun 2022 18:11:45 +0200
Message-Id: <20220620161153.11741-4-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220620160726.19798-1-jack@suse.cz>
References: <20220620160726.19798-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4130; h=from:subject; bh=qs6TSsXEJH7St4+PyWGL2d7x3W3aJJBF3Q4+TOnvplc=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBisJxBeJ2e4V/j5ei30ZKfZZOVA8gx64pjb1wvenqc 6vPcqZKJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYrCcQQAKCRCcnaoHP2RA2QFbCA CF+GhxKDrCpF+Ie4nsQ6V1wiuk6bAW0B2E+XxBkiy5jdWWyC+tdxX9oEDRr/zyr67M+9TLUnpKzTTU F9kbMWjhufrT8aj1vLhox5hUvg8ERA+kXfunChSjz/TT2JG/dGT4p8yoT8DvrOX5ubXMhFEfiGufqU 1g+d7nmEhkBbntjfOYiFCWQA1Aqd/j/enF5AYHDXpNwUX8EPmBgsgEGmahhuFs1shAXj5ZAKAKT76W rrITcTC+NovWN4SokH+S3wm6rxNSzQLVQ/4EE8Rc40gHTCvskxPjVppQskFnvgfzJwlfO1SwaSCH/U H6c6vkmOqBwHOcif846Ab1FNwiWdD2
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

ioprio_get(2) can be asked to return the best IO priority from several
tasks (IOPRIO_WHO_PGRP, IOPRIO_WHO_USER). Currently the call treats
tasks without set IO priority as having priority
IOPRIO_CLASS_BE/IOPRIO_BE_NORM however this does not really reflect the
IO priority the task will get (which depends on task's nice value).

Fix the code to use the real IO priority task's IO will use. For this we
do some factoring out to share the code converting task's CPU priority
to IO priority and we also have to modify code for
ioprio_get(IOPRIO_WHO_PROCESS) to keep returning IOPRIO_CLASS_NONE
priority for tasks without set IO priority as a special case to maintain
userspace visible API.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/ioprio.c         | 49 ++++++++++++++++++++++++++++++++++++------
 include/linux/ioprio.h | 19 +++-------------
 2 files changed, 45 insertions(+), 23 deletions(-)

diff --git a/block/ioprio.c b/block/ioprio.c
index b5cf7339709b..a4c19ce0de4c 100644
--- a/block/ioprio.c
+++ b/block/ioprio.c
@@ -138,6 +138,27 @@ SYSCALL_DEFINE3(ioprio_set, int, which, int, who, int, ioprio)
 	return ret;
 }
 
+/*
+ * If the task has set an I/O priority, use that. Otherwise, return
+ * the default I/O priority.
+ */
+int __get_task_ioprio(struct task_struct *p)
+{
+	struct io_context *ioc = p->io_context;
+	int prio;
+
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
@@ -145,10 +166,29 @@ static int get_task_ioprio(struct task_struct *p)
 	ret = security_task_getioprio(p);
 	if (ret)
 		goto out;
-	ret = IOPRIO_DEFAULT;
+	task_lock(p);
+	ret = __get_task_ioprio(p);
+	task_unlock(p);
+out:
+	return ret;
+}
+
+/*
+ * Return raw IO priority value as set by userspace. We use this for
+ * ioprio_get(pid, IOPRIO_WHO_PROCESS) so that we keep historical behavior and
+ * also so that userspace can distinguish unset IO priority (which just gets
+ * overriden based on task's nice value) from IO priority set to some value.
+ */
+static int get_task_raw_ioprio(struct task_struct *p) { int ret;
+
+	ret = security_task_getioprio(p);
+	if (ret)
+		goto out;
 	task_lock(p);
 	if (p->io_context)
 		ret = p->io_context->ioprio;
+	else
+		ret = IOPRIO_DEFAULT;
 	task_unlock(p);
 out:
 	return ret;
@@ -156,11 +196,6 @@ static int get_task_ioprio(struct task_struct *p)
 
 static int ioprio_best(unsigned short aprio, unsigned short bprio)
 {
-	if (!ioprio_valid(aprio))
-		aprio = IOPRIO_PRIO_VALUE(IOPRIO_CLASS_BE, IOPRIO_BE_NORM);
-	if (!ioprio_valid(bprio))
-		bprio = IOPRIO_PRIO_VALUE(IOPRIO_CLASS_BE, IOPRIO_BE_NORM);
-
 	return min(aprio, bprio);
 }
 
@@ -181,7 +216,7 @@ SYSCALL_DEFINE2(ioprio_get, int, which, int, who)
 			else
 				p = find_task_by_vpid(who);
 			if (p)
-				ret = get_task_ioprio(p);
+				ret = get_task_raw_ioprio(p);
 			break;
 		case IOPRIO_WHO_PGRP:
 			if (!who)
diff --git a/include/linux/ioprio.h b/include/linux/ioprio.h
index 519d51fc8902..24e648dc4fb3 100644
--- a/include/linux/ioprio.h
+++ b/include/linux/ioprio.h
@@ -46,24 +46,11 @@ static inline int task_nice_ioclass(struct task_struct *task)
 		return IOPRIO_CLASS_BE;
 }
 
-/*
- * If the calling process has set an I/O priority, use that. Otherwise, return
- * the default I/O priority.
- */
+int __get_task_ioprio(struct task_struct *p);
+
 static inline int get_current_ioprio(void)
 {
-	struct io_context *ioc = current->io_context;
-	int prio;
-
-	if (ioc)
-		prio = ioc->ioprio;
-	else
-		prio = IOPRIO_DEFAULT;
-
-	if (IOPRIO_PRIO_CLASS(prio) == IOPRIO_CLASS_NONE)
-		prio = IOPRIO_PRIO_VALUE(task_nice_ioclass(current),
-					 task_nice_ioprio(current));
-	return prio;
+	return __get_task_ioprio(current);
 }
 
 extern int set_task_ioprio(struct task_struct *task, int ioprio);
-- 
2.35.3

