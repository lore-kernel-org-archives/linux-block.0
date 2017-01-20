Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:59094 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752243AbdATV5Y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Jan 2017 16:57:24 -0500
From: Josef Bacik <jbacik@fb.com>
To: <arnd@arndb.de>, <gregkh@linuxfoundation.org>, <axboe@fb.com>,
        <nbd-general@lists.sourceforge.net>, <linux-block@vger.kernel.org>,
        <kernel-team@fb.com>
Subject: [PATCH 4/4] nbd: add a nbd-control interface
Date: Fri, 20 Jan 2017 16:56:52 -0500
Message-ID: <1484949412-6903-4-git-send-email-jbacik@fb.com>
In-Reply-To: <1484949412-6903-1-git-send-email-jbacik@fb.com>
References: <1484949412-6903-1-git-send-email-jbacik@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This patch mirrors the loop back device behavior with a few changes.  First
there is no DEL operation as NBD doesn't get as much churn as loop devices do.
Secondly the GET_NEXT operation can optionally create a new NBD device or not.
Our infrastructure people want to not allow NBD to create new devices as it
causes problems for them in containers.  However allow this to be optional as
things like the OSS NBD client probably doesn't care and would like to just be
given a device to use.

Signed-off-by: Josef Bacik <jbacik@fb.com>
---
 drivers/block/nbd.c      | 129 ++++++++++++++++++++++++++++++++++++++++++-----
 include/uapi/linux/nbd.h |  10 ++++
 2 files changed, 125 insertions(+), 14 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 96f7681..c06ed36 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -35,6 +35,7 @@
 #include <linux/types.h>
 #include <linux/debugfs.h>
 #include <linux/blk-mq.h>
+#include <linux/miscdevice.h>
 
 #include <linux/uaccess.h>
 #include <asm/types.h>
@@ -59,6 +60,7 @@ struct nbd_device {
 	unsigned long runtime_flags;
 	struct nbd_sock **socks;
 	int magic;
+	int index;
 
 	struct blk_mq_tag_set tag_set;
 
@@ -1041,6 +1043,7 @@ static int nbd_dev_add(int index)
 	if (err < 0)
 		goto out_free_disk;
 
+	nbd->index = index;
 	nbd->disk = disk;
 	nbd->tag_set.ops = &nbd_mq_ops;
 	nbd->tag_set.nr_hw_queues = 1;
@@ -1097,20 +1100,109 @@ static int nbd_dev_add(int index)
 	return err;
 }
 
-/*
- * And here should be modules and kernel interface 
- *  (Just smiley confuses emacs :-)
- */
+static int find_free_cb(int id, void *ptr, void *data)
+{
+	struct nbd_device *nbd = ptr;
+	struct nbd_device **ret = data;
+
+	if (nbd->num_connections == 0) {
+		*ret = nbd;
+		return 1;
+	}
+	if (*ret == NULL || (*ret)->index < nbd->index)
+		*ret = nbd;
+	return 0;
+}
+
+static int nbd_dev_lookup(struct nbd_device **ret, int index)
+{
+	struct nbd_device *nbd = NULL;
+
+	if (index < 0) {
+		int err = idr_for_each(&nbd_index_idr, &find_free_cb, &nbd);
+		if (err != 1) {
+			if (nbd != NULL) {
+				*ret = NULL;
+				return nbd->index + 1;
+			} else {
+				return 0;
+			}
+		}
+	} else
+		nbd = idr_find(&nbd_index_idr, index);
+	if (nbd) {
+		*ret = nbd;
+		return nbd->index;
+	}
+	return -ENODEV;
+}
+
+static long nbd_control_ioctl(struct file *file, unsigned int cmd,
+			      unsigned long parm)
+{
+	struct nbd_device *nbd = NULL;
+	int ret = -ENOSYS;
+
+	mutex_lock(&nbd_index_mutex);
+	switch (cmd) {
+	case NBD_CTL_ADD:
+		ret = nbd_dev_lookup(&nbd, parm);
+		if (ret >= 0) {
+			ret = -EEXIST;
+			break;
+		}
+		ret = nbd_dev_add(parm);
+		break;
+	case NBD_CTL_GET_FREE:
+		ret = nbd_dev_lookup(&nbd, -1);
+		if (ret < 0)
+			break;
+		if (parm && !nbd) {
+			int index = ret;
+
+			ret = nbd_dev_add(ret);
+			if (ret < 0)
+				break;
+			ret = index;
+		}
+		break;
+	default:
+		break;
+	}
+	mutex_unlock(&nbd_index_mutex);
+	return ret;
+}
+
+static const struct file_operations nbd_ctl_fops = {
+	.open		= nonseekable_open,
+	.unlocked_ioctl	= nbd_control_ioctl,
+	.compat_ioctl	= nbd_control_ioctl,
+	.owner		= THIS_MODULE,
+	.llseek		= noop_llseek,
+};
+
+static struct miscdevice nbd_misc = {
+	.minor	= NBD_CTRL_MINOR,
+	.name	= "nbd-control",
+	.fops	= &nbd_ctl_fops,
+};
+
+MODULE_ALIAS_MISCDEV(NBD_CTRL_MINOR);
+MODULE_ALIAS("devname:nbd-control");
 
 static int __init nbd_init(void)
 {
-	int i;
+	int i, ret;
 
 	BUILD_BUG_ON(sizeof(struct nbd_request) != 28);
+	ret = misc_register(&nbd_misc);
+	if (ret < 0)
+		return ret;
 
+	ret = -EINVAL;
 	if (max_part < 0) {
 		printk(KERN_ERR "nbd: max_part must be >= 0\n");
-		return -EINVAL;
+		goto out_misc;
 	}
 
 	part_shift = 0;
@@ -1129,17 +1221,20 @@ static int __init nbd_init(void)
 	}
 
 	if ((1UL << part_shift) > DISK_MAX_PARTS)
-		return -EINVAL;
-
+		goto out_misc;
 	if (nbds_max > 1UL << (MINORBITS - part_shift))
-		return -EINVAL;
+		goto out_misc;
+
 	recv_workqueue = alloc_workqueue("knbd-recv",
 					 WQ_MEM_RECLAIM | WQ_HIGHPRI, 0);
-	if (!recv_workqueue)
-		return -ENOMEM;
-
-	if (register_blkdev(NBD_MAJOR, "nbd"))
-		return -EIO;
+	if (!recv_workqueue) {
+		ret = -ENOMEM;
+		goto out_misc;
+	}
+	if (register_blkdev(NBD_MAJOR, "nbd")) {
+		ret = -EIO;
+		goto out_workqueue;
+	}
 
 	nbd_dbg_init();
 
@@ -1148,6 +1243,11 @@ static int __init nbd_init(void)
 		nbd_dev_add(i);
 	mutex_unlock(&nbd_index_mutex);
 	return 0;
+out_workqueue:
+	destroy_workqueue(recv_workqueue);
+out_misc:
+	misc_deregister(&nbd_misc);
+	return ret;
 }
 
 static int nbd_exit_cb(int id, void *ptr, void *data)
@@ -1164,6 +1264,7 @@ static void __exit nbd_cleanup(void)
 	idr_for_each(&nbd_index_idr, &nbd_exit_cb, NULL);
 	idr_destroy(&nbd_index_idr);
 	destroy_workqueue(recv_workqueue);
+	misc_deregister(&nbd_misc);
 	unregister_blkdev(NBD_MAJOR, "nbd");
 }
 
diff --git a/include/uapi/linux/nbd.h b/include/uapi/linux/nbd.h
index c91c642..a76924b 100644
--- a/include/uapi/linux/nbd.h
+++ b/include/uapi/linux/nbd.h
@@ -29,6 +29,16 @@
 #define NBD_SET_TIMEOUT _IO( 0xab, 9 )
 #define NBD_SET_FLAGS   _IO( 0xab, 10)
 
+/* Use the last 8 values of our allocation for CTRL ioctls. */
+#define NBD_CTL_ADD		_IO( 0xab, 23)
+#define NBD_CTL_GET_FREE	_IO( 0xab, 24)
+
+enum {
+	NBD_CTL_GET_FREE_SCAN = 0, /* Get the next free available device. */
+	NBD_CTL_GET_FREE_ADD = 1, /* Get the next free available device, but
+				     create one if one does not exist. */
+};
+
 enum {
 	NBD_CMD_READ = 0,
 	NBD_CMD_WRITE = 1,
-- 
2.7.4

