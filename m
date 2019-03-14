Return-Path: <SRS0=8xnz=RR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 295AAC43381
	for <linux-block@archiver.kernel.org>; Thu, 14 Mar 2019 16:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 036632184E
	for <linux-block@archiver.kernel.org>; Thu, 14 Mar 2019 16:09:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbfCNQJc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Mar 2019 12:09:32 -0400
Received: from mga04.intel.com ([192.55.52.120]:23645 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbfCNQJb (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Mar 2019 12:09:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Mar 2019 09:09:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,478,1544515200"; 
   d="scan'208";a="134073392"
Received: from gklab-107-059.igk.intel.com ([10.102.107.59])
  by orsmga003.jf.intel.com with ESMTP; 14 Mar 2019 09:09:29 -0700
From:   Igor Konopko <igor.j.konopko@intel.com>
To:     mb@lightnvm.io, javier@javigon.com, hans.holmberg@cnexlabs.com
Cc:     linux-block@vger.kernel.org, igor.j.konopko@intel.com
Subject: [PATCH 17/18] lightnvm: allow to use full device path
Date:   Thu, 14 Mar 2019 17:04:27 +0100
Message-Id: <20190314160428.3559-18-igor.j.konopko@intel.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190314160428.3559-1-igor.j.konopko@intel.com>
References: <20190314160428.3559-1-igor.j.konopko@intel.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch adds the possibility to provide full device path (like
/dev/nvme0n1) when specifying device on top of which pblk instance
should be created/removed.

This makes creation of targets from nvme-cli (or other ioctl based
tools) more unified with other commands in comparison with current
situation where almost all commands uses full device path with except
of lightnvm creation/removal parameter which uses just 'nvme0n1'
naming convention. After this changes both approach will be valid.

Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
---
 drivers/lightnvm/core.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index c01f83b..838c3d8 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -1195,6 +1195,21 @@ void nvm_unregister(struct nvm_dev *dev)
 }
 EXPORT_SYMBOL(nvm_unregister);
 
+#define PREFIX_STR "/dev/"
+static void nvm_normalize_path(char *path)
+{
+	path[DISK_NAME_LEN - 1] = '\0';
+	if (!memcmp(PREFIX_STR, path,
+				sizeof(char) * strlen(PREFIX_STR))) {
+		/*
+		 * User provide name in '/dev/nvme0n1' format,
+		 * so we need to skip '/dev/' for comparison
+		 */
+		memmove(path, path + sizeof(char) * strlen(PREFIX_STR),
+			(DISK_NAME_LEN - strlen(PREFIX_STR)) * sizeof(char));
+	}
+}
+
 static int __nvm_configure_create(struct nvm_ioctl_create *create)
 {
 	struct nvm_dev *dev;
@@ -1304,9 +1319,9 @@ static long nvm_ioctl_dev_create(struct file *file, void __user *arg)
 		return -EINVAL;
 	}
 
-	create.dev[DISK_NAME_LEN - 1] = '\0';
+	nvm_normalize_path(create.dev);
+	nvm_normalize_path(create.tgtname);
 	create.tgttype[NVM_TTYPE_NAME_MAX - 1] = '\0';
-	create.tgtname[DISK_NAME_LEN - 1] = '\0';
 
 	if (create.flags != 0) {
 		__u32 flags = create.flags;
@@ -1333,7 +1348,7 @@ static long nvm_ioctl_dev_remove(struct file *file, void __user *arg)
 	if (copy_from_user(&remove, arg, sizeof(struct nvm_ioctl_remove)))
 		return -EFAULT;
 
-	remove.tgtname[DISK_NAME_LEN - 1] = '\0';
+	nvm_normalize_path(remove.tgtname);
 
 	if (remove.flags != 0) {
 		pr_err("nvm: no flags supported\n");
@@ -1373,8 +1388,6 @@ static long nvm_ioctl_dev_factory(struct file *file, void __user *arg)
 	if (copy_from_user(&fact, arg, sizeof(struct nvm_ioctl_dev_factory)))
 		return -EFAULT;
 
-	fact.dev[DISK_NAME_LEN - 1] = '\0';
-
 	if (fact.flags & ~(NVM_FACTORY_NR_BITS - 1))
 		return -EINVAL;
 
-- 
2.9.5

