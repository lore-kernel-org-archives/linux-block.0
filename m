Return-Path: <SRS0=v1Da=O3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB5FC43387
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 14:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDDD921871
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 14:33:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbeLROdn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Dec 2018 09:33:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:55686 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726426AbeLROdm (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Dec 2018 09:33:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 79811AC6E;
        Tue, 18 Dec 2018 14:33:41 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     linux-bcache@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Coly Li <colyli@suse.de>
Subject: [PATCH 2/2] bcache: export backing_dev_uuid via sysfs
Date:   Tue, 18 Dec 2018 22:32:50 +0800
Message-Id: <20181218143250.81793-2-colyli@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20181218143250.81793-1-colyli@suse.de>
References: <20181218143250.81793-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When there are multiple bcache devices, after a reboot the name of
bcache devices may change (e.g. current /dev/bcache1 was /dev/bcache0
before reboot). Therefore we need the backing device UUID (sb.uuid) to
identify each bcache device.

Backing device uuid can be found by program bcache-super-show, but
directly exporting backing_dev_uuid by sysfs file
/sys/block/bcache<?>/bcache/backing_dev_uuid is a much simpler method.

With backing_dev_uuid, and partition uuids from /dev/disk/by-partuuid/,
now we can identify each bcache device and its partitions conveniently.

Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/sysfs.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
index 8f7674d199fb..b5028ba90795 100644
--- a/drivers/md/bcache/sysfs.c
+++ b/drivers/md/bcache/sysfs.c
@@ -68,6 +68,7 @@ read_attribute(btree_written);
 read_attribute(metadata_written);
 read_attribute(active_journal_entries);
 read_attribute(backing_dev_name);
+read_attribute(backing_dev_uuid);
 
 sysfs_time_stats_attribute(btree_gc,	sec, ms);
 sysfs_time_stats_attribute(btree_split, sec, us);
@@ -247,6 +248,13 @@ SHOW(__bch_cached_dev)
 		return strlen(buf);
 	}
 
+	if (attr == &sysfs_backing_dev_uuid) {
+		/* convert binary uuid into 36-byte string plus '\0' */
+		snprintf(buf, 36+1, "%pU", dc->sb.uuid);
+		strcat(buf, "\n");
+		return strlen(buf);
+	}
+
 #undef var
 	return 0;
 }
@@ -439,6 +447,7 @@ static struct attribute *bch_cached_dev_files[] = {
 	&sysfs_bypass_torture_test,
 #endif
 	&sysfs_backing_dev_name,
+	&sysfs_backing_dev_uuid,
 	NULL
 };
 KTYPE(bch_cached_dev);
-- 
2.16.4

