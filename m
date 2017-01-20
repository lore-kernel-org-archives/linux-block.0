Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:59079 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752234AbdATV5U (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Jan 2017 16:57:20 -0500
From: Josef Bacik <jbacik@fb.com>
To: <arnd@arndb.de>, <gregkh@linuxfoundation.org>, <axboe@fb.com>,
        <nbd-general@lists.sourceforge.net>, <linux-block@vger.kernel.org>,
        <kernel-team@fb.com>
Subject: [PATCH 2/4] miscdevice: add a minor number for nbd-control
Date: Fri, 20 Jan 2017 16:56:50 -0500
Message-ID: <1484949412-6903-2-git-send-email-jbacik@fb.com>
In-Reply-To: <1484949412-6903-1-git-send-email-jbacik@fb.com>
References: <1484949412-6903-1-git-send-email-jbacik@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

NBD is moving to a loop-control esque way of managing it's device
creation and deletion.  Reserver a minor number for the new device.

Signed-off-by: Josef Bacik <jbacik@fb.com>
---
 include/linux/miscdevice.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/miscdevice.h b/include/linux/miscdevice.h
index ed30d5d..7e5c140 100644
--- a/include/linux/miscdevice.h
+++ b/include/linux/miscdevice.h
@@ -44,6 +44,7 @@
 #define MISC_MCELOG_MINOR	227
 #define HPET_MINOR		228
 #define FUSE_MINOR		229
+#define NBD_CTRL_MINOR		230
 #define KVM_MINOR		232
 #define BTRFS_MINOR		234
 #define AUTOFS_MINOR		235
-- 
2.7.4

