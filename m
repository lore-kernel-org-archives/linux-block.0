Return-Path: <SRS0=5Asf=UN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 030A2C31E4B
	for <linux-block@archiver.kernel.org>; Fri, 14 Jun 2019 13:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D38ED20850
	for <linux-block@archiver.kernel.org>; Fri, 14 Jun 2019 13:15:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbfFNNPS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Jun 2019 09:15:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:46102 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727956AbfFNNPS (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Jun 2019 09:15:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1A85EAF7B;
        Fri, 14 Jun 2019 13:15:17 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     linux-bcache@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Coly Li <colyli@suse.de>
Subject: [PATCH 20/29] bcache: more detailed error message to bcache_device_link()
Date:   Fri, 14 Jun 2019 21:13:49 +0800
Message-Id: <20190614131358.2771-21-colyli@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190614131358.2771-1-colyli@suse.de>
References: <20190614131358.2771-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch adds more accurate error message for specific
ssyfs_create_link() call, to help debugging failure during
bcache device start tup.

Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/super.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 74eb18b1af40..1fa3f4e26d02 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -693,6 +693,7 @@ static void bcache_device_link(struct bcache_device *d, struct cache_set *c,
 {
 	unsigned int i;
 	struct cache *ca;
+	int ret;
 
 	for_each_cache(ca, d->c, i)
 		bd_link_disk_holder(ca->bdev, d->disk);
@@ -700,9 +701,13 @@ static void bcache_device_link(struct bcache_device *d, struct cache_set *c,
 	snprintf(d->name, BCACHEDEVNAME_SIZE,
 		 "%s%u", name, d->id);
 
-	WARN(sysfs_create_link(&d->kobj, &c->kobj, "cache") ||
-	     sysfs_create_link(&c->kobj, &d->kobj, d->name),
-	     "Couldn't create device <-> cache set symlinks");
+	ret = sysfs_create_link(&d->kobj, &c->kobj, "cache");
+	if (ret < 0)
+		pr_err("Couldn't create device -> cache set symlink");
+
+	ret = sysfs_create_link(&c->kobj, &d->kobj, d->name);
+	if (ret < 0)
+		pr_err("Couldn't create cache set -> device symlink");
 
 	clear_bit(BCACHE_DEV_UNLINK_DONE, &d->flags);
 }
-- 
2.16.4

