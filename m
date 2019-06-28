Return-Path: <SRS0=XMJ3=U3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5638FC4321A
	for <linux-block@archiver.kernel.org>; Fri, 28 Jun 2019 12:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 351E62086D
	for <linux-block@archiver.kernel.org>; Fri, 28 Jun 2019 12:01:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbfF1MBO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Jun 2019 08:01:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:54510 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726957AbfF1MBO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Jun 2019 08:01:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 74702B62C;
        Fri, 28 Jun 2019 12:01:13 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     axboe@kernel.dk
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        Coly Li <colyli@suse.de>
Subject: [PATCH 16/37] bcache: improve error message in bch_cached_dev_run()
Date:   Fri, 28 Jun 2019 19:59:39 +0800
Message-Id: <20190628120000.40753-17-colyli@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190628120000.40753-1-colyli@suse.de>
References: <20190628120000.40753-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch adds more error message in bch_cached_dev_run() to indicate
the exact reason why an error value is returned. Please notice when
printing out the "is running already" message, pr_info() is used here,
because in this case also -EBUSY is returned, the bcache device can
continue to attach to the cache devince and run, so it won't be an
error level message in kernel message.

Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/super.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index a836910ef368..e9e6d653bf70 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -926,13 +926,18 @@ int bch_cached_dev_run(struct cached_dev *dc)
 		NULL,
 	};
 
-	if (dc->io_disable)
+	if (dc->io_disable) {
+		pr_err("I/O disabled on cached dev %s",
+		       dc->backing_dev_name);
 		return -EIO;
+	}
 
 	if (atomic_xchg(&dc->running, 1)) {
 		kfree(env[1]);
 		kfree(env[2]);
 		kfree(buf);
+		pr_info("cached dev %s is running already",
+		       dc->backing_dev_name);
 		return -EBUSY;
 	}
 
@@ -961,7 +966,7 @@ int bch_cached_dev_run(struct cached_dev *dc)
 	if (sysfs_create_link(&d->kobj, &disk_to_dev(d->disk)->kobj, "dev") ||
 	    sysfs_create_link(&disk_to_dev(d->disk)->kobj,
 			      &d->kobj, "bcache")) {
-		pr_debug("error creating sysfs link");
+		pr_err("Couldn't create bcache dev <-> disk sysfs symlinks");
 		return -ENOMEM;
 	}
 
-- 
2.16.4

