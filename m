Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 283EECCA47C
	for <linux-block@archiver.kernel.org>; Thu, 23 Jun 2022 07:48:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbiFWHsz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 03:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbiFWHsp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 03:48:45 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8812E2CE20
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 00:48:42 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 52BB621D3F;
        Thu, 23 Jun 2022 07:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655970521; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sai0gSNhCOOCwT4p71673N36tYVieClulJBCa4VuXMw=;
        b=k01duLq6QjRpaxN3IFdcHRkKxnIrmnTaXfbyNa4Ntr/x7MF5RObkpWABIewNsZPQsCqqP9
        uvKERR7gcRjxB86Hk5xfvO/WFwZtDUjuaePCN9h8EY9+/2IeRHJLr9++AJ1oVvooeENerZ
        yFTjbt4LsyMbNhtE16A97ux+rrAb9yw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655970521;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sai0gSNhCOOCwT4p71673N36tYVieClulJBCa4VuXMw=;
        b=oPGZJdD7M2vjPEBl/1+JpDJjzcB3a8cwZgp3G/yxDpLPaZfe21n4+NVux70Qw2kuUbmv6z
        lv9jcKIf2wP8I8Aw==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A77232C15C;
        Thu, 23 Jun 2022 07:48:35 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id CBC51A063C; Thu, 23 Jun 2022 09:48:40 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Niklas Cassel <Niklas.Cassel@wdc.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH 5/9] block: Fix handling of tasks without ioprio in ioprio_get(2)
Date:   Thu, 23 Jun 2022 09:48:30 +0200
Message-Id: <20220623074840.5960-5-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220623074450.30550-1-jack@suse.cz>
References: <20220623074450.30550-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2497; h=from:subject; bh=bkmCruvw4Mbu2TMSHVoHVwTNJClRHpULvxS2rdsetms=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBitBrN640MSQDobxOglOTA9H26GCW8L5RH6J6gVOKF b6K7ckeJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYrQazQAKCRCcnaoHP2RA2bQbCA C6qBgQBva9K4iAF+uB/TDNW67QPkrnaxPzU8E0tdEdg6rRGouyhwuwXf50GAsyMHiSHC2BMpnDMARL wH4Yv0T6kwEGRx7VRTpfrFjlWPaawSLCzoDAMkVXL3hDZSlPw0fP0Ldj46JqTWp4rZAEGB8ZOJ4qKp Ven/kdO7nugKJxk7jguXA/GwyUlcvh9i2ej/uQ3dK3KvE2LsD8NOyzjtxVacC1r5C/O6Zin5sFWJrC gOph1adLh8fPcJRpEHogHbKPXuLxbyfDCWvwZCIq5MmwA4esuYFG6F3o12UXvDd2/Rfn0l/oT9ay10 tqIt8ovHXpE1kvdkKZhwpNJAGoAlc7
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

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Tested-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
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

