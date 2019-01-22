Return-Path: <SRS0=aewy=P6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB52C282C3
	for <linux-block@archiver.kernel.org>; Tue, 22 Jan 2019 15:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 935CD217D6
	for <linux-block@archiver.kernel.org>; Tue, 22 Jan 2019 15:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548170819;
	bh=YdMOG5hIPebuBTE0TS4QbtMeuiflJa1UNYVFoBVxNu8=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=yT2j3WcYM7pHBRlo8rAP/8GBPNY2xoE1JhCqXwUFYWBkXzn3MCKuXYfDoLiIcC5Wp
	 trIgIlhGVlD3SqjDJEvO5tRBTE8ULJBbHE6hOeKzAvJF6v6aKyfHSAT5NKxdn+gxVP
	 f+jT/+1Ocn2oInNsibzY0hRUtUdz2cSTr5g4On50=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729776AbfAVP05 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:26:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:35918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729035AbfAVPXK (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Jan 2019 10:23:10 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6AAAD217D4;
        Tue, 22 Jan 2019 15:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548170589;
        bh=YdMOG5hIPebuBTE0TS4QbtMeuiflJa1UNYVFoBVxNu8=;
        h=From:To:Cc:Subject:Date:From;
        b=TZVkhibBwwG/kEyrjpMV5y/sO8E2LkbFUYYdDy0RKB7KYNXOoIoXqtgwySZM0t+nE
         UOv10OBsZVwklEumxSS5JNmGgI2b/FZJaSnqKzGhXMhSMvlHgqAzgOV6yabv8dJemB
         EMS8dpgN0jDxuKbZUhGFnt4fXBIEKu4oU2JBbtWU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Ed L. Cashin" <ed.cashin@acm.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: [PATCH] block: aoe: no need to check return value of debugfs_create functions
Date:   Tue, 22 Jan 2019 16:21:04 +0100
Message-Id: <20190122152151.16139-5-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Cc: "Ed L. Cashin" <ed.cashin@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/block/aoe/aoeblk.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/block/aoe/aoeblk.c b/drivers/block/aoe/aoeblk.c
index e2c6aae2d636..b602646bfa04 100644
--- a/drivers/block/aoe/aoeblk.c
+++ b/drivers/block/aoe/aoeblk.c
@@ -207,14 +207,7 @@ aoedisk_add_debugfs(struct aoedev *d)
 	else
 		p++;
 	BUG_ON(*p == '\0');
-	entry = debugfs_create_file(p, 0444, aoe_debugfs_dir, d,
-				    &aoe_debugfs_fops);
-	if (IS_ERR_OR_NULL(entry)) {
-		pr_info("aoe: cannot create debugfs file for %s\n",
-			d->gd->disk_name);
-		return;
-	}
-	BUG_ON(d->debugfs);
+	debugfs_create_file(p, 0444, aoe_debugfs_dir, d, &aoe_debugfs_fops);
 	d->debugfs = entry;
 }
 void
@@ -472,10 +465,6 @@ aoeblk_init(void)
 	if (buf_pool_cache == NULL)
 		return -ENOMEM;
 	aoe_debugfs_dir = debugfs_create_dir("aoe", NULL);
-	if (IS_ERR_OR_NULL(aoe_debugfs_dir)) {
-		pr_info("aoe: cannot create debugfs directory\n");
-		aoe_debugfs_dir = NULL;
-	}
 	return 0;
 }
 
-- 
2.20.1

