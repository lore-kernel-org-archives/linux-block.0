Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:61954 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934096AbdBQRfb (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Feb 2017 12:35:31 -0500
From: Scott Bauer <scott.bauer@intel.com>
To: linux-block@vger.kernel.org
Cc: axboe@fb.com, keith.busch@intel.com, jonathan.derrick@intel.com,
        hch@lst.de, Scott Bauer <scott.bauer@intel.com>
Subject: [PATCH] block/sed-opal: Introduce free_opal_dev to free the structure and clean up state
Date: Fri, 17 Feb 2017 10:25:13 -0700
Message-Id: <1487352313-3539-1-git-send-email-scott.bauer@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Before we free the opal structure we need to clean up any saved
locking ranges that the user had told us to unlock from a suspend.
Also fixup a list_for_each to list_for_each_safe in the save path.

Signed-off-by: Scott Bauer <scott.bauer@intel.com>
---
 block/sed-opal.c         | 33 +++++++++++++++++++++++++++++++--
 include/linux/sed-opal.h |  5 +++++
 2 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index d1c52ba..1be5c72 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -988,9 +988,9 @@ static int start_opal_session_cont(struct opal_dev *dev)
 static void add_suspend_info(struct opal_dev *dev,
 			     struct opal_suspend_data *sus)
 {
-	struct opal_suspend_data *iter;
+	struct opal_suspend_data *iter, *next;
 
-	list_for_each_entry(iter, &dev->unlk_lst, node) {
+	list_for_each_entry_safe(iter, next, &dev->unlk_lst, node) {
 		if (iter->lr == sus->lr) {
 			list_del(&iter->node);
 			kfree(iter);
@@ -2014,6 +2014,28 @@ static int check_opal_support(struct opal_dev *dev)
 	return ret;
 }
 
+static void clean_opal_dev(struct opal_dev *dev)
+{
+
+	struct opal_suspend_data *suspend, *next;
+
+	mutex_lock(&dev->dev_lock);
+	list_for_each_entry_safe(suspend, next, &dev->unlk_lst, node) {
+		list_del(&suspend->node);
+		kfree(suspend);
+	}
+	mutex_unlock(&dev->dev_lock);
+}
+
+void free_opal_dev(struct opal_dev *dev)
+{
+	if (!dev)
+		return;
+	clean_opal_dev(dev);
+	kfree(dev);
+}
+EXPORT_SYMBOL(free_opal_dev);
+
 struct opal_dev *init_opal_dev(void *data, sec_send_recv *send_recv)
 {
 	struct opal_dev *dev;
@@ -2193,6 +2215,13 @@ static int opal_reverttper(struct opal_dev *dev, struct opal_key *opal)
 	dev->func_data[1] = opal;
 	ret = next(dev);
 	mutex_unlock(&dev->dev_lock);
+
+	/* If we succesfully reverted lets clean
+	 * any saved locking ranges.
+	 */
+	if (!ret)
+		clean_opal_dev(dev);
+
 	return ret;
 }
 
diff --git a/include/linux/sed-opal.h b/include/linux/sed-opal.h
index deee23d..04b124f 100644
--- a/include/linux/sed-opal.h
+++ b/include/linux/sed-opal.h
@@ -27,6 +27,7 @@ typedef int (sec_send_recv)(void *data, u16 spsp, u8 secp, void *buffer,
 		size_t len, bool send);
 
 #ifdef CONFIG_BLK_SED_OPAL
+void free_opal_dev(struct opal_dev *dev);
 bool opal_unlock_from_suspend(struct opal_dev *dev);
 struct opal_dev *init_opal_dev(void *data, sec_send_recv *send_recv);
 int sed_ioctl(struct opal_dev *dev, unsigned int cmd, void __user *ioctl_ptr);
@@ -51,6 +52,10 @@ static inline bool is_sed_ioctl(unsigned int cmd)
 	return false;
 }
 #else
+static inline void free_opal_dev(struct opal_dev *dev)
+{
+}
+
 static inline bool is_sed_ioctl(unsigned int cmd)
 {
 	return false;
-- 
2.7.4
