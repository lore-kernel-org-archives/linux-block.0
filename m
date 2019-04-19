Return-Path: <SRS0=cp6W=SV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71BBBC282DA
	for <linux-block@archiver.kernel.org>; Fri, 19 Apr 2019 18:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B774222CC
	for <linux-block@archiver.kernel.org>; Fri, 19 Apr 2019 18:24:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbfDSSXz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:23:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:33632 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727867AbfDSSXr (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Apr 2019 14:23:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 10844AFBF;
        Fri, 19 Apr 2019 16:06:07 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     linux-bcache@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Coly Li <colyli@suse.de>
Subject: [RFC PATCH v2 12/16] bcache: add pendings_cleanup to stop pending bcache device
Date:   Sat, 20 Apr 2019 00:05:05 +0800
Message-Id: <20190419160509.66298-13-colyli@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190419160509.66298-1-colyli@suse.de>
References: <20190419160509.66298-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If a bcache device is in dirty state and its cache set is not
registered, this bcache deivce will not appear in /dev/bcache<N>,
and there is no way to stop it or remove the bcache kernel module.

This is an as-designed behavior, but sometimes people has to reboot
whole system to release or stop the pending backing device.

This sysfs interface may remove such pending bcache devices when
write anything into the sysfs file manually.

Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/super.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 9b41e0b62cc0..e988e46a6479 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -2246,9 +2246,13 @@ static int register_cache(struct cache_sb *sb, struct page *sb_page,
 
 static ssize_t register_bcache(struct kobject *k, struct kobj_attribute *attr,
 			       const char *buffer, size_t size);
+static ssize_t bch_pending_bdevs_cleanup(struct kobject *k,
+					 struct kobj_attribute *attr,
+					 const char *buffer, size_t size);
 
 kobj_attribute_write(register,		register_bcache);
 kobj_attribute_write(register_quiet,	register_bcache);
+kobj_attribute_write(pendings_cleanup,	bch_pending_bdevs_cleanup);
 
 static bool bch_is_open_backing(struct block_device *bdev)
 {
@@ -2373,6 +2377,56 @@ static ssize_t register_bcache(struct kobject *k, struct kobj_attribute *attr,
 	goto out;
 }
 
+
+struct pdev {
+	struct list_head list;
+	struct cached_dev *dc;
+};
+
+static ssize_t bch_pending_bdevs_cleanup(struct kobject *k,
+					 struct kobj_attribute *attr,
+					 const char *buffer,
+					 size_t size)
+{
+	LIST_HEAD(pending_devs);
+	ssize_t ret = size;
+	struct cached_dev *dc, *tdc;
+	struct pdev *pdev, *tpdev;
+	struct cache_set *c, *tc;
+
+	mutex_lock(&bch_register_lock);
+	list_for_each_entry_safe(dc, tdc, &uncached_devices, list) {
+		pdev = kmalloc(sizeof(struct pdev), GFP_KERNEL);
+		if (!pdev)
+			break;
+		pdev->dc = dc;
+		list_add(&pdev->list, &pending_devs);
+	}
+
+	list_for_each_entry_safe(pdev, tpdev, &pending_devs, list) {
+		list_for_each_entry_safe(c, tc, &bch_cache_sets, list) {
+			char *pdev_set_uuid = pdev->dc->sb.set_uuid;
+			char *set_uuid = c->sb.uuid;
+
+			if (!memcmp(pdev_set_uuid, set_uuid, 16)) {
+				list_del(&pdev->list);
+				kfree(pdev);
+				break;
+			}
+		}
+	}
+	mutex_unlock(&bch_register_lock);
+
+	list_for_each_entry_safe(pdev, tpdev, &pending_devs, list) {
+		pr_info("delete pdev %p", pdev);
+		list_del(&pdev->list);
+		bcache_device_stop(&pdev->dc->disk);
+		kfree(pdev);
+	}
+
+	return ret;
+}
+
 static int bcache_reboot(struct notifier_block *n, unsigned long code, void *x)
 {
 	if (code == SYS_DOWN ||
@@ -2483,6 +2537,7 @@ static int __init bcache_init(void)
 	static const struct attribute *files[] = {
 		&ksysfs_register.attr,
 		&ksysfs_register_quiet.attr,
+		&ksysfs_pendings_cleanup.attr,
 		NULL
 	};
 
-- 
2.16.4

