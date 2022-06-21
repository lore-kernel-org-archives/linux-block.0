Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32AB8CCA473
	for <linux-block@archiver.kernel.org>; Tue, 21 Jun 2022 10:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348536AbiFUKZE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Jun 2022 06:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348446AbiFUKZA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Jun 2022 06:25:00 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1772899E
        for <linux-block@vger.kernel.org>; Tue, 21 Jun 2022 03:24:59 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A1E8721E1F;
        Tue, 21 Jun 2022 10:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655807097; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9EZYgGkXpA+F+aduRhJXYDAEAbUAiC1vagAru/4lOpU=;
        b=mfQlpI6wpk+U7jotXxa8JFnMoTBvHfTM9Xqg3J5EFB/EKS6Ckjv7K+rbbs4uAoPdwQAv0p
        rUcg750/s9vx1RVlBTC5X6/yTHUs/DTMT3o6wunhgLgg2lnEBm+N4WZ6rv9MQgHbfvPWhR
        3kAAgEnJr+XYBBkqCj9vnJGenyhneik=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655807097;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9EZYgGkXpA+F+aduRhJXYDAEAbUAiC1vagAru/4lOpU=;
        b=byMMXjTX42akqTRIlo5jQK/gWxdi7ZGKN6LNDtv1f7ivKIGC1LvKtjEuj/MA+P6v42t67z
        ht+vBAWBFsz34NCA==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 913462C14B;
        Tue, 21 Jun 2022 10:24:57 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id EB5D6A063C; Tue, 21 Jun 2022 12:24:55 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Niklas Cassel <Niklas.Cassel@wdc.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH 5/9] block: Fix handling of tasks without ioprio in ioprio_get(2)
Date:   Tue, 21 Jun 2022 12:24:42 +0200
Message-Id: <20220621102455.13183-5-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220621102201.26337-1-jack@suse.cz>
References: <20220621102201.26337-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2371; h=from:subject; bh=lIuUFnJjT8+7FS9MiTSu0lJmXk8YBvbq/vId5g6LMYA=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBisZxp2P/H7Idag4dVwNUJknDcdysxBcUVMt16DOvs jGGsn7eJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYrGcaQAKCRCcnaoHP2RA2ZYfCA CXO2wQP8K+MevYWi072RZzf3F49MXYX8kGRTwvJ3WDW4ns5LE/JNHek9RRPLS5h4J7Fc3DJN0qti7h m85DL2ao/68hZ5oSLBE/4vMtbJXLXAL1T53SSKLOq8gcZZEn1/ehsJtAPO4nlVkC+bvW97ByuiEjgA 3RU1bGFZf8Pt4cVOoTKAY7NMaP4vPxN/wpCsgPGvC+t85mTUpcqLc0lvuYcOfjbaZvTtHo/8E5PolP IwDOT8m1g61ak6QvlJ9KDmKcP+R4PdArlr/UfLbV8cOg+IIyO4Dl7UPOR6xPl+Ea0KginRdvyeSoDu nZiIDLoReo+MqGkFt1eHVbyCKUUmN1
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

Fix the code to use the real IO priority task's IO will use. We have to
modify code for ioprio_get(IOPRIO_WHO_PROCESS) to keep returning
IOPRIO_CLASS_NONE priority for tasks without set IO priority as a
special case to maintain userspace visible API.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/ioprio.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/block/ioprio.c b/block/ioprio.c
index 8c46f672a0ba..32a456b45804 100644
--- a/block/ioprio.c
+++ b/block/ioprio.c
@@ -171,10 +171,31 @@ static int get_task_ioprio(struct task_struct *p)
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
+static int get_task_raw_ioprio(struct task_struct *p)
+{
+	int ret;
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
@@ -182,11 +203,6 @@ static int get_task_ioprio(struct task_struct *p)
 
 static int ioprio_best(unsigned short aprio, unsigned short bprio)
 {
-	if (!ioprio_valid(aprio))
-		aprio = IOPRIO_PRIO_VALUE(IOPRIO_CLASS_BE, IOPRIO_BE_NORM);
-	if (!ioprio_valid(bprio))
-		bprio = IOPRIO_PRIO_VALUE(IOPRIO_CLASS_BE, IOPRIO_BE_NORM);
-
 	return min(aprio, bprio);
 }
 
@@ -207,7 +223,7 @@ SYSCALL_DEFINE2(ioprio_get, int, which, int, who)
 			else
 				p = find_task_by_vpid(who);
 			if (p)
-				ret = get_task_ioprio(p);
+				ret = get_task_raw_ioprio(p);
 			break;
 		case IOPRIO_WHO_PGRP:
 			if (!who)
-- 
2.35.3

