Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:34490 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934057AbdC3Nt7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Mar 2017 09:49:59 -0400
From: Dmitry Monakhov <dmonakhov@openvz.org>
To: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        martin.petersen@oracle.com
Cc: Dmitry Monakhov <dmonakhov@openvz.org>
Subject: [PATCH 8/8] tcm_fileio: Prevent information leak for short reads
Date: Thu, 30 Mar 2017 17:49:36 +0400
Message-Id: <1490881776-28735-9-git-send-email-dmonakhov@openvz.org>
In-Reply-To: <1490881776-28735-1-git-send-email-dmonakhov@openvz.org>
References: <1490881776-28735-1-git-send-email-dmonakhov@openvz.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

If we failed to read data from backing file (probably because some one
truncate file under us), we must zerofill cmd's data, otherwise it will
be returned as is. Most likely cmd's data are unitialized pages from
page cache. This result in information leak.

xfstests: generic/420
http://marc.info/?l=linux-scsi&m=149087996913448&w=2

Signed-off-by: Dmitry Monakhov <dmonakhov@openvz.org>
---
 drivers/target/target_core_file.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/target/target_core_file.c b/drivers/target/target_core_file.c
index 87aa376..d69908d 100644
--- a/drivers/target/target_core_file.c
+++ b/drivers/target/target_core_file.c
@@ -277,12 +277,11 @@ static int fd_do_rw(struct se_cmd *cmd, struct file *fd,
 	else
 		ret = vfs_iter_read(fd, &iter, &pos);
 
-	kfree(bvec);
-
 	if (is_write) {
 		if (ret < 0 || ret != data_length) {
 			pr_err("%s() write returned %d\n", __func__, ret);
-			return (ret < 0 ? ret : -EINVAL);
+			if (ret >= 0)
+				ret = -EINVAL;
 		}
 	} else {
 		/*
@@ -295,17 +294,27 @@ static int fd_do_rw(struct se_cmd *cmd, struct file *fd,
 				pr_err("%s() returned %d, expecting %u for "
 						"S_ISBLK\n", __func__, ret,
 						data_length);
-				return (ret < 0 ? ret : -EINVAL);
+				if (ret >= 0)
+					ret = -EINVAL;
 			}
 		} else {
 			if (ret < 0) {
 				pr_err("%s() returned %d for non S_ISBLK\n",
 						__func__, ret);
-				return ret;
+			} else if (ret != data_length) {
+				/*
+				 * Short read case:
+				 * Probably some one truncate file under us.
+				 * We must explicitly zero sg-pages to prevent
+				 * expose uninizialized pages to userspace.
+				 */
+				BUG_ON(ret > data_length);
+				ret += iov_iter_zero(data_length - ret, &iter);
 			}
 		}
 	}
-	return 1;
+	kfree(bvec);
+	return ret;
 }
 
 static sense_reason_t
-- 
2.9.3
