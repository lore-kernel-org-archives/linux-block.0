Return-Path: <SRS0=lHMQ=S2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67FD2C282CE
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 16:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 393C6206A3
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 16:49:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732375AbfDXQtO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Apr 2019 12:49:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:59926 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732215AbfDXQtO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Apr 2019 12:49:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 38D0DAF68;
        Wed, 24 Apr 2019 16:49:13 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     axboe@kernel.dk
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        Geliang Tang <geliangtang@gmail.com>, Coly Li <colyli@suse.de>
Subject: [PATCH 04/18] bcache: use kmemdup_nul for CACHED_LABEL buffer
Date:   Thu, 25 Apr 2019 00:48:29 +0800
Message-Id: <20190424164843.29535-5-colyli@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190424164843.29535-1-colyli@suse.de>
References: <20190424164843.29535-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Geliang Tang <geliangtang@gmail.com>

This patch uses kmemdup_nul to create a NUL-terminated string from
dc->sb.label. This is better than open coding it.

With this, we can move env[2] initialization into env[] array to make
code more elegant.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/super.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index a697a3a923cd..6e618cb6126c 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -906,21 +906,18 @@ static int cached_dev_status_update(void *arg)
 void bch_cached_dev_run(struct cached_dev *dc)
 {
 	struct bcache_device *d = &dc->disk;
-	char buf[SB_LABEL_SIZE + 1];
+	char *buf = kmemdup_nul(dc->sb.label, SB_LABEL_SIZE, GFP_KERNEL);
 	char *env[] = {
 		"DRIVER=bcache",
 		kasprintf(GFP_KERNEL, "CACHED_UUID=%pU", dc->sb.uuid),
-		NULL,
+		kasprintf(GFP_KERNEL, "CACHED_LABEL=%s", buf ? : ""),
 		NULL,
 	};
 
-	memcpy(buf, dc->sb.label, SB_LABEL_SIZE);
-	buf[SB_LABEL_SIZE] = '\0';
-	env[2] = kasprintf(GFP_KERNEL, "CACHED_LABEL=%s", buf);
-
 	if (atomic_xchg(&dc->running, 1)) {
 		kfree(env[1]);
 		kfree(env[2]);
+		kfree(buf);
 		return;
 	}
 
@@ -944,6 +941,7 @@ void bch_cached_dev_run(struct cached_dev *dc)
 	kobject_uevent_env(&disk_to_dev(d->disk)->kobj, KOBJ_CHANGE, env);
 	kfree(env[1]);
 	kfree(env[2]);
+	kfree(buf);
 
 	if (sysfs_create_link(&d->kobj, &disk_to_dev(d->disk)->kobj, "dev") ||
 	    sysfs_create_link(&disk_to_dev(d->disk)->kobj, &d->kobj, "bcache"))
-- 
2.16.4

