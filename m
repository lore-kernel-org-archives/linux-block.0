Return-Path: <SRS0=v1Da=O3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39DC9C43387
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 14:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10F5621871
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 14:33:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbeLROdh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Dec 2018 09:33:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:55564 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726426AbeLROdh (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Dec 2018 09:33:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AAD7AB121;
        Tue, 18 Dec 2018 14:33:35 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     linux-bcache@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Coly Li <colyli@suse.de>
Subject: [PATCH 1/2] bcache: export backing_dev_name via sysfs
Date:   Tue, 18 Dec 2018 22:32:49 +0800
Message-Id: <20181218143250.81793-1-colyli@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch export dc->backing_dev_name to sysfs file
/sys/block/bcache<?>/bcache/backing_dev_name, then people or user space
tools may know the backing device name of this bcache device.

Of cause it can be done by parsing sysfs links, but this method can be
much simpler to find the link between bcache device and backing device.

Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/sysfs.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
index 26f035a0c5b9..8f7674d199fb 100644
--- a/drivers/md/bcache/sysfs.c
+++ b/drivers/md/bcache/sysfs.c
@@ -67,6 +67,7 @@ read_attribute(written);
 read_attribute(btree_written);
 read_attribute(metadata_written);
 read_attribute(active_journal_entries);
+read_attribute(backing_dev_name);
 
 sysfs_time_stats_attribute(btree_gc,	sec, ms);
 sysfs_time_stats_attribute(btree_split, sec, us);
@@ -240,6 +241,12 @@ SHOW(__bch_cached_dev)
 		return strlen(buf);
 	}
 
+	if (attr == &sysfs_backing_dev_name) {
+		snprintf(buf, BDEVNAME_SIZE + 1, "%s", dc->backing_dev_name);
+		strcat(buf, "\n");
+		return strlen(buf);
+	}
+
 #undef var
 	return 0;
 }
@@ -431,6 +438,7 @@ static struct attribute *bch_cached_dev_files[] = {
 	&sysfs_verify,
 	&sysfs_bypass_torture_test,
 #endif
+	&sysfs_backing_dev_name,
 	NULL
 };
 KTYPE(bch_cached_dev);
-- 
2.16.4

